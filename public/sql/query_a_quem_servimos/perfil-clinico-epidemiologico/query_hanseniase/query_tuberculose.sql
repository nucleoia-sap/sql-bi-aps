-- ======================================================================
-- Parâmetro dinâmico: 9 meses antes da execução
-- ======================================================================
DECLARE data_corte DATETIME DEFAULT DATETIME_SUB(CURRENT_DATETIME(), INTERVAL 9 MONTH);

-- ======================================================================
-- 1) LISTA DE TUBERCULOSE COM CPF (chave: id_cnes|'|'|id_prontuario_local)
--    -> normaliza CPF (apenas dígitos) e filtra nulos/vazios
-- ======================================================================
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us._tuberculose_lista_com_cpf` AS
WITH
tb_base AS (
  SELECT
    TRIM(id_cnes) AS id_cnes_norm,
    TRIM(id_prontuario_local) AS id_pl_norm,
    CONCAT(TRIM(id_cnes), '|', TRIM(id_prontuario_local)) AS chave_tb,
    t.*
  FROM `rj-sms.brutos_prontuario_vitacare_historico.tuberculose` t
),
acto_base AS (
  SELECT
    TRIM(id_cnes) AS id_cnes_norm,
    TRIM(id_prontuario_local) AS id_pl_norm,
    CONCAT(TRIM(id_cnes), '|', TRIM(id_prontuario_local)) AS chave_tb,
    REGEXP_REPLACE(TRIM(patient_cpf), r'\D', '') AS paciente_cpf_digits
  FROM `rj-sms.brutos_prontuario_vitacare_historico.acto`
  WHERE patient_cpf IS NOT NULL
    AND LENGTH(TRIM(patient_cpf)) > 0
),
acto_chave_cpf AS (
  SELECT
    chave_tb,
    ANY_VALUE(paciente_cpf_digits) AS paciente_cpf_digits
  FROM acto_base
  WHERE chave_tb IS NOT NULL
    AND paciente_cpf_digits IS NOT NULL
    AND LENGTH(paciente_cpf_digits) = 11
  GROUP BY chave_tb
)
SELECT
  tb.*,
  ac.paciente_cpf_digits AS paciente_cpf
FROM tb_base tb
LEFT JOIN acto_chave_cpf ac
  ON tb.chave_tb = ac.chave_tb
;
-- ======================================================================
-- 2) TABELA FINAL: _tuberculose_em_tratamento
--    -> todas as etapas usam CPF normalizado (11 dígitos)
-- ======================================================================
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento` AS
WITH
/* 2.1) Prescrição (EA) — coleta bruta de itens relevantes */
tb_prescricao_raw AS (
  SELECT
    REGEXP_REPLACE(TRIM(ea.paciente_cpf), r'\D', '') AS paciente_cpf,
    ea.entrada_datahora AS data_prescricao,
    LOWER(p.nome) AS nome_medicamento
  FROM `rj-sms.saude_historico_clinico.episodio_assistencial` AS ea,
       UNNEST(ea.prescricoes) AS p
  WHERE
    ea.entrada_datahora >= data_corte
    AND ea.paciente_cpf IS NOT NULL
    AND LENGTH(TRIM(ea.paciente_cpf)) > 0
    AND REGEXP_CONTAINS(LOWER(p.nome), r'rifampicin|isoniazid|pirazinamid|etambutol|\b(rhze|ripe|rip|ri)\b')
),
/* tokeniza nomes: troca '+' por ',' e divide por vírgula */
tokens AS (
  SELECT
    paciente_cpf,
    data_prescricao,
    LOWER(TRIM(tok)) AS tok
  FROM tb_prescricao_raw,
  UNNEST(SPLIT(REGEXP_REPLACE(nome_medicamento, r'\+', ','))) AS tok
),
/* flags por consulta (nomes + siglas) */
flags_base AS (
  SELECT
    paciente_cpf,
    data_prescricao,
    COUNTIF(REGEXP_CONTAINS(tok, r'\brhze\b')) > 0 AS has_sig_rhze,
    COUNTIF(REGEXP_CONTAINS(tok, r'\bripe\b')) > 0 AS has_sig_ripe,
    COUNTIF(REGEXP_CONTAINS(tok, r'\brip\b'))  > 0 AS has_sig_rip,
    COUNTIF(REGEXP_CONTAINS(tok, r'\bri\b'))   > 0 AS has_sig_ri,
    COUNTIF(REGEXP_CONTAINS(tok, r'rifamp'))   > 0 AS has_r_name,
    COUNTIF(REGEXP_CONTAINS(tok, r'isoniaz'))  > 0 AS has_i_name,
    COUNTIF(REGEXP_CONTAINS(tok, r'pirazinam'))> 0 AS has_p_name,
    COUNTIF(REGEXP_CONTAINS(tok, r'etambut'))  > 0 AS has_e_name
  FROM tokens
  GROUP BY paciente_cpf, data_prescricao
),
/* classifica o ESQUEMA por consulta (propaga siglas p/ R/I/P/E) */
esquema_por_consulta AS (
  SELECT
    paciente_cpf,
    data_prescricao,
    (has_r_name OR has_sig_rhze OR has_sig_ripe OR has_sig_rip OR has_sig_ri) AS has_r,
    (has_i_name OR has_sig_rhze OR has_sig_ripe OR has_sig_rip OR has_sig_ri) AS has_i,
    (has_p_name OR has_sig_ripe OR has_sig_rip)                               AS has_p,
    (has_e_name OR has_sig_ripe OR has_sig_rhze)                              AS has_e,
    CASE
      WHEN ( (has_r_name OR has_sig_rhze OR has_sig_ripe OR has_sig_rip OR has_sig_ri)
             AND (has_i_name OR has_sig_rhze OR has_sig_ripe OR has_sig_rip OR has_sig_ri)
             AND (has_p_name OR has_sig_ripe OR has_sig_rip)
             AND (has_e_name OR has_sig_ripe OR has_sig_rhze) ) THEN 'RIPE'  -- inclui RHZE
      WHEN ( (has_r_name OR has_sig_rhze OR has_sig_ripe OR has_sig_rip OR has_sig_ri)
             AND (has_i_name OR has_sig_rhze OR has_sig_ripe OR has_sig_rip OR has_sig_ri)
             AND (has_p_name OR has_sig_ripe OR has_sig_rip)
             AND NOT (has_e_name OR has_sig_ripe OR has_sig_rhze) ) THEN 'RIP'
      WHEN ( (has_r_name OR has_sig_rhze OR has_sig_ripe OR has_sig_rip OR has_sig_ri)
             AND (has_i_name OR has_sig_rhze OR has_sig_ripe OR has_sig_rip OR has_sig_ri)
             AND NOT (has_p_name OR has_sig_ripe OR has_sig_rip)
             AND NOT (has_e_name OR has_sig_ripe OR has_sig_rhze) ) THEN 'RI'
      ELSE NULL
    END AS tipo_esquema
  FROM flags_base
),
/* mantém SOMENTE consultas com esquema completo + lista dos 4 fármacos */
consultas_validas AS (
  SELECT
    e.paciente_cpf,
    e.data_prescricao,
    e.tipo_esquema,
    ARRAY_TO_STRING(
      ARRAY(
        SELECT med FROM UNNEST([
          IF(e.has_r, 'rifampicina', NULL),
          IF(e.has_i, 'isoniazida', NULL),
          IF(e.has_p, 'pirazinamida', NULL),
          IF(e.has_e, 'etambutol', NULL)
        ]) med
        WHERE med IS NOT NULL
      ), ', '
    ) AS lista_meds_consulta
  FROM esquema_por_consulta e
  WHERE e.tipo_esquema IS NOT NULL
),
presc_cpfs AS (
  SELECT DISTINCT paciente_cpf
  FROM consultas_validas
  WHERE paciente_cpf IS NOT NULL AND LENGTH(paciente_cpf) = 11
),
presc_meds_ult AS (
  SELECT paciente_cpf,
         lista_meds_consulta AS medicamentos_prescritos_mais_recente
  FROM (
    SELECT
      paciente_cpf,
      lista_meds_consulta,
      ROW_NUMBER() OVER (PARTITION BY paciente_cpf ORDER BY data_prescricao DESC) AS rn
    FROM consultas_validas
    WHERE paciente_cpf IS NOT NULL AND LENGTH(paciente_cpf) = 11
  )
  WHERE rn = 1
),
/* 2.2) CID — quem ativou em algum momento e permanece ATIVO (A15–A19) */
cid_eventos AS (
  SELECT
    REGEXP_REPLACE(TRIM(ea.paciente_cpf), r'\D', '') AS paciente_cpf,
    UPPER(TRIM(c.situacao)) AS situacao_norm,
    IFNULL(SAFE_CAST(c.data_diagnostico AS DATETIME), ea.entrada_datahora) AS dt_ref
  FROM `rj-sms.saude_historico_clinico.episodio_assistencial` AS ea,
       UNNEST(ea.condicoes) AS c
  WHERE
    (LOWER(c.id) LIKE 'a15%' OR LOWER(c.id) LIKE 'a16%'
     OR LOWER(c.id) LIKE 'a17%' OR LOWER(c.id) LIKE 'a18%' OR LOWER(c.id) LIKE 'a19%')
    AND IFNULL(SAFE_CAST(c.data_diagnostico AS DATETIME), ea.entrada_datahora) >= data_corte
    AND ea.paciente_cpf IS NOT NULL
    AND LENGTH(TRIM(ea.paciente_cpf)) > 0
),
-- registro MAIS RECENTE por CPF
cid_ultimo AS (
  SELECT AS VALUE
    STRUCT(paciente_cpf, situacao_norm, dt_ref)
  FROM (
    SELECT
      paciente_cpf, situacao_norm, dt_ref,
      ROW_NUMBER() OVER (PARTITION BY paciente_cpf ORDER BY dt_ref DESC) AS rn
    FROM cid_eventos
    WHERE paciente_cpf IS NOT NULL AND LENGTH(paciente_cpf) = 11
  )
  WHERE rn = 1
),
-- teve pelo menos UM evento ATIVO na janela
cid_teve_ativo AS (
  SELECT DISTINCT paciente_cpf
  FROM cid_eventos
  WHERE situacao_norm = 'ATIVO'
    AND paciente_cpf IS NOT NULL AND LENGTH(paciente_cpf) = 11
),
-- mantém ATIVO E já ativou em algum momento (na janela)
cid_cpfs AS (
  SELECT u.paciente_cpf
  FROM cid_ultimo u
  JOIN cid_teve_ativo t USING (paciente_cpf)
  WHERE u.situacao_norm = 'ATIVO'
),

/* 2.3) Lista TB (por CPF) + campos */
lista_info AS (
  SELECT
    REGEXP_REPLACE(TRIM(paciente_cpf), r'\D', '') AS paciente_cpf,
    num_sinan,
    data_exclusao,
    motivo_encerramento,
    id_cnes AS id_cnes_lista
  FROM (
    SELECT
      paciente_cpf, num_sinan, data_exclusao, motivo_encerramento, id_cnes, data_inicio_trat,
      ROW_NUMBER() OVER (PARTITION BY paciente_cpf ORDER BY data_inicio_trat DESC) AS rn
    FROM `rj-sms-sandbox.sub_pav_us._tuberculose_lista_com_cpf`
    WHERE data_inicio_trat >= data_corte
      AND paciente_cpf IS NOT NULL AND LENGTH(TRIM(paciente_cpf)) > 0
  )
  WHERE rn = 1
    AND LENGTH(REGEXP_REPLACE(TRIM(paciente_cpf), r'\D', '')) = 11
),
lista_cpfs AS (
  SELECT DISTINCT REGEXP_REPLACE(TRIM(paciente_cpf), r'\D', '') AS paciente_cpf
  FROM `rj-sms-sandbox.sub_pav_us._tuberculose_lista_com_cpf`
  WHERE data_inicio_trat >= data_corte
    AND paciente_cpf IS NOT NULL
    AND LENGTH(TRIM(paciente_cpf)) > 0
    AND LENGTH(REGEXP_REPLACE(TRIM(paciente_cpf), r'\D', '')) = 11
),

/* 2.4) Episódio Assistencial (EA) — mais recente na janela */
ea_info AS (
  SELECT
    paciente_cpf,
    motivo_atendimento,
    desfecho_atendimento,
    estabelecimento.id_cnes AS id_cnes_ea
  FROM (
    SELECT
      REGEXP_REPLACE(TRIM(paciente_cpf), r'\D', '') AS paciente_cpf,
      motivo_atendimento, desfecho_atendimento, estabelecimento, entrada_datahora,
      ROW_NUMBER() OVER (PARTITION BY REGEXP_REPLACE(TRIM(paciente_cpf), r'\D', '') ORDER BY entrada_datahora DESC) AS rn
    FROM `rj-sms.saude_historico_clinico.episodio_assistencial`
    WHERE entrada_datahora >= data_corte
      AND paciente_cpf IS NOT NULL
      AND LENGTH(TRIM(paciente_cpf)) > 0
  )
  WHERE rn = 1
    AND LENGTH(paciente_cpf) = 11
),

/* 2.5) Universo de CPFs presentes em qualquer critério */
universo AS (
  SELECT paciente_cpf FROM presc_cpfs
  UNION DISTINCT SELECT paciente_cpf FROM cid_cpfs
  UNION DISTINCT SELECT paciente_cpf FROM lista_cpfs
)

-- 2.6) Tabela final
SELECT
  u.paciente_cpf AS cpf,
  IF(p.paciente_cpf IS NOT NULL, 1, 0) AS criterio1_prescricao,
  IF(c.paciente_cpf IS NOT NULL, 1, 0) AS criterio2_cid_ativo,
  IF(l.paciente_cpf IS NOT NULL, 1, 0) AS criterio3_lista_tuberculose,
  pm.medicamentos_prescritos_mais_recente,
  li.num_sinan,
  li.data_exclusao,
  li.motivo_encerramento,
  COALESCE(ei.id_cnes_ea, li.id_cnes_lista) AS id_cnes,
  ei.motivo_atendimento,
  ei.desfecho_atendimento,
-- ===== Abandono (Sim/Não) =====
  CASE
    WHEN REGEXP_CONTAINS(CONCAT(' ',IFNULL(ei.motivo_atendimento,''),' ',IFNULL(ei.desfecho_atendimento,''),' '),
         r'(?i)\b(abandono|abandonou|abandona(r|do|da)|aband[oô]nou|evas[aã]o|evadiu|perda\s+de\s+seguimento|perdeu\s+seguimento|interrup[cç][aã]o\s+do\s+tratament[oa]|interrompeu\s+tratament[oa])\b')
    THEN 'Sim' ELSE 'Não'
  END AS Abandono,

  -- ===== Cura (Sim/Não) =====
  CASE
    WHEN
      (
        REGEXP_CONTAINS(IFNULL(ei.motivo_atendimento,''), r'(?i)\b(alta\s+por\s+cura|cura|curado|curada)\b')
        OR REGEXP_CONTAINS(IFNULL(ei.motivo_atendimento,''), r'(?i)\btratament[oa]\s+(completo|conclu[ií]d[oa]|finalizad[oa]|terminad[oa])\b')
        OR REGEXP_CONTAINS(IFNULL(ei.motivo_atendimento,''), r'(?i)\b(fim|t[ée]rmino)\s+do\s+tratament[oa]\b')
        OR (
          REGEXP_CONTAINS(IFNULL(ei.motivo_atendimento,''), r'(?i)\bencerr(a|amento)\b')
          AND REGEXP_CONTAINS(IFNULL(ei.motivo_atendimento,''), r'(?i)\b(cid|alta|cura)\b')
          AND REGEXP_CONTAINS(IFNULL(ei.motivo_atendimento,''), r'(?i)\b(tb|tuberculose)\b')
        )
      )
      AND NOT REGEXP_CONTAINS(CONCAT(' ',IFNULL(ei.motivo_atendimento,''),' ',IFNULL(ei.desfecho_atendimento,''),' '),
          r'(?i)\b(abandono|abandonou|abandona(r|do|da)|aband[oô]nou|óbito|obito|alta\s+a\s+pedido|transfer[êe]ncia|transferid[oa]|falh[ae]|fal[êe]ncia|reca[ií]da|recidiva|reinfec[cç][aã]o|interrup[cç][aã]o|suspens[aã]o|perda\s+de\s+seguimento|perdeu\s+seguimento|evas[aã]o)\b')
      AND NOT REGEXP_CONTAINS(IFNULL(ei.motivo_atendimento,''), r'(?i)\b(sem\s+cura|n[aã]o\s+cura)\b')
    THEN 'Sim'
    ELSE 'Não'
  END AS Cura
FROM universo u
LEFT JOIN presc_cpfs     p  USING (paciente_cpf)
LEFT JOIN cid_cpfs       c  USING (paciente_cpf)
LEFT JOIN lista_cpfs     l  USING (paciente_cpf)
LEFT JOIN presc_meds_ult pm USING (paciente_cpf)
LEFT JOIN lista_info     li USING (paciente_cpf)
LEFT JOIN ea_info        ei USING (paciente_cpf)
WHERE u.paciente_cpf IS NOT NULL
  AND LENGTH(u.paciente_cpf) = 11
;
-- ======================================================================
-- 3) Totais por critério (consulta imediata)
-- ======================================================================
SELECT
  COUNT(*)                                          AS total_cpfs_na_tabela,
  SUM(criterio1_prescricao)                         AS total_criterio1_prescricao,
  SUM(criterio2_cid_ativo)                          AS total_criterio2_cid_ativo,
  SUM(criterio3_lista_tuberculose)                  AS total_criterio3_lista_tuberculose,
  COUNTIF(criterio1_prescricao + criterio2_cid_ativo + criterio3_lista_tuberculose > 0) AS total_pelo_menos_um_criterio
FROM `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento`;

-- =====================================================================
-- conferindo se passou alguém zerado nos critérios
--=====================================================================
SELECT
  cpf
FROM `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento`
WHERE criterio1_prescricao = 0
  AND criterio2_cid_ativo = 0
  AND criterio3_lista_tuberculose = 0
ORDER BY cpf;

--=====================================================================
-- indicando a pontuação final
--=====================================================================
-- 1) cria a coluna (se não existir)
ALTER TABLE `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento`
ADD COLUMN IF NOT EXISTS soma_criterios INT64;

-- 2) preenche a coluna
UPDATE `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento`
SET soma_criterios = criterio1_prescricao
                   + criterio2_cid_ativo
                   + criterio3_lista_tuberculose
WHERE TRUE;  -- BigQuery exige WHERE

-- ======================================================================
-- 6) Inserindo coluna tipo_sms_agrupado (via join com dados mestres)
-- ======================================================================

-- 1️⃣ Adiciona a coluna caso não exista
ALTER TABLE `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento`
ADD COLUMN IF NOT EXISTS tipo_sms_agrupado STRING;

-- 2️⃣ Atualiza os valores com base na tabela de estabelecimentos
UPDATE `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento` AS t
SET tipo_sms_agrupado = e.tipo_sms_agrupado
FROM `rj-sms.saude_dados_mestres.estabelecimento` AS e
WHERE SAFE_CAST(t.id_cnes AS STRING) = SAFE_CAST(e.id_cnes AS STRING);

-- ======================================================================
-- 7) Mantendo apenas unidades APS
-- ======================================================================
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento` AS
SELECT *
FROM `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento`
WHERE tipo_sms_agrupado = 'APS';
