import React from 'react'; // Não precisa mais de useState aqui!
import { CheckCircleIcon, DatabaseIcon, HospitalIcon, KeyIcon, MapPinIcon } from "@phosphor-icons/react";

// Componentes Genéricos
import { DocHeader } from '../../components/Documentation/DocHeader';
import { DocMetadata } from '../../components/Documentation/DocMetadata';
import { DocTabs } from '../../components/Documentation/DocTabs'; // <--- Novo componente
import { SqlViewer } from '../../components/Documentation/sqlViewer';
import { DictionaryTable } from '../../components/Documentation/DicionaryTable';

export function Query_QuemSomos() {

    // 1. Definição dos Cards de Metadados
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
                <>
                    <span className="flex items-center gap-1"><DatabaseIcon size={16} /> equipe_profissional_saude</span>
                    <span className="flex items-center gap-1"><HospitalIcon size={16} /> estabelecimento</span>
                </>
            )
        },
        {
            label: "Principal Chave",
            mono: false,
            value: (
                <span className="flex items-center gap-2">
                    <KeyIcon size={16} className="text-amber-500" /> ID_INE (Equipe)
                </span>
            )
        }
    ];

    // 2. Definição do Dicionário
    const dictionaryData = [
        { column: "id_ine", type: "STRING", description: "Identificador Nacional de Equipe (Chave Primária)." },
        { column: "nome_equipe", type: "STRING", description: "Nome de referência da equipe (ex: Equipe Carioca)." },
        { column: "id_cnes", type: "STRING", description: "Cadastro Nacional de Estabelecimentos de Saúde vinculado." },
        { column: "nome_unidade", type: "STRING", description: "Nome limpo/padronizado da unidade de saúde." },
        { column: "area_programatica", type: "STRING", description: "Área de planejamento da saúde (Ex: AP 1.0, AP 3.1)." },
        { column: "endereco_completo", type: "STRING", description: "Concatenação de logradouro, número, bairro e CEP." },
        { column: "numero_de_medicos", type: "INTEGER", description: "Contagem distinta de médicos vinculados ao INE." },
        { column: "numero_de_enfermeiros", type: "INTEGER", description: "Contagem distinta de enfermeiros vinculados ao INE." },
        { column: "numero_de_acs", type: "INTEGER", description: "Contagem de Agentes Comunitários de Saúde." },
    ];

    // 3. Definição do Conteúdo das Abas
    // Aqui nós passamos o JSX específico desta página
    const tabsConfig = [
        {
            id: 'regras',
            label: 'Regras de Negócio',
            content: (
                <div className="p-8">
                    <h3 className="text-lg font-semibold text-slate-800 mb-4">Lógica de Construção</h3>
                    <ul className="space-y-4">
                        <li className="flex gap-3">
                            <CheckCircleIcon size={24} weight="fill" className="text-green-500 mt-0.5 flex-shrink-0" />
                            <div>
                                <strong className="text-slate-900">Extração e Deduplicação:</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Extrai dados brutos da tabela <code className="bg-slate-100 px-1 rounded">equipe_profissional_saude</code>, selecionando apenas o registro (snapshot) mais recente de cada equipe (INE).
                                </p>
                            </div>
                        </li>
                        <li className="flex gap-3">
                            <CheckCircleIcon size={24} weight="fill" className="text-green-500 mt-0.5 flex-shrink-0" />
                            <div>
                                <strong className="text-slate-900">Contagem de Profissionais:</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Conta profissionais por categoria (Médicos, Enfermeiros, ACS, etc.) de forma deduplicada. Classifica ASB e TSB com base no CBO, garantindo contagem única.
                                </p>
                            </div>
                        </li>
                        <li className="flex gap-3">
                            <CheckCircleIcon size={24} weight="fill" className="text-green-500 mt-0.5 flex-shrink-0" />
                            <div>
                                <strong className="text-slate-900">Enriquecimento (CNES):</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Combina dados da equipe com dados do estabelecimento (tabela <code className="bg-slate-100 px-1 rounded">estabelecimento</code>), adicionando endereço, contatos e administração.
                                </p>
                            </div>
                        </li>
                        <li className="flex gap-3">
                            <MapPinIcon size={24} weight="fill" className="text-amber-500 mt-0.5 flex-shrink-0" />
                            <div>
                                <strong className="text-slate-900">Geolocalização:</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Realiza ajustes pontuais (Hardcoded updates) de latitude e longitude para unidades específicas (ex: CNES 9071385, 5476844) ao final do processamento.
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
            content: <SqlViewer filePath="/sql/query_quem_somos/script.sql" />
        },
        {
            id: 'dicionario',
            label: 'Dicionário de Dados',
            content: <DictionaryTable rows={dictionaryData} />
        }
    ];

    // --- RENDERIZAÇÃO ---
    return (
        <div className="flex-1 overflow-y-auto p-6 md:p-10 pt-20 md:pt-10 custom-scrollbar">
            <div className="max-w-6xl mx-auto">

                <DocHeader
                    title="QUERY - QUEM SOMOS"
                    description="Tabela base unificada de equipes e unidades de saúde com dados deduplicados."
                    breadcrumbs={['Tabela Agregada', 'BI APS']}
                    badgeText="Tabela Agregada"
                    bqLink="https://console.cloud.google.com/bigquery?sq=446908838175:393c3bebd8fe4928a5d0756e0bccbb24"
                />

                <DocMetadata items={metadataItems} />

                {/* Aqui entra o componente reutilizável */}
                <DocTabs tabs={tabsConfig} />

            </div>
        </div>
    );
}