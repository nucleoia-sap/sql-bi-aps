import { ChartPolarIcon } from "@phosphor-icons/react"

export const HeroSection = () => {
    return (
        <div className="bg-white rounded-2xl p-8 border border-slate-200 shadow-sm mb-10 relative overflow-hidden">
            <div className="absolute top-0 right-0 w-64 h-64 bg-gradient-to-br from-sky-50 to-blue-50 rounded-full blur-3xl -mr-16 -mt-16 opacity-50 pointer-events-none"></div>

            <div className="relative z-10">
                <div className="flex items-center gap-2 text-sky-600 mb-2">
                    <ChartPolarIcon size={20} />
                    <span className="text-sm font-bold uppercase tracking-wider">Documentação Técnica</span>
                </div>
                <h1 className="text-3xl md:text-4xl font-bold text-slate-900 mb-4">
                    BI da Atenção Primária à Saúde (APS)
                </h1>
                <p className="text-lg text-slate-600 max-w-3xl leading-relaxed">
                    Bem-vindo ao repositório oficial de documentação das queries e regras de negócio do painel de monitoramento da APS.
                </p>
            </div>
        </div>
    )
}