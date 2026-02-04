import {
    CheckCircleIcon,
    DatabaseIcon,
    HospitalIcon,
    CalendarBlankIcon,
    FunnelIcon,
    PencilSimpleIcon,
    MapPinIcon
} from "@phosphor-icons/react";

// Componentes Genéricos
import { DocHeader } from '../../components/Documentation/DocHeader';
import { DocMetadata } from '../../components/Documentation/DocMetadata';
import { DocTabs } from '../../components/Documentation/DocTabs';
import { SqlViewer } from '../../components/Documentation/sqlViewer';
import { DictionaryTable } from '../../components/Documentation/DicionaryTable';

export function Query_QuemSomos_Unidades() {

    // 1. Definição dos Metadados
    const metadataItems = [
        {
            label: "Tabela de Destino",
            value: "rj-sms-sandbox.sub_pav_us.unidades_equipes",
            mono: true
        },
        {
            label: "Fontes de Dados",
            mono: false,
            value: (
                <div className="flex flex-col gap-1">
                    <span className="flex items-center gap-1"><HospitalIcon size={16} /> estabelecimento_sus_rio_historico</span>
                    <span className="flex items-center gap-1"><DatabaseIcon size={16} /> equipe_profissional_saude</span>
                </div>
            )
        },
        {
            label: "Chave / Granularidade",
            mono: false,
            value: (
                <span className="flex items-center gap-2">
                    <CalendarBlankIcon size={16} className="text-amber-500" /> CNES por Competência (Mês)
                </span>
            )
        }
    ];

    // 2. Definição do Dicionário (Baseado no SELECT do script SQL)
    const dictionaryData = [
        { column: "id_cnes", type: "STRING", description: "Código CNES do estabelecimento (Chave)." },
        { column: "competencia", type: "STRING", description: "Mês e ano de referência formatado (MM/AAAA)." },
        { column: "area_programatica", type: "STRING", description: "Área de planejamento (AP). Inclui correção manual para CNES 8078106." },
        { column: "nome_limpo", type: "STRING", description: "Nome padronizado da unidade de saúde." },
        { column: "tipo_sms_agrupado", type: "STRING", description: "Classificação da unidade (Foco em APS: CMS, CF, CSE)." },
        { column: "id_ine", type: "STRING", description: "Identificador da equipe de saúde (Join via Tabela de Equipes)." },
        { column: "nome_referencia", type: "STRING", description: "Nome da equipe de saúde (se houver vínculo)." },
        { column: "endereco_latitude", type: "FLOAT", description: "Latitude da unidade (Com correção pontual)." },
        { column: "endereco_longitude", type: "FLOAT", description: "Longitude da unidade (Com correção pontual)." },
    ];

    // 3. Conteúdo das Abas
    const tabsConfig = [
        {
            id: 'regras',
            label: 'Regras de Negócio',
            content: (
                <div className="p-8">
                    <h3 className="text-lg font-semibold text-slate-800 mb-4">Pipeline de Tratamento</h3>
                    <ul className="space-y-6">
                        {/* Regra 1: Integração */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <DatabaseIcon size={24} weight="fill" className="text-blue-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">Integração Estabelecimento + Equipe</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Utiliza <code className="bg-slate-100 px-1 rounded">LEFT JOIN</code> para unir o histórico de estabelecimentos com a base de equipes.
                                    <br />
                                    <strong>Importante:</strong> Garante que estabelecimentos sem equipe cadastrada permaneçam na base (preservação de dados da tabela da esquerda).
                                </p>
                            </div>
                        </li>

                        {/* Regra 2: Filtros */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <FunnelIcon size={24} weight="fill" className="text-slate-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">Filtro de Escopo (APS)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Mantém apenas unidades classificadas como <strong>CMS, CF ou CSE</strong>.
                                    <br />
                                    <em>Exceção:</em> Mantém registros com tipo nulo/vazio para evitar exclusão acidental de unidades incompletas e força a exclusão do CNES <code>4538390</code>.
                                </p>
                            </div>
                        </li>

                        {/* Regra 3: Correções Manuais */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <PencilSimpleIcon size={24} weight="fill" className="text-orange-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">Correções de Cadastro (Hardcoded)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Aplica correções manuais em campos críticos (Nome, AP, Tipo) para CNES específicos (ex: <code>8078106</code> e <code>8062900</code>) que apresentam falhas na base de origem.
                                </p>
                            </div>
                        </li>

                        {/* Regra 4: Geolocalização */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <MapPinIcon size={24} weight="fill" className="text-green-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">Ajuste de Geolocalização</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Realiza um <code>UPDATE</code> final para corrigir as coordenadas (Latitude/Longitude) especificamente do CNES <code>9071385</code>.
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
            // Ajuste o caminho abaixo conforme onde você salvará o arquivo 'unidades.sql' na pasta public
            content: <SqlViewer filePath={`${import.meta.env.BASE_URL}sql/query_quem_somos/unidades/unidades.sql`} />
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
                    title="QUERY - UNIDADES"
                    description="Tabela consolidada de unidades APS com cruzamento de equipes (INE) e correções cadastrais."
                    breadcrumbs={['Quem Somos', 'Unidades']}
                    badgeText="Cadastro"
                    badgeColor="purple" // Roxo para combinar com a identidade "Quem Somos"
                    bqLink="#" // Coloque o link do BigQuery aqui se tiver
                />

                <DocMetadata items={metadataItems} />

                <DocTabs tabs={tabsConfig} />

            </div>
        </div>
    );
}