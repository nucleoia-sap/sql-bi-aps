export const SidebarContainer = ({ children, isOpen }) => {
    return (
        <aside className={`
            bg-slate-900 text-slate-300 w-64 flex-shrink-0 fixed inset-y-0 left-0 z-40 flex flex-col h-full shadow-xl
            transition-transform duration-300 ease-in-out
            ${isOpen ? 'translate-x-0' : '-translate-x-full'} 
            md:relative md:translate-x-0
        `}>
            {children}
        </aside>
    )
}