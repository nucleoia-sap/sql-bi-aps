import {
    Funnel,
    GitMerge,
    IdentificationBadge,
    Calculator,
    MapPin,
    Database,
    UsersThree,
    Stethoscope
} from "@phosphor-icons/react";

// Componentes Genéricos
import { DocHeader } from '../../components/Documentation/DocHeader';
import { DocMetadata } from '../../components/Documentation/DocMetadata';
import { DocTabs } from '../../components/Documentation/DocTabs';
import { SqlViewer } from '../../components/Documentation/sqlViewer';
import { DictionaryTable } from '../../components/Documentation/DicionaryTable';

export function Query_QuemSomos_Profissionais_esf() {

    // 1. Definição dos Metadados
    const metadataItems = [
        {
            label: "Tabela de Destino",
            value: "rj-sms-sandbox.sub_pav_us.dw_equipes_unidades_profissionais",
            mono: true
        },
        {
            label: "Fontes de Dados",
            mono: false,
            value: (
                <div className="flex flex-col gap-1">
                    <span className="flex items-center gap-1"><Database size={16} /> estabelecimento_sus_rio_historico</span>
                    <span className="flex items-center gap-1"><UsersThree size={16} /> equipe_profissional_saude</span>
                    <span className="flex items-center gap-1"><IdentificationBadge size={16} /> profissional_saude (CBO)</span>
                </div>
            )
        },
        {
            label: "Granularidade",
            mono: false,
            value: (
                <span className="flex items-center gap-2">
                    <Stethoscope size={16} className="text-purple-500" /> Equipe (INE) por Competência
                </span>
            )
        }
    ];

    // 2. Dicionário de Dados (Extraído do SELECT final do SQL)
    const dictionaryData = [
        { column: "ano_mes_competencia", type: "STRING", description: "Mês de referência no formato YYYY-MM." },
        { column: "id_ine", type: "STRING", description: "Código INE da equipe. Se nulo, gera 'SEM_EQUIPE_{CNES}'." },
        { column: "nome_equipe", type: "STRING", description: "Nome de referência da equipe." },
        { column: "id_cnes", type: "STRING", description: "Código CNES da unidade de saúde." },
        { column: "nome_unidade", type: "STRING", description: "Nome limpo da unidade de saúde." },
        { column: "area_programatica", type: "STRING", description: "Área de planejamento (AP)." },
        { column: "tipo_unidade", type: "STRING", description: "Tipo oficial do estabelecimento." },
        { column: "num_equipes", type: "INTEGER (0/1)", description: "Flag indicando se existe equipe vinculada (1) ou se é apenas unidade (0)." },

        // Contagens
        { column: "numero_de_medicos", type: "INTEGER", description: "Tamanho do array de médicos." },
        { column: "numero_de_enfermeiros", type: "INTEGER", description: "Tamanho do array de enfermeiros." },
        { column: "numero_de_acs", type: "INTEGER", description: "Contagem de Agentes Comunitários de Saúde." },
        { column: "numero_de_tecnicos", type: "INTEGER", description: "Contagem de Auxiliares/Técnicos de Enfermagem." },
        { column: "numero_de_dentistas", type: "INTEGER", description: "Contagem de Cirurgiões Dentistas." },
        { column: "numero_de_asb", type: "INTEGER", description: "Auxiliares de Saúde Bucal (Classificado via Regex no CBO)." },
        { column: "numero_de_tsb", type: "INTEGER", description: "Técnicos de Saúde Bucal (Classificado via Regex no CBO)." },

        // Endereço
        { column: "endereco_completo", type: "STRING", description: "Endereço concatenado (Logradouro, Número, Bairro, CEP)." },
        { column: "endereco_latitude", type: "FLOAT", description: "Latitude (Com correção pontual para CNES 9071385)." },
        { column: "endereco_longitude", type: "FLOAT", description: "Longitude (Com correção pontual para CNES 9071385)." },
    ];

    // 3. Conteúdo das Abas
    const tabsConfig = [
        {
            id: 'regras',
            label: 'Regras de Negócio',
            content: (
                <div className="p-8">
                    <h3 className="text-lg font-semibold text-slate-800 mb-4">Pipeline de Construção (ETL)</h3>
                    <ul className="space-y-6">

                        {/* Regra 1: Filtro Inicial */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <Funnel size={24} weight="fill" className="text-blue-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">1. Recorte de APS (Pré-Join)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Filtra a base de estabelecimentos históricos <em>antes</em> de realizar qualquer cruzamento.
                                    <br />
                                    Critério: <code>tipo_sms_simplificado IN ('CF', 'CMS', 'CSE')</code>.
                                </p>
                            </div>
                        </li>

                        {/* Regra 2: Join e Preservação */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <GitMerge size={24} weight="fill" className="text-purple-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">2. Preservação de Unidades (LEFT JOIN)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Utiliza <code>LEFT JOIN</code> entre Estabelecimentos e Equipes.
                                    <br />
                                    <strong>Objetivo:</strong> Manter unidades na base mesmo que não possuam equipe cadastrada (casos onde <code>id_ine</code> é nulo).
                                    Para evitar erros no BI, IDs nulos são convertidos para <code>SEM_EQUIPE_CNES</code>.
                                </p>
                            </div>
                        </li>

                        {/* Regra 3: Saúde Bucal */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <IdentificationBadge size={24} weight="fill" className="text-orange-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">3. Classificação Saúde Bucal (ASB vs TSB)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Como a base original traz apenas listas genéricas, o script utiliza <strong>Expressões Regulares (Regex)</strong> na descrição do CBO normalizado para distinguir:
                                </p>
                                <ul className="list-disc list-inside text-sm text-slate-500 mt-1 ml-2">
                                    <li><strong>TSB:</strong> Contém "TÉCNICO" e "SAÚDE BUCAL".</li>
                                    <li><strong>ASB:</strong> Contém "AUXILIAR" e "SAÚDE BUCAL" (e não é TSB).</li>
                                </ul>
                            </div>
                        </li>

                        {/* Regra 4: Contagens */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <Calculator size={24} weight="fill" className="text-green-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">4. Métricas de RH</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Calcula o tamanho dos arrays (<code>ARRAY_LENGTH</code>) para médicos, enfermeiros, dentistas e outros, consolidando os totais por equipe.
                                </p>
                            </div>
                        </li>

                        {/* Regra 5: Correções */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <MapPin size={24} weight="fill" className="text-red-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">5. Pós-Processamento e Correções</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Aplica correções <em>hardcoded</em> de latitude/longitude para o CNES <code>9071385</code> e padroniza a coluna <code>area_programatica</code> para usar o ID oficial.
                                </p>
                            </div>
                        </li>

                    </ul>
                </div>
            )
        },
        {
            id: 'sql',
            label: 'Script SQL',
            content: <SqlViewer filePath={`${import.meta.env.BASE_URL}sql/query_quem_somos/profissionais/profissionais_esf.sql`} />
        },
        {
            id: 'dicionario',
            label: 'Dicionário de Dados',
            content: <DictionaryTable rows={dictionaryData} />
        }
    ];

    return (
        <div className="flex-1 overflow-y-auto p-6 md:p-10 pt-20 md:pt-10 custom-scrollbar animate-fade-in">
            <div className="max-w-6xl mx-auto">

                <DocHeader
                    title="QUERY - PROFISSIONAIS eSF"
                    description="Tabela consolidada de unidades e equipes da APS, com contagem detalhada de profissionais e classificação de Saúde Bucal."
                    breadcrumbs={['Quem Somos', 'Profissionais eSF']}
                    badgeText="Tabela Agregada"
                    badgeColor="purple"
                    bqLink="https://console.cloud.google.com/bigquery?sq=446908838175:393c3bebd8fe4928a5d0756e0bccbb24"
                />

                <DocMetadata items={metadataItems} />

                <DocTabs tabs={tabsConfig} />

            </div>
        </div>
    );
}