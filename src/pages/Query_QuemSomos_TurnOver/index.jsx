import {
    UserFocusIcon,
    BuildingsIcon,
    FunnelIcon,
    SigmaIcon,
    ArrowsLeftRightIcon,
    DatabaseIcon
} from "@phosphor-icons/react";

// Componentes Genéricos
import { DocHeader } from '../../components/Documentation/DocHeader';
import { DocMetadata } from '../../components/Documentation/DocMetadata';
import { DocTabs } from '../../components/Documentation/DocTabs';
import { SqlViewer } from '../../components/Documentation/sqlViewer';
import { DictionaryTable } from '../../components/Documentation/DicionaryTable';

export function Query_QuemSomos_TurnOver() {

    // 1. Definição dos Metadados
    const metadataItems = [
        {
            label: "Tabela Agregada",
            value: "rj-sms-sandbox.sub_pav_us.profissionais_aps_turnover_agrupado",
            mono: true
        },
        {
            label: "Tabela Analítica",
            value: "rj-sms-sandbox.sub_pav_us.profissionais_aps_turnover",
            mono: true
        },
        {
            label: "Fontes de Dados",
            mono: false,
            value: (
                <div className="flex flex-col gap-1">
                    <span className="flex items-center gap-1"><DatabaseIcon size={16} /> profissional_sus_rio_historico</span>
                    <span className="flex items-center gap-1"><BuildingsIcon size={16} /> estabelecimento_sus_rio_historico</span>
                </div>
            )
        },
        {
            label: "Granularidade",
            mono: false,
            value: (
                <span className="flex items-center gap-2">
                    <ArrowsLeftRightIcon size={16} className="text-orange-500" /> Por Unidade, Tipo Profissional e Mês
                </span>
            )
        }
    ];

    // 2. Dicionário de Dados (Focado na Tabela Agrupada Final)
    const dictionaryData = [
        { column: "id_estabelecimento_ap", type: "STRING", description: "Área Programática (AP) da unidade." },
        { column: "estabelecimento_nome_fantasia", type: "STRING", description: "Nome da unidade de saúde." },
        { column: "tipo_profissional", type: "STRING", description: "Categoria normalizada (Médico, Enfermeiro, ACS, Tec/Aux Enfermagem, Outros)." },
        { column: "mes_entrada_profissional", type: "STRING", description: "Mês de admissão no formato YYYY-MM." },
        { column: "mes_desligamento_profissional", type: "STRING", description: "Mês de saída no formato YYYY-MM (pode ser nulo se ativo)." },
        { column: "quantidade", type: "INTEGER", description: "Contagem de profissionais naquele grupo." },
    ];

    // 3. Conteúdo das Abas
    const tabsConfig = [
        {
            id: 'regras',
            label: 'Regras de Negócio',
            content: (
                <div className="p-8">
                    <h3 className="text-lg font-semibold text-slate-800 mb-4">Pipeline de Cálculo de Turnover</h3>
                    <ul className="space-y-6">

                        {/* Passo 1: Seleção de Profissionais */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <UserFocusIcon size={24} weight="fill" className="text-blue-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">1. Snapshot de Profissionais</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Seleciona o registro mais recente (<code>MAX(data_registro)</code>) da tabela histórica de profissionais.
                                    <br />
                                    <strong>Filtro Crítico:</strong> Considera apenas registros onde <code>data_entrada_profissional</code> está preenchida.
                                </p>
                            </div>
                        </li>

                        {/* Passo 2: Filtro de Estabelecimentos */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <BuildingsIcon size={24} weight="fill" className="text-purple-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">2. Filtro de Unidades APS</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Considera apenas unidades ativas (<code>ativa = 'sim'</code>) e dos tipos:
                                    <span className="font-mono text-xs bg-slate-100 px-1 mx-1 rounded">CF</span>
                                    <span className="font-mono text-xs bg-slate-100 px-1 mx-1 rounded">CMS</span>
                                    <span className="font-mono text-xs bg-slate-100 px-1 mx-1 rounded">CSE</span>.
                                </p>
                            </div>
                        </li>

                        {/* Passo 3: Categorização */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <FunnelIcon size={24} weight="fill" className="text-orange-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">3. Categorização via CBO</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Normaliza o cargo do profissional analisando a descrição do CBO (Classificação Brasileira de Ocupações) via <code>LIKE</code>:
                                </p>
                                <ul className="list-disc list-inside text-sm text-slate-500 mt-1 ml-2">
                                    <li><strong>Médico:</strong> Contém "MEDICO".</li>
                                    <li><strong>Enfermeiro:</strong> Contém "ENFERMEIRO" (exceto técnicos).</li>
                                    <li><strong>ACS:</strong> Contém "AGENTE COMUNITARIO".</li>
                                    <li><strong>Técnico:</strong> Contém "ENFERM" (mas não caiu na regra de enfermeiro acima).</li>
                                </ul>
                            </div>
                        </li>

                        {/* Passo 4: Agregação */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <SigmaIcon size={24} weight="fill" className="text-green-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">4. Agregação Final</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Gera uma tabela sumarizada contando o volume de entradas e saídas agrupado por:
                                    <br />
                                    <code>AP + Unidade + Tipo Profissional + Mês Entrada + Mês Saída</code>.
                                </p>
                            </div>
                        </li>

                        {/* Obs Operacional */}
                        <li className="flex gap-3 pt-4 border-t border-slate-100">
                            <div className="mt-1">
                                <ArrowsLeftRightIcon size={24} weight="regular" className="text-slate-400" />
                            </div>
                            <div>
                                <strong className="text-slate-900">Observação Operacional</strong>
                                <p className="text-slate-500 text-xs mt-1 italic">
                                    Um profissional pode ser contado mais de uma vez na agregação total se ele estiver vinculado a mais de uma AP ou Estabelecimento simultaneamente. Isso é esperado para a visão por unidade.
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
            // Certifique-se de salvar o arquivo como turn_over.sql na pasta public
            content: <SqlViewer filePath={`${import.meta.env.BASE_URL}sql/query_quem_somos/profissionais/turn_over.sql`} />
        },
        {
            id: 'dicionario',
            label: 'Dicionário de Dados',
            content: <DictionaryTable rows={dictionaryData} />
        }
    ];

    // --- RENDERIZAÇÃO ---
    return (
        <div className="flex-1 overflow-y-auto p-6 md:p-10 pt-20 md:pt-10 custom-scrollbar animate-fade-in">
            <div className="max-w-6xl mx-auto">

                <DocHeader
                    title="QUERY - TURNOVER PROFISSIONAL"
                    description="Monitoramento de entradas e saídas de profissionais (Médicos, Enfermeiros, Técnicos e ACS) na rede APS."
                    breadcrumbs={['Quem Somos', 'Turnover']}
                    badgeText="Recursos Humanos"
                    badgeColor="orange"
                    bqLink="#"
                />

                <DocMetadata items={metadataItems} />

                <DocTabs tabs={tabsConfig} />

            </div>
        </div>
    );
}