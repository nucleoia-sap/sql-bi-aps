Twitter (Unidade) = 
VAR TwitterPadraoSemFiltro = "Saude_Rio"
VAR PlaceholderNulo = "--"

VAR HaFiltroUE =
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_unidade]) ||
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_equipe])

VAR HaFiltroAP =
    ISFILTERED('dw_equipes_unidades_profissionais'[area_programatica])

-- Twitter por Unidade
VAR TwDistintos =
    FILTER(
        VALUES('dw_equipes_unidades_profissionais'[twitter]),   -- cuidado: coluna se chama "twiiter" na base
        NOT ISBLANK('dw_equipes_unidades_profissionais'[twitter]) &&
        LEN(TRIM('dw_equipes_unidades_profissionais'[twitter])) > 0
    )

VAR ValorUnidade =
    SWITCH(
        TRUE(),
        COUNTROWS(TwDistintos) = 0, BLANK(),
        COUNTROWS(TwDistintos) = 1, MINX(TwDistintos, 'dw_equipes_unidades_profissionais'[twitter]),
        CONCATENATEX(TwDistintos, 'dw_equipes_unidades_profissionais'[twitter], ", ")
    )

-- Twitter por AP
VAR APsSelecionadas =
    SELECTCOLUMNS(
        FILTER(
            VALUES('dw_equipes_unidades_profissionais'[area_programatica]),
            NOT ISBLANK('dw_equipes_unidades_profissionais'[area_programatica])
        ),
        "AP",
        SUBSTITUTE(SUBSTITUTE(SUBSTITUTE('dw_equipes_unidades_profissionais'[area_programatica], "AP", ""), ".", ""), " ", "")
    )

VAR TwAPTable =
    CALCULATETABLE(
        VALUES('Informações_auxiliares_CNES_ap'[Twitter]),
        TREATAS(APsSelecionadas, 'Informações_auxiliares_CNES_ap'[AP])
    )

VAR ValorAP =
    CONCATENATEX(
        FILTER(
            TwAPTable,
            NOT ISBLANK('Informações_auxiliares_CNES_ap'[Twitter]) &&
            LEN(TRIM('Informações_auxiliares_CNES_ap'[Twitter])) > 0
        ),
        'Informações_auxiliares_CNES_ap'[Twitter],
        ", "
    )

RETURN
IF(
    HaFiltroUE,
    COALESCE(ValorUnidade, PlaceholderNulo),
    IF(HaFiltroAP, COALESCE(ValorAP, PlaceholderNulo), TwitterPadraoSemFiltro)
)
