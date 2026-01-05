import { useState } from 'react';
import { List } from '@phosphor-icons/react';
import { menuItems } from '../data/menuItens';
import { SidebarItem } from './SidebarItem';
import { SidebarSearch } from './SidebarSearch';
import { VersionProject } from '../VersionProject';
import logoPrefeitura from '../../assets/logos/logo-prefeitura-2.png';

export function Sidebar() {
    const [isOpen, setIsOpen] = useState(false);
    const [searchTerm, setSearchTerm] = useState('');
    const [expandedMenus, setExpandedMenus] = useState({});

    const toggleSubmenu = (title) => {
        setExpandedMenus(prev => ({
            ...prev,
            [title]: !prev[title]
        }));
    };

    return (
        <>
            {/* Mobile Header */}
            <div className="fixed w-full bg-slate-900 text-white z-50 flex items-center justify-between p-4 md:hidden">
                <div className="font-bold text-lg flex items-center gap-2">BI-APS</div>
                <button onClick={() => setIsOpen(!isOpen)}>
                    <List size={24} />
                </button>
            </div>

            {/* Sidebar Container */}
            <aside className={`
        bg-slate-900 text-slate-300 w-64 flex-shrink-0 fixed inset-y-0 left-0 z-40 flex flex-col h-full shadow-xl
        transition-transform duration-300 ease-in-out
        ${isOpen ? 'translate-x-0' : '-translate-x-full'} 
        md:relative md:translate-x-0
      `}>

                {/* Logo Area */}
                <div className="p-6 pt-24 md:pt-8 border-b border-slate-800 flex flex-col items-center text-center gap-2">
                    <div className="w-40 h-10 flex items-center justify-center text-xs text-slate-500">
                        <img src={logoPrefeitura} alt="Logo da Prefeitura" />
                    </div>
                    <h1 className="font-bold text-white text-xl tracking-wide mt-5">BI-APS</h1>
                    <p className="text-[10px] text-slate-500 uppercase tracking-widest border-t border-slate-800 pt-2 w-full">
                        Documentação
                    </p>
                </div>

                {/* Componente de Busca */}
                <SidebarSearch
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                />

                {/* Lista de Navegação */}
                <nav className="flex-1 overflow-y-auto py-2 space-y-1 px-3 custom-scrollbar">
                    {menuItems.map((item, index) => (
                        <SidebarItem
                            key={index}
                            item={item}
                            searchTerm={searchTerm}
                            expandedMenus={expandedMenus}
                            toggleSubmenu={toggleSubmenu}
                        />
                    ))}
                </nav>

                {/* Footer */}
                <VersionProject />
            </aside>

            {/* Overlay Mobile */}
            {isOpen && (
                <div
                    onClick={() => setIsOpen(false)}
                    className="fixed inset-0 bg-black/50 z-30 md:hidden"
                />
            )}
        </>
    );
}