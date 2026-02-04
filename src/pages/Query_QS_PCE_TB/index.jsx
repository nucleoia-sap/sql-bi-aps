import React, { useState } from 'react';
import {
    CaretDownIcon,
    ChartLineUpIcon,
    FunnelIcon,
    PillIcon,
    FileTextIcon,
    CalendarIcon
} from "@phosphor-icons/react";

import { SqlViewer } from "../../components/Documentation/sqlViewer";
import { DictionaryTable } from "../../components/Documentation/DicionaryTable";
import { DocHeader } from "../../components/Documentation/DocHeader";
import { DocMetadata } from "../../components/Documentation/DocMetadata";
import { DocTabs } from "../../components/Documentation/DocTabs";

export function Query_Tuberculose() {

    // --- ESTADOS ---

    const [selectedSql, setSelectedSql] = useState('preparacao_lista');

    // 1. Definição dos Metadados
    const metadataItems = [
        {
            label: "Tabela Final",
            value: "rj-sms-sandbox.sub_pav_us._tuberculose_em_tratamento",
            mono: true
        },
        {
            label: "Fontes Principais",
            mono: false,
            value: (
                <>
                    <span className="flex items-center gap-1">
                        <PillIcon size={16} /> Prescrições (RIPE/RIP/RI)
                    </span>
                    <span className="flex items-center gap-1">
                        <FileTextIcon size={16} /> Listas Oficiais (Tuberculose/ACTO)
                    </span>
                </>
            )
        },
        {
            label: "Janela Temporal",
            mono: false,
            value: (
                <span className="flex items-center gap-2">
                    <CalendarIcon size={16} className="text-amber-500" /> Diagnóstico: 9 Meses | Tratamento: Ativo
                </span>
            )
        }
    ];

    // 2. Definição do Dicionário (Baseado no texto fornecido)
    const dictionaryData = [
        // Identificadores
        { column: "paciente_cpf", type: "STRING", description: "CPF do paciente normalizado (apenas dígitos)." },
        { column: "id_cnes", type: "STRING", description: "Código CNES da unidade de saúde." },

        // Critérios (Flags)
        { column: "criterio1_prescricao", type: "INTEGER (0/1)", description: "Indica presença de esquema terapêutico (RIPE, RI, RIP)." },
        { column: "criterio2_cid_ativo", type: "INTEGER (0/1)", description: "Indica diagnóstico clínico com CID A15-A19 e situação 'ATIVO' nos últimos 9 meses." },
        { column: "criterio3_lista_tuberculose", type: "INTEGER (0/1)", description: "Indica presença na lista oficial de acompanhamento (Vitacare/Acto)." },

        // Cálculos
        { column: "soma_criterios", type: "INTEGER", description: "Soma dos flags acima. Indica a força da evidência (1 a 3)." },

        // Informações Clínicas Ricas (Adicionadas baseadas no Script 2 e 3)
        { column: "medicamentos_prescritos_mais_recente", type: "STRING", description: "Lista dos fármacos identificados na prescrição mais recente." },
        { column: "Cura", type: "STRING (Sim/Não)", description: "Identificado via texto livre (alta por cura, tratamento completo)." },
        { column: "Abandono", type: "STRING (Sim/Não)", description: "Identificado via texto livre (abandono, evasão, perda de seguimento)." },

        // Filtros
        { column: "tipo_sms_agrupado", type: "STRING", description: "Classificação da unidade (apenas 'APS' mantidos)." },

        // KPIs (Só mantenha se o SQL realmente criar essas colunas no final, caso contrário, use soma_criterios)
        // { column: "tuberculose", type: "BOOLEAN", description: "Flag final KPI (Geralmente se soma_criterios > 0)." },
    ];

    // 3. Conteúdo das Abas
    const tabsConfig = [
        {
            id: 'regras',
            label: 'Regras de Negócio',
            content: (
                <div className="p-8">
                    <h3 className="text-lg font-semibold text-slate-800 mb-4">Processo de Identificação (Multicritério)</h3>
                    <p className="text-slate-600 text-sm mb-6">
                        A query consolida informações de múltiplas fontes para identificar pacientes em tratamento, cruzando prescrições específicas, diagnósticos (CIDs A15–A19) e listas oficiais, gerando a tabela base para o painel "A quem servimos".
                    </p>

                    <ul className="space-y-6">
                        {/* Critério 1 */}
                        <li className="flex gap-3">
                            <div className="flex-shrink-0 mt-1">
                                <span className="flex items-center justify-center w-6 h-6 rounded-full bg-blue-100 text-blue-600 font-bold text-xs">1</span>
                            </div>
                            <div>
                                <strong className="text-slate-900 block">Critério Farmacológico (Prescrições)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Identificação de esquemas completos de tratamento através da varredura de prescrições.
                                    <br />
                                    Medicamentos rastreados: <span className="font-semibold text-slate-700">Rifampicina, Isoniazida, Pirazinamida e Etambutol</span>.
                                    <br />
                                    <span className="text-xs bg-slate-100 px-1 py-0.5 rounded text-slate-500 font-mono mt-1 inline-block">
                                        Flag: criterio1_prescricao (Esquemas RIPE, RI, RIP)
                                    </span>
                                </p>
                            </div>
                        </li>

                        {/* Critério 2 */}
                        <li className="flex gap-3">
                            <div className="flex-shrink-0 mt-1">
                                <span className="flex items-center justify-center w-6 h-6 rounded-full bg-blue-100 text-blue-600 font-bold text-xs">2</span>
                            </div>
                            <div>
                                <strong className="text-slate-900 block">Critério Clínico (Diagnóstico Ativo)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Verificação de diagnósticos ativos nos últimos <strong>9 meses</strong>.
                                    Considera registros com CIDs no intervalo <strong>A15–A19</strong> e status marcado especificamente como "ATIVO".
                                    <br />
                                    <span className="text-xs bg-slate-100 px-1 py-0.5 rounded text-slate-500 font-mono mt-1 inline-block">
                                        Flag: criterio2_cid_ativo
                                    </span>
                                </p>
                            </div>
                        </li>

                        {/* Critério 3 */}
                        <li className="flex gap-3">
                            <div className="flex-shrink-0 mt-1">
                                <span className="flex items-center justify-center w-6 h-6 rounded-full bg-blue-100 text-blue-600 font-bold text-xs">3</span>
                            </div>
                            <div>
                                <strong className="text-slate-900 block">Critério Administrativo (Listas Oficiais)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Integração com listas oficiais de acompanhamento e tabela <code className="bg-slate-100 px-1 rounded">acto</code>.
                                    Inclui normalização de identificadores (CNES + Prontuário) para criação de chave única.
                                    <br />
                                    <span className="text-xs bg-slate-100 px-1 py-0.5 rounded text-slate-500 font-mono mt-1 inline-block">
                                        Flag: criterio3_lista_tuberculose
                                    </span>
                                </p>
                            </div>
                        </li>

                        {/* Enriquecimento e Filtro */}
                        <li className="flex gap-3">
                            <div className="flex-shrink-0 mt-1">
                                <FunnelIcon size={24} className="text-slate-400" />
                            </div>
                            <div>
                                <strong className="text-slate-900 block">Filtro de Escopo e Desfecho</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Processamento de texto livre para classificação de desfechos (Cura e Abandono) e filtragem final para manter apenas unidades da <strong>Atenção Primária (APS)</strong> baseada no tipo de unidade agrupado.
                                </p>
                            </div>
                        </li>

                        {/* KPIs */}
                        <li className="flex gap-3 pt-4 border-t border-slate-100">
                            <div className="flex-shrink-0 mt-1">
                                <ChartLineUpIcon size={24} className="text-green-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900 block">Impacto no Painel (KPIs)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    A tabela alimenta os seguintes indicadores no dashboard:
                                </p>
                                <ul className="list-disc list-inside text-sm text-slate-500 mt-1 ml-1">
                                    <li>Total de pessoas com Tuberculose ativa.</li>
                                    <li>% de casos identificados exclusivamente por CID ativo.</li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </div>
            )
        },
        {
            id: 'sql',
            label: 'Script SQL',
            content: (
                <div>
                    <div className="border-b border-gray-300 p-4">
                        <div className="relative inline-block w-full md:w-auto">
                            <select
                                value={selectedSql}
                                onChange={(e) => setSelectedSql(e.target.value)}
                                className="appearance-none bg-gray-300 pl-4 pr-10 py-2 rounded-md border border-gray-300 font-medium text-sm focus:outline-none focus:ring-2 focus:ring-sky-500 focus:border-sky-500 transition-all cursor-pointer w-full md:min-w-[300px]"
                            >
                                <option value="preparacao_lista">1. Preparação (Normalização Listas)</option>
                                <option value="criterio_prescricao">2. Critério Farmacológico (Prescrições)</option>
                                <option value="consolidacao_final">3. Consolidação Final e Desfechos</option>
                            </select>
                            <CaretDownIcon size={16} className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 pointer-events-none" />
                        </div>
                    </div>

                    {/* Ajuste o caminho abaixo para refletir a estrutura real das pastas do projeto.
                       Exemplo: sql/query_a_quem_servimos/perfil-clinico-epidemiologico/tuberculose/
                    */}
                    <SqlViewer
                        filePath={`${import.meta.env.BASE_URL}sql/query_a_quem_servimos/perfil-clinico-epidemiologico/tuberculose/${selectedSql}.sql`}
                    />
                </div>
            )
        },
        {
            id: 'dicionario',
            label: 'Dicionário de Dados',
            content: <DictionaryTable rows={dictionaryData} />
        }
    ];

    return (
        <div className="p-6 md:p-10 pt-20 md:pt-10 max-w-6xl mx-auto animate-fade-in">
            <DocHeader
                title="QUERY - TUBERCULOSE"
                description="Monitoramento de pacientes em tratamento via identificação de esquemas medicamentosos (RIPE), CIDs ativos e listas oficiais."
                breadcrumbs={['Linha de Cuidado', 'Agravo Específico']}
                badgeText="Agravo Específico"
                badgeColor="amber"
                bqLink="https://console.cloud.google.com/bigquery?sq=446908838175:9c6f78f519b34791b598cba40ce4359c"
            />

            <DocMetadata items={metadataItems} />

            <DocTabs tabs={tabsConfig} />
        </div>
    );
}