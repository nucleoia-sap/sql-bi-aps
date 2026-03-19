-- =========================================================================
-- DECLARAÇÃO DE VARIÁVEIS PARA AS COLUNAS (eCR)
-- =========================================================================
DECLARE colunas_ecr_acesso,
colunas_ecr_gestacao,
colunas_ecr_ist,
colunas_ecr_tuberculose STRING;

-- =========================================================================
-- PASSO 1: CAPTURA DINÂMICA DE COLUNAS
-- =========================================================================
SET
    colunas_ecr_acesso = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_eCR_cr_mais_acesso'
            AND REGEXP_CONTAINS (
                column_name,
                r '^(jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)'
            )
    );

SET
    colunas_ecr_gestacao = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_eCR_cr_gestacao'
            AND REGEXP_CONTAINS (
                column_name,
                r '^(jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)'
            )
    );

SET
    colunas_ecr_ist = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_eCR_cr_ist'
            AND REGEXP_CONTAINS (
                column_name,
                r '^(jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)'
            )
    );

SET
    colunas_ecr_tuberculose = (
        SELECT
            STRING_AGG (column_name, ', ')
        FROM
            `rj-sms-sandbox.sub_pav_us.INFORMATION_SCHEMA.COLUMNS`
        WHERE
            table_name = 'SIAPS_eCR_cr_tuberculose'
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
CREATE OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.siaps_consolidado_eCR` AS

WITH base_unpivot AS (
  SELECT ine, ap, cnes, unidade, equipe, 'Mais_acesso_eCR' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_eCR_cr_mais_acesso` UNPIVOT(valor FOR col IN (%s))
  UNION ALL
  SELECT ine, ap, cnes, unidade, equipe, 'Gestação eCR' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_eCR_cr_gestacao` UNPIVOT(valor FOR col IN (%s))
  UNION ALL
  SELECT ine, ap, cnes, unidade, equipe, 'IST eCR' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_eCR_cr_ist` UNPIVOT(valor FOR col IN (%s))
  UNION ALL
  SELECT ine, ap, cnes, unidade, equipe, 'Tuberculose eCR' as Componente, col, valor FROM `rj-sms-sandbox.sub_pav_us.SIAPS_eCR_cr_tuberculose` UNPIVOT(valor FOR col IN (%s))
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
  -- 2. TRATAMENTO DO TIPO INDICADOR (Substituindo 'razao' por 'percent' conforme seu padrão original)
  CASE 
    WHEN REGEXP_CONTAINS(col, 'razao') THEN 'percent'
    ELSE REGEXP_EXTRACT(col, r'^(?:jan|fev|mar|abr|mai|jun|jul|ago|set|out|nov|dez)(?:_\\d{4})?_(.*)')
  END AS Tipo_Indicador,
  -- 3. LIMPEZA E CONVERSÃO DO VALOR
  SAFE_CAST(REPLACE(REPLACE(CAST(valor AS STRING), '%%', ''), ',', '.') AS FLOAT64) AS Valor
FROM base_unpivot
WHERE ine != 'MRJ'
""",
    colunas_ecr_acesso,
    colunas_ecr_gestacao,
    colunas_ecr_ist,
    colunas_ecr_tuberculose
);