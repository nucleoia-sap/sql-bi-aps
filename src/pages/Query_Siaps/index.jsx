import React, { useState, useEffect } from 'react';
import {
    TableIcon,
    UsersIcon,
    UsersThreeIcon,
    SmileyIcon,
    UsersFourIcon,
    CaretDownIcon
} from "@phosphor-icons/react";
import { DocTabs } from '../../components/Documentation/DocTabs';
import { DocMetadata } from '../../components/Documentation/DocMetadata';
import { DocHeader } from '../../components/Documentation/DocHeader';
import { DictionaryTable } from '../../components/Documentation/DicionaryTable';
import { SqlViewer } from '../../components/Documentation/sqlViewer';
import { RViewer } from '../../components/Documentation/RViewer'



export function Query_Siaps() {
    // --- ESTADOS ---

    // 1. Estado para controlar qual SQL está sendo exibido
    const [selectedSql, setSelectedSql] = useState('esf');

    // 2. Estados para animação suave do nome da tabela
    const tableNames = [
        'rj-sms-sandbox.sub_pav_us.siaps_consolidado',
        'rj-sms-sandbox.sub_pav_us.siaps_consolidado_esb',
        'rj-sms-sandbox.sub_pav_us.siaps_consolidado_emulti'
    ];

    const [currentTableIndex, setCurrentTableIndex] = useState(0);
    const [isTableVisible, setIsTableVisible] = useState(true); // Controla a opacidade

    // Efeito de Rotação Suave (Fade Out -> Troca Texto -> Fade In)

    useEffect(() => {
        const interval = setInterval(() => {
            // 1. Inicia o Fade Out
            setIsTableVisible(false);

            // 2. Aguarda a transição terminar (500ms) para trocar o texto
            setTimeout(() => {
                setCurrentTableIndex((prev) => (prev + 1) % tableNames.length);

                // 3. Inicia o Fade In
                setIsTableVisible(true);
            }, 500);

        }, 4000);

        return () => clearInterval(interval);
    }, []);

    // --- DADOS ---

    // Metadados com Componente Personalizado de Animação
    const metadataItems = [
        {
            label: "Tabela Final",
            mono: true,
            // Passamos um JSX dinâmico como valor
            value: (
                <div className="relative">
                    <span
                        className="animate-fade-in block"
                    >
                        {tableNames[currentTableIndex]}
                    </span>
                    {/* Indicador visual (bolinha verde piscando) */}
                    <div
                        className="absolute -top-3 -right-1 w-1.5 h-1.5 bg-green-400 rounded-full animate-pulse"
                        title="Alternando automaticamente"
                    />
                </div>
            )
        },
        {
            label: "Fontes Principais",
            mono: false,
            value: (
                <span className="flex items-center gap-1">
                    <TableIcon size={16} /> Tabelas SIAPS (Por Componente)
                </span>
            )
        },
        {
            label: "Granularidade",
            mono: false,
            value: (
                <span className="flex items-center gap-2">
                    <UsersIcon size={16} className="text-amber-500" /> Por Equipe (INE) e Mês
                </span>
            )
        }
    ];

    const dictionaryData = [
        { column: "ine", type: "STRING", description: "Identificador Nacional de Equipe." },
        { column: "cnes", type: "STRING", description: "Código CNES da unidade de saúde." },
        { column: "Periodo", type: "DATE", description: "Data de referência do indicador (Primeiro dia do mês)." },
        { column: "Componente", type: "STRING", description: "Nome do componente avaliado (ex: Mais Acesso, Prevenção do Câncer)." },
        { column: "Tipo_Indicador", type: "STRING", description: "Tipo do valor: Numerador ('num'), Denominador ('den') ou Percentual/Média." },
        { column: "Valor", type: "FLOAT", description: "Resultado numérico do indicador para aquele mês/equipe." },
    ];

    // --- CONTEÚDO DAS ABAS ---
    const tabsConfig = [
        {
            id: 'regras',
            label: 'Regras de Negócio',
            content: (
                <div className="p-8">
                    <p className="text-slate-600 text-sm mb-6">
                        As queries transformam os dados mensais (colunas largas) em um formato unificado (tabela longa/unpivot), permitindo análise temporal facilitada. Abaixo estão os componentes monitorados por categoria.
                    </p>

                    {/* Bloco ESF (Azul) */}
                    <div className="mb-8 border border-blue-100 rounded-lg overflow-hidden">
                        <div className="bg-blue-50 px-6 py-3 border-b border-blue-100 flex items-center gap-2">
                            <UsersThreeIcon size={20} className="text-blue-600" weight="fill" />
                            <h3 className="font-bold text-blue-800 text-sm uppercase">Estratégia Saúde da Família (ESF)</h3>
                        </div>
                        <div className="p-6 bg-white">
                            <ul className="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm text-slate-700">
                                {[
                                    { id: 'C1', label: 'Mais Acesso', desc: 'Indicadores de acesso e vinculação.' },
                                    { id: 'C2', label: 'Resolutividade', desc: 'Capacidade de resolução na atenção primária.' },
                                    { id: 'C3', label: 'Coordenação do Cuidado', desc: 'Integração com outros níveis.' },
                                    { id: 'C4', label: 'Carteira de Serviços', desc: 'Oferta de serviços essenciais.' },
                                    { id: 'C5', label: 'Sustentabilidade', desc: 'Eficiência no uso de recursos.' },
                                    { id: 'C6', label: 'Responsabilidade Sanitária', desc: 'Vigilância e território.' },
                                    { id: 'C7', label: 'Prevenção do Câncer', desc: 'Rastreamento e prevenção.' },
                                    { id: 'C8', label: 'Satisfação do Usuário', desc: 'Avaliação da experiência.' }
                                ].map(item => (
                                    <li key={item.id} className="flex items-start gap-2">
                                        <span className="font-mono text-xs bg-slate-100 px-1.5 py-0.5 rounded text-slate-500 mt-0.5">{item.id}</span>
                                        <span><strong>{item.label}:</strong> {item.desc}</span>
                                    </li>
                                ))}
                            </ul>
                        </div>
                    </div>

                    {/* Bloco ESB (Teal) */}
                    <div className="mb-8 border border-teal-100 rounded-lg overflow-hidden">
                        <div className="bg-teal-50 px-6 py-3 border-b border-teal-100 flex items-center gap-2">
                            <SmileyIcon size={20} className="text-teal-600" weight="fill" />
                            <h3 className="font-bold text-teal-800 text-sm uppercase">Equipes de Saúde Bucal (ESB)</h3>
                        </div>
                        <div className="p-6 bg-white">
                            <ul className="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm text-slate-700">
                                {[
                                    { id: 'B1', label: '1º Consulta Programada', desc: 'Acesso inicial odontológico.' },
                                    { id: 'B2', label: 'Razão Tratamentos Concluídos', desc: 'Eficácia do tratamento.' },
                                    { id: 'B3', label: 'Proporção de Exodontias', desc: 'Indicador de mutilação dentária.' },
                                    { id: 'B4', label: 'Atendimentos de Urgência', desc: 'Resposta a condições agudas.' },
                                    { id: 'B5', label: 'Supervisão TSB', desc: 'Acompanhamento técnico.' },
                                    { id: 'B6', label: 'Tratamento Restaurador Atraumático', desc: 'Procedimentos conservadores.' }
                                ].map(item => (
                                    <li key={item.id} className="flex items-start gap-2">
                                        <span className="font-mono text-xs bg-slate-100 px-1.5 py-0.5 rounded text-slate-500 mt-0.5">{item.id}</span>
                                        <span><strong>{item.label}:</strong> {item.desc}</span>
                                    </li>
                                ))}
                            </ul>
                        </div>
                    </div>

                    {/* Bloco eMulti (Roxo) */}
                    <div className="border border-purple-100 rounded-lg overflow-hidden">
                        <div className="bg-purple-50 px-6 py-3 border-b border-purple-100 flex items-center gap-2">
                            <UsersFourIcon size={20} className="text-purple-600" weight="fill" />
                            <h3 className="font-bold text-purple-800 text-sm uppercase">Equipes Multiprofissionais (eMulti)</h3>
                        </div>
                        <div className="p-6 bg-white">
                            <ul className="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm text-slate-700">
                                <li className="flex items-start gap-2">
                                    <span className="font-mono text-xs bg-slate-100 px-1.5 py-0.5 rounded text-slate-500 mt-0.5">M1</span>
                                    <span><strong>Atendimentos eMulti:</strong> Volume de atendimentos da equipe multi.</span>
                                </li>
                                <li className="flex items-start gap-2">
                                    <span className="font-mono text-xs bg-slate-100 px-1.5 py-0.5 rounded text-slate-500 mt-0.5">M2</span>
                                    <span><strong>Ações Interprofissionais:</strong> Atuação conjunta e matriciamento.</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            )
        },
        {
            id: 'r',
            label: 'Script R',
            content: (
                <div>
                    <RViewer
                        filePath={`${import.meta.env.BASE_URL}R/query_nossos_resultados/query_siaps/script.r`}
                    />
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
                                <option value="esf">SIAPS - ESF (Saúde da Família)</option>
                                <option value="esb">SIAPS - ESB (Saúde Bucal)</option>
                                <option value="emulti">SIAPS - eMulti</option>
                            </select>
                            <CaretDownIcon size={16} className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 pointer-events-none" />
                        </div>
                    </div>

                    <SqlViewer
                        filePath={`${import.meta.env.BASE_URL}sql/query_nossos_resultados/query_siaps/script_${selectedSql}.sql`}
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
                title="QUERY - SIAPS"
                description="Consolidação dos indicadores do Sistema de Informação da Atenção Primária à Saúde."
                breadcrumbs={['Nossos Resultados', 'Indicadores de Desempenho']}
                badgeText="Indicadores de Desempenho"
                badgeColor="blue"
                bqLink="#"
            />

            <DocMetadata items={metadataItems} />

            <DocTabs tabs={tabsConfig} />
        </div>
    );
}