import {
    Database,
    ShareNetwork,
    FileJsIcon,
    MapTrifoldIcon,
    CodeIcon
} from "@phosphor-icons/react";

import { DocHeader } from '../../../components/Documentation/DocHeader';import { DocMetadata } from '../../../components/Documentation/DocMetadata';
import { DocTabs } from '../../../components/Documentation/DocTabs';
import { JsonViewer } from '../../../components/Documentation/JsonViewer';
import { DictionaryTable } from '../../../components/Documentation/DicionaryTable';

export function Query_QuemSomos_Construcao_Do_Mapa() {

    // 1. Definição dos Metadados
    const metadataItems = [
        {
            label: "Fonte de Dados",
            value: "rj-sms-sandbox.sub_pav_us.dw_equipes_unidades", // Base citada na regra
            mono: true
        },
        {
            label: "Formato de Saída",
            mono: false,
            value: (
                <span className="flex items-center gap-1">
                    <FileJsIcon size={16} className="text-yellow-600" /> GeoJSON (FeatureCollection)
                </span>
            )
        },
        {
            label: "Aplicação Final",
            mono: false,
            value: (
                <span className="flex items-center gap-2">
                    <MapTrifoldIcon size={16} className="text-green-600" /> Power BI (Mapa Coroplético)
                </span>
            )
        }
    ];

    // 2. Dicionário de Dados (Estrutura típica de um GeoJSON para Power BI)
    const dictionaryData = [
        { column: "type", type: "STRING", description: "Tipo do objeto GeoJSON (Geralmente 'FeatureCollection')." },
        { column: "features", type: "ARRAY", description: "Lista de objetos contendo a geometria e propriedades." },
        { column: "properties.id_cnes", type: "STRING", description: "Chave de ligação com os dados do Power BI." },
        { column: "properties.nome_unidade", type: "STRING", description: "Nome da unidade para Tooltip no mapa." },
        { column: "geometry.type", type: "STRING", description: "Tipo da geometria (Point para unidades, Polygon para áreas)." },
        { column: "geometry.coordinates", type: "ARRAY", description: "Par de coordenadas [Longitude, Latitude]." },
    ];

    // 3. Conteúdo das Abas
    const tabsConfig = [
        {
            id: 'regras',
            label: 'Regras de Negócio',
            content: (
                <div className="p-8">
                    <h3 className="text-lg font-semibold text-slate-800 mb-4">Pipeline Geoespacial</h3>
                    <ul className="space-y-6">
                        {/* Etapa 1: Extração */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <Database size={24} weight="fill" className="text-blue-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">Extração de Coordenadas</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Consulta a tabela consolidada <code>dw_equipes_unidades</code> no Data Lake para capturar as colunas de latitude e longitude tratadas de cada unidade de saúde ativa.
                                </p>
                            </div>
                        </li>

                        {/* Etapa 2: Construção JSON */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <CodeIcon size={24} weight="fill" className="text-yellow-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">Conversão para GeoJSON</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Transformação dos dados tabulares em estrutura hierárquica <strong>GeoJSON</strong> (Padrão RFC 7946).
                                    <br />
                                    Cada unidade se torna uma <em>Feature</em> do tipo <em>Point</em> contendo suas propriedades (CNES, Nome) dentro do objeto.
                                </p>
                            </div>
                        </li>

                        {/* Etapa 3: Integração */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <ShareNetwork size={24} weight="fill" className="text-green-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">Integração Power BI</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Importação do arquivo JSON como camada de referência no componente de mapa visual.
                                    <br />
                                    Permite a criação de <strong>mapas coropléticos</strong> (áreas de cobertura) ou mapas de símbolos proporcionais.
                                </p>
                            </div>
                        </li>
                    </ul>
                </div>
            )
        },
        {
            id: 'json', // ID solicitado
            label: 'Arquivo JSON', // Label solicitado
            // ATENÇÃO: Crie um arquivo de exemplo "exemplo_mapa.json" na sua pasta public/dados/
            content: <JsonViewer filePath={`${import.meta.env.BASE_URL}json/query_quem_somos/construcaoMapa.json`} />
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
                    title="QUERY - CONSTRUÇÃO DO MAPA"
                    description="Geração de insumos geoespaciais para visualização territorial das unidades de saúde."
                    breadcrumbs={['Quem Somos', 'Mapa Territorial']}
                    badgeText="Geoespacial"
                    badgeColor="green"
                    bqLink="#"
                />

                <DocMetadata items={metadataItems} />

                <DocTabs tabs={tabsConfig} />

            </div>
        </div>
    );
}

