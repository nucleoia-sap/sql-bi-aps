import {
    Function,
    CaretDown
} from "@phosphor-icons/react";

// Componentes Genéricos
import { DocHeader } from '../../components/Documentation/DocHeader';
import { DocMetadata } from '../../components/Documentation/DocMetadata';
import { DocTabs } from '../../components/Documentation/DocTabs';
import { SqlViewer } from '../../components/Documentation/sqlViewer';
import { DictionaryTable } from '../../components/Documentation/DicionaryTable';
import { useState } from "react";

export function Query_QuemSomos_InfoAuxiliares() {

    // --- ESTADOS ---
    const [selectedScript, setSelectedScript] = useState('gestor');

    // 1. Definição dos Metadados
    const metadataItems = [
        {
            label: "Contexto",
            value: "Dinâmico (Filtro Power BI)",
            mono: false
        },
        {
            label: "Tabelas Auxiliares",
            mono: true,
            value: (
                <div className="flex flex-col gap-1">
                    <span>Informações_auxiliares_CNES_uni</span>
                    <span>Informações_auxiliares_CNES_ap</span>
                </div>
            )
        },
        {
            label: "Tecnologia",
            mono: false,
            value: (
                <span className="flex items-center gap-2">
                    <Function size={16} className="text-yellow-600" /> Medidas DAX
                </span>
            )
        }
    ];

    // 2. Dicionário de Dados (Atualizado com Email e Twitter)
    const dictionaryData = [
        { column: "Gestor", type: "DAX Measure", description: "Retorna o Gerente (Unidade), Coordenador (AP) ou Secretário (Município)." },
        { column: "Endereço", type: "DAX Measure", description: "Retorna o endereço da unidade ou da sede administrativa." },
        { column: "Telefone", type: "DAX Measure", description: "Telefones da unidade ou Central 1746." },
        { column: "Email", type: "DAX Measure", description: "E-mail de contato da unidade ou da ouvidoria." },
        { column: "Horário Semanal", type: "DAX Measure", description: "Horário de funcionamento (Seg-Sex)." },
        { column: "Horário Sábado", type: "DAX Measure", description: "Horário de funcionamento aos sábados." },
        { column: "Redes Sociais", type: "DAX Measure", description: "Links para Instagram, Facebook e Twitter da unidade." },
    ];

    // 3. Conteúdo das Abas
    const tabsConfig = [
        {
            id: 'regras',
            label: 'Regras de Negócio',
            content: (
                <div className="p-8">
                    <h3 className="text-lg font-semibold text-slate-800 mb-4">Lógica de Contexto (Hierarquia)</h3>
                    <p className="text-slate-600 text-sm mb-6">
                        As medidas utilizam a função <code>ISFILTERED</code> e <code>SWITCH</code> do DAX para identificar qual nível de detalhe está selecionado no painel e exibir a informação correspondente.
                    </p>

                    <ul className="space-y-6">
                        {/* Nível 1: Unidade */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <span className="flex items-center justify-center w-8 h-8 rounded-full bg-blue-100 text-blue-600 font-bold text-sm">1</span>
                            </div>
                            <div>
                                <strong className="text-slate-900">Nível Unidade (Filtro Ativo: Nome/CNES)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Se uma unidade ou equipe específica estiver selecionada, busca os dados na tabela <code>Informações_auxiliares_CNES_uni</code>.
                                    <br />
                                    <em>Exemplo: Gerente local, Telefone da unidade, E-mail específico.</em>
                                </p>
                            </div>
                        </li>

                        {/* Nível 2: CAP */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <span className="flex items-center justify-center w-8 h-8 rounded-full bg-amber-100 text-amber-600 font-bold text-sm">2</span>
                            </div>
                            <div>
                                <strong className="text-slate-900">Nível Coordenação (Filtro Ativo: AP)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Se apenas a Área Programática (AP) estiver filtrada, busca na tabela <code>Informações_auxiliares_CNES_ap</code>.
                                    <br />
                                    <em>Exemplo: Coordenador da CAP, Endereço da Sede.</em>
                                </p>
                            </div>
                        </li>

                        {/* Nível 3: Município */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <span className="flex items-center justify-center w-8 h-8 rounded-full bg-slate-100 text-slate-600 font-bold text-sm">3</span>
                            </div>
                            <div>
                                <strong className="text-slate-900">Nível Município (Sem Filtros)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Se nenhum filtro for aplicado, retorna os valores padrão (Default).
                                    <br />
                                    <em>Exemplo: Secretário de Saúde, Central 1746, Redes Sociais da SMS.</em>
                                </p>
                            </div>
                        </li>
                    </ul>
                </div>
            )
        },
        {
            id: 'scripts',
            label: 'Medidas DAX',
            content: (
                <div>
                    {/* Seletor de Medidas */}
                    <div className="border-b border-gray-300 p-4 bg-slate-50">
                        <div className="flex items-center gap-4 flex-wrap">
                            <label className="text-sm font-medium text-slate-600">Selecione a Medida:</label>
                            <div className="relative inline-block w-full md:w-auto">
                                <select
                                    value={selectedScript}
                                    onChange={(e) => setSelectedScript(e.target.value)}
                                    className="appearance-none bg-white pl-4 pr-10 py-2 rounded-md border border-gray-300 font-medium text-sm focus:outline-none focus:ring-2 focus:ring-sky-500 focus:border-sky-500 transition-all cursor-pointer w-full md:min-w-[250px]"
                                >
                                    <option value="gestor">Gestor / Responsável</option>
                                    <option value="endereco">Endereço Completo</option>
                                    <option value="telefone">Telefone</option>
                                    <option value="email">E-mail</option>
                                    <option value="horario_semanal">Horário Semanal</option>
                                    <option value="horario_sabado">Horário Sábado</option>
                                    <option value="instagram">Instagram</option>
                                    <option value="facebook">Facebook</option>
                                    <option value="twitter">Twitter (X)</option>
                                </select>
                                <CaretDown size={16} className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 pointer-events-none" />
                            </div>
                        </div>
                    </div>

                    <SqlViewer
                        filePath={`${import.meta.env.BASE_URL}sql/query_quem_somos/info-aux-de-gestores/${selectedScript}.sql`}
                    />
                </div>
            )
        },
        {
            id: 'dicionario',
            label: 'Dicionário de Saída',
            content: <DictionaryTable rows={dictionaryData} />
        }
    ];

    // --- RENDERIZAÇÃO ---
    return (
        <div className="flex-1 overflow-y-auto p-6 md:p-10 pt-20 md:pt-10 custom-scrollbar animate-fade-in">
            <div className="max-w-6xl mx-auto">

                <DocHeader
                    title="QUERY - INFORMAÇÕES AUXILIARES"
                    description="Consolidação dinâmica de dados de gestão (contatos, horários, responsáveis) via DAX para o rodapé do painel."
                    breadcrumbs={['Quem Somos', 'Info. Gestores']}
                    badgeText="Lógica DAX"
                    badgeColor="yellow"
                    bqLink="#"
                />

                <DocMetadata items={metadataItems} />

                <DocTabs tabs={tabsConfig} />

            </div>
        </div>
    );
}