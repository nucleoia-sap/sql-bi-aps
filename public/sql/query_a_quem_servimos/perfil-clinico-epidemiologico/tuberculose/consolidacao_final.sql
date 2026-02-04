-- ===== Abandono (Sim/Não) =====
CASE
    WHEN REGEXP_CONTAINS (
        CONCAT (
            ' ',
            IFNULL (ei.motivo_atendimento, ''),
            ' ',
            IFNULL (ei.desfecho_atendimento, ''),
            ' '
        ),
        r '(?i)\b(abandono|abandonou|abandona(r|do|da)|aband[oô]nou|evas[aã]o|evadiu|perda\s+de\s+seguimento|perdeu\s+seguimento|interrup[cç][aã]o\s+do\s+tratament[oa]|interrompeu\s+tratament[oa])\b'
    ) THEN 'Sim'
    ELSE 'Não'
END AS Abandono,
-- ===== Cura (Sim/Não) =====
CASE
    WHEN (
        REGEXP_CONTAINS (
            IFNULL (ei.motivo_atendimento, ''),
            r '(?i)\b(alta\s+por\s+cura|cura|curado|curada)\b'
        )
        OR REGEXP_CONTAINS (
            IFNULL (ei.motivo_atendimento, ''),
            r '(?i)\btratament[oa]\s+(completo|conclu[ií]d[oa]|finalizad[oa]|terminad[oa])\b'
        )
        OR REGEXP_CONTAINS (
            IFNULL (ei.motivo_atendimento, ''),
            r '(?i)\b(fim|t[ée]rmino)\s+do\s+tratament[oa]\b'
        )
        OR (
            REGEXP_CONTAINS (
                IFNULL (ei.motivo_atendimento, ''),
                r '(?i)\bencerr(a|amento)\b'
            )
            AND REGEXP_CONTAINS (
                IFNULL (ei.motivo_atendimento, ''),
                r '(?i)\b(cid|alta|cura)\b'
            )
            AND REGEXP_CONTAINS (
                IFNULL (ei.motivo_atendimento, ''),
                r '(?i)\b(tb|tuberculose)\b'
            )
        )
    )
    AND NOT REGEXP_CONTAINS (
        CONCAT (
            ' ',
            IFNULL (ei.motivo_atendimento, ''),
            ' ',
            IFNULL (ei.desfecho_atendimento, ''),
            ' '
        ),
        r '(?i)\b(abandono|abandonou|abandona(r|do|da)|aband[oô]nou|óbito|obito|alta\s+a\s+pedido|transfer[êe]ncia|transferid[oa]|falh[ae]|fal[êe]ncia|reca[ií]da|recidiva|reinfec[cç][aã]o|interrup[cç][aã]o|suspens[aã]o|perda\s+de\s+seguimento|perdeu\s+seguimento|evas[aã]o)\b'
    )
    AND NOT REGEXP_CONTAINS (
        IFNULL (ei.motivo_atendimento, ''),
        r '(?i)\b(sem\s+cura|n[aã]o\s+cura)\b'
    ) THEN 'Sim'
    ELSE 'Não'
END AS Cura
FROM
    universo u
    LEFT JOIN presc_cpfs p USING (paciente_cpf)
    LEFT JOIN cid_cpfs c USING (paciente_cpf)
    LEFT JOIN lista_cpfs l USING (paciente_cpf)
    LEFT JOIN presc_meds_ult pm USING (paciente_cpf)
    LEFT JOIN lista_info li USING (paciente_cpf)
    LEFT JOIN ea_info ei USING (paciente_cpf)
WHERE
    u.paciente_cpf IS NOT NULL
    AND LENGTH (u.paciente_cpf) = 11;

-- ======================================================================
-- 3) Totais por critério (consulta imediata)
-- ======================================================================
SELECT
    COUNT(*) AS total_cpfs_na_tabela,
    SUM(criterio1_prescricao) AS total_criterio1_prescricao,
    SUM(criterio2_cid_ativo) AS total_criterio2_cid_ativo,
    SUM(criterio3_lista_tuberculose) AS total_criterio3_lista_tuberculose,
    COUNTIF (
        criterio1_prescricao + criterio2_cid_ativo + criterio3_lista_tuberculose > 0
    ) AS total_pelo_menos_um_criterio
FROM
    `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento`;

-- =====================================================================
-- conferindo se passou alguém zerado nos critérios
--=====================================================================
SELECT
    cpf
FROM
    `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento`
WHERE
    criterio1_prescricao = 0
    AND criterio2_cid_ativo = 0
    AND criterio3_lista_tuberculose = 0
ORDER BY
    cpf;

--=====================================================================
-- indicando a pontuação final
--=====================================================================
-- 1) cria a coluna (se não existir)
ALTER TABLE `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento`
ADD COLUMN IF NOT EXISTS soma_criterios INT64;

-- 2) preenche a coluna
UPDATE `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento`
SET
    soma_criterios = criterio1_prescricao + criterio2_cid_ativo + criterio3_lista_tuberculose
WHERE
    TRUE;

-- BigQuery exige WHERE
-- ======================================================================
-- 6) Inserindo coluna tipo_sms_agrupado (via join com dados mestres)
-- ======================================================================
-- 1️⃣ Adiciona a coluna caso não exista
ALTER TABLE `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento`
ADD COLUMN IF NOT EXISTS tipo_sms_agrupado STRING;

-- 2️⃣ Atualiza os valores com base na tabela de estabelecimentos
UPDATE `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento` AS t
SET
    tipo_sms_agrupado = e.tipo_sms_agrupado
FROM
    `rj-sms.saude_dados_mestres.estabelecimento` AS e
WHERE
    SAFE_CAST (t.id_cnes AS STRING) = SAFE_CAST (e.id_cnes AS STRING);

-- ======================================================================
-- 7) Mantendo apenas unidades APS
-- ======================================================================
CREATE
OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento` AS
SELECT
    *
FROM
    `rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento`
WHERE
    tipo_sms_agrupado = 'APS';