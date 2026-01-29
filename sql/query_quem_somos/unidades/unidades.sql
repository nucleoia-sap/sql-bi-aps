-- ============================================================
-- 1) CRIA / RECRIA A TABELA FINAL: unidades_equipes
--    - Base mãe: estabelecimento_sus_rio_historico (A)
--    - Junta equipes: equipe_profissional_saude (B) via LEFT JOIN (mantém A mesmo sem match em B)
--    - Filtra APS: CMS/CF/CSE (mas aceita nulos/vazios para não perder unidades incompletas)
--    - Garante inclusão de CNES críticos (8078106 e 8062900)
--    - Exclui CNES 4538390
--    - Corrige campos do CNES 8078106
--    - Cria coluna "competencia" no formato MM/AAAA
-- ============================================================

CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.unidades_equipes` AS
WITH a_base AS (
  SELECT
    a.*,

    -- Normaliza id_cnes removendo espaços/brancos (para filtro/join mais robusto)
    REGEXP_REPLACE(CAST(a.id_cnes AS STRING), r'\s+', '') AS id_cnes_key
  FROM `rj-sms.saude_cnes.estabelecimento_sus_rio_historico` a
)

SELECT
  -- Traz tudo da base A, exceto colunas que vamos sobrescrever/renomear
  a.* EXCEPT(
    id_ap,
    nome_limpo,
    nome_complemento,
    tipo_sms,
    tipo_sms_simplificado,
    tipo_sms_agrupado,
    id_cnes_key
  ),

  -- Coluna concatenada de competência (MM/AAAA)
  FORMAT(
    '%02d/%04d',
    SAFE_CAST(a.mes_competencia AS INT64),
    SAFE_CAST(a.ano_competencia AS INT64)
  ) AS competencia,

  -- Renomeia id_ap -> area_programatica (e corrige manualmente para CNES 8078106)
  CASE
    WHEN a.id_cnes_key = '8078106' THEN '40'
    ELSE CAST(a.id_ap AS STRING)
  END AS area_programatica,

  -- Correções manuais para CNES 8078106 (que vem com vários campos vazios na raiz)
  CASE
    WHEN a.id_cnes_key = '8078106' THEN 'SMS CF ANDARAI AP 22'
    ELSE a.nome_limpo
  END AS nome_limpo,

  CASE
    WHEN a.id_cnes_key = '8078106' THEN 'ANDARAI AP 22'
    ELSE a.nome_complemento
  END AS nome_complemento,

  CASE
    WHEN a.id_cnes_key = '8078106' THEN 'CLINICA DA FAMILIA'
    ELSE a.tipo_sms
  END AS tipo_sms,

  CASE
    WHEN a.id_cnes_key = '8078106' THEN 'CF'
    ELSE a.tipo_sms_simplificado
  END AS tipo_sms_simplificado,

  CASE
    WHEN a.id_cnes_key = '8078106' THEN 'APS'
    ELSE a.tipo_sms_agrupado
  END AS tipo_sms_agrupado,

  -- Campos que vêm da base B (podem ficar NULL quando não existir equipe para o CNES)
  b.id_ine,
  b.equipe_tipo_descricao,
  b.nome_referencia

FROM a_base a

-- LEFT JOIN garante que registros de A permaneçam mesmo que não existam em B
LEFT JOIN `rj-sms.saude_dados_mestres.equipe_profissional_saude` b
  ON a.id_cnes_key = REGEXP_REPLACE(CAST(b.id_cnes AS STRING), r'\s+', '')

WHERE
  -- Mantém APS (CMS/CF/CSE), mas aceita nulo/vazio para não excluir unidades incompletas
  (
    a.tipo_sms_simplificado IN ('CMS','CF','CSE')
    OR a.tipo_sms_simplificado IS NULL
    OR TRIM(CAST(a.tipo_sms_simplificado AS STRING)) = ''
    -- Garante que estes CNES entrem mesmo se estiverem incompletos
    OR a.id_cnes_key IN ('8078106','8062900')
  )
  -- Exclui este CNES explicitamente
  AND a.id_cnes_key <> '4538390'
;

-- ============================================================
-- 2) CORREÇÃO PONTUAL DE LAT/LONG PARA UM CNES ESPECÍFICO
-- ============================================================

UPDATE `rj-sms-sandbox.sub_pav_us.unidades_equipes`
SET
  endereco_latitude  = -22.904063375530836,
  endereco_longitude = -43.38993528447122
WHERE REGEXP_REPLACE(CAST(id_cnes AS STRING), r'\s+', '') = '9071385';
