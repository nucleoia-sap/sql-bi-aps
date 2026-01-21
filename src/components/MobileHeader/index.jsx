import { ListIcon } from "@phosphor-icons/react"

export const MobileHeader = ({ onToggle }) => {
    return (
        <div className="fixed w-full bg-slate-900 text-white z-50 flex items-center justify-between p-4 md:hidden">
            <div className="font-bold text-lg flex items-center gap-2">BI-APS</div>
            <button onClick={onToggle}>
                <ListIcon size={24} />
            </button>
        </div>
    )
}