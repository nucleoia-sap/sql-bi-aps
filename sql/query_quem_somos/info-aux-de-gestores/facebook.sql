Facebook (Unidade) = 
VAR FacebookPadraoSemFiltro = "secretaria.saude.rio"
VAR PlaceholderNulo = "--"

VAR HaFiltroUE =
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_unidade]) ||
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_equipe])

VAR HaFiltroAP =
    ISFILTERED('dw_equipes_unidades_profissionais'[area_programatica])

VAR FbDistintos =
    FILTER(
        VALUES('dw_equipes_unidades_profissionais'[facebook]),
        NOT ISBLANK('dw_equipes_unidades_profissionais'[facebook]) &&
        LEN(TRIM('dw_equipes_unidades_profissionais'[facebook])) > 0
    )

VAR ValorUnidade =
    SWITCH(
        TRUE(),
        COUNTROWS(FbDistintos) = 0, BLANK(),
        COUNTROWS(FbDistintos) = 1, MINX(FbDistintos,'dw_equipes_unidades_profissionais'[facebook]),
        CONCATENATEX(FbDistintos,'dw_equipes_unidades_profissionais'[facebook],", ")
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

VAR FbAPTable =
    CALCULATETABLE(
        VALUES('Informações_auxiliares_CNES_ap'[Facebook]),
        TREATAS(APsSelecionadas, 'Informações_auxiliares_CNES_ap'[AP])
    )

VAR ValorAP =
    CONCATENATEX(
        FILTER(
            FbAPTable,
            NOT ISBLANK('Informações_auxiliares_CNES_ap'[Facebook]) &&
            LEN(TRIM('Informações_auxiliares_CNES_ap'[Facebook])) > 0
        ),
        'Informações_auxiliares_CNES_ap'[Facebook],
        ", "
    )

RETURN
IF(
    HaFiltroUE,
    COALESCE(ValorUnidade, PlaceholderNulo),
    IF(HaFiltroAP, COALESCE(ValorAP, PlaceholderNulo), FacebookPadraoSemFiltro)
)
