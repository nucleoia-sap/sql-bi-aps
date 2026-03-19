-- =========================================================================
-- DECLARAÇÃO DE VARIÁVEIS PARA AS COLUNAS (eAPP)
-- =========================================================================
DECLARE col_eapp_acesso,
col_eapp_gestacao,
col_eapp_diab_has STRING;

DECLARE col_eapp_ist,
col_eapp_tuberc,
col_eapp_cancer STRING;

-- =========================================================================
-- PASSO 1: CAPTURA DINÂMICA DE COLUNAS
-- =========================================================================
SET
    col_eapp_acesso = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_eAPP_app_mais_acesso'
            AND REGEXP_CONTAINS (
                column_name,
                r '^(jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)'
            )
    );

SET
    col_eapp_gestacao = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_eAPP_app_gestacao'
            AND REGEXP_CONTAINS (
                column_name,
                r '^(jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)'
            )
    );

SET
    col_eapp_diab_has = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_eAPP_app_diabetes_e_hipertensao'
            AND REGEXP_CONTAINS (
                column_name,
                r '^(jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)'
            )
    );

SET
    col_eapp_ist = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_eAPP_app_ist'
            AND REGEXP_CONTAINS (
                column_name,
                r '^(jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)'
            )
    );

SET
    col_eapp_tuberc = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_eAPP_app_tuberculose'
            AND REGEXP_CONTAINS (
                column_name,
                r '^(jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)'
            )
    );

SET
    col_eapp_cancer = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_eAPP_app_prevencao_cancer'
            AND REGEXP_CONTAINS (
                column_name,
                r '^(jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)'
            )
    );

-- =========================================================================
-- PASSO 2: EXECUÇÃO DO UNPIVOT E CONSOLIDAÇÃO
-- =========================================================================
EXECUTE IMMEDIATE FORMAT (
    """
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.siaps_consolidado_eAPP` AS

WITH base_unpivot AS (
  SELECT ine, ap, cnes, unidade, equipe, 'Mais_acesso_eAPP' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_eAPP_app_mais_acesso` UNPIVOT(valor FOR col IN (%s))
  UNION ALL
  SELECT ine, ap, cnes, unidade, equipe, 'Gestação_eAPP' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_eAPP_app_gestacao` UNPIVOT(valor FOR col IN (%s))
  UNION ALL
  SELECT ine, ap, cnes, unidade, equipe, 'Diabetes e Hipertensão eAPP' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_eAPP_app_diabetes_e_hipertensao` UNPIVOT(valor FOR col IN (%s))
  UNION ALL
  SELECT ine, ap, cnes, unidade, equipe, 'IST eAPP' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_eAPP_app_ist` UNPIVOT(valor FOR col IN (%s))
  UNION ALL
  SELECT ine, ap, cnes, unidade, equipe, 'Tuberculose eAPP' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_eAPP_app_tuberculose` UNPIVOT(valor FOR col IN (%s))
  UNION ALL
  SELECT ine, ap, cnes, unidade, equipe, 'Prevenção do câncer eAPP' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_eAPP_app_prevencao_cancer` UNPIVOT(valor FOR col IN (%s))
)

SELECT 
  ine, ap, cnes, unidade, equipe,
  -- 1. TRATAMENTO DA DATA
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
  -- 2. MAPEAMENTO DO TIPO INDICADOR (Converte 'razao' para 'percent')
  CASE 
    WHEN REGEXP_CONTAINS(col, 'razao') THEN 'percent'
    ELSE REGEXP_EXTRACT(col, r'^(?:jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)(?:_\\d{4})?_(.*)')
  END AS Tipo_Indicador,
  -- 3. LIMPEZA E CONVERSÃO DO VALOR
  SAFE_CAST(REPLACE(REPLACE(CAST(valor AS STRING), '%%', ''), ',', '.') AS FLOAT64) AS Valor
FROM base_unpivot
WHERE ine != 'MRJ'
""",
    col_eapp_acesso,
    col_eapp_gestacao,
    col_eapp_diab_has,
    col_eapp_ist,
    col_eapp_tuberc,
    col_eapp_cancer
);