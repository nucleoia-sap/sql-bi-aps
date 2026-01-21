import logoPrefeitura from '../../assets/logos/logo-prefeitura-2.png';

export const SidebarHeader = () => {
    return (
        <div className="p-6 pt-24 md:pt-8 border-b border-slate-800 flex flex-col items-center text-center gap-2">
            <div className="w-40 h-auto flex items-center justify-center text-xs text-slate-500">
                <img src={logoPrefeitura} alt="Logo da Prefeitura" />
            </div>
            <div className="flex flex-col gap-1 w-full mt-5">
                <h1 className="font-bold text-white text-xl tracking-wide">BI-APS</h1>
                <p className="text-[10px] text-slate-500 uppercase tracking-[0.2em] font-medium border-t border-slate-800 pt-2 mt-1">
                    Documentação
                </p>
            </div>
        </div>
    )
}