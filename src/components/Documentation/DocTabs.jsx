import { useState } from 'react';

export const DocTabs = ({ tabs }) => {

    const [activeTab, setActiveTab] = useState(tabs[0]?.id);

    return (
        <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden mb-10">
            {/* --- Cabeçalho das Abas (Botões) --- */}
            <div className="border-b border-slate-200 flex overflow-x-auto bg-slate-50">
                {tabs.map((tab) => (
                    <button
                        key={tab.id}
                        onClick={() => setActiveTab(tab.id)}
                        className={`px-6 py-4 text-sm font-medium focus:outline-none transition-colors border-b-2 whitespace-nowrap cursor-pointer
                        ${activeTab === tab.id
                                ? 'text-sky-600 border-sky-600'
                                : 'text-slate-500 border-transparent hover:text-slate-700'}`}
                    >
                        {tab.label}
                    </button>
                ))}
            </div>

            {/* --- Conteúdo da Aba Ativa --- */}
            <div className="min-h-[300px]">
                {tabs.map((tab) => {
                    if (activeTab !== tab.id) return null;
                    return (
                        <div key={tab.id} className="animate-fade-in">
                            {tab.content}
                        </div>
                    );
                })}
            </div>
        </div>
    );
};