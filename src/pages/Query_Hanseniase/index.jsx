import {
    Pill,
    FileText,
    Calendar,
    Funnel
} from "@phosphor-icons/react";
import { SqlViewer } from "../../components/Documentation/sqlViewer";
import { DictionaryTable } from "../../components/Documentation/DicionaryTable";
import { DocHeader } from "../../components/Documentation/DocHeader";
import { DocMetadata } from "../../components/Documentation/DocMetadata";
import { DocTabs } from "../../components/Documentation/DocTabs";

// Componentes Genéricos


export function Query_Hanseniase() {

    // 1. Definição dos Metadados
    const metadataItems = [
        {
            label: "Tabela Final",
            value: "rj-sms-sandbox.sub_pav_us._hanseniase_em_tratamento",
            mono: true
        },
        {
            label: "Fontes Principais",
            mono: false,
            value: (
                <>
                    <span className="flex items-center gap-1">
                        <Pill size={16} /> Prescrições (Medicamentos)
                    </span>
                    <span className="flex items-center gap-1">
                        <FileText size={16} /> Vitacare (Lista Oficial)
                    </span>
                </>
            )
        },
        {
            label: "Janela Temporal",
            mono: false,
            value: (
                <span className="flex items-center gap-2">
                    <Calendar size={16} className="text-amber-500" /> Últimos 18 Meses
                </span>
            )
        }
    ];

    // 2. Definição do Dicionário
    const dictionaryData = [
        { column: "cpf", type: "STRING", description: "CPF do paciente (apenas dígitos)." },
        { column: "criterio1_prescricao", type: "INTEGER (0/1)", description: "Indica se o paciente recebeu prescrição de Rifampicina/Clofazimina/Dapsona." },
        { column: "criterio2_cid_ativo", type: "INTEGER (0/1)", description: "Indica se houve registro de CID A30* com situação 'ATIVO'." },
        { column: "criterio3_lista_hanseniase", type: "INTEGER (0/1)", description: "Indica presença na lista nominal oficial (Vitacare/SINAN)." },
        { column: "soma_criterios", type: "INTEGER", description: "Soma dos flags acima. Indica a força da evidência (1 a 3)." },
        { column: "medicamentos_prescritos", type: "STRING", description: "Lista concatenada dos medicamentos identificados na prescrição mais recente." },
    ];

    // 3. Conteúdo das Abas
    const tabsConfig = [
        {
            id: 'regras',
            label: 'Regras de Negócio',
            content: (
                <div className="p-8">
                    <h3 className="text-lg font-semibold text-slate-800 mb-4">Critérios de Inclusão (Multicritério)</h3>
                    <p className="text-slate-600 text-sm mb-6">
                        Para maximizar a sensibilidade da detecção, um paciente é considerado "Em Tratamento" se atender a <strong>pelo menos um</strong> dos critérios abaixo na janela dos últimos 18 meses.
                    </p>

                    <ul className="space-y-6">
                        {/* Critério 1 */}
                        <li className="flex gap-3">
                            <div className="flex-shrink-0 mt-1">
                                <span className="flex items-center justify-center w-6 h-6 rounded-full bg-purple-100 text-purple-600 font-bold text-xs">1</span>
                            </div>
                            <div>
                                <strong className="text-slate-900 block">Critério Farmacológico (Prescrições)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Identificação de medicamentos rastreadores específicos (poliquimioterapia).
                                    <br />
                                    <span className="text-xs bg-slate-100 px-1 py-0.5 rounded text-slate-500 font-mono mt-1 inline-block">
                                        Rifampicina + Clofazimina + Dapsona
                                    </span> ou combinações com Ofloxacino/Minociclina.
                                </p>
                            </div>
                        </li>

                        {/* Critério 2 */}
                        <li className="flex gap-3">
                            <div className="flex-shrink-0 mt-1">
                                <span className="flex items-center justify-center w-6 h-6 rounded-full bg-purple-100 text-purple-600 font-bold text-xs">2</span>
                            </div>
                            <div>
                                <strong className="text-slate-900 block">Critério Clínico (CID Ativo)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Registro de Episódio Assistencial com diagnóstico CID iniciando em <strong>A30</strong> (Hanseníase) e situação marcada como 'ATIVO' em qualquer momento da janela temporal.
                                </p>
                            </div>
                        </li>

                        {/* Critério 3 */}
                        <li className="flex gap-3">
                            <div className="flex-shrink-0 mt-1">
                                <span className="flex items-center justify-center w-6 h-6 rounded-full bg-purple-100 text-purple-600 font-bold text-xs">3</span>
                            </div>
                            <div>
                                <strong className="text-slate-900 block">Critério Administrativo (Lista Oficial)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Presença na lista oficial de notificação (SINAN/Vitacare). Como essa lista as vezes não possui CPF, é feito um cruzamento (JOIN) com a tabela <code className="bg-slate-100 px-1 rounded">acto</code> para recuperar o CPF do paciente via chave composta (CNES + Prontuário).
                                </p>
                            </div>
                        </li>

                        {/* Filtro de Escopo */}
                        <li className="flex gap-3">
                            <div className="flex-shrink-0 mt-1">
                                <Funnel size={24} className="text-slate-400" />
                            </div>
                            <div>
                                <strong className="text-slate-900 block">Filtro de Escopo (APS)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    A lista final é filtrada para conter apenas unidades classificadas como <strong>Atenção Primária à Saúde (APS)</strong> na tabela mestre de estabelecimentos.
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
            content: <SqlViewer filePath={`${import.meta.env.BASE_URL}sql/query_a_quem_servimos/perfil-clinico-epidemiologico/query_hanseniase/perfil_clinico_epidemiologico_hanseniase.sql`} />
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
                title="QUERY - HANSENÍASE"
                description="Identificação de pacientes em tratamento ativo via critérios clínicos, medicamentosos e administrativos."
                breadcrumbs={['Linha de Cuidado', 'Agravo Específico']}
                badgeText="Agravo Específico"
                badgeColor="amber"
                bqLink="#"
            />

            <DocMetadata items={metadataItems} />

            <DocTabs tabs={tabsConfig} />
        </div>
    );
}