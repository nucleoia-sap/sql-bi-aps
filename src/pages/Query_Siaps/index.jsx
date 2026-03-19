import React, { useState, useEffect } from 'react';
import {
    TableIcon,
    UsersIcon,
    UsersThreeIcon,
    SmileyIcon,
    UsersFourIcon,
    CaretDownIcon,
    BabyIcon,
    GenderFemaleIcon,
    ActivityIcon,
    HeartbeatIcon
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
                    <div className="mb-12 border border-purple-100 rounded-lg overflow-hidden">
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

                    {/* ========================================= */}
                    {/* NOVO BLOCO DE INDICADORES ADICIONADO AQUI */}
                    {/* ========================================= */}

                    <div className="border-t border-slate-200 pt-10">
                        <div className="mb-6">
                            <h2 className="text-xl font-bold text-slate-800">Bloco de Indicadores</h2>
                            <p className="text-slate-600 text-sm mt-2 bg-slate-50 p-3 rounded-md border border-slate-100 inline-block">
                                As regras atribuídas nesse bloco contam a quantidade de registros que cumprem as regras definidas.
                            </p>
                        </div>

                        {/* Bloco Crianças (Rosa) */}
                        <div className="mb-8 border border-rose-100 rounded-lg overflow-hidden">
                            <div className="bg-rose-50 px-6 py-3 border-b border-rose-100 flex items-center gap-2">
                                <BabyIcon size={20} className="text-rose-600" weight="fill" />
                                <h3 className="font-bold text-rose-800 text-sm uppercase">Crianças</h3>
                            </div>
                            <div className="p-6 bg-white">
                                <div className="mb-6 bg-slate-50 p-4 rounded-md border border-slate-100 text-sm text-slate-600 space-y-2">
                                    <p><strong className="text-slate-700">Notas:</strong> A tabela só tem dados a partir de maio de 2024</p>
                                    <p><strong className="text-slate-700">Tabela utilizada:</strong> <code className="text-rose-600 bg-rose-50 px-1.5 py-0.5 rounded">rj-sms.brutos_informes_vitacare.criancas_menores_5_anos</code></p>
                                    <p><strong className="text-slate-700">Formato:</strong> Lista nominal</p>
                                </div>

                                <ul className="space-y-4 text-sm text-slate-700">
                                    <li className="flex flex-col gap-1">
                                        <span className="font-semibold text-slate-900">Crianças &lt; 1 ano com avaliação do desenvolvimento (Denver)</span>
                                        <span className="text-slate-600 ml-4 border-l-2 border-rose-200 pl-3 py-1 bg-slate-50 rounded-r">
                                            <strong>Regra:</strong> Crianças menores de 12 meses e que tiveram avaliação do denver (<code>n_avaliacao_desenvolvimento_denver</code>) preenchida.
                                        </span>
                                    </li>
                                    <li className="flex flex-col gap-1">
                                        <span className="font-semibold text-slate-900">Crianças de 6 meses exatos com a 3ª dose da Penta registrada</span>
                                        <span className="text-slate-600 ml-4 border-l-2 border-rose-200 pl-3 py-1 bg-slate-50 rounded-r">
                                            <strong>Regra:</strong> Crianças com 6 meses exatos e <code>data_3d_penta</code> preenchida.
                                        </span>
                                    </li>
                                    <li className="flex flex-col gap-1">
                                        <span className="font-semibold text-slate-900">Total de crianças menores de 1 ano na equipe</span>
                                        <span className="text-slate-600 ml-4 border-l-2 border-rose-200 pl-3 py-1 bg-slate-50 rounded-r">
                                            <strong>Regra:</strong> Crianças &lt; 12 meses calculada a partir da <code>data_nascimento</code>.
                                        </span>
                                    </li>
                                    <li className="flex flex-col gap-1">
                                        <span className="font-semibold text-slate-900">Crianças de 1 a 2 anos com Denver feito na entre 12 e 24 meses</span>
                                        <span className="text-slate-600 ml-4 border-l-2 border-rose-200 pl-3 py-1 bg-slate-50 rounded-r">
                                            <strong>Regra:</strong> Crianças com idade ≥ 12 meses e &lt; 24 meses com <code>n_avaliacao_desenvolvimento_denver</code> preenchida, cuja idade no período da avaliação tenha sido ≥ 12 meses.
                                        </span>
                                    </li>
                                    <li className="flex flex-col gap-1">
                                        <span className="font-semibold text-slate-900">Total de crianças de 1 a 2 anos</span>
                                        <span className="text-slate-600 ml-4 border-l-2 border-rose-200 pl-3 py-1 bg-slate-50 rounded-r">
                                            <strong>Regra:</strong> Crianças com idade ≥ 12 meses e &lt; 24 meses.
                                        </span>
                                    </li>
                                    <li className="flex flex-col gap-1">
                                        <span className="font-semibold text-slate-900">Crianças &lt; 2 anos que passaram por orientação de Saúde Bucal (ESB)</span>
                                        <span className="text-slate-600 ml-4 border-l-2 border-rose-200 pl-3 py-1 bg-slate-50 rounded-r">
                                            <strong>Regra:</strong> Crianças com idade &lt; 24 meses com <code>data_orientacao_equipe_esb</code> preenchida, cuja idade no período da avaliação tenha sido &lt; 24 meses.
                                        </span>
                                    </li>
                                    <li className="flex flex-col gap-1">
                                        <span className="font-semibold text-slate-900">Total crianças &lt; 2 anos</span>
                                        <span className="text-slate-600 ml-4 border-l-2 border-rose-200 pl-3 py-1 bg-slate-50 rounded-r">
                                            <strong>Regra:</strong> Crianças com idade &lt; 24 meses.
                                        </span>
                                    </li>
                                    <li className="flex flex-col gap-1">
                                        <span className="font-semibold text-slate-900">Crianças que receberam a primeira visita (VD) até o 7º dia de vida</span>
                                        <span className="text-slate-600 ml-4 border-l-2 border-rose-200 pl-3 py-1 bg-slate-50 rounded-r">
                                            <strong>Regra:</strong> Crianças até 7 dias de vida que receberam visita do acs no período (<code>data_primeira_visita_acs</code> preenchida dentro de 7 dias após o nascimento).
                                        </span>
                                    </li>
                                    <li className="flex flex-col gap-1">
                                        <span className="font-semibold text-slate-900">Crianças com 1 ano de vida</span>
                                        <span className="text-slate-600 ml-4 border-l-2 border-rose-200 pl-3 py-1 bg-slate-50 rounded-r">
                                            <strong>Regra:</strong> Crianças com exatamente 1 ano (= 12 meses). —&gt; REVER SE ATÉ 2 ANOS INCOMPLETOS &lt; 24 MESES
                                        </span>
                                    </li>
                                    <li className="flex flex-col gap-1">
                                        <span className="font-semibold text-slate-900">Aleitamento Materno Exclusivo em menores de 6 meses</span>
                                        <span className="text-slate-600 ml-4 border-l-2 border-rose-200 pl-3 py-1 bg-slate-50 rounded-r">
                                            <strong>Regra:</strong> Crianças com idade &lt; 6 meses com aleitamento materno exclusivo (<code>aleitamento = E</code>).
                                        </span>
                                    </li>
                                    <li className="flex flex-col gap-1">
                                        <span className="font-semibold text-slate-900">Crianças menores de 6 meses</span>
                                        <span className="text-slate-600 ml-4 border-l-2 border-rose-200 pl-3 py-1 bg-slate-50 rounded-r">
                                            <strong>Regra:</strong> Crianças com idade &lt; 6 meses (Calculado a partir da <code>data_nascimento</code>).
                                        </span>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        {/* Bloco Saúde da Mulher (Fuchsia/Pink) */}
                        <div className="mb-8 border border-fuchsia-100 rounded-lg overflow-hidden">
                            <div className="bg-fuchsia-50 px-6 py-3 border-b border-fuchsia-100 flex items-center gap-2">
                                <GenderFemaleIcon size={20} className="text-fuchsia-600" weight="fill" />
                                <h3 className="font-bold text-fuchsia-800 text-sm uppercase">Saúde da Mulher</h3>
                            </div>
                            <div className="p-6 bg-white">
                                <div className="mb-4 bg-slate-50 p-4 rounded-md border border-slate-100 text-sm text-slate-600 space-y-2">
                                    <p><strong className="text-slate-700">Tabela utilizada:</strong> <code className="text-fuchsia-600 bg-fuchsia-50 px-1.5 py-0.5 rounded">rj-sms.brutos_informes_vitacare.indicadores_cg_variavel_2</code></p>
                                    <p><strong className="text-slate-700">Formato:</strong> Tabela consolidada V2 (Sem lista nominal)</p>
                                </div>
                                <p className="text-sm text-slate-700 ml-4 border-l-2 border-fuchsia-200 pl-3 py-1 bg-slate-50 rounded-r">
                                    O código pega os valores registrados nas colunas “numerador” e “denominador” dos indicadores (coluna indicador) <strong>D1 e D8</strong>.
                                </p>
                            </div>
                        </div>

                        {/* Bloco Diabetes e Tabagismo (Laranja/Orange) */}
                        <div className="mb-8 border border-orange-100 rounded-lg overflow-hidden">
                            <div className="bg-orange-50 px-6 py-3 border-b border-orange-100 flex items-center gap-2">
                                <ActivityIcon size={20} className="text-orange-600" weight="fill" />
                                <h3 className="font-bold text-orange-800 text-sm uppercase">Diabetes, Tabagismo</h3>
                            </div>
                            <div className="p-6 bg-white">
                                <div className="mb-6 bg-slate-50 p-4 rounded-md border border-slate-100 text-sm text-slate-600 space-y-2">
                                    <p><strong className="text-slate-700">Tabela utilizada:</strong> <code className="text-orange-600 bg-orange-50 px-1.5 py-0.5 rounded">rj-sms.brutos_informes_vitacare.indicadores_cg_variavel_3</code></p>
                                    <p><strong className="text-slate-700">Formato:</strong> Tabela consolidada V3 (Sem lista nominal)</p>
                                </div>
                                <div className="text-sm text-slate-700 ml-4 border-l-2 border-orange-200 pl-3 py-2 bg-slate-50 rounded-r">
                                    <p className="mb-3">O código pega os valores em condicionalidades registrados nos grupos da variável 3:</p>
                                    <ul className="list-disc pl-5 space-y-1">
                                        <li><strong>Diabetes com Hemoglobina Glicada e avaliação do pé:</strong> (V3, Grupo 6, Condições d,g,a)</li>
                                        <li><strong>Idoso com Avaliação Multidimensional:</strong> (V3, Grupo 8, Condições g,a)</li>
                                        <li><strong>Tabagistas com avaliação de saúde bucal:</strong> (V3, Grupo 10, Condições c,a)</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        {/* Bloco Gestantes (Âmbar/Amber) */}
                        <div className="mb-8 border border-amber-100 rounded-lg overflow-hidden">
                            <div className="bg-amber-50 px-6 py-3 border-b border-amber-100 flex items-center gap-2">
                                <UsersIcon size={20} className="text-amber-600" weight="fill" />
                                <h3 className="font-bold text-amber-800 text-sm uppercase">Gestantes</h3>
                            </div>
                            <div className="p-6 bg-white">
                                <div className="mb-6 bg-slate-50 p-4 rounded-md border border-slate-100 text-sm text-slate-600 space-y-2">
                                    <p><strong className="text-slate-700">Tabela utilizada:</strong> <code className="text-amber-600 bg-amber-50 px-1.5 py-0.5 rounded">rj-sms.brutos_informes_vitacare.acompanhamento_mensal_gestantes</code></p>
                                    <p><strong className="text-slate-700">Formato:</strong> Lista nominal</p>
                                    <p><strong className="text-slate-700">Competência:</strong> É calculada com base no mês de ocorrência do parto.</p>
                                </div>

                                <ul className="space-y-4 text-sm text-slate-700">
                                    <li className="flex flex-col gap-1">
                                        <span className="font-semibold text-slate-900">Gestantes com avaliação da saúde bucal</span>
                                        <span className="text-slate-600 ml-4 border-l-2 border-amber-200 pl-3 py-1 bg-slate-50 rounded-r">
                                            <strong>Regra:</strong> Mulheres cuja a <code>data_parto</code> está em branco e tiveram registro de avaliação pela saúde bucal (<code>data_consulta_de_sb</code>) até o dia do parto.
                                        </span>
                                    </li>
                                    <li className="flex flex-col gap-1">
                                        <span className="font-semibold text-slate-900">Gestantes com 7 ou mais consultas</span>
                                        <span className="text-slate-600 ml-4 border-l-2 border-amber-200 pl-3 py-1 bg-slate-50 rounded-r">
                                            <strong>Regra:</strong> Gestantes cuja <code>data_parto</code> não é em branco e tiveram sete ou mais consultas de pré-natal (<code>num_de_consultas_de_pre_natal</code>).
                                        </span>
                                    </li>
                                    <li className="flex flex-col gap-1">
                                        <span className="font-semibold text-slate-900">Gestantes com pré-natal encerrado</span>
                                        <span className="text-slate-600 ml-4 border-l-2 border-amber-200 pl-3 py-1 bg-slate-50 rounded-r">
                                            <strong>Regra:</strong> Gestantes cuja <code>data_parto</code> não é em branco.
                                        </span>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        {/* Bloco Hipertensão (Vermelho/Red) */}
                        <div className="mb-8 border border-red-100 rounded-lg overflow-hidden">
                            <div className="bg-red-50 px-6 py-3 border-b border-red-100 flex items-center gap-2">
                                <HeartbeatIcon size={20} className="text-red-600" weight="fill" />
                                <h3 className="font-bold text-red-800 text-sm uppercase">Hipertensão</h3>
                            </div>
                            <div className="p-6 bg-white">
                                <div className="mb-6 bg-slate-50 p-4 rounded-md border border-slate-100 text-sm text-slate-600 space-y-2">
                                    <p><strong className="text-slate-700">Tabela origem:</strong> <code className="text-red-600 bg-red-50 px-1.5 py-0.5 rounded">rj-sms.brutos_informes_vitacare.relacao_hasdm_vitahiscare</code></p>
                                    <p><strong className="text-slate-700">Formato:</strong> Lista nominal</p>
                                    <p><strong className="text-slate-700">Status do Cadastro (Limitação):</strong> O indicador considera apenas pacientes com <code>situacao_cad = 'ATIVO'</code> na data da extração dos dados (retrato atual).</p>
                                    <p><strong className="text-slate-700">Nota:</strong> Pacientes que eram ativos no passado, mas foram inativados recentemente (óbito, mudança de território), não serão contabilizados nos históricos retroativos.</p>
                                </div>

                                <ul className="space-y-4 text-sm text-slate-700">
                                    <li className="flex flex-col gap-1">
                                        <span className="font-semibold text-slate-900">Hipertenso que teve consulta (Médico ou Enf) e aferição de PA no semestre</span>
                                        <div className="text-slate-600 ml-4 border-l-2 border-red-200 pl-3 py-2 bg-slate-50 rounded-r flex flex-col gap-2">
                                            <span><strong>Regra Consulta recente:</strong> Ter registro de <code>data_ultima_consulta_med</code> ou <code>data_ultima_consulta_enf</code> dentro do intervalo de 6 meses anteriores à competência (Lógica: Basta uma das duas datas estar dentro do prazo).</span>
                                            <span><strong>Regra aferição de PA:</strong> Ter registro de <code>data_pa</code> dentro do intervalo de 6 meses anteriores à competência.</span>
                                        </div>
                                    </li>
                                </ul>
                            </div>
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
                                <option value="ecr">SIAPS - eCR</option>
                                <option value="eapp">SIAPS - eAPP</option>
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