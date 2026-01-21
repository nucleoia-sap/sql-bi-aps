import {
    DatabaseIcon,
    HeartbeatIcon,
    FingerprintIcon
} from "@phosphor-icons/react";

import { DocHeader } from '../../components/Documentation/DocHeader';
import { DocMetadata } from '../../components/Documentation/DocMetadata';
import { DocTabs } from '../../components/Documentation/DocTabs';
import { SqlViewer } from '../../components/Documentation/sqlViewer';
import { DictionaryTable } from '../../components/Documentation/DicionaryTable';


export function Query_AQuemServimos() {

    // 1. Definição dos Cards de Metadados
    const metadataItems = [
        {
            label: "Tabela Final",
            value: "rj-sms-sandbox.sub_pav_us.VisaoGeral_Dash_Indicadores_Ativos_final",
            mono: true
        },
        {
            label: "Fontes Principais",
            mono: false,
            value: (
                <>
                    <span className="flex items-center gap-1" title="brutos_prontuario_vitacare_historico.cadastro">
                        <DatabaseIcon size={16} /> Vitacare (Cadastro)
                    </span>
                    <span className="flex items-center gap-1" title="sub_pav_us.morbidades">
                        <HeartbeatIcon size={16} /> Morbidades & Clínico
                    </span>
                </>
            )
        },
        {
            label: "Identificador Único",
            mono: false,
            value: (
                <span className="flex items-center gap-2">
                    <FingerprintIcon size={16} className="text-amber-500" /> CPF (Deduplicado)
                </span>
            )
        }
    ];

    // 2. Definição do Dicionário
    const dictionaryData = [
        { column: "id_unico_preciso", type: "STRING (HASH)", description: "Hash SHA256 único gerado a partir do nome normalizado + data de nascimento." },
        { column: "cpf", type: "STRING", description: "Cadastro de Pessoa Física validado e deduplicado." },
        { column: "idade", type: "INTEGER", description: "Idade calculada em anos (DATE_DIFF) em relação à data atual." },
        { column: "fx_etaria", type: "STRING", description: "Faixa etária quinquenal (ex: '00-04 anos', '80+ anos')." },
        { column: "bf / cfc", type: "STRING", description: "Indicador de benefício social (Bolsa Família / Cartão Família Carioca). Valores: SIM/NAO." },
        { column: "gestante", type: "STRING", description: "Flag (SIM/NAO) se o CPF consta na base ativa de acompanhamento de gestantes." },
        { column: "tuberculose", type: "BOOLEAN", description: "Verdadeiro se paciente está em tratamento ativo de Tuberculose." },
        { column: "hanseniase", type: "BOOLEAN", description: "Verdadeiro se paciente está em tratamento ativo de Hanseníase." },
        { column: "HAS / DM", type: "BOOLEAN", description: "Flags para Hipertensão Arterial Sistêmica e Diabetes Mellitus." },
    ];

    // 3. Definição do Conteúdo das Abas
    const tabsConfig = [
        {
            id: 'regras',
            label: 'Regras de Negócio',
            content: (
                <div className="p-8">
                    <h3 className="text-lg font-semibold text-slate-800 mb-4">Pipeline de Processamento</h3>
                    <ul className="space-y-6">

                        {/* Passo 1 */}
                        <li className="flex gap-3">
                            <div className="flex-shrink-0 mt-1">
                                <span className="flex items-center justify-center w-6 h-6 rounded-full bg-blue-100 text-blue-600 font-bold text-xs">1</span>
                            </div>
                            <div>
                                <strong className="text-slate-900 block">Limpeza e Padronização</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Remove caracteres especiais e acentos dos nomes. Valida CPFs (removendo sequências inválidas como '11111111111' e '00000000000'). Cria um hash SHA256 (ID único) baseado no nome normalizado e data de nascimento.
                                </p>
                            </div>
                        </li>

                        {/* Passo 2 */}
                        <li className="flex gap-3">
                            <div className="flex-shrink-0 mt-1">
                                <span className="flex items-center justify-center w-6 h-6 rounded-full bg-blue-100 text-blue-600 font-bold text-xs">2</span>
                            </div>
                            <div>
                                <strong className="text-slate-900 block">Filtro de Cadastros Válidos</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Mantém apenas usuários com situação 'Ativo', cadastro 'Permanente' e sem indicativo de óbito. Remove explicitamente cadastros de teste (nomes contendo 'teste', 'exemplo', 'paciente padrao').
                                </p>
                            </div>
                        </li>

                        {/* Passo 3 */}
                        <li className="flex gap-3">
                            <div className="flex-shrink-0 mt-1">
                                <span className="flex items-center justify-center w-6 h-6 rounded-full bg-blue-100 text-blue-600 font-bold text-xs">3</span>
                            </div>
                            <div>
                                <strong className="text-slate-900 block">Deduplicação Inteligente (CPF)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Prioriza o registro mais recente (maior timestamp). Preenche lacunas de dados (raca, sexo, nome da mãe) buscando em registros históricos do mesmo CPF para evitar campos nulos (<code className="bg-slate-100 px-1 rounded text-xs">IGNORE NULLS</code>).
                                </p>
                            </div>
                        </li>

                        {/* Passo 4 */}
                        <li className="flex gap-3">
                            <div className="flex-shrink-0 mt-1">
                                <span className="flex items-center justify-center w-6 h-6 rounded-full bg-blue-100 text-blue-600 font-bold text-xs">4</span>
                            </div>
                            <div>
                                <strong className="text-slate-900 block">Enriquecimento Clínico e Social</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Cruza dados com bases de programas sociais (Bolsa Família, Cartão Família Carioca), base de Gestações e base de Morbidades (Diabetes, Hipertensão, Tuberculose, Hanseníase, Obesidade, etc.).
                                </p>
                            </div>
                        </li>

                        {/* Passo 5 - Nota: Cor diferente (Emerald) conforme o original */}
                        <li className="flex gap-3">
                            <div className="flex-shrink-0 mt-1">
                                <span className="flex items-center justify-center w-6 h-6 rounded-full bg-emerald-100 text-emerald-600 font-bold text-xs">5</span>
                            </div>
                            <div>
                                <strong className="text-slate-900 block">Anonimização Final</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Gera uma tabela espelho (<code className="bg-slate-100 px-1 rounded text-xs">_Anonimizada</code>) removendo dados sensíveis como Nome, Nome da Mãe e Endereço detalhado, mantendo apenas as flags clínicas e demográficas para o dashboard público.
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
            content: <SqlViewer filePath="/sql/query_a_quem_servimos/script.sql" />
        },
        {
            id: 'dicionario',
            label: 'Dicionário de Dados',
            content: <DictionaryTable rows={dictionaryData} />
        }
    ];

    // --- RENDERIZAÇÃO ---
    return (
        <div className="p-6 md:p-10 pt-20 md:pt-10 max-w-6xl mx-auto animate-fade-in">

            <DocHeader
                title="QUERY - A QUEM SERVIMOS"
                description="Processamento completo da base de cadastros (CPFs) com dados clínicos e sociodemográficos."
                breadcrumbs={['Tabela Consolidada', 'BI APS']}
                badgeText="Tabela Consolidada"
                badgeColor="purple"
                bqLink="#" // Link BigQuery
            />

            <DocMetadata items={metadataItems} />

            <DocTabs tabs={tabsConfig} />

        </div>
    );
}