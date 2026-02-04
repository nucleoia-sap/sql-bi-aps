import {
    BabyIcon,
    BandaidsIcon,
    CaretDownIcon,
    ChartLineUpIcon,
    DesktopIcon,
    DropIcon,
    HeartIcon,
    IdentificationCardIcon,
    InfoIcon,
    ScalesIcon,
    UsersIcon,
    UsersThreeIcon,
    VirusIcon
} from "@phosphor-icons/react"
import { AccordionSection } from "../AccordionSection"
import { DocCard } from "../DocCard"
import { useState } from "react"

export const ListCards = () => {

    // Estado para controlar qual acordeão está aberto
    const [activeAccordion, setActiveAccordion] = useState(null);

    // Estado para os sub-acordeões (DCNT, DCT, etc.)
    const [activeSubAccordion, setActiveSubAccordion] = useState(null);

    const toggleAccordion = (id) => {
        setActiveAccordion(activeAccordion === id ? null : id);
    };

    const toggleSubAccordion = (id) => {
        setActiveSubAccordion(activeSubAccordion === id ? null : id);
    };

    return (
        <div className="mb-12 space-y-4">

            {/* 1. QUEM SOMOS (Transformado em Accordion com Cards) */}
            <AccordionSection
                title="Quem Somos"
                subtitle="Dados cadastrais de equipes e unidades de saúde."
                icon={IdentificationCardIcon}
                colorClass="bg-purple-50"
                textClass="text-purple-600"
                isOpen={activeAccordion === 'quem-somos'}
                onToggle={() => toggleAccordion('quem-somos')}
            >
                <div className="mt-6">
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                        <DocCard
                            to="/documentacao/quem-somos/unidades"
                            icon={IdentificationCardIcon}
                            title="Query - Unidades"
                            desc="Dados das unidades de saúde."
                            status="CONCLUÍDO"
                            colorTheme="purple"
                        />
                        <DocCard
                            to="/documentacao/quem-somos/medicos-pmm-pmpb"
                            icon={UsersIcon}
                            title="Query - MÉDICOS PMM e PMPB"
                            desc="Médicos dos programas federais."
                            status="CONCLUÍDO"
                            colorTheme="purple"
                        />
                        <DocCard
                            to="/documentacao/quem-somos/construcao-do-mapa"
                            icon={DesktopIcon}
                            title="Query - Construção do Mapa"
                            desc="Estruturação territorial."
                            status="CONCLUÍDO"
                            colorTheme="purple"
                        />
                        <DocCard
                            to="/documentacao/quem-somos/info-auxiliares"
                            icon={InfoIcon}
                            title="Query - Info. auxiliares de gestores"
                            desc="Dados de apoio à gestão."
                            status="CONCLUÍDO"
                            colorTheme="purple"
                        />
                        <DocCard
                            to="/documentacao/quem-somos/profissionais-esf"
                            icon={UsersThreeIcon}
                            title="Query - Profissionais eSF"
                            desc="Equipes de Saúde da Família."
                            status="CONCLUÍDO"
                            colorTheme="purple"
                        />
                        <DocCard
                            to="/documentacao/quem-somos/turnover"
                            icon={ChartLineUpIcon}
                            title="Query - Turn over dos profissionais"
                            desc="Rotatividade de médicos e enfermeiros."
                            status="CONCLUÍDO"
                            colorTheme="purple"
                        />
                    </div>
                </div>
            </AccordionSection>

            {/* 2. A QUEM SERVIMOS */}
            <AccordionSection
                title="A Quem Servimos"
                subtitle="Perfil Demográfico e Epidemiológico"
                icon={UsersThreeIcon}
                colorClass="bg-blue-50"
                textClass="text-blue-600"
                isOpen={activeAccordion === 'servimos'}
                onToggle={() => toggleAccordion('servimos')}
            >
                {/* Conteúdo Interno */}
                <div className="mt-6">
                    <h4 className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-3 pl-1">Principal</h4>
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                        <DocCard
                            to="/documentacao/a-quem-servimos"
                            icon={UsersIcon}
                            title="Query - A Quem Servimos"
                            desc="Visão geral do perfil populacional."
                            status="CONCLUÍDO"
                            colorTheme="blue"
                        />
                    </div>

                    {/* Sub-seção Perfil */}
                    <div className="mt-6">
                        <h4 className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-3 pl-1 border-t border-slate-200 pt-4">
                            Perfil Clínico-Epidemiológico
                        </h4>
                        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                            <DocCard to="/documentacao/a-quem-servimos/pce/hanseniase" icon={BandaidsIcon} title="Hanseníase" desc="Monitoramento de casos." status="CONCLUÍDO" colorTheme="orange" />
                            <DocCard to="/documentacao/a-quem-servimos/pce/tuberculose" icon={BandaidsIcon} title="Tuberculose" desc="Acompanhamento respiratório." status="CONCLUÍDO" colorTheme="indigo" />
                            <DocCard to="#" icon={VirusIcon} title="Sífilis" desc="Indicadores de teste e tratamento." status="EM BREVE" colorTheme="pink" />
                            <DocCard to="#" icon={DropIcon} title="Hepatites" desc="Monitoramento viral." status="EM BREVE" colorTheme="yellow" />
                        </div>
                    </div>
                </div>
            </AccordionSection>

            {/* 3. NOSSOS RESULTADOS */}
            <AccordionSection
                title="Nossos Resultados"
                subtitle="Indicadores e Metas"
                icon={ChartLineUpIcon}
                colorClass="bg-teal-50"
                textClass="text-teal-600"
                isOpen={activeAccordion === 'resultados'}
                onToggle={() => toggleAccordion('resultados')}
            >
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-6 mt-6">
                    <DocCard to="/documentacao/nossos-resultados/siaps" icon={DesktopIcon} title="SIAPS" desc="Consolidação dos indicadores." status="CONCLUÍDO" colorTheme="teal" />
                    <DocCard to="#" icon={BabyIcon} title="UAPI" desc="Unidade Amiga da Primeira Infância." status="EM BREVE" colorTheme="teal" />
                    <DocCard to="#" icon={ScalesIcon} title="Accountability" desc="Responsabilização e transparência." status="EM BREVE" colorTheme="teal" />
                </div>

                {/* Sub-acordeões (Linhas de Cuidado) */}
                <div className="space-y-3">

                    {/* DCT */}
                    <div className="rounded-xl border border-slate-200 bg-white overflow-hidden">
                        <button onClick={() => toggleSubAccordion('dct')} className="w-full flex justify-between p-3 px-4 bg-slate-50 hover:bg-slate-100 transition-colors">
                            <div className="flex items-center gap-3">
                                <VirusIcon className="text-slate-500" size={20} />
                                <span className="text-sm font-semibold text-slate-700">Doenças Crônicas Transmissíveis</span>
                            </div>
                            <CaretDownIcon size={16} className={`text-slate-400 transition-transform duration-300 ${activeSubAccordion === 'dct' ? 'rotate-180' : ''}`} />
                        </button>

                        <div className={`grid transition-[grid-template-rows] duration-300 ${activeSubAccordion === 'dct' ? 'grid-rows-[1fr]' : 'grid-rows-[0fr]'}`}>
                            <div className="overflow-hidden bg-white">
                                <div className="p-4 border-t border-slate-100 bg-slate-50/50">
                                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                                        {/* Itens do MenuItems DCT */}
                                        <DocCard to="#" icon={VirusIcon} title="Tuberculose" desc="Linha de cuidado." status="EM BREVE" colorTheme="slate" />
                                        <DocCard to="#" icon={VirusIcon} title="Sífilis" desc="Linha de cuidado." status="EM BREVE" colorTheme="slate" />
                                        <DocCard to="#" icon={VirusIcon} title="Hanseníase" desc="Linha de cuidado." status="EM BREVE" colorTheme="slate" />
                                        <DocCard to="#" icon={VirusIcon} title="Hepatites" desc="Linha de cuidado." status="EM BREVE" colorTheme="slate" />
                                        <DocCard to="#" icon={VirusIcon} title="HIV-AIDS" desc="Linha de cuidado." status="EM BREVE" colorTheme="slate" />
                                        <DocCard to="#" icon={VirusIcon} title="Laboratório" desc="Exames relacionados." status="EM BREVE" colorTheme="slate" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    {/* DCNT */}
                    <div className="rounded-xl border border-slate-200 bg-white overflow-hidden">
                        <button onClick={() => toggleSubAccordion('dcnt')} className="w-full flex justify-between p-3 px-4 bg-slate-50 hover:bg-slate-100 transition-colors">
                            <div className="flex items-center gap-3">
                                <HeartIcon className="text-slate-500" size={20} />
                                <span className="text-sm font-semibold text-slate-700">Doenças Crônicas Não Transmissíveis</span>
                            </div>
                            <CaretDownIcon size={16} className={`text-slate-400 transition-transform duration-300 ${activeSubAccordion === 'dcnt' ? 'rotate-180' : ''}`} />
                        </button>

                        <div className={`grid transition-[grid-template-rows] duration-300 ${activeSubAccordion === 'dcnt' ? 'grid-rows-[1fr]' : 'grid-rows-[0fr]'}`}>
                            <div className="overflow-hidden bg-white">
                                <div className="p-4 border-t border-slate-100 bg-slate-50/50">
                                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                                        {/* Itens do MenuItems DCNT */}
                                        <DocCard to="#" icon={HeartIcon} title="Hipertensão" desc="Linha de cuidado." status="EM BREVE" colorTheme="slate" />
                                        <DocCard to="#" icon={HeartIcon} title="Diabetes" desc="Linha de cuidado." status="EM BREVE" colorTheme="slate" />
                                        <DocCard to="#" icon={HeartIcon} title="PICS" desc="Práticas integrativas." status="EM BREVE" colorTheme="slate" />
                                        <DocCard to="#" icon={HeartIcon} title="CÂNCER" desc="Rastreamento e cuidado." status="EM BREVE" colorTheme="slate" />
                                        <DocCard to="#" icon={HeartIcon} title="Saúde Bucal" desc="Atenção odontológica." status="EM BREVE" colorTheme="slate" />
                                        <DocCard to="#" icon={HeartIcon} title="Saúde do Trabalhador" desc="Vigilância em saúde." status="EM BREVE" colorTheme="slate" />
                                        <DocCard to="#" icon={HeartIcon} title="Policlínicas" desc="Atenção especializada." status="EM BREVE" colorTheme="slate" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    {/* Ciclos de Vida (Adicionei pois estava no menuItems) */}
                    <div className="rounded-xl border border-slate-200 bg-white overflow-hidden">
                        <button onClick={() => toggleSubAccordion('ciclos')} className="w-full flex justify-between p-3 px-4 bg-slate-50 hover:bg-slate-100 transition-colors">
                            <div className="flex items-center gap-3">
                                <BabyIcon className="text-slate-500" size={20} />
                                <span className="text-sm font-semibold text-slate-700">Ciclos de Vida</span>
                            </div>
                            <CaretDownIcon size={16} className={`text-slate-400 transition-transform duration-300 ${activeSubAccordion === 'ciclos' ? 'rotate-180' : ''}`} />
                        </button>

                        <div className={`grid transition-[grid-template-rows] duration-300 ${activeSubAccordion === 'ciclos' ? 'grid-rows-[1fr]' : 'grid-rows-[0fr]'}`}>
                            <div className="overflow-hidden bg-white">
                                <div className="p-4 border-t border-slate-100 bg-slate-50/50">
                                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                                        <DocCard to="#" icon={BabyIcon} title="Saúde da Pessoa Idosa" desc="Linha de cuidado." status="EM BREVE" colorTheme="slate" />
                                        <DocCard to="#" icon={BabyIcon} title="Saúde da Mulher" desc="Linha de cuidado." status="EM BREVE" colorTheme="slate" />
                                        <DocCard to="#" icon={BabyIcon} title="Saúde do Homem" desc="Linha de cuidado." status="EM BREVE" colorTheme="slate" />
                                        <DocCard to="#" icon={BabyIcon} title="Criança e Adolescente" desc="Linha de cuidado." status="EM BREVE" colorTheme="slate" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </AccordionSection>
        </div>
    )
}