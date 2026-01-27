---------------------------------------------------------------------
--------------------   QUERY BASE DE CADASTROS OTIMIZADA ------------
---------------------------------------------------------------------

-- Fonte primária: `rj-sms.brutos_prontuario_vitacare_historico.cadastro`

-- PASSO 1: Preparação Inicial, Limpeza Básica e Criação de ID Único
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.base_preparada_teste1` AS
WITH
  FonteDeDados AS (
    SELECT DISTINCT *
    FROM `rj-sms.brutos_prontuario_vitacare_historico.cadastro`
  ),
  DadosComTimestampsEFlags AS (
    SELECT
      *,
      SAFE_CAST(data_cadastro AS DATETIME) AS data_cadastro_ts,
      SAFE_CAST(loaded_at AS DATETIME)   AS loaded_at_dt,
      CASE
        WHEN
          cpf IS NULL OR
          TRIM(cpf) = '' OR
          LOWER(TRIM(cpf)) IN ('na', 'n/a', 'não informado', 'none', 'teste') OR
          cpf = '00000000000' OR
          cpf IN ('11111111111','22222222222','33333333333','44444444444',
                  '55555678901','66666666666','77777777777','88888888888','99999999999') OR
          LENGTH(cpf) != 11 OR
          REGEXP_CONTAINS(cpf, r'[^0-9]')
        THEN 'Não'
        ELSE 'Sim'
      END AS cpf_valido
    FROM FonteDeDados
  ),
  LimpezaDeNomes AS (
    SELECT
      *,
      CASE
        WHEN REGEXP_CONTAINS(LOWER(TRIM(nome)), r'^(ignorado|nao informado|nao tem|nao possui|nao consta|sem informar|mae desconhecida|test|pacient|rn )')
        THEN NULL
        ELSE TRIM(
               REGEXP_REPLACE(
                 REGEXP_REPLACE(
                   REGEXP_REPLACE(
                     NORMALIZE(LOWER(TRIM(nome)), NFD),
                     r'\b(de|da|do|das|dos|a|o|as|os|e)\b', ' '
                   ),
                   r'[^a-z ]', ''
                 ),
                 r'\s+', ' '
               )
             )
      END AS nome_normalizado
    FROM DadosComTimestampsEFlags
  )
SELECT
  * EXCEPT (nome_normalizado, data_cadastro_ts, loaded_at_dt),
  TO_HEX(
    SHA256(
      CONCAT(
        COALESCE(nome_normalizado, 'sem_nome'),'_',
        COALESCE(FORMAT_DATE('%Y-%m-%d', SAFE_CAST(data_nascimento AS DATE)), 'sem_data')
      )
    )
  ) AS id_unico_preciso,
  data_cadastro_ts,
  loaded_at_dt
FROM LimpezaDeNomes;

-- PASSO 2: Filtro de ativos/permanentes/testes/datas
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.base_filtrada_teste2` AS
WITH BasePreProcessada AS (
  SELECT
    *,
    REGEXP_REPLACE(NORMALIZE(LOWER(TRIM(nome)), NFD), r'\pM', '') AS nome_limpo_para_filtro
  FROM `rj-sms-sandbox.sub_pav_us.base_preparada_teste1`
)
SELECT
  * EXCEPT(nome_limpo_para_filtro)
FROM BasePreProcessada
WHERE
  situacao_usuario = 'Ativo'
  AND cadastro_permanente = TRUE
  AND (obito IS NULL OR obito = FALSE)
  AND LOWER(nome) NOT LIKE 'teste%'
  AND LOWER(nome) <> 'testes'
  AND NOT (
    nome_limpo_para_filtro LIKE '%teste%' OR
    nome_limpo_para_filtro LIKE '%exemplo%' OR
    nome_limpo_para_filtro LIKE 'ignorado%' OR
    nome_limpo_para_filtro LIKE 'nao informado%' OR
    nome_limpo_para_filtro LIKE 'aguardando%' OR
    nome_limpo_para_filtro LIKE 'paciente padrao%' OR
    LENGTH(nome_limpo_para_filtro) <= 1 OR
    REGEXP_CONTAINS(nome_limpo_para_filtro, r'[0-9]') OR
    nome_limpo_para_filtro IN ('sem nome','nao tem','nao possui','desconhecido')
  )
  AND EXTRACT(YEAR FROM SAFE_CAST(data_cadastro AS DATE)) <= 2025;

-- PASSO 3: Deduplicação e qualificação por CPF
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.base_qualificada_teste3` AS
SELECT
  * EXCEPT (
      raca_cor, sexo, data_nascimento, nome_mae, nome_pai, nacionalidade, pais_nascimento,
      municipio_nascimento, estado_nascimento, identidade_genero, orientacao_sexual,
      data_cadastro_ts, loaded_at_dt
  ),
  FIRST_VALUE(NULLIF(TRIM(raca_cor), '') IGNORE NULLS) OVER (PARTITION BY cpf ORDER BY data_cadastro_ts DESC, loaded_at_dt DESC) AS raca_cor,
  FIRST_VALUE(NULLIF(TRIM(sexo), '') IGNORE NULLS) OVER (PARTITION BY cpf ORDER BY data_cadastro_ts DESC, loaded_at_dt DESC) AS sexo,
  FIRST_VALUE(data_nascimento IGNORE NULLS) OVER (PARTITION BY cpf ORDER BY data_cadastro_ts DESC, loaded_at_dt DESC) AS data_nascimento,
  FIRST_VALUE(NULLIF(TRIM(nome_mae), '') IGNORE NULLS) OVER (PARTITION BY cpf ORDER BY data_cadastro_ts DESC, loaded_at_dt DESC) AS nome_mae,
  FIRST_VALUE(NULLIF(TRIM(nome_pai), '') IGNORE NULLS) OVER (PARTITION BY cpf ORDER BY data_cadastro_ts DESC, loaded_at_dt DESC) AS nome_pai,
  FIRST_VALUE(NULLIF(TRIM(nacionalidade), '') IGNORE NULLS) OVER (PARTITION BY cpf ORDER BY data_cadastro_ts DESC, loaded_at_dt DESC) AS nacionalidade,
  FIRST_VALUE(NULLIF(TRIM(pais_nascimento), '') IGNORE NULLS) OVER (PARTITION BY cpf ORDER BY data_cadastro_ts DESC, loaded_at_dt DESC) AS pais_nascimento,
  FIRST_VALUE(NULLIF(TRIM(municipio_nascimento), '') IGNORE NULLS) OVER (PARTITION BY cpf ORDER BY data_cadastro_ts DESC, loaded_at_dt DESC) AS municipio_nascimento_nome,
  FIRST_VALUE(NULLIF(TRIM(estado_nascimento), '') IGNORE NULLS) OVER (PARTITION BY cpf ORDER BY data_cadastro_ts DESC, loaded_at_dt DESC) AS estado_nascimento,
  FIRST_VALUE(NULLIF(TRIM(identidade_genero), '') IGNORE NULLS) OVER (PARTITION BY cpf ORDER BY data_cadastro_ts DESC, loaded_at_dt DESC) AS identidade_genero,
  FIRST_VALUE(NULLIF(TRIM(orientacao_sexual), '') IGNORE NULLS) OVER (PARTITION BY cpf ORDER BY data_cadastro_ts DESC, loaded_at_dt DESC) AS orientacao_sexual,
  data_cadastro_ts,
  loaded_at_dt
FROM `rj-sms-sandbox.sub_pav_us.base_filtrada_teste2`
WHERE cpf_valido = 'Sim'
QUALIFY ROW_NUMBER() OVER (PARTITION BY cpf ORDER BY data_cadastro_ts DESC, loaded_at_dt DESC) = 1;

-- PASSO 4: Auxiliares (idade, faixa etária, flags)
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.base_com_auxiliares_teste4` AS
SELECT
  *,
  DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) AS idade,
  CASE
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) IS NULL THEN 'Não informado'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 0  AND 4  THEN '00-04 anos'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 5  AND 9  THEN '05-09 anos'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 10 AND 14 THEN '10-14 anos'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 15 AND 19 THEN '15-19 anos'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 20 AND 24 THEN '20-24 anos'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 25 AND 29 THEN '25-29 anos'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 30 AND 34 THEN '30-34 anos'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 35 AND 39 THEN '35-39 anos'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 40 AND 44 THEN '40-44 anos'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 45 AND 49 THEN '45-49 anos'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 50 AND 54 THEN '50-54 anos'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 55 AND 59 THEN '55-59 anos'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 60 AND 64 THEN '60-64 anos'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 65 AND 69 THEN '65-69 anos'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 70 AND 74 THEN '70-74 anos'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 75 AND 79 THEN '75-79 anos'
    WHEN DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) >= 80 THEN '80+ anos'
    ELSE 'Não classificado'
  END AS fx_etaria,
  (DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) = 0) AS flag_menor_1_ano,
  (DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) < 6) AS flag_menor_2_anos,
  (sexo = 'Feminino' AND DATE_DIFF(CURRENT_DATE(), SAFE_CAST(data_nascimento AS DATE), YEAR) BETWEEN 10 AND 49) AS flag_mif
FROM `rj-sms-sandbox.sub_pav_us.base_qualificada_teste3`;

-- PASSO 5: BF/CFC
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.base_com_bf_cfc_teste5` AS
WITH
  a_com_nome_normalizado AS (
    SELECT
      *,
      REGEXP_REPLACE(NORMALIZE(LOWER(TRIM(nome)), NFD), r'\pM', '') AS nome_normalizado
    FROM `rj-sms-sandbox.sub_pav_us.base_com_auxiliares_teste4`
  ),
  b_beneficiarios_dedup AS (
    SELECT
      CAST(cpf AS STRING) AS cpf,
      REGEXP_REPLACE(NORMALIZE(LOWER(TRIM(nome_do_beneficiario)), NFD), r'\pM', '') AS nome_normalizado_b,
      data_nascimento AS data_nascimento_b,
      bf,
      cfc
    FROM (
      SELECT
        b.cpf, b.nome_do_beneficiario, b.data_nascimento, b.bf, b.cfc,
        ROW_NUMBER() OVER (
          PARTITION BY
            CASE WHEN b.cpf IS NOT NULL AND TRIM(CAST(b.cpf AS STRING)) != '' THEN CAST(b.cpf AS STRING) ELSE NULL END,
            CASE WHEN b.cpf IS NULL OR TRIM(CAST(b.cpf AS STRING)) = '' THEN CONCAT(REGEXP_REPLACE(NORMALIZE(LOWER(TRIM(b.nome_do_beneficiario)), NFD), r'\pM', ''), '_', b.data_nascimento) ELSE NULL END
          ORDER BY b.bf DESC, b.cfc DESC
        ) AS rn
      FROM `rj-sms-sandbox.sub_pav_us.beneficiarios_bf_cfc` b
      WHERE b.cpf IS NOT NULL OR b.data_nascimento IS NOT NULL
    )
    WHERE rn = 1
  )
SELECT
  a.* EXCEPT(nome_normalizado),
  COALESCE(b_cpf.bf,  b_nome.bf)  AS bf_externo,
  COALESCE(b_cpf.cfc, b_nome.cfc) AS cfc_externo
FROM a_com_nome_normalizado a
LEFT JOIN b_beneficiarios_dedup b_cpf
  ON CAST(a.cpf AS STRING) = b_cpf.cpf
LEFT JOIN b_beneficiarios_dedup b_nome
  ON b_cpf.cpf IS NULL
  AND a.data_nascimento = b_nome.data_nascimento_b
  AND a.nome_normalizado = b_nome.nome_normalizado_b;

-- PASSO 6: Qualificação final + nomes de referência
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.base_final_pre_gestante_teste6` AS
SELECT
  a.* EXCEPT(bf_externo, cfc_externo, municipio_nascimento_nome),
  COALESCE(NULLIF(a.bf_externo, ''),  CASE WHEN a.familia_beneficiaria_auxilio_brasil = TRUE THEN 'SIM' WHEN a.familia_beneficiaria_auxilio_brasil = FALSE THEN 'NAO' ELSE NULL END) AS bf,
  COALESCE(NULLIF(a.cfc_externo, ''), CASE WHEN a.familia_beneficiaria_cfc          = TRUE THEN 'SIM' WHEN a.familia_beneficiaria_cfc          = FALSE THEN 'NAO' ELSE NULL END) AS cfc,
  CASE
    WHEN LOWER(TRIM(a.identidade_genero)) IN ('sim','não') THEN 'Preenchimento inadequado (Sim/Não)'
    WHEN LOWER(TRIM(a.identidade_genero)) = 'travesti' THEN 'Travesti'
    WHEN LOWER(TRIM(a.identidade_genero)) IN ('mulher transgãªnero','mulher transexual') THEN 'Mulher Transgênero'
    WHEN LOWER(TRIM(a.identidade_genero)) IN ('homem transgãªnero','homem transexual')  THEN 'Homem Transgênero'
    WHEN LOWER(TRIM(a.identidade_genero)) = 'mulher cisgãªnero' THEN 'Mulher Cisgênero'
    WHEN LOWER(TRIM(a.identidade_genero)) = 'homem cisgãªnero'  THEN 'Homem Cisgênero'
    WHEN LOWER(TRIM(a.identidade_genero)) = 'nã£o binã¡rio'     THEN 'Não Binário'
    WHEN LOWER(TRIM(a.identidade_genero)) = 'cis'               THEN 'Cisgênero (não especificado)'
    WHEN LOWER(TRIM(a.identidade_genero)) = 'outro'             THEN 'Outro'
    ELSE NULL
  END AS id_genero_qualificada,
  b_equipe.nome_referencia      AS nome_referencia_equipe,
  b_estabelecimento.nome_limpo  AS nome_unidade_limpo
FROM `rj-sms-sandbox.sub_pav_us.base_com_bf_cfc_teste5` a
LEFT JOIN `rj-sms.saude_dados_mestres.equipe_profissional_saude` AS b_equipe
  ON a.ine_equipe = b_equipe.id_ine
LEFT JOIN `rj-sms.saude_dados_mestres.estabelecimento` AS b_estabelecimento
  ON a.id_cnes = b_estabelecimento.ID_CNES;

-- PASSO 7: Gestação + Escolaridade + dedup final
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Ativos_final` AS
WITH
  base_gestantes_dedup AS (
    SELECT
      cpf, fase_atual,
      ROW_NUMBER() OVER (PARTITION BY cpf ORDER BY data_inicio DESC) AS rn
    FROM `rj-sms.projeto_gestacoes.linha_tempo`
    WHERE cpf IS NOT NULL
  ),
  BaseComGestacaoEEscolaridade AS (
    SELECT
      a.*,
      CASE WHEN b.cpf IS NOT NULL THEN 'SIM' ELSE 'NAO' END AS gestante,
      b.fase_atual,
      CASE
        WHEN a.escolaridade IS NULL THEN 'Ign/Branco'
        WHEN a.escolaridade = 'Não sabe ler/escrever' THEN 'Analfabeto'
        WHEN a.escolaridade = 'Alfabetizado' THEN 'Alfabetizado'
        WHEN a.escolaridade IN ('4º Ano/3ª Série','Fundamental Incompleto') THEN 'Fund. Incomp.'
        WHEN a.escolaridade = 'Fundamental Completo' THEN 'Fund. Comp.'
        WHEN a.escolaridade = 'Médio Incompleto' THEN 'Médio Incomp.'
        WHEN a.escolaridade = 'Médio Completo' THEN 'Médio Comp.'
        WHEN a.escolaridade = 'Superior incompleto' THEN 'Sup. Incomp.'
        WHEN a.escolaridade = 'Superior completo' THEN 'Sup. Comp.'
        WHEN a.escolaridade = 'Especialização/Residência' THEN 'Pós-grad.'
        WHEN a.escolaridade IN ('Mestrado','Doutorado') THEN 'Mest/Dout'
        WHEN a.escolaridade = 'Creche ou Pré-escola' THEN 'Creche/Pré-Escola'
        ELSE 'Outros'
      END AS escolaridade_nova,
      CASE
        WHEN a.escolaridade = 'Não sabe ler/escrever' THEN 1
        WHEN a.escolaridade = 'Alfabetizado' THEN 2
        WHEN a.escolaridade IN ('4º Ano/3ª Série','Fundamental Incompleto') THEN 3
        WHEN a.escolaridade = 'Fundamental Completo' THEN 4
        WHEN a.escolaridade = 'Médio Incompleto' THEN 5
        WHEN a.escolaridade = 'Médio Completo' THEN 6
        WHEN a.escolaridade = 'Superior incompleto' THEN 7
        WHEN a.escolaridade = 'Superior completo' THEN 8
        WHEN a.escolaridade = 'Especialização/Residência' THEN 9
        WHEN a.escolaridade IN ('Mestrado','Doutorado') THEN 10
        WHEN a.escolaridade = 'Creche ou Pré-escola' THEN 2.5
        WHEN a.escolaridade IS NULL THEN 98
        ELSE 99
      END AS escolaridade_ordem
    FROM `rj-sms-sandbox.sub_pav_us.base_final_pre_gestante_teste6` a
    LEFT JOIN base_gestantes_dedup b ON a.cpf = b.cpf AND b.rn = 1
  )
SELECT * FROM BaseComGestacaoEEscolaridade
QUALIFY ROW_NUMBER() OVER (PARTITION BY cpf ORDER BY data_cadastro_ts DESC, loaded_at_dt DESC) = 1;

-- =========================================================
-- ROTINA COMPLETA: atualiza Ativos_final e recria Anonimizada (TABLE)
-- =========================================================

-- ---------------------------------------------------------
-- (1) TUBERCULOSE: criar colunas e preencher em Ativos_final
-- ---------------------------------------------------------
ALTER TABLE `rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Ativos_final`
ADD COLUMN IF NOT EXISTS tuberculose BOOL,
ADD COLUMN IF NOT EXISTS tuberculose_cid_ativo INT64;

-- tuberculose = TRUE se CPF estiver em _tuberculose_em_tratamento
UPDATE `rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Ativos_final` AS v
SET v.tuberculose = TRUE
FROM `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento` AS t
WHERE REGEXP_REPLACE(TRIM(t.cpf), r'\D', '') = REGEXP_REPLACE(TRIM(v.cpf), r'\D', '')
  AND LENGTH(REGEXP_REPLACE(TRIM(t.cpf), r'\D', '')) = 11;

-- quem não recebeu TRUE vira FALSE
UPDATE `rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Ativos_final`
SET tuberculose = FALSE
WHERE tuberculose IS NULL;

-- copia o valor de criterio2_cid_ativo (0/1)
UPDATE `rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Ativos_final` AS v
SET v.tuberculose_cid_ativo = t.criterio2_cid_ativo
FROM `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento` AS t
WHERE REGEXP_REPLACE(TRIM(t.cpf), r'\D', '') = REGEXP_REPLACE(TRIM(v.cpf), r'\D', '')
  AND LENGTH(REGEXP_REPLACE(TRIM(t.cpf), r'\D', '')) = 11;

------------------------------------------------------------
-- (2) HANSENÍASE: criar colunas e preencher em Ativos_final
-- ---------------------------------------------------------
ALTER TABLE `rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Ativos_final`
ADD COLUMN IF NOT EXISTS hanseniase BOOL,
ADD COLUMN IF NOT EXISTS hanseniase_cid_ativo INT64;

-- hanseniase = TRUE se CPF estiver em _hanseniase_em_tratamento
UPDATE `rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Ativos_final` AS v
SET v.hanseniase = TRUE
FROM `rj-sms-sandbox.sub_pav_us._hanseniase_em_tratamento` AS h
WHERE
  REGEXP_REPLACE(TRIM(h.cpf), r'\D', '') = REGEXP_REPLACE(TRIM(v.cpf), r'\D', '')
  AND LENGTH(REGEXP_REPLACE(TRIM(h.cpf), r'\D', '')) = 11;

-- quem não recebeu TRUE vira FALSE
UPDATE `rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Ativos_final`
SET hanseniase = FALSE
WHERE hanseniase IS NULL;

-- copia o valor de criterio2_cid_ativo (0/1) da base de hanseníase
UPDATE `rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Ativos_final` AS v
SET v.hanseniase_cid_ativo = h.criterio2_cid_ativo
FROM `rj-sms-sandbox.sub_pav_us._hanseniase_em_tratamento` AS h
WHERE
  REGEXP_REPLACE(TRIM(h.cpf), r'\D', '') = REGEXP_REPLACE(TRIM(v.cpf), r'\D', '')
  AND LENGTH(REGEXP_REPLACE(TRIM(h.cpf), r'\D', '')) = 11;

-- ---------------------------------------------------------
-- (2) AGRAVOS CRÔNICOS: criar colunas e preencher
-- ---------------------------------------------------------
ALTER TABLE `rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Ativos_final`
ADD COLUMN IF NOT EXISTS DM                BOOL,
ADD COLUMN IF NOT EXISTS HAS               BOOL,
ADD COLUMN IF NOT EXISTS SIDA              BOOL,
ADD COLUMN IF NOT EXISTS OBESIDADE         BOOL,
ADD COLUMN IF NOT EXISTS POLIFARMACIA      BOOL,
ADD COLUMN IF NOT EXISTS HIPERPOLIFARMACIA BOOL,
ADD COLUMN IF NOT EXISTS TABACO            BOOL,
ADD COLUMN IF NOT EXISTS PRE_DM            BOOL;

UPDATE `rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Ativos_final` v
SET
  DM                = COALESCE(m.DM, FALSE),
  HAS               = COALESCE(m.HAS, FALSE),
  SIDA              = COALESCE(m.SIDA, FALSE),
  OBESIDADE         = COALESCE(m.OBESIDADE, FALSE),
  POLIFARMACIA      = COALESCE(m.POLIFARMACIA, FALSE),
  HIPERPOLIFARMACIA = COALESCE(m.HIPERPOLIFARMACIA, FALSE),
  TABACO            = COALESCE(m.TABACO, FALSE),
  PRE_DM            = COALESCE(m.PRE_DM, FALSE)
FROM (
  SELECT
    REGEXP_REPLACE(TRIM(cpf), r'\D', '') AS cpf_norm,
    LOGICAL_OR(HAS)               AS HAS,
    LOGICAL_OR(DM)                AS DM,
    LOGICAL_OR(SIDA)              AS SIDA,
    LOGICAL_OR(obesidade)         AS OBESIDADE,
    LOGICAL_OR(polifarmacia)      AS POLIFARMACIA,
    LOGICAL_OR(hiperpolifarmacia) AS HIPERPOLIFARMACIA,
    LOGICAL_OR(tabaco)            AS TABACO,
    LOGICAL_OR(pre_DM)            AS PRE_DM
  FROM `rj-sms-sandbox.sub_pav_us.morbidades_20251015`
  WHERE cpf IS NOT NULL
    AND LENGTH(REGEXP_REPLACE(TRIM(cpf), r'\D', '')) = 11
  GROUP BY cpf_norm
) AS m
WHERE REGEXP_REPLACE(TRIM(v.cpf), r'\D', '') = m.cpf_norm
  AND LENGTH(REGEXP_REPLACE(TRIM(v.cpf), r'\D', '')) = 11;

-- ---------------------------------------------------------
-- (3) RECRIA A BASE DO DASHBOARD (ANONIMIZADA) COMO TABELA
--     -> Sempre substitui a existente
--     -> Remove sensíveis/menos úteis e renomeia campos
-- ---------------------------------------------------------

-- elimina a tabela antiga para evitar conflito de particionamento/clusterização
DROP TABLE IF EXISTS `rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Anonimizada`;

-- recria a tabela final do dashboard a partir da Ativos_final
CREATE TABLE `rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Anonimizada` AS
WITH base AS (
  SELECT
    -- remove informações sensíveis / pouco úteis
    * EXCEPT(
      nome, nome_social, nome_mae, nome_pai,
      comodos, destino_lixo, luz_eletrica, tempo_moradia, tipo_domicilio,
      tipo_logradouro, tratamento_agua, meios_transporte, possui_filtro_agua,
      esgotamento_sanitario, familia_localizacao
    )
  FROM `rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Ativos_final`
)
SELECT
  -- mantém tudo que sobrou e aplica renomes desejados
  base.* EXCEPT (id_cnes, unidade, ap, equipe),
  id_cnes AS unidade_cadastro,
  unidade AS unidade_nome,
  ap      AS ap_cadastro,
  equipe  AS equipe_nome
FROM base;

-- ---------------------------------------------------------
-- (4) (Opcional) VALIDAÇÕES RÁPIDAS
-- ---------------------------------------------------------
-- checar nulos em tuberculose
SELECT COUNT(*) AS n_nulls_tuberculose
FROM `rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Anonimizada`
WHERE tuberculose IS NULL;

-- distribuição de tuberculose_cid_ativo
SELECT tuberculose_cid_ativo, COUNT(*) AS n
FROM `rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Anonimizada`
GROUP BY tuberculose_cid_ativo;
