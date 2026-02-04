Instagram (Unidade) = 
VAR InstagramPadraoSemFiltro = "saude_rio"
VAR PlaceholderNulo = "--"

VAR HaFiltroUE =
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_unidade]) ||
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_equipe])

VAR HaFiltroAP =
    ISFILTERED('dw_equipes_unidades_profissionais'[area_programatica])

VAR InstasDistintos =
    FILTER(
        VALUES('dw_equipes_unidades_profissionais'[instagram]),
        NOT ISBLANK('dw_equipes_unidades_profissionais'[instagram]) &&
        LEN(TRIM('dw_equipes_unidades_profissionais'[instagram])) > 0
    )

VAR ValorUnidade =
    SWITCH(
        TRUE(),
        COUNTROWS(InstasDistintos) = 0, BLANK(),
        COUNTROWS(InstasDistintos) = 1, MINX(InstasDistintos,'dw_equipes_unidades_profissionais'[instagram]),
        CONCATENATEX(InstasDistintos,'dw_equipes_unidades_profissionais'[instagram],", ")
    )

VAR APsSelecionadas =
    SELECTCOLUMNS(
        FILTER(
            VALUES('dw_equipes_unidades_profissionais'[area_programatica]),
            NOT ISBLANK('dw_equipes_unidades_profissionais'[area_programatica])
        ),
        "AP",
        SUBSTITUTE(SUBSTITUTE(SUBSTITUTE('dw_equipes_unidades_profissionais'[area_programatica],"AP",""),".","")," ","")
    )

VAR InstaAPTable =
    CALCULATETABLE(
        VALUES('Informações_auxiliares_CNES_ap'[Instagram]),
        TREATAS(APsSelecionadas, 'Informações_auxiliares_CNES_ap'[AP])
    )

VAR ValorAP =
    CONCATENATEX(
        FILTER(
            InstaAPTable,
            NOT ISBLANK('Informações_auxiliares_CNES_ap'[Instagram]) &&
            LEN(TRIM('Informações_auxiliares_CNES_ap'[Instagram])) > 0
        ),
        'Informações_auxiliares_CNES_ap'[Instagram],
        ", "
    )

RETURN
IF(
    HaFiltroUE,
    COALESCE(ValorUnidade, PlaceholderNulo),
    IF(HaFiltroAP, COALESCE(ValorAP, PlaceholderNulo), InstagramPadraoSemFiltro)
)
