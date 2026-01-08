---------------------------------------------------------------------
--------------------   QUERY BASE DE CADASTROS QUEM SOMOS-----------
---------------------------------------------------------------------
-- === DW por equipe (INE) com contagens deduplicadas e dados da unidade ===
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.dw_equipes_unidades_profissionais` AS
WITH
-- Fonte (pode ter múltiplas linhas/snapshots por INE)
eps AS (
  SELECT *
  FROM `rj-sms.saude_dados_mestres.equipe_profissional_saude`
),

-- Metadados mais recentes por INE (nome, CNES, etc.)
eps_latest AS (
  SELECT
    id_ine,
    ARRAY_AGG(STRUCT(
      nome_referencia,
      id_cnes,
      id_equipe_tipo,
      equipe_tipo_descricao,
      id_area,
      area_descricao,
      telefone AS whatsapp_equipe,
      ultima_atualizacao_infos_equipe,
      ultima_atualizacao_profissionais
    )
    ORDER BY ultima_atualizacao_infos_equipe DESC,
             SAFE.PARSE_DATE('%Y-%m-%d', NULLIF(ultima_atualizacao_profissionais,'')) DESC NULLS LAST
    LIMIT 1)[OFFSET(0)] AS s
  FROM eps
  GROUP BY id_ine
),

-- Contagens DEDUP por categoria (valem para TODAS as linhas do INE)
med AS (
  SELECT id_ine, COUNT(DISTINCT UPPER(TRIM(p))) AS numero_de_medicos
  FROM eps, UNNEST(COALESCE(medicos, [])) p
  GROUP BY id_ine
),
enf AS (
  SELECT id_ine, COUNT(DISTINCT UPPER(TRIM(p))) AS numero_de_enfermeiros
  FROM eps, UNNEST(COALESCE(enfermeiros, [])) p
  GROUP BY id_ine
),
acs AS (
  SELECT id_ine, COUNT(DISTINCT UPPER(TRIM(p))) AS numero_de_acs
  FROM eps, UNNEST(COALESCE(agentes_comunitarios, [])) p
  GROUP BY id_ine
),
tec AS (
  SELECT id_ine, COUNT(DISTINCT UPPER(TRIM(p))) AS numero_de_tecnicos
  FROM eps, UNNEST(COALESCE(auxiliares_tecnicos_enfermagem, [])) p
  GROUP BY id_ine
),
dent AS (
  SELECT id_ine, COUNT(DISTINCT UPPER(TRIM(p))) AS numero_de_dentistas
  FROM eps, UNNEST(COALESCE(dentista, [])) p
  GROUP BY id_ine
),

-- ASB/TSB (um array único): classificar por CBO e contar 1x por profissional
sb_exp AS (
  SELECT id_ine, UPPER(TRIM(p)) AS prof_id
  FROM eps, UNNEST(COALESCE(auxiliares_tecnico_saude_bucal, [])) p
),
prof_norm AS (
  SELECT
    UPPER(TRIM(p.id_profissional_sus)) AS prof_id,
    c.id_cbo, c.cbo, c.cbo_agrupador, c.cbo_familia
  FROM `rj-sms.saude_dados_mestres.profissional_saude` p
  LEFT JOIN UNNEST(p.cbo) c
),
sb_prof AS (
  SELECT e.id_ine, n.prof_id,
         UPPER(COALESCE(n.cbo, n.cbo_agrupador, n.cbo_familia, '')) AS cbo_text
  FROM sb_exp e
  LEFT JOIN prof_norm n ON n.prof_id = e.prof_id
),
sb_per_prof AS (
  SELECT
    id_ine,
    prof_id,
    MAX(REGEXP_CONTAINS(cbo_text, r'T[ÉE]CNIC[OA].*SA[UÚ]DE BUCAL|(^|[^A-Z])TSB([^A-Z]|$)')) AS has_tsb,
    MAX(REGEXP_CONTAINS(cbo_text, r'AUXILIAR.*SA[UÚ]DE BUCAL|(^|[^A-Z])ASB([^A-Z]|$)'))       AS has_asb
  FROM sb_prof
  GROUP BY id_ine, prof_id
),
sb_agg AS (
  SELECT
    id_ine,
    COUNTIF(has_tsb) AS numero_de_tsb,                     -- prioridade TSB > ASB
    COUNTIF(NOT has_tsb AND has_asb) AS numero_de_asb
  FROM sb_per_prof
  GROUP BY id_ine
),

-- Consolidado por INE
eq_counts AS (
  SELECT
    l.id_ine,
    l.s.nome_referencia,
    l.s.id_cnes,
    l.s.id_equipe_tipo,
    l.s.equipe_tipo_descricao,
    l.s.id_area,
    l.s.area_descricao,
    l.s.whatsapp_equipe,
    l.s.ultima_atualizacao_infos_equipe AS data_cadastro_equipe,

    COALESCE(med.numero_de_medicos,0)      AS numero_de_medicos,
    COALESCE(enf.numero_de_enfermeiros,0)  AS numero_de_enfermeiros,
    COALESCE(acs.numero_de_acs,0)          AS numero_de_acs,
    COALESCE(tec.numero_de_tecnicos,0)     AS numero_de_tecnicos,
    COALESCE(dent.numero_de_dentistas,0)   AS numero_de_dentistas,
    COALESCE(sb.numero_de_asb,0)           AS numero_de_asb,
    COALESCE(sb.numero_de_tsb,0)           AS numero_de_tsb
  FROM eps_latest l
  LEFT JOIN med  USING (id_ine)
  LEFT JOIN enf  USING (id_ine)
  LEFT JOIN acs  USING (id_ine)
  LEFT JOIN tec  USING (id_ine)
  LEFT JOIN dent USING (id_ine)
  LEFT JOIN sb_agg sb USING (id_ine)
),

-- Estabelecimento: último snapshot por CNES
est_latest AS (
  SELECT * EXCEPT(rn)
  FROM (
    SELECT est.*,
           ROW_NUMBER() OVER (
             PARTITION BY id_cnes
             ORDER BY data_particao DESC, data_snapshot DESC, data_carga DESC
           ) rn
    FROM `rj-sms.saude_dados_mestres.estabelecimento` est
  )
  WHERE rn = 1
)

SELECT
  e.id_ine,
  e.nome_referencia                        AS nome_equipe,
  e.id_cnes,
  est.id_unidade,
  est.nome_limpo                           AS nome_unidade,
  est.nome_acentuado,
  est.area_programatica,
  est.ativa,
  est.tipo_sms_agrupado,
  est.tipo_sms,
  est.tipo_sms_simplificado,
  est.tipo                                  AS tipo_unidade,
  est.responsavel_sms,
  est.administracao,

  -- >>> adicionados do cadastro da equipe
  e.id_equipe_tipo,
  e.equipe_tipo_descricao,

  -- Contatos e redes
  e.whatsapp_equipe,
  est.telefone                              AS telefones_unidade,   -- ARRAY<STRING>
  est.email                                 AS email_unidade,
  est.facebook, est.instagram, est.twitter,

  -- Endereço individual + concatenado
  est.endereco_bairro,
  est.endereco_logradouro,
  est.endereco_numero,
  est.endereco_complemento,
  est.endereco_cep,
  est.endereco_latitude,
  est.endereco_longitude,
  ARRAY_TO_STRING(
    ARRAY(
      SELECT x FROM UNNEST([
        est.endereco_logradouro,
        est.endereco_numero,
        est.endereco_bairro,
        est.endereco_cep
      ]) x
      WHERE x IS NOT NULL AND x != ''
    ), ', '
  ) AS endereco_completo,

  -- Datas
  COALESCE(e.data_cadastro_equipe, est.data_particao) AS data_cadastro,

  -- Métricas finais (1 linha por INE)
  1                         AS num_equipes,
  e.numero_de_medicos,
  e.numero_de_enfermeiros,
  e.numero_de_acs,
  e.numero_de_tecnicos,
  e.numero_de_dentistas,
  e.numero_de_asb,
  e.numero_de_tsb

FROM eq_counts e
LEFT JOIN est_latest est
  ON e.id_cnes = est.id_cnes;

-- Ajuste pontual de latitude/longitude
UPDATE `rj-sms-sandbox.sub_pav_us.dw_equipes_unidades_profissionais`
SET endereco_latitude  = -22.93737468843257,
    endereco_longitude = -43.38997821862196
WHERE id_cnes = '9071385';

-- Ajuste pontual de latitude/longitude
UPDATE `rj-sms-sandbox.sub_pav_us.dw_equipes_unidades_profissionais`
SET endereco_latitude  = -22.861636903102696,
    endereco_longitude = -43.23689602128584
WHERE id_cnes = '5476844';

-- Ajuste pontual de latitude/longitude
UPDATE `rj-sms-sandbox.sub_pav_us.dw_equipes_unidades_profissionais`
SET endereco_latitude  = -22.889936030457402,
    endereco_longitude = -43.245886871165126
WHERE id_cnes = '6514022';

-- Ajuste pontual de latitude/longitude
UPDATE `rj-sms-sandbox.sub_pav_us.dw_equipes_unidades_profissionais`
SET endereco_latitude  = -22.803477688696983,
    endereco_longitude = -43.17877817116512
WHERE id_cnes = '9072659';

-- Ajuste pontual de latitude/longitude
UPDATE `rj-sms-sandbox.sub_pav_us.dw_equipes_unidades_profissionais`
SET endereco_latitude  = -22.847320773151868,
    endereco_longitude = -43.396639374729304
WHERE id_cnes = '7998678';