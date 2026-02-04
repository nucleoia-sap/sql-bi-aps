-- ======================================================================
-- Parâmetro dinâmico: 9 meses antes da execução
-- ======================================================================
DECLARE data_corte DATETIME DEFAULT DATETIME_SUB (CURRENT_DATETIME (), INTERVAL 9 MONTH);

-- ======================================================================
-- 1) LISTA DE TUBERCULOSE COM CPF (chave: id_cnes|'|'|id_prontuario_local)
--    -> normaliza CPF (apenas dígitos) e filtra nulos/vazios
-- ======================================================================
CREATE
OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us._tuberculose_lista_com_cpf` AS
WITH
    tb_base AS (
        SELECT
            TRIM(id_cnes) AS id_cnes_norm,
            TRIM(id_prontuario_local) AS id_pl_norm,
            CONCAT (TRIM(id_cnes), '|', TRIM(id_prontuario_local)) AS chave_tb,
            t.*
        FROM
            `rj-sms.brutos_prontuario_vitacare_historico.tuberculose` t
    ),
    acto_base AS (
        SELECT
            TRIM(id_cnes) AS id_cnes_norm,
            TRIM(id_prontuario_local) AS id_pl_norm,
            CONCAT (TRIM(id_cnes), '|', TRIM(id_prontuario_local)) AS chave_tb,
            REGEXP_REPLACE (TRIM(patient_cpf), r '\D', '') AS paciente_cpf_digits
        FROM
            `rj-sms.brutos_prontuario_vitacare_historico.acto`
        WHERE
            patient_cpf IS NOT NULL
            AND LENGTH (TRIM(patient_cpf)) > 0
    ),
    acto_chave_cpf AS (
        SELECT
            chave_tb,
            ANY_VALUE (paciente_cpf_digits) AS paciente_cpf_digits
        FROM
            acto_base
        WHERE
            chave_tb IS NOT NULL
            AND paciente_cpf_digits IS NOT NULL
            AND LENGTH (paciente_cpf_digits) = 11
        GROUP BY
            chave_tb
    )
SELECT
    tb.*,
    ac.paciente_cpf_digits AS paciente_cpf
FROM
    tb_base tb
    LEFT JOIN acto_chave_cpf ac ON tb.chave_tb = ac.chave_tb;