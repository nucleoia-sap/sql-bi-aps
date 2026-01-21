import { ArrowRightIcon } from "@phosphor-icons/react"
import { Link } from "react-router"

export const SimpleCard = ({ to, icon: Icon, title, desc, colorClass, borderClass, textClass, hoverBgClass, hoverTextClass }) => {
    return (
        <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden mb-6">
            <div className="p-1">
                <Link to={to} className="flex items-center p-5 hover:bg-slate-50 transition-colors group rounded-lg">
                    <div className={`p-3 ${colorClass} ${textClass} rounded-lg mr-5 ${hoverBgClass} transition-colors border ${borderClass}`}>
                        <Icon size={24} weight="regular" />
                    </div>
                    <div className="flex-1">
                        <h3 className={`text-lg font-bold text-slate-900 ${hoverTextClass} transition-colors`}>{title}</h3>
                        <p className="text-sm text-slate-500">{desc}</p>
                    </div>
                    <ArrowRightIcon size={20} className={`text-slate-300 ${hoverTextClass} transition-colors`} />
                </Link>
            </div>
        </div>
    )
}