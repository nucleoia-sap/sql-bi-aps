export const ContainerMain = ({ children }) => {
    return (
        <div className="flex h-screen bg-slate-50 text-slate-800 overflow-hidden font-inter">
            {children}
        </div>
    )
}