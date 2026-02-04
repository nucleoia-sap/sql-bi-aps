Endereço (Unidade) = 
VAR EndPadraoSemFiltro =
    "Centro Administrativo São Sebastião" & UNICHAR(10) &
    "Rua Afonso Cavalcanti, 455" & UNICHAR(10) &
    "Cidade Nova, Rio de Janeiro/RJ" & UNICHAR(10) &
    "CEP 20211-110"
VAR PlaceholderNulo = "--"

VAR HaFiltroUE =
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_unidade]) ||
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_equipe])

VAR HaFiltroAP =
    ISFILTERED('dw_equipes_unidades_profissionais'[area_programatica])

-- Endereço da UNIDADE/EQUIPE (DW)
VAR EnderecosU =
    FILTER(
        VALUES('dw_equipes_unidades_profissionais'[endereco_completo]),
        NOT ISBLANK('dw_equipes_unidades_profissionais'[endereco_completo]) &&
        LEN(TRIM('dw_equipes_unidades_profissionais'[endereco_completo])) > 0
    )
VAR ValorUnidade =
    SWITCH(
        TRUE(),
        COUNTROWS(EnderecosU) = 0, BLANK(),
        COUNTROWS(EnderecosU) = 1, MINX(EnderecosU, 'dw_equipes_unidades_profissionais'[endereco_completo]),
        CONCATENATEX(EnderecosU, 'dw_equipes_unidades_profissionais'[endereco_completo], UNICHAR(10))
    )

-- Endereço por AP (tabela auxiliar)
VAR APsSelecionadas =
    SELECTCOLUMNS(
        FILTER(
            VALUES('dw_equipes_unidades_profissionais'[area_programatica]),
            NOT ISBLANK('dw_equipes_unidades_profissionais'[area_programatica])
        ),
        "AP",
        SUBSTITUTE(SUBSTITUTE(SUBSTITUTE('dw_equipes_unidades_profissionais'[area_programatica], "AP", ""), ".", ""), " ", "")
    )
VAR EndAPTable =
    CALCULATETABLE(
        VALUES('Informações_auxiliares_CNES_ap'[endereco_completo]),
        TREATAS(APsSelecionadas, 'Informações_auxiliares_CNES_ap'[AP])
    )
VAR ValorAP =
    CONCATENATEX(
        FILTER(
            EndAPTable,
            NOT ISBLANK('Informações_auxiliares_CNES_ap'[endereco_completo]) &&
            LEN(TRIM('Informações_auxiliares_CNES_ap'[endereco_completo])) > 0
        ),
        'Informações_auxiliares_CNES_ap'[endereco_completo],
        UNICHAR(10)
    )

RETURN
IF(
    HaFiltroUE,
    COALESCE(ValorUnidade, PlaceholderNulo),
    IF(HaFiltroAP, COALESCE(ValorAP, PlaceholderNulo), EndPadraoSemFiltro)
)
