import {
    FileXls,
    Broom,
    CloudArrowUp,
    ChartBar,
    CheckCircle,
    UsersThree,
    Code
} from "@phosphor-icons/react";

// Componentes Genéricos
import { DocHeader } from '../../components/Documentation/DocHeader';
import { DocMetadata } from '../../components/Documentation/DocMetadata';
import { DocTabs } from '../../components/Documentation/DocTabs';
import { DictionaryTable } from '../../components/Documentation/DicionaryTable';
import { RViewer } from '../../components/Documentation/RViewer';

export function Query_QuemSomos_Medicos_PMM_PMPB() {

    // 1. Definição dos Metadados
    const metadataItems = [
        {
            label: "Tabelas de Destino",
            value: "rj-sms-sandbox.sub_pav_us.pmm / pmpb",
            mono: true
        },
        {
            label: "Fontes de Dados",
            mono: false,
            value: (
                <div className="flex flex-col gap-1">
                    <span className="flex items-center gap-1"><FileXls size={16} /> Arquivos Locais (PMM.xlsx, PMPB.xlsx)</span>
                    <span className="flex items-center gap-1"><UsersThree size={16} /> PROF_EQUIP / PROF_UNID (Cruzamento)</span>
                </div>
            )
        },
        {
            label: "Tecnologia",
            mono: false,
            value: (
                <span className="flex items-center gap-2">
                    <Code size={16} className="text-blue-500" /> Script R (janitor + bigrquery)
                </span>
            )
        }
    ];

    // 2. Definição do Dicionário (Inferido pelo contexto de RH/Médicos)
    const dictionaryData = [
        { column: "nome_profissional", type: "STRING", description: "Nome completo do médico normalizado." },
        { column: "cpf", type: "STRING", description: "CPF padronizado (apenas números) usado como chave de cruzamento." },
        { column: "programa", type: "STRING", description: "Indica o vínculo (PMM - Mais Médicos ou PMPB - Médicos pelo Brasil)." },
        { column: "data_inicio", type: "DATE", description: "Data de início das atividades no programa." },
        { column: "unidade_lotacao", type: "STRING", description: "Nome da unidade de saúde onde o profissional está alocado." },
        { column: "id_cnes", type: "STRING", description: "Código CNES da unidade de atuação." },
        { column: "status_vinculo", type: "STRING", description: "Situação atual do profissional (Ativo/Inativo)." },
    ];

    // 3. Conteúdo das Abas
    const tabsConfig = [
        {
            id: 'regras',
            label: 'Regras de Negócio',
            content: (
                <div className="p-8">
                    <h3 className="text-lg font-semibold text-slate-800 mb-4">Pipeline ETL (R Script)</h3>
                    <ul className="space-y-6">
                        {/* Etapa 1: Carregamento */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <FileXls size={24} weight="fill" className="text-green-600" />
                            </div>
                            <div>
                                <strong className="text-slate-900">Carregamento das Bases</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Leitura dos arquivos <code>.xlsx</code> (PMM e PMPB) utilizando o pacote <code>rio</code>.
                                    Integração com tabelas auxiliares de profissionais (PROF_EQUIP, PROF_UNID) para cruzamento de dados.
                                </p>
                            </div>
                        </li>

                        {/* Etapa 2: Limpeza */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <Broom size={24} weight="fill" className="text-orange-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">Padronização e Limpeza</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Aplicação da função <code>clean_for_bq</code> para normalizar nomes de colunas (snake_case) e remover caracteres especiais.
                                    <br />
                                    Padronização do <strong>CPF</strong> para garantir chaves consistentes e remoção de colunas totalmente nulas (NA).
                                </p>
                            </div>
                        </li>

                        {/* Etapa 3: Integração */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <UsersThree size={24} weight="fill" className="text-blue-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">Classificação de Vínculos</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Cruzamento com tabelas institucionais para classificar cada profissional conforme seu programa (PMM/PMPB), permitindo a análise consolidada no dashboard.
                                </p>
                            </div>
                        </li>

                        {/* Etapa 4: Publicação BigQuery */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <CloudArrowUp size={24} weight="fill" className="text-sky-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">Publicação no Data Lake</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Upload para o BigQuery via <code>bq_table_upload()</code>.
                                    Utiliza o modo <code>WRITE_TRUNCATE</code> para atualização integral e criação automática de schema (<code>CREATE_IF_NEEDED</code>).
                                </p>
                            </div>
                        </li>

                        {/* Etapa 5: Power BI */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <ChartBar size={24} weight="fill" className="text-amber-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">Disponibilização (Power BI)</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Conexão direta das tabelas do BigQuery ao Power BI, automatizando o fluxo de atualização e eliminando etapas manuais.
                                </p>
                            </div>
                        </li>

                        {/* Etapa 6: Validação */}
                        <li className="flex gap-3">
                            <div className="mt-1">
                                <CheckCircle size={24} weight="fill" className="text-teal-500" />
                            </div>
                            <div>
                                <strong className="text-slate-900">Auditoria Final</strong>
                                <p className="text-slate-600 text-sm mt-1">
                                    Verificação de completude dos registros, consistência dos CPFs e correspondência correta dos vínculos antes da liberação.
                                </p>
                            </div>
                        </li>
                    </ul>
                </div>
            )
        },
        {
            id: 'r', // ID alterado para R
            label: 'Script R', // Label alterado
            // Ajuste o caminho abaixo para onde você salvou o arquivo .r na pasta public
            content: <RViewer filePath={`${import.meta.env.BASE_URL}R/query_quem_somos/profissionais/medicos_PMM_pMPB.r`} />
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
                    title="QUERY - MÉDICOS PMM E PMPB"
                    description="Pipeline de ingestão e tratamento dos profissionais do Programa Mais Médicos e Médicos pelo Brasil."
                    breadcrumbs={['Quem Somos', 'Médicos PMM/PMPB']}
                    badgeText="Ingestão de Dados (R)"
                    badgeColor="blue"
                    bqLink="#"
                />

                <DocMetadata items={metadataItems} />

                <DocTabs tabs={tabsConfig} />

            </div>
        </div>
    );
}