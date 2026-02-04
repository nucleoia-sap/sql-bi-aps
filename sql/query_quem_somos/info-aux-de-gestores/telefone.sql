Telefone (Unidade) = 
VAR TelefonePadraoSemFiltro = "1746 (Central de Atendimento ao Cidadão)"
VAR PlaceholderNulo = "--"

VAR HaFiltroUE =
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_unidade]) ||
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_equipe])

VAR HaFiltroAP =
    ISFILTERED('dw_equipes_unidades_profissionais'[area_programatica])

-- Telefones da UNIDADE/EQUIPE (tabela DW)
VAR TelsDistintos =
    FILTER(
        VALUES('dw_equipes_unidades_profissionais'[telefones_unidade]),
        NOT ISBLANK('dw_equipes_unidades_profissionais'[telefones_unidade]) &&
        LEN(TRIM('dw_equipes_unidades_profissionais'[telefones_unidade])) > 0
    )
VAR ValorUnidade =
    SWITCH(
        TRUE(),
        COUNTROWS(TelsDistintos) = 0, BLANK(),
        COUNTROWS(TelsDistintos) = 1, MINX(TelsDistintos, 'dw_equipes_unidades_profissionais'[telefones_unidade]),
        CONCATENATEX(TelsDistintos, 'dw_equipes_unidades_profissionais'[telefones_unidade], ", ")
    )

-- Telefones por AP (tabela auxiliar)
VAR APsSelecionadas =
    SELECTCOLUMNS(
        FILTER(
            VALUES('dw_equipes_unidades_profissionais'[area_programatica]),
            NOT ISBLANK('dw_equipes_unidades_profissionais'[area_programatica])
        ),
        "AP",
        SUBSTITUTE(SUBSTITUTE(SUBSTITUTE('dw_equipes_unidades_profissionais'[area_programatica], "AP", ""), ".", ""), " ", "")
    )
VAR TelAPTable =
    CALCULATETABLE(
        VALUES('Informações_auxiliares_CNES_ap'[Telefone]),
        TREATAS(APsSelecionadas, 'Informações_auxiliares_CNES_ap'[AP])
    )
VAR ValorAP =
    CONCATENATEX(
        FILTER(
            TelAPTable,
            NOT ISBLANK('Informações_auxiliares_CNES_ap'[Telefone]) &&
            LEN(TRIM('Informações_auxiliares_CNES_ap'[Telefone])) > 0
        ),
        'Informações_auxiliares_CNES_ap'[Telefone],
        ", "
    )

RETURN
IF(
    HaFiltroUE,
    COALESCE(ValorUnidade, PlaceholderNulo),
    IF(HaFiltroAP, COALESCE(ValorAP, PlaceholderNulo), TelefonePadraoSemFiltro)
)
