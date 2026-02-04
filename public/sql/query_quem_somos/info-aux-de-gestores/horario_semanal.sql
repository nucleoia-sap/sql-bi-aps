Horario Semanal (Unidade) = 
VAR HorarioPadraoSemFiltro = "08h às 17h"
VAR PlaceholderNulo = "--"

VAR HaFiltroUE =
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_unidade]) ||
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_equipe])

VAR HaFiltroAP =
    ISFILTERED('dw_equipes_unidades_profissionais'[area_programatica])

-- Horários distintos da unidade
VAR HorariosUnidadeDistintos =
    FILTER(
        VALUES('Informações_auxiliares_CNES_uni'[horario_sem]),
        NOT ISBLANK('Informações_auxiliares_CNES_uni'[horario_sem]) &&
        LEN(TRIM('Informações_auxiliares_CNES_uni'[horario_sem])) > 0
    )

VAR ValorUnidade =
    SWITCH(
        TRUE(),
        COUNTROWS(HorariosUnidadeDistintos) = 0, BLANK(),
        COUNTROWS(HorariosUnidadeDistintos) = 1, MINX(HorariosUnidadeDistintos, 'Informações_auxiliares_CNES_uni'[horario_sem]),
        CONCATENATEX(HorariosUnidadeDistintos, 'Informações_auxiliares_CNES_uni'[horario_sem], ", ")
    )

-- APs selecionadas
VAR APsSelecionadas =
    SELECTCOLUMNS(
        FILTER(
            VALUES('dw_equipes_unidades_profissionais'[area_programatica]),
            NOT ISBLANK('dw_equipes_unidades_profissionais'[area_programatica])
        ),
        "AP",
        SUBSTITUTE(SUBSTITUTE(SUBSTITUTE('dw_equipes_unidades_profissionais'[area_programatica],"AP",""),".","")," ","")
    )

-- Tabela de horários por AP
VAR HorarioAPTable =
    CALCULATETABLE(
        VALUES('Informações_auxiliares_CNES_ap'[horario]),
        TREATAS(APsSelecionadas, 'Informações_auxiliares_CNES_ap'[AP])
    )

VAR ValorAP =
    CONCATENATEX(
        FILTER(
            HorarioAPTable,
            NOT ISBLANK('Informações_auxiliares_CNES_ap'[horario]) &&
            LEN(TRIM('Informações_auxiliares_CNES_ap'[horario])) > 0
        ),
        'Informações_auxiliares_CNES_ap'[horario],
        ", "
    )

RETURN
IF(
    HaFiltroUE,
    COALESCE(ValorUnidade, PlaceholderNulo),
    IF(HaFiltroAP, COALESCE(ValorAP, PlaceholderNulo), HorarioPadraoSemFiltro)
)
