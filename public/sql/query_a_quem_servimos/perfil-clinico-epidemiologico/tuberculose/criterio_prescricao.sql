
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