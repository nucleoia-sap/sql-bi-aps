import { FolderOpenIcon } from "@phosphor-icons/react"

export const TitleHome = ({ children }) => {
    return (
        <h2 className="text-lg font-bold text-slate-800 mb-4 flex items-center gap-2">
            <FolderOpenIcon size={24} className="text-slate-400" /> {children}
        </h2>
    )
}