import { BabyIcon, BandaidsIcon, CaretDownIcon, ChartLineUpIcon, DesktopIcon, DropIcon, HeartIcon, IdentificationCardIcon, InfoIcon, ScalesIcon, UsersIcon, UsersThreeIcon, VirusIcon } from "@phosphor-icons/react"
import { AccordionSection } from "../AccordionSection"
import { DocCard } from "../DocCard"
import { SimpleCard } from "../SimpleCard"
import { useState } from "react"
import { Query_QuemSomos } from "../../pages/Query_QuemSomos"

export const ListCards = () => {

    // Estado para controlar qual acordeão está aberto (permite apenas um por vez, ou mude lógica se quiser múltiplos)
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
        <div className="mb-12">
            {/* 1. QUEM SOMOS - (Card Simples) */}
            <SimpleCard
                to="/documentacao/quem-somos"
                icon={IdentificationCardIcon}
                title="Quem Somos"
                desc="Dados cadastrais de equipes e unidades de saúde."
                colorClass="bg-purple-50"
                textClass="text-purple-600"
                borderClass="border-purple-100"
                hoverBgClass="group-hover:bg-purple-100"
                hoverTextClass="group-hover:text-purple-700"
            />

            {/* 2. A quem Servimos + Perfil Clínico */}
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

                    {/* Sub-seção Perfil (Pode ser outro acordeão interno ou apenas grid) */}
                    <div className="mt-6">
                        <h4 className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-3 pl-1 border-t border-slate-200 pt-4">
                            Perfil Clínico-Epidemiológico
                        </h4>
                        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                            <DocCard to="/documentacao/a-quem-servimos/pce/hanseniase" icon={BandaidsIcon} title="Hanseníase" desc="Monitoramento de casos." status="CONCLUÍDO" colorTheme="orange" />
                            <DocCard to="#" icon={BandaidsIcon} title="Tuberculose" desc="Acompanhamento respiratório." status="EM CONSTRUÇÃO" colorTheme="indigo" />
                            <DocCard to="#" icon={VirusIcon} title="Sífilis" desc="Indicadores de teste e tratamento." status="EM BREVE" colorTheme="pink" />
                            <DocCard to="#" icon={DropIcon} title="Hepatites" desc="Monitoramento viral." status="EM BREVE" colorTheme="yellow" />
                        </div>
                    </div>
                </div>
            </AccordionSection>

            {/* 3. Nossos Resultados */}

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
                    <DocCard to="#" icon={BabyIcon} title="UAPI" desc="Query em construção." status="EM BREVE" colorTheme="teal" />
                    <DocCard to="#" icon={ScalesIcon} title="Accountability" desc="Query em construção." status="EM BREVE" colorTheme="teal" />
                </div>

                {/* Sub-acordeões (DCT e DCNT) */}
                <div className="space-y-3">
                    {/* DCT */}
                    <div className="rounded-xl border border-slate-200 bg-white overflow-hidden">
                        <button onClick={() => toggleSubAccordion('dct')} className="w-full flex justify-between p-3 px-4 bg-slate-50 hover:bg-slate-100">
                            <div className="flex items-center gap-3"><VirusIcon className="text-slate-500" /><span className="text-sm font-semibold text-slate-700">Doenças Crônicas Transmissíveis</span></div>
                            <CaretDownIcon size={16} className={`text-slate-400 transition-transform ${activeSubAccordion === 'dct' ? 'rotate-180' : ''}`} />
                        </button>
                        <div className={`grid transition-[grid-template-rows] duration-300 ${activeSubAccordion === 'dct' ? 'grid-rows-[1fr]' : 'grid-rows-[0fr]'}`}>
                            <div className="overflow-hidden bg-white px-4">
                                <div className="p-4 text-sm text-slate-500 italic flex gap-2"><InfoIcon /> Conteúdo em desenvolvimento...</div>
                            </div>
                        </div>
                    </div>

                    {/* DCNT */}
                    <div className="rounded-xl border border-slate-200 bg-white overflow-hidden">
                        <button onClick={() => toggleSubAccordion('dcnt')} className="w-full flex justify-between p-3 px-4 bg-slate-50 hover:bg-slate-100">
                            <div className="flex items-center gap-3"><HeartIcon className="text-slate-500" /><span className="text-sm font-semibold text-slate-700">Doenças Crônicas Não Transmissíveis</span></div>
                            <CaretDownIcon size={16} className={`text-slate-400 transition-transform ${activeSubAccordion === 'dcnt' ? 'rotate-180' : ''}`} />
                        </button>
                        <div className={`grid transition-[grid-template-rows] duration-300 ${activeSubAccordion === 'dcnt' ? 'grid-rows-[1fr]' : 'grid-rows-[0fr]'}`}>
                            <div className="overflow-hidden bg-white px-4">
                                <div className="p-4 text-sm text-slate-500 italic flex gap-2"><InfoIcon /> Conteúdo em desenvolvimento...</div>
                            </div>
                        </div>
                    </div>
                </div>
            </AccordionSection>
        </div>
    )
}