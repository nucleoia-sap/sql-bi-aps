-- =========================================================================
-- DECLARAÇÃO DE VARIÁVEIS PARA AS COLUNAS DE CADA COMPONENTE
-- =========================================================================
DECLARE colunas_c1,
colunas_c2,
colunas_c3,
colunas_c4,
colunas_c5,
colunas_c6,
colunas_c7 STRING;

-- =========================================================================
-- PASSO 1: CAPTURA DINÂMICA DE COLUNAS (Filtrando colunas que começam com meses)
-- =========================================================================
SET
    colunas_c1 = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_c1_maisacesso_equipes'
            AND REGEXP_CONTAINS (
                column_name,
                r '^(jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)'
            )
    );

SET
    colunas_c2 = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_c2_des_inf_equipes'
            AND REGEXP_CONTAINS (
                column_name,
                r '^(jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)'
            )
    );

SET
    colunas_c3 = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_c3_gestantes_equipes'
            AND REGEXP_CONTAINS (
                column_name,
                r '^(jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)'
            )
    );

SET
    colunas_c4 = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_c4_dm_equipes'
            AND REGEXP_CONTAINS (
                column_name,
                r '^(jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)'
            )
    );

SET
    colunas_c5 = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_c5_has_equipes'
            AND REGEXP_CONTAINS (
                column_name,
                r '^(jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)'
            )
    );

SET
    colunas_c6 = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_c6_idosos_equipes'
            AND REGEXP_CONTAINS (
                column_name,
                r '^(jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)'
            )
    );

SET
    colunas_c7 = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_c7_prevencao_cancer_equipes'
            AND REGEXP_CONTAINS (
                column_name,
                r '^(jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)'
            )
    );

-- =========================================================================
-- PASSO 2: EXECUÇÃO DO UNPIVOT E CONSOLIDAÇÃO DINÂMICA
-- =========================================================================
EXECUTE IMMEDIATE FORMAT (
    """
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.siaps_consolidado` AS

WITH base_unpivot AS (
  SELECT ine, ap, cnes, cod_area, unidade, nome_equipe, tipo_equipe, 'Mais Acesso' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_c1_maisacesso_equipes` UNPIVOT(valor FOR col IN (%s))
  UNION ALL
  SELECT ine, ap, cnes, cod_area, unidade, nome_equipe, tipo_equipe, 'Desenvolvimento Infantil' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_c2_des_inf_equipes` UNPIVOT(valor FOR col IN (%s))
  UNION ALL
  SELECT ine, ap, cnes, cod_area, unidade, nome_equipe, tipo_equipe, 'Gestantes' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_c3_gestantes_equipes` UNPIVOT(valor FOR col IN (%s))
  UNION ALL
  SELECT ine, ap, cnes, cod_area, unidade, nome_equipe, tipo_equipe, 'Diabetes Mellitus' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_c4_dm_equipes` UNPIVOT(valor FOR col IN (%s))
  UNION ALL
  SELECT ine, ap, cnes, cod_area, unidade, nome_equipe, tipo_equipe, 'Hipertensão' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_c5_has_equipes` UNPIVOT(valor FOR col IN (%s))
  UNION ALL
  SELECT ine, ap, cnes, cod_area, unidade, nome_equipe, tipo_equipe, 'Idosos' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_c6_idosos_equipes` UNPIVOT(valor FOR col IN (%s))
  UNION ALL
  SELECT ine, ap, cnes, cod_area, unidade, nome_equipe, tipo_equipe, 'Prevenção do câncer' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_c7_prevencao_cancer_equipes` UNPIVOT(valor FOR col IN (%s))
)

SELECT 
  ine, ap, cnes, cod_area, unidade, nome_equipe, tipo_equipe, 
  -- 1. TRATAMENTO DA DATA (Extrai ano e mapeia mês)
  SAFE.PARSE_DATE('%%Y-%%m-%%d', 
    CONCAT(
      COALESCE(REGEXP_EXTRACT(col, r'\\d{4}'), '2025'), '-', 
      CASE 
        WHEN REGEXP_CONTAINS(LOWER(col), 'jan') THEN '01' WHEN REGEXP_CONTAINS(LOWER(col), 'fev') THEN '02'
        WHEN REGEXP_CONTAINS(LOWER(col), 'mar') THEN '03' WHEN REGEXP_CONTAINS(LOWER(col), 'abr') THEN '04'
        WHEN REGEXP_CONTAINS(LOWER(col), 'mai') THEN '05' WHEN REGEXP_CONTAINS(LOWER(col), 'jun') THEN '06'
        WHEN REGEXP_CONTAINS(LOWER(col), 'jul') THEN '07' WHEN REGEXP_CONTAINS(LOWER(col), 'ago') THEN '08'
        WHEN REGEXP_CONTAINS(LOWER(col), 'set') THEN '09' WHEN REGEXP_CONTAINS(LOWER(col), 'out') THEN '10'
        WHEN REGEXP_CONTAINS(LOWER(col), 'nov') THEN '11' WHEN REGEXP_CONTAINS(LOWER(col), 'dez') THEN '12'
      END, '-01')
  ) AS Periodo,
  Componente,
  -- 2. EXTRAÇÃO DO TIPO DE INDICADOR (Tudo que vem após o mês/ano)
  -- Ex: jan_2025_num -> num | fev_2025_a -> a
  REGEXP_EXTRACT(col, r'^(?:jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)(?:_\\d{4})?_(.*)') AS Tipo_Indicador,
  -- 3. LIMPEZA E CONVERSÃO DO VALOR
  SAFE_CAST(REPLACE(REPLACE(CAST(valor AS STRING), '%%', ''), ',', '.') AS FLOAT64) AS Valor
FROM base_unpivot
""",
    colunas_c1,
    colunas_c2,
    colunas_c3,
    colunas_c4,
    colunas_c5,
    colunas_c6,
    colunas_c7
);