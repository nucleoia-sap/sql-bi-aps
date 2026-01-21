// (Título, breadcrumbs e botão BigQuery)

import { ArrowSquareOutIcon } from "@phosphor-icons/react";

export const DocHeader = ({ breadcrumbs = [], title, description, bqLink, badgeText, badgeColor = "purple" }) => {

    const badgeStyles = {
        purple: "bg-purple-100 text-purple-700",
        amber: "bg-amber-100 text-amber-700",
        blue: "bg-blue-100 text-blue-700"
    };

    return (
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-8 pb-6 border-b border-slate-200">
            <div>
                <div className="flex items-center gap-2 mb-2">
                    {badgeText && (
                        <span className={`${badgeStyles[badgeColor] || badgeStyles.purple} text-xs font-bold px-2 py-1 rounded uppercase tracking-wide`}>
                            {badgeText}
                        </span>
                    )}
                    {breadcrumbs.map((crumb, index) => (
                        <div key={index} className="flex items-center gap-2">
                            <span className="text-slate-400 text-sm">/</span>
                            <span className="text-slate-500 text-sm">{crumb}</span>
                        </div>
                    ))}
                </div>
                <h1 className="text-3xl font-bold text-slate-900">{title}</h1>
                <p className="text-slate-600 mt-1">{description}</p>
            </div>

            {bqLink && (
                <div className="flex gap-3">
                    <a
                        href={bqLink}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="flex items-center gap-2 bg-sky-600 text-white hover:bg-sky-700 px-4 py-2 rounded-md text-sm font-medium transition-colors shadow-sm"
                    >
                        <ArrowSquareOutIcon size={18} /> Abrir no BigQuery
                    </a>
                </div>
            )}
        </div>
    );
};