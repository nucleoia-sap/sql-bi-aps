// (Os 3 cards de resumo no topo)

export const DocMetadata = ({ items }) => {
    return (
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            {items.map((item, index) => (
                <div key={index} className="bg-white p-4 rounded-lg border border-slate-200 shadow-sm h-full">
                    <p className="text-xs text-slate-500 uppercase font-semibold mb-1">{item.label}</p>

                    {/* Renderização condicional para código monoespaçado vs texto normal */}
                    {item.mono ? (
                        <div className="text-slate-800 font-medium text-xs break-all font-mono bg-slate-50 p-1 rounded">
                            {item.value}
                        </div>
                    ) : (
                        <div className="text-slate-800 font-medium text-sm flex flex-col gap-1">
                            {item.value}
                        </div>
                    )}
                </div>
            ))}
        </div>
    );
};