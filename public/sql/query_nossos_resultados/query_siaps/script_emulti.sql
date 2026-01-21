CREATE
OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.siaps_consolidado_emulti` AS
WITH
    unpivot_all AS (
        -- ==================================================
        -- Componente 1: Ações Interprofissionais (Tabela: SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes)
        -- ==================================================
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-01-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'num_M2' AS Tipo_Indicador,
            jan_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-01-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'den_M2' AS Tipo_Indicador,
            jan_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-01-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'percent_M2' AS Tipo_Indicador,
            jan_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-02-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'num_M2' AS Tipo_Indicador,
            fev_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-02-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'den_M2' AS Tipo_Indicador,
            fev_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-02-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'percent_M2' AS Tipo_Indicador,
            fev_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-03-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'num_M2' AS Tipo_Indicador,
            mar_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-03-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'den_M2' AS Tipo_Indicador,
            mar_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-03-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'percent_M2' AS Tipo_Indicador,
            mar_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-04-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'num_M2' AS Tipo_Indicador,
            abr_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-04-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'den_M2' AS Tipo_Indicador,
            abr_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-04-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'percent_M2' AS Tipo_Indicador,
            abr_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-05-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'num_M2' AS Tipo_Indicador,
            mai_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-05-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'den_M2' AS Tipo_Indicador,
            mai_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-05-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'percent_M2' AS Tipo_Indicador,
            mai_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-06-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'num_M2' AS Tipo_Indicador,
            jun_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-06-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'den_M2' AS Tipo_Indicador,
            jun_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-06-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'percent_M2' AS Tipo_Indicador,
            jun_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-07-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'num_M2' AS Tipo_Indicador,
            jul_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-07-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'den_M2' AS Tipo_Indicador,
            jul_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-07-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'percent_M2' AS Tipo_Indicador,
            jul_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-08-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'num_M2' AS Tipo_Indicador,
            ago_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-08-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'den_M2' AS Tipo_Indicador,
            ago_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-08-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'percent_M2' AS Tipo_Indicador,
            ago_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-09-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'num_M2' AS Tipo_Indicador,
            set_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-09-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'den_M2' AS Tipo_Indicador,
            set_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-09-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'percent_M2' AS Tipo_Indicador,
            set_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-10-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'num_M2' AS Tipo_Indicador,
            out_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-10-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'den_M2' AS Tipo_Indicador,
            out_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-10-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'percent_M2' AS Tipo_Indicador,
            out_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-11-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'num_M2' AS Tipo_Indicador,
            nov_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-11-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'den_M2' AS Tipo_Indicador,
            nov_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-11-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'percent_M2' AS Tipo_Indicador,
            nov_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-12-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'num_M2' AS Tipo_Indicador,
            dez_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-12-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'den_M2' AS Tipo_Indicador,
            dez_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-12-01' AS Periodo,
            'Ações Interprofissionais' AS Componente,
            'percent_M2' AS Tipo_Indicador,
            dez_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m2_acoes_interprofissionais_emulti_equipes`
        UNION ALL
        -- ==================================================
        -- Componente 2: Atendimentos eMulti (Tabela: SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes)
        -- ==================================================
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-01-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'num_M1' AS Tipo_Indicador,
            jan_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-01-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'den_M1' AS Tipo_Indicador,
            jan_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-01-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'media_M1' AS Tipo_Indicador,
            jan_2025_media AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-02-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'num_M1' AS Tipo_Indicador,
            fev_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-02-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'den_M1' AS Tipo_Indicador,
            fev_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-02-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'media_M1' AS Tipo_Indicador,
            fev_2025_media AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-03-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'num_M1' AS Tipo_Indicador,
            mar_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-03-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'den_M1' AS Tipo_Indicador,
            mar_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-03-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'media_M1' AS Tipo_Indicador,
            mar_2025_media AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-04-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'num_M1' AS Tipo_Indicador,
            abr_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-04-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'den_M1' AS Tipo_Indicador,
            abr_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-04-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'media_M1' AS Tipo_Indicador,
            abr_2025_media AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-05-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'num_M1' AS Tipo_Indicador,
            mai_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-05-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'den_M1' AS Tipo_Indicador,
            mai_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-05-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'media_M1' AS Tipo_Indicador,
            mai_2025_media AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-06-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'num_M1' AS Tipo_Indicador,
            jun_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-06-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'den_M1' AS Tipo_Indicador,
            jun_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-06-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'media_M1' AS Tipo_Indicador,
            jun_2025_media AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-07-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'num_M1' AS Tipo_Indicador,
            jul_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-07-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'den_M1' AS Tipo_Indicador,
            jul_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-07-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'media_M1' AS Tipo_Indicador,
            jul_2025_media AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-08-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'num_M1' AS Tipo_Indicador,
            ago_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-08-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'den_M1' AS Tipo_Indicador,
            ago_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-08-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'media_M1' AS Tipo_Indicador,
            ago_2025_media AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-09-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'num_M1' AS Tipo_Indicador,
            set_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-09-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'den_M1' AS Tipo_Indicador,
            set_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-09-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'media_M1' AS Tipo_Indicador,
            set_2025_media AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-10-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'num_M1' AS Tipo_Indicador,
            out_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-10-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'den_M1' AS Tipo_Indicador,
            out_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-10-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'media_M1' AS Tipo_Indicador,
            out_2025_media AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-11-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'num_M1' AS Tipo_Indicador,
            nov_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-11-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'den_M1' AS Tipo_Indicador,
            nov_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-11-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'media_M1' AS Tipo_Indicador,
            nov_2025_media AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-12-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'num_M1' AS Tipo_Indicador,
            dez_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-12-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'den_M1' AS Tipo_Indicador,
            dez_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
        UNION ALL
        SELECT
            ine,
            ap,
            cnes,
            cod_area,
            unidade,
            nome_equipe,
            tipo_equipe,
            '2025-12-01' AS Periodo,
            'Atendimentos eMulti' AS Componente,
            'media_M1' AS Tipo_Indicador,
            dez_2025_media AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_EMULTI_m1_med_atend_emulti_por_pessoa_equipes`
    )
SELECT
    ine,
    ap,
    cnes,
    cod_area,
    unidade,
    nome_equipe,
    tipo_equipe,
    CAST(Periodo AS DATE) AS Periodo,
    Componente,
    Tipo_Indicador,
    Valor
FROM
    unpivot_all;

-- A linha "WHERE Valor IS NOT NULL;" foi removida permanentemente.