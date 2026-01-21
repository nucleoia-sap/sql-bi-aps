CREATE
OR REPLACE TABLE `rj-sms-sandbox.sub_pav_us.siaps_consolidado_esb` AS
WITH
    unpivot_all AS (
        -- ==================================================
        -- Componente 1: 1º consulta programada (Tabela: SIAPS_ESB_b1_1a_cons_prog_equipes)
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
            '1º consulta programada' AS Componente,
            'num_B1' AS Tipo_Indicador,
            jan_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'den_B1' AS Tipo_Indicador,
            jan_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'percent_B1' AS Tipo_Indicador,
            jan_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'num_B1' AS Tipo_Indicador,
            fev_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'den_B1' AS Tipo_Indicador,
            fev_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'percent_B1' AS Tipo_Indicador,
            fev_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'num_B1' AS Tipo_Indicador,
            mar_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'den_B1' AS Tipo_Indicador,
            mar_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'percent_B1' AS Tipo_Indicador,
            mar_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'num_B1' AS Tipo_Indicador,
            abr_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'den_B1' AS Tipo_Indicador,
            abr_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'percent_B1' AS Tipo_Indicador,
            abr_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'num_B1' AS Tipo_Indicador,
            mai_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'den_B1' AS Tipo_Indicador,
            mai_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'percent_B1' AS Tipo_Indicador,
            mai_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'num_B1' AS Tipo_Indicador,
            jun_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'den_B1' AS Tipo_Indicador,
            jun_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'percent_B1' AS Tipo_Indicador,
            jun_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'num_B1' AS Tipo_Indicador,
            jul_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'den_B1' AS Tipo_Indicador,
            jul_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'percent_B1' AS Tipo_Indicador,
            jul_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'num_B1' AS Tipo_Indicador,
            ago_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'den_B1' AS Tipo_Indicador,
            ago_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'percent_B1' AS Tipo_Indicador,
            ago_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'num_B1' AS Tipo_Indicador,
            set_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'den_B1' AS Tipo_Indicador,
            set_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'percent_B1' AS Tipo_Indicador,
            set_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'num_B1' AS Tipo_Indicador,
            out_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'den_B1' AS Tipo_Indicador,
            out_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'percent_B1' AS Tipo_Indicador,
            out_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'num_B1' AS Tipo_Indicador,
            nov_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'den_B1' AS Tipo_Indicador,
            nov_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'percent_B1' AS Tipo_Indicador,
            nov_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'num_B1' AS Tipo_Indicador,
            dez_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'den_B1' AS Tipo_Indicador,
            dez_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
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
            '1º consulta programada' AS Componente,
            'percent_B1' AS Tipo_Indicador,
            dez_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b1_1a_cons_prog_equipes`
        UNION ALL
        -- ==================================================
        -- Componente 2: Tratamento Concluído (Tabela: rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes)
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
            'Tratamento Concluído' AS Componente,
            'num_B2' AS Tipo_Indicador,
            jan_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'den_B2' AS Tipo_Indicador,
            jan_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'percent_B2' AS Tipo_Indicador,
            jan_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'num_B2' AS Tipo_Indicador,
            fev_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'den_B2' AS Tipo_Indicador,
            fev_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'percent_B2' AS Tipo_Indicador,
            fev_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'num_B2' AS Tipo_Indicador,
            mar_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'den_B2' AS Tipo_Indicador,
            mar_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'percent_B2' AS Tipo_Indicador,
            mar_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'num_B2' AS Tipo_Indicador,
            abr_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'den_B2' AS Tipo_Indicador,
            abr_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'percent_B2' AS Tipo_Indicador,
            abr_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'num_B2' AS Tipo_Indicador,
            mai_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'den_B2' AS Tipo_Indicador,
            mai_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'percent_B2' AS Tipo_Indicador,
            mai_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'num_B2' AS Tipo_Indicador,
            jun_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'den_B2' AS Tipo_Indicador,
            jun_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'percent_B2' AS Tipo_Indicador,
            jun_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'num_B2' AS Tipo_Indicador,
            jul_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'den_B2' AS Tipo_Indicador,
            jul_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'percent_B2' AS Tipo_Indicador,
            jul_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'num_B2' AS Tipo_Indicador,
            ago_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'den_B2' AS Tipo_Indicador,
            ago_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'percent_B2' AS Tipo_Indicador,
            ago_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'num_B2' AS Tipo_Indicador,
            set_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'den_B2' AS Tipo_Indicador,
            set_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'percent_B2' AS Tipo_Indicador,
            set_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'num_B2' AS Tipo_Indicador,
            out_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'den_B2' AS Tipo_Indicador,
            out_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'percent_B2' AS Tipo_Indicador,
            out_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'num_B2' AS Tipo_Indicador,
            nov_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'den_B2' AS Tipo_Indicador,
            nov_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'percent_B2' AS Tipo_Indicador,
            nov_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'num_B2' AS Tipo_Indicador,
            dez_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'den_B2' AS Tipo_Indicador,
            dez_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Tratamento Concluído' AS Componente,
            'percent_B2' AS Tipo_Indicador,
            dez_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
        UNION ALL
        -- ==================================================
        -- Componente 3: Taxa de exodontias (Tabela: rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b3_tx_exodontias_equipes)
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
            'Taxa de exodontias' AS Componente,
            'num_B3' AS Tipo_Indicador,
            jan_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b3_tx_exodontias_equipes`
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
            'Taxa de exodontias' AS Componente,
            'den_B3' AS Tipo_Indicador,
            jan_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b3_tx_exodontias_equipes`
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
            'Taxa de exodontias' AS Componente,
            'percent_B3' AS Tipo_Indicador,
            jan_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b3_tx_exodontias_equipes`
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
            'Taxa de exodontias' AS Componente,
            'num_B3' AS Tipo_Indicador,
            fev_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'den_B3' AS Tipo_Indicador,
            fev_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'percent_B3' AS Tipo_Indicador,
            fev_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'num_B3' AS Tipo_Indicador,
            mar_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'den_B3' AS Tipo_Indicador,
            mar_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'percent_B3' AS Tipo_Indicador,
            mar_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'num_B3' AS Tipo_Indicador,
            abr_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'den_B3' AS Tipo_Indicador,
            abr_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'percent_B3' AS Tipo_Indicador,
            abr_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'num_B3' AS Tipo_Indicador,
            mai_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'den_B3' AS Tipo_Indicador,
            mai_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'percent_B3' AS Tipo_Indicador,
            mai_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'num_B3' AS Tipo_Indicador,
            jun_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'den_B3' AS Tipo_Indicador,
            jun_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'percent_B3' AS Tipo_Indicador,
            jun_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'num_B3' AS Tipo_Indicador,
            jul_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'den_B3' AS Tipo_Indicador,
            jul_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'percent_B3' AS Tipo_Indicador,
            jul_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'num_B3' AS Tipo_Indicador,
            ago_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'den_B3' AS Tipo_Indicador,
            ago_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'percent_B3' AS Tipo_Indicador,
            ago_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'num_B3' AS Tipo_Indicador,
            set_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'den_B3' AS Tipo_Indicador,
            set_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'percent_B3' AS Tipo_Indicador,
            set_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'num_B3' AS Tipo_Indicador,
            out_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'den_B3' AS Tipo_Indicador,
            out_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'percent_B3' AS Tipo_Indicador,
            out_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'num_B3' AS Tipo_Indicador,
            nov_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'den_B3' AS Tipo_Indicador,
            nov_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'percent_B3' AS Tipo_Indicador,
            nov_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'num_B3' AS Tipo_Indicador,
            dez_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'den_B3' AS Tipo_Indicador,
            dez_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
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
            'Taxa de exodontias' AS Componente,
            'percent_B3' AS Tipo_Indicador,
            dez_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b2_tto_odonto_concluido_equipes`
        UNION ALL
        -- ==================================================
        -- Componente 4: Escovação Supervisionada (Tabela: rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes)
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
            'Escovação Supervisionada' AS Componente,
            'num_B4' AS Tipo_Indicador,
            jan_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'den_B4' AS Tipo_Indicador,
            jan_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'percent_B4' AS Tipo_Indicador,
            jan_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'num_B4' AS Tipo_Indicador,
            fev_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'den_B4' AS Tipo_Indicador,
            fev_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'percent_B4' AS Tipo_Indicador,
            fev_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'num_B4' AS Tipo_Indicador,
            mar_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'den_B4' AS Tipo_Indicador,
            mar_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'percent_B4' AS Tipo_Indicador,
            mar_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'num_B4' AS Tipo_Indicador,
            abr_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'den_B4' AS Tipo_Indicador,
            abr_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'percent_B4' AS Tipo_Indicador,
            abr_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'num_B4' AS Tipo_Indicador,
            mai_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'den_B4' AS Tipo_Indicador,
            mai_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'percent_B4' AS Tipo_Indicador,
            mai_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'num_B4' AS Tipo_Indicador,
            jun_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'den_B4' AS Tipo_Indicador,
            jun_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'percent_B4' AS Tipo_Indicador,
            jun_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'num_B4' AS Tipo_Indicador,
            jul_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'den_B4' AS Tipo_Indicador,
            jul_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'percent_B4' AS Tipo_Indicador,
            jul_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'num_B4' AS Tipo_Indicador,
            ago_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'den_B4' AS Tipo_Indicador,
            ago_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'percent_B4' AS Tipo_Indicador,
            ago_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'num_B4' AS Tipo_Indicador,
            set_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'den_B4' AS Tipo_Indicador,
            set_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'percent_B4' AS Tipo_Indicador,
            set_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'num_B4' AS Tipo_Indicador,
            out_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'den_B4' AS Tipo_Indicador,
            out_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'percent_B4' AS Tipo_Indicador,
            out_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'num_B4' AS Tipo_Indicador,
            nov_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'den_B4' AS Tipo_Indicador,
            nov_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'percent_B4' AS Tipo_Indicador,
            nov_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'num_B4' AS Tipo_Indicador,
            dez_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'den_B4' AS Tipo_Indicador,
            dez_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
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
            'Escovação Supervisionada' AS Componente,
            'percent_B4' AS Tipo_Indicador,
            dez_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b4_escovacao_supervisionada_equipes`
        UNION ALL
        -- ==================================================
        -- Componente 5: Procedimentos preventivos (Tabela: rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes)
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
            'Procedimentos preventivos' AS Componente,
            'num_B5' AS Tipo_Indicador,
            jan_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'den_B5' AS Tipo_Indicador,
            jan_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'percent_B5' AS Tipo_Indicador,
            jan_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'num_B5' AS Tipo_Indicador,
            fev_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'den_B5' AS Tipo_Indicador,
            fev_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'percent_B5' AS Tipo_Indicador,
            fev_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'num_B5' AS Tipo_Indicador,
            mar_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'den_B5' AS Tipo_Indicador,
            mar_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'percent_B5' AS Tipo_Indicador,
            mar_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'num_B5' AS Tipo_Indicador,
            abr_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'den_B5' AS Tipo_Indicador,
            abr_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'percent_B5' AS Tipo_Indicador,
            abr_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'num_B5' AS Tipo_Indicador,
            mai_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'den_B5' AS Tipo_Indicador,
            mai_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'percent_B5' AS Tipo_Indicador,
            mai_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'num_B5' AS Tipo_Indicador,
            jun_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'den_B5' AS Tipo_Indicador,
            jun_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'percent_B5' AS Tipo_Indicador,
            jun_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'num_B5' AS Tipo_Indicador,
            jul_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'den_B5' AS Tipo_Indicador,
            jul_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'percent_B5' AS Tipo_Indicador,
            jul_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'num_B5' AS Tipo_Indicador,
            ago_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'den_B5' AS Tipo_Indicador,
            ago_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'percent_B5' AS Tipo_Indicador,
            ago_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'num_B5' AS Tipo_Indicador,
            set_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'den_B5' AS Tipo_Indicador,
            set_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'percent_B5' AS Tipo_Indicador,
            set_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'num_B5' AS Tipo_Indicador,
            out_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'den_B5' AS Tipo_Indicador,
            out_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'percent_B5' AS Tipo_Indicador,
            out_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'num_B5' AS Tipo_Indicador,
            nov_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'den_B5' AS Tipo_Indicador,
            nov_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'percent_B5' AS Tipo_Indicador,
            nov_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'num_B5' AS Tipo_Indicador,
            dez_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'den_B5' AS Tipo_Indicador,
            dez_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
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
            'Procedimentos preventivos' AS Componente,
            'percent_B5' AS Tipo_Indicador,
            dez_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b5_proc_odonto_preventivos_equipes`
        UNION ALL
        -- ==================================================
        -- Componente 6: Tratamento restaurador (Tabela: rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes)
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
            'Tratamento restaurador' AS Componente,
            'num_B6' AS Tipo_Indicador,
            jan_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'den_B6' AS Tipo_Indicador,
            jan_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'percent_B6' AS Tipo_Indicador,
            jan_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'num_B6' AS Tipo_Indicador,
            fev_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'den_B6' AS Tipo_Indicador,
            fev_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'percent_B6' AS Tipo_Indicador,
            fev_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'num_B6' AS Tipo_Indicador,
            mar_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'den_B6' AS Tipo_Indicador,
            mar_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'percent_B6' AS Tipo_Indicador,
            mar_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'num_B6' AS Tipo_Indicador,
            abr_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'den_B6' AS Tipo_Indicador,
            abr_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'percent_B6' AS Tipo_Indicador,
            abr_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'num_B6' AS Tipo_Indicador,
            mai_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'den_B6' AS Tipo_Indicador,
            mai_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'percent_B6' AS Tipo_Indicador,
            mai_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'num_B6' AS Tipo_Indicador,
            jun_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'den_B6' AS Tipo_Indicador,
            jun_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'percent_B6' AS Tipo_Indicador,
            jun_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'num_B6' AS Tipo_Indicador,
            jul_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'den_B6' AS Tipo_Indicador,
            jul_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'percent_B6' AS Tipo_Indicador,
            jul_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'num_B6' AS Tipo_Indicador,
            ago_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'den_B6' AS Tipo_Indicador,
            ago_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'percent_B6' AS Tipo_Indicador,
            ago_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'num_B6' AS Tipo_Indicador,
            set_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'den_B6' AS Tipo_Indicador,
            set_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'percent_B6' AS Tipo_Indicador,
            set_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'num_B6' AS Tipo_Indicador,
            out_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'den_B6' AS Tipo_Indicador,
            out_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'percent_B6' AS Tipo_Indicador,
            out_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'num_B6' AS Tipo_Indicador,
            nov_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'den_B6' AS Tipo_Indicador,
            nov_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'percent_B6' AS Tipo_Indicador,
            nov_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'num_B5' AS Tipo_Indicador,
            dez_2025_num AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'den_B6' AS Tipo_Indicador,
            dez_2025_den AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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
            'Tratamento restaurador' AS Componente,
            'percent_B6' AS Tipo_Indicador,
            dez_2025_percent AS Valor
        FROM
            `rj-sms-sandbox.sub_pav_us.SIAPS_ESB_b6_trat_restaurador_atraumatico_equipes`
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