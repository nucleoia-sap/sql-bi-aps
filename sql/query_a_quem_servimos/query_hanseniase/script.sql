-- ======================================================================
-- Parâmetro dinâmico: 18 meses antes da execução
-- ======================================================================
DECLARE data_corte DATETIME DEFAULT DATETIME_SUB(CURRENT_DATETIME(), INTERVAL 18 MONTH);

-- ======================================================================
-- 1) LISTA DE HANSENÍASE COM CPF (chave: id_cnes|'|'|id_prontuario_local)
--    Fonte sem CPF: rj-sms.brutos_prontuario_vitacare_historico.hanseniase
--    CPF via ACTO:  rj-sms.brutos_prontuario_vitacare_historico.acto
-- ======================================================================
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us._hanseniase_lista_com_cpf` AS
WITH
hs_base AS (
  SELECT
    TRIM(id_cnes) AS id_cnes_norm,
    TRIM(id_prontuario_local) AS id_pl_norm,
    CONCAT(TRIM(id_cnes), '|', TRIM(id_prontuario_local)) AS chave_hs,
    h.*
  FROM `rj-sms.brutos_prontuario_vitacare_historico.hanseniase` h
),
acto_base AS (
  SELECT
    TRIM(id_cnes) AS id_cnes_norm,
    TRIM(id_prontuario_local) AS id_pl_norm,
    CONCAT(TRIM(id_cnes), '|', TRIM(id_prontuario_local)) AS chave_hs,
    REGEXP_REPLACE(TRIM(patient_cpf), r'\D', '') AS paciente_cpf_digits
  FROM `rj-sms.brutos_prontuario_vitacare_historico.acto`
  WHERE patient_cpf IS NOT NULL
    AND LENGTH(TRIM(patient_cpf)) > 0
),
acto_chave_cpf AS (
  SELECT
    chave_hs,
    ANY_VALUE(paciente_cpf_digits) AS paciente_cpf_digits
  FROM acto_base
  WHERE chave_hs IS NOT NULL
    AND paciente_cpf_digits IS NOT NULL
    AND LENGTH(paciente_cpf_digits) = 11
  GROUP BY chave_hs
)
SELECT
  hs.*,
  ac.paciente_cpf_digits AS paciente_cpf
FROM hs_base hs
LEFT JOIN acto_chave_cpf ac
  ON hs.chave_hs = ac.chave_hs
;

-- ======================================================================
-- 2) TABELA FINAL: _hanseniase_em_tratamento
--    Critérios:
--    (1) Prescrição relevante
--    (2) CID A30* ativo na janela e ativo no registro mais recente
--    (3) Presença na lista de Hanseníase (com CPF)
-- ======================================================================
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us._hanseniase_em_tratamento` AS
WITH
/* 2.1) PRESCRIÇÕES RELEVANTES (EA)
   - Rifampicina + Clofazimina + Dapsona (padrão)
   - OU (qualquer 2 desses) + (Ofloxacino OU Minociclina)
*/
hs_prescricao_raw AS (
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
    AND REGEXP_CONTAINS(
          LOWER(p.nome),
          r'rifampicin|rifampicina|clofazim|clofazimina|dapson|dapsona|ofloxac|ofloxacino|minociclin|minociclina'
        )
),
tokens AS (
  SELECT
    paciente_cpf,
    data_prescricao,
    LOWER(TRIM(tok)) AS tok
  FROM hs_prescricao_raw,
  UNNEST(SPLIT(REGEXP_REPLACE(nome_medicamento, r'\+', ','))) AS tok
),
flags_base AS (
  SELECT
    paciente_cpf,
    data_prescricao,
    COUNTIF(REGEXP_CONTAINS(tok, r'rifampicin|rifampicina')) > 0 AS has_rifa,
    COUNTIF(REGEXP_CONTAINS(tok, r'clofazim|clofazimina'))    > 0 AS has_clofa,
    COUNTIF(REGEXP_CONTAINS(tok, r'dapson|dapsona'))          > 0 AS has_dapso,
    COUNTIF(REGEXP_CONTAINS(tok, r'ofloxac|ofloxacino'))      > 0 AS has_oflox,
    COUNTIF(REGEXP_CONTAINS(tok, r'minociclin|minociclina'))  > 0 AS has_minoc
  FROM tokens
  GROUP BY paciente_cpf, data_prescricao
),
esquema_por_consulta AS (
  SELECT
    paciente_cpf,
    data_prescricao,
    has_rifa, has_clofa, has_dapso, has_oflox, has_minoc,
    (CAST(has_rifa AS INT64) + CAST(has_clofa AS INT64) + CAST(has_dapso AS INT64)) AS cnt_base3,
    CASE
      WHEN (has_rifa AND has_clofa AND has_dapso) THEN 'PADRAO_RCD'
      WHEN ( (CAST(has_rifa AS INT64)+CAST(has_clofa AS INT64)+CAST(has_dapso AS INT64)) >= 2
             AND (has_oflox OR has_minoc) ) THEN 'BASE2_PLUS_ADJ'
      ELSE NULL
    END AS tipo_esquema
  FROM flags_base
),
consultas_validas AS (
  SELECT
    e.paciente_cpf,
    e.data_prescricao,
    e.tipo_esquema,
    ARRAY_TO_STRING(
      ARRAY(
        SELECT med FROM UNNEST([
          IF(e.has_rifa, 'rifampicina', NULL),
          IF(e.has_clofa, 'clofazimina', NULL),
          IF(e.has_dapso, 'dapsona', NULL),
          IF(e.has_oflox,'ofloxacino', NULL),
          IF(e.has_minoc,'minociclina', NULL)
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

/* 2.2) CID — A30* (Hanseníase)
   Regra: teve ativo em algum momento nos últimos 18 meses (independente do status atual)
   Mantém apenas a linha mais recente por pessoa
*/
cid_eventos AS (
  SELECT
    REGEXP_REPLACE(TRIM(ea.paciente_cpf), r'\D', '') AS paciente_cpf,
    UPPER(TRIM(c.situacao)) AS situacao_norm,
    IFNULL(SAFE_CAST(c.data_diagnostico AS DATETIME), ea.entrada_datahora) AS dt_ref
  FROM `rj-sms.saude_historico_clinico.episodio_assistencial` AS ea,
       UNNEST(ea.condicoes) AS c
  WHERE
    LOWER(c.id) LIKE 'a30%'  -- CID A30 = hanseníase
    AND IFNULL(SAFE_CAST(c.data_diagnostico AS DATETIME), ea.entrada_datahora) >= data_corte
    AND ea.paciente_cpf IS NOT NULL
    AND LENGTH(TRIM(ea.paciente_cpf)) = 11
),

-- Linha mais recente por CPF
cid_ultimo AS (
  SELECT
    paciente_cpf,
    situacao_norm,
    dt_ref
  FROM (
    SELECT
      paciente_cpf,
      situacao_norm,
      dt_ref,
      ROW_NUMBER() OVER (PARTITION BY paciente_cpf ORDER BY dt_ref DESC) AS rn
    FROM cid_eventos
  )
  WHERE rn = 1
),

-- Quem teve ATIVO em algum momento (nos últimos 18 meses)
cid_teve_ativo AS (
  SELECT DISTINCT paciente_cpf
  FROM cid_eventos
  WHERE situacao_norm = 'ATIVO'
),

-- Mantém a linha mais recente dessas pessoas
cid_cpfs AS (
  SELECT u.*
  FROM cid_ultimo u
  JOIN cid_teve_ativo t USING (paciente_cpf)
),


/* 2.3) Lista Hanseníase (por CPF) */
lista_info AS (
  SELECT
    REGEXP_REPLACE(TRIM(paciente_cpf), r'\D', '') AS paciente_cpf,
    numero_sinan_hansen AS num_sinan,
    id_cnes AS id_cnes_lista
  FROM (
    SELECT
      paciente_cpf,
      numero_sinan_hansen,
      id_cnes,
      data_inicio_tratamento,
      ROW_NUMBER() OVER (PARTITION BY paciente_cpf ORDER BY data_inicio_tratamento DESC) AS rn
    FROM `rj-sms-sandbox.sub_pav_us._hanseniase_lista_com_cpf`
    WHERE data_inicio_tratamento >= data_corte
      AND paciente_cpf IS NOT NULL AND LENGTH(TRIM(paciente_cpf)) > 0
  )
  WHERE rn = 1
    AND LENGTH(REGEXP_REPLACE(TRIM(paciente_cpf), r'\D', '')) = 11
),
lista_cpfs AS (
  SELECT DISTINCT REGEXP_REPLACE(TRIM(paciente_cpf), r'\D', '') AS paciente_cpf
  FROM `rj-sms-sandbox.sub_pav_us._hanseniase_lista_com_cpf`
  WHERE data_inicio_tratamento >= data_corte
    AND paciente_cpf IS NOT NULL
    AND LENGTH(TRIM(paciente_cpf)) > 0
    AND LENGTH(REGEXP_REPLACE(TRIM(paciente_cpf), r'\D', '')) = 11
),

/* 2.4) EA — mais recente na janela (traz também nome da unidade do EA) */
ea_info AS (
  SELECT
    paciente_cpf,
    motivo_atendimento,
    desfecho_atendimento,
    estabelecimento.id_cnes  AS id_cnes_ea,
    estabelecimento.nome     AS unidade_nome_ea
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

/* 2.5) UNIVERSO DE CPFs presentes em qualquer critério */
universo AS (
  SELECT paciente_cpf FROM presc_cpfs
  UNION DISTINCT SELECT paciente_cpf FROM cid_cpfs
  UNION DISTINCT SELECT paciente_cpf FROM lista_cpfs
)

-- 2.6) TABELA FINAL (sem dependência de dimensão externa)
SELECT
  u.paciente_cpf AS cpf,

  -- Critérios
  IF(p.paciente_cpf IS NOT NULL, 1, 0) AS criterio1_prescricao,
  IF(c.paciente_cpf IS NOT NULL, 1, 0) AS criterio2_cid_ativo,
  IF(l.paciente_cpf IS NOT NULL, 1, 0) AS criterio3_lista_hanseniase,

  -- Informações úteis
  pm.medicamentos_prescritos_mais_recente,
  li.num_sinan,

  -- CNES prioritário da lista; fallback para EA
  COALESCE(li.id_cnes_lista, ei.id_cnes_ea) AS id_cnes,

  -- Nome da unidade: usa o nome do EA; se não houver, mostra o CNES como texto
  COALESCE(ei.unidade_nome_ea,
           CONCAT('CNES ', COALESCE(li.id_cnes_lista, ei.id_cnes_ea))) AS unidade_cadastro,

  ei.motivo_atendimento,
  ei.desfecho_atendimento

FROM universo u
LEFT JOIN presc_cpfs     p      USING (paciente_cpf)
LEFT JOIN cid_cpfs       c      USING (paciente_cpf)
LEFT JOIN lista_cpfs     l      USING (paciente_cpf)
LEFT JOIN presc_meds_ult pm     USING (paciente_cpf)
LEFT JOIN lista_info     li     USING (paciente_cpf)
LEFT JOIN ea_info        ei     USING (paciente_cpf)
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
  SUM(criterio3_lista_hanseniase)                   AS total_criterio3_lista_hanseniase,
  COUNTIF(criterio1_prescricao + criterio2_cid_ativo + criterio3_lista_hanseniase > 0) AS total_pelo_menos_um_criterio
FROM `rj-sms-sandbox.sub_pav_us._hanseniase_em_tratamento`;

-- =====================================================================
-- 4) Conferindo se passou alguém zerado nos critérios
-- =====================================================================
SELECT
  cpf
FROM `rj-sms-sandbox.sub_pav_us._hanseniase_em_tratamento`
WHERE criterio1_prescricao = 0
  AND criterio2_cid_ativo = 0
  AND criterio3_lista_hanseniase = 0
ORDER BY cpf;

-- =====================================================================
-- 5) soma_criterios
-- =====================================================================
ALTER TABLE `rj-sms-sandbox.sub_pav_us._hanseniase_em_tratamento`
ADD COLUMN IF NOT EXISTS soma_criterios INT64;

UPDATE `rj-sms-sandbox.sub_pav_us._hanseniase_em_tratamento`
SET soma_criterios = criterio1_prescricao
                   + criterio2_cid_ativo
                   + criterio3_lista_hanseniase
WHERE TRUE;

-- ======================================================================
-- 6) Inserindo coluna tipo_sms_agrupado (via join com dados mestres)
-- ======================================================================

-- 1️⃣ Adiciona a coluna caso não exista
ALTER TABLE `rj-sms-sandbox.sub_pav_us._hanseniase_em_tratamento`
ADD COLUMN IF NOT EXISTS tipo_sms_agrupado STRING;

-- 2️⃣ Atualiza os valores com base na tabela de estabelecimentos
UPDATE `rj-sms-sandbox.sub_pav_us._hanseniase_em_tratamento` AS t
SET tipo_sms_agrupado = e.tipo_sms_agrupado
FROM `rj-sms.saude_dados_mestres.estabelecimento` AS e
WHERE SAFE_CAST(t.id_cnes AS STRING) = SAFE_CAST(e.id_cnes AS STRING);

-- ======================================================================
-- 7) Criando versão final apenas com APS
-- ======================================================================
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us._hanseniase_em_tratamento` AS
SELECT *
FROM `rj-sms-sandbox.sub_pav_us._hanseniase_em_tratamento`
WHERE tipo_sms_agrupado = 'APS';