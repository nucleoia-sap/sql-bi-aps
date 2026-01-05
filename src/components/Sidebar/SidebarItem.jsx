import {
    CaretDown, House, IdentificationCard, UsersThree,
    ChartBar, ChartLineUp, Virus
} from '@phosphor-icons/react';

// O mapa de ícones fica aqui, pois só este componente usa
const iconMap = {
    "ph-house": House,
    "ph-identification-card": IdentificationCard,
    "ph-users-three": UsersThree,
    "ph-chart-bar": ChartBar,
    "ph-chart-line-up": ChartLineUp,
    "ph-virus": Virus
};

export function SidebarItem({ item, searchTerm, expandedMenus, toggleSubmenu }) {
    // 1. Lógica de filtro (Busca)
    if (searchTerm && !item.title.toLowerCase().includes(searchTerm.toLowerCase())) {
        // Se for submenu ou grupo, a gente não esconde direto, pois pode ter filhos que batem com a busca.
        // (Mantendo a lógica simples anterior: se não for folha, esconde. Melhorias futuras podem vir aqui)
        if (item.type !== 'group' && item.type !== 'submenu') return null;
    }

    const IconComponent = item.icon ? iconMap[item.icon] : null;
    const isExpanded = expandedMenus[item.title];

    // --- TIPO: GRUPO ---
    if (item.type === 'group') {
        return (
            <div>
                <h3 className="px-3 text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2 mt-4">
                    {item.title}
                </h3>
                <ul className="space-y-1">
                    {item.children.map((child, idx) => (
                        <SidebarItem
                            key={idx}
                            item={child}
                            searchTerm={searchTerm}
                            expandedMenus={expandedMenus}
                            toggleSubmenu={toggleSubmenu}
                        />
                    ))}
                </ul>
            </div>
        );
    }

    // --- TIPO: SUBMENU ---
    if (item.type === 'submenu') {
        return (
            <li>
                <button
                    onClick={() => toggleSubmenu(item.title)}
                    className="w-full flex items-center justify-between px-3 py-2 rounded-md text-sm text-slate-400 hover:text-white hover:bg-slate-800/50 group transition-colors"
                >
                    <div className="flex items-center gap-3 overflow-hidden">
                        {IconComponent && <IconComponent size={20} />}

                        {item.marquee ? (
                            <div className="marquee-container overflow-hidden whitespace-nowrap w-full">
                                <span className="block group-hover:-translate-x-12 transition-transform duration-1000">
                                    {item.title}
                                </span>
                            </div>
                        ) : (
                            <span>{item.title}</span>
                        )}
                    </div>
                    <CaretDown className={`transition-transform duration-200 ${isExpanded ? 'rotate-180' : ''}`} />
                </button>

                <div className={`pl-4 overflow-hidden transition-all duration-300 ${isExpanded ? 'max-h-96 opacity-100' : 'max-h-0 opacity-0'}`}>
                    <ul className="mt-1 space-y-1 border-l border-slate-700 ml-2 pl-2">
                        {item.children?.map((subChild, idx) => (
                            // RECURSIVIDADE: O componente chama a si mesmo para os filhos
                            <SidebarItem
                                key={idx}
                                item={subChild}
                                searchTerm={searchTerm}
                                expandedMenus={expandedMenus}
                                toggleSubmenu={toggleSubmenu}
                            />
                        ))}
                    </ul>
                </div>
            </li>
        );
    }

    // --- TIPO: LINK SIMPLES ---
    return (
        <li>
            <a
                href={item.path}
                className="flex items-center gap-3 px-3 py-2 rounded-md text-sm text-slate-400 hover:text-white hover:bg-slate-800/50 transition-colors"
            >
                {IconComponent && <IconComponent size={20} />}
                {item.title}
            </a>
        </li>
    );
}