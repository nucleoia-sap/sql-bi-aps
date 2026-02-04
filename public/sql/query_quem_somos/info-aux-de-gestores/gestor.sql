Gestor = 
VAR GestorPadraoSemFiltro = "Secretário Municipal de Saúde: Daniel Soranz"
VAR PlaceholderNulo = "--"

VAR HaFiltroUE =
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_unidade]) ||
    ISFILTERED('dw_equipes_unidades_profissionais'[nome_equipe])

VAR HaFiltroAP =
    ISFILTERED('dw_equipes_unidades_profissionais'[area_programatica])

// --- LÓGICA PARA FILTRO DE UNIDADE/EQUIPE (UE) ---
// Coleta os 'id_cnes' filtrados da dw_equipes_unidades_profissionais (CORREÇÃO AQUI!)
VAR IDsCNESFiltrados = 
    VALUES('dw_equipes_unidades_profissionais'[id_cnes])

// Busca os Gerentes correspondentes na Informações_auxiliares_CNES_uni via CNES
VAR GerentesDeUnidade =
    CALCULATETABLE(
        VALUES('Informações_auxiliares_CNES_uni'[Gerente]),
        TREATAS(IDsCNESFiltrados, 'Informações_auxiliares_CNES_uni'[CNES]) // Mapeia id_cnes para CNES
    )

VAR ValorGerenteUnidade =
    IF(
        NOT ISEMPTY(GerentesDeUnidade),
        CONCATENATEX(
            FILTER(
                GerentesDeUnidade,
                NOT ISBLANK('Informações_auxiliares_CNES_uni'[Gerente]) &&
                LEN(TRIM('Informações_auxiliares_CNES_uni'[Gerente])) > 0
            ),
            'Informações_auxiliares_CNES_uni'[Gerente],
            ", "
        ),
        BLANK()
    )

// --- LÓGICA PARA FILTRO DE ÁREA PROGRAMÁTICA (AP) ---
// Coleta as 'area_programatica' filtradas da dw_equipes_unidades_profissionais
VAR APsSelecionadasFormatadas =
    SELECTCOLUMNS(
        FILTER(
            VALUES('dw_equipes_unidades_profissionais'[area_programatica]),
            NOT ISBLANK('dw_equipes_unidades_profissionais'[area_programatica])
        ),
        "AP",
        SUBSTITUTE(SUBSTITUTE(SUBSTITUTE('dw_equipes_unidades_profissionais'[area_programatica],"AP",""),".","")," ","")
    )

// Busca os Coordenadores correspondentes na Informações_auxiliares_CNES_ap via 'AP'
VAR CoordenadoresDeAP =
    CALCULATETABLE(
        VALUES('Informações_auxiliares_CNES_ap'[Coordenador(a)]),
        TREATAS(APsSelecionadasFormatadas, 'Informações_auxiliares_CNES_ap'[AP])
    )

VAR ValorCoordenadorAP =
    IF(
        NOT ISEMPTY(CoordenadoresDeAP),
        CONCATENATEX(
            FILTER(
                CoordenadoresDeAP,
                NOT ISBLANK('Informações_auxiliares_CNES_ap'[Coordenador(a)]) &&
                LEN(TRIM('Informações_auxiliares_CNES_ap'[Coordenador(a)])) > 0
            ),
            'Informações_auxiliares_CNES_ap'[Coordenador(a)],
            ", "
        ),
        BLANK()
    )

RETURN
IF(
    HaFiltroUE,
    COALESCE(ValorGerenteUnidade, PlaceholderNulo),
    IF(HaFiltroAP, COALESCE(ValorCoordenadorAP, PlaceholderNulo), GestorPadraoSemFiltro)
)