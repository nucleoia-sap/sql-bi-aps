// Card de Documentação (Os cards menores dentro dos acordeões)

import { Link } from "react-router";

export const DocCard = ({ to, icon: Icon, title, desc, status, colorTheme }) => {
    // Mapas de cores baseados no tema passado
    
    const themeStyles = {
        blue: { bg: 'bg-blue-50', text: 'text-blue-600', hoverBg: 'group-hover:bg-blue-100', hoverBorder: 'hover:border-blue-300', hoverTitle: 'group-hover:text-blue-600' },
        orange: { bg: 'bg-orange-50', text: 'text-orange-600', hoverBg: 'group-hover:bg-orange-100', hoverBorder: 'hover:border-orange-300', hoverTitle: 'group-hover:text-orange-600' },
        indigo: { bg: 'bg-indigo-50', text: 'text-indigo-600', hoverBg: 'group-hover:bg-indigo-100', hoverBorder: 'hover:border-indigo-300', hoverTitle: 'group-hover:text-indigo-600' },
        pink: { bg: 'bg-pink-50', text: 'text-pink-600', hoverBg: 'group-hover:bg-pink-100', hoverBorder: 'hover:border-pink-300', hoverTitle: 'group-hover:text-pink-600' },
        yellow: { bg: 'bg-yellow-50', text: 'text-yellow-600', hoverBg: 'group-hover:bg-yellow-100', hoverBorder: 'hover:border-yellow-300', hoverTitle: 'group-hover:text-yellow-600' },
        teal: { bg: 'bg-teal-50', text: 'text-teal-600', hoverBg: 'group-hover:bg-teal-100', hoverBorder: 'hover:border-teal-300', hoverTitle: 'group-hover:text-teal-600' },
    };

    const t = themeStyles[colorTheme] || themeStyles.blue;
    const isPending = status !== 'CONCLUÍDO';

    return (
        <Link to={to} className={`doc-card block bg-white rounded-xl border border-slate-200 p-6 ${t.hoverBorder} group h-full flex flex-col ${isPending ? 'opacity-70' : ''}`}>
            <div className="flex justify-between items-start mb-4">
                <div className={`p-3 ${t.bg} ${t.text} rounded-lg ${t.hoverBg} transition-colors`}>
                    <Icon size={24} />
                </div>
                <span className={`text-[10px] font-bold px-2 py-1 rounded-full border uppercase ${status === 'CONCLUÍDO' ? 'bg-green-100 text-green-700 border-green-200' : status === 'EM CONSTRUÇÃO' ? 'border-blue-200 text-blue-700 bg-blue-100' : 'bg-gray-100 text-gray-700 border-gray-200'}`}>
                    {status}
                </span>
            </div>
            <h3 className={`text-lg font-bold text-slate-900 mb-2 ${t.hoverTitle} transition-colors`}>{title}</h3>
            <p className="text-sm text-slate-500 mb-0 flex-1">{desc}</p>
        </Link>
    );
};