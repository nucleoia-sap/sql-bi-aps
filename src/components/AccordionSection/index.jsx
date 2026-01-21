import { CaretDownIcon } from "@phosphor-icons/react"

export const AccordionSection = ({ title, subtitle, icon: Icon, colorClass, textClass, isOpen, onToggle, children }) => {
    return (
        <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden mb-6">
            <button
                onClick={onToggle}
                className="w-full flex items-center justify-between p-6 bg-white hover:bg-slate-50 transition-colors focus:outline-none"
            >
                <div className="flex items-center gap-4">
                    <div className={`p-2 ${colorClass} ${textClass} rounded-lg border border-opacity-20`}>
                        <Icon size={24} />
                    </div>
                    <div className="text-left">
                        <h3 className="text-lg font-bold text-slate-900">{title}</h3>
                        <p className="text-xs text-slate-500 mt-1 uppercase tracking-wide font-medium">{subtitle}</p>
                    </div>
                </div>
                <CaretDownIcon size={20} className={`text-slate-400 transition-transform duration-300 ${isOpen ? 'rotate-180' : ''}`} />
            </button>

            {/* Animação com Grid */}
            <div className={`grid transition-[grid-template-rows] duration-300 ease-out ${isOpen ? 'grid-rows-[1fr]' : 'grid-rows-[0fr]'}`}>
                <div className="overflow-hidden">
                    <div className="px-6 bg-slate-50 border-t border-slate-100 pb-6">
                        {children}
                    </div>
                </div>
            </div>
        </div>
    )
}