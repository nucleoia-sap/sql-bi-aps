Horario Sabado (Unidade) = 
VAR Placeholder = "---"

VAR HaFiltroUE =
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_unidade]) ||
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_equipe])

VAR HaFiltroAP =
    ISFILTERED('dw_equipes_unidades_profissionais'[area_programatica])

-- Horários de sábado distintos da unidade
VAR HorariosSabadoDistintos =
    FILTER(
        VALUES('Informações_auxiliares_CNES_uni'[horario_sab]),
        NOT ISBLANK('Informações_auxiliares_CNES_uni'[horario_sab]) &&
        LEN(TRIM('Informações_auxiliares_CNES_uni'[horario_sab])) > 0
    )

VAR ValorUnidade =
    SWITCH(
        TRUE(),
        COUNTROWS(HorariosSabadoDistintos) = 0, BLANK(),
        COUNTROWS(HorariosSabadoDistintos) = 1, MINX(HorariosSabadoDistintos, 'Informações_auxiliares_CNES_uni'[horario_sab]),
        CONCATENATEX(HorariosSabadoDistintos, 'Informações_auxiliares_CNES_uni'[horario_sab], ", ")
    )

RETURN
IF(
    HaFiltroUE,
    COALESCE(ValorUnidade, Placeholder),
    Placeholder
)
