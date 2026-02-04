Email (Unidade) = 
VAR EmailPadraoSemFiltro = "1746 (Central de Atendimento ao Cidadão)"
VAR PlaceholderNulo = "--"

VAR HaFiltroUE =
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_unidade]) ||
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_equipe])

VAR HaFiltroAP =
    ISFILTERED('dw_equipes_unidades_profissionais'[area_programatica])

-- ===== UNIDADE/EQUIPE =====
VAR EmailsDistintos =
    FILTER(
        VALUES('dw_equipes_unidades_profissionais'[email_unidade]),
        NOT ISBLANK('dw_equipes_unidades_profissionais'[email_unidade]) &&
        LEN(TRIM('dw_equipes_unidades_profissionais'[email_unidade])) > 0
    )
VAR ValorUnidade =
    SWITCH(
        TRUE(),
        COUNTROWS(EmailsDistintos) = 0, BLANK(),
        COUNTROWS(EmailsDistintos) = 1, MINX(EmailsDistintos,'dw_equipes_unidades_profissionais'[email_unidade]),
        CONCATENATEX(EmailsDistintos,'dw_equipes_unidades_profissionais'[email_unidade],", ")
    )

-- ===== AP (tabela auxiliar) =====
VAR APsSelecionadas =
    SELECTCOLUMNS(
        FILTER(
            VALUES('dw_equipes_unidades_profissionais'[area_programatica]),
            NOT ISBLANK('dw_equipes_unidades_profissionais'[area_programatica])
        ),
        "AP",
        SUBSTITUTE(SUBSTITUTE(SUBSTITUTE('dw_equipes_unidades_profissionais'[area_programatica],"AP",""),".","")," ","")
    )
VAR EmailAPTable =
    CALCULATETABLE(
        VALUES('Informações_auxiliares_CNES_ap'[Email]),
        TREATAS(APsSelecionadas, 'Informações_auxiliares_CNES_ap'[AP])
    )
VAR ValorAP =
    CONCATENATEX(
        FILTER(
            EmailAPTable,
            NOT ISBLANK('Informações_auxiliares_CNES_ap'[Email]) &&
            LEN(TRIM('Informações_auxiliares_CNES_ap'[Email])) > 0
        ),
        'Informações_auxiliares_CNES_ap'[Email],
        ", "
    )

RETURN
IF(
    HaFiltroUE,
    COALESCE(ValorUnidade, PlaceholderNulo),
    IF(HaFiltroAP, COALESCE(ValorAP, PlaceholderNulo), EmailPadraoSemFiltro)
)
