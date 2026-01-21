// Dicionário de dados

export const DictionaryTable = ({ rows }) => {

    const typeColors = {
        STRING: "text-pink-600 bg-pink-50/30",
        INTEGER: "text-blue-600 bg-blue-50/30",
        BOOLEAN: "text-purple-600 bg-purple-50/30",
        DATE: "text-amber-600 bg-amber-50/30",
        FLOAT: "text-emerald-600 bg-emerald-50/30"
    };

    return (
        <div className="overflow-x-auto">
            <table className="w-full text-left text-sm text-slate-600">
                <thead className="bg-slate-50 text-slate-500 font-medium border-b border-slate-200">
                    <tr>
                        <th className="px-6 py-3 border-r border-slate-200 w-1/4">Coluna</th>
                        <th className="px-6 py-3 border-r border-slate-200 w-1/6">Tipo</th>
                        <th className="px-6 py-3">Descrição</th>
                    </tr>
                </thead>
                <tbody className="divide-y divide-slate-100">
                    {rows.map((row, idx) => (
                        <tr key={idx} className="hover:bg-slate-50 transition-colors">
                            <td className={`px-6 py-3 font-mono text-xs ${typeColors[row.type] || "text-slate-600"}`}>
                                {row.column}
                            </td>
                            <td className="px-6 py-3 text-xs">{row.type}</td>
                            <td className="px-6 py-3">{row.description}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};