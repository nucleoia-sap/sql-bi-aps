export const Main = ({ children }) => {
    return (
        <main className="flex-1 flex flex-col h-full overflow-hidden relative w-full bg-slate-50">
            <div className="flex-1 overflow-y-auto p-6 md:p-10 pt-20 md:pt-10 custom-scrollbar">
                <div className="max-w-6xl mx-auto">
                    {children}
                </div>
            </div>
        </main>
    )
}