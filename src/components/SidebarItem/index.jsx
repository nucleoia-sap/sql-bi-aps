import { useLocation, Link } from 'react-router'; // Importar hooks do Router
import {
    ChartLineUpIcon,
    ChartBarIcon,
    UsersThreeIcon,
    IdentificationCardIcon,
    VirusIcon,
    CaretDownIcon,
    HouseIcon,
    HandHeartIcon,
    PulseIcon
} from '@phosphor-icons/react';

const iconMap = {
    "ph-house": HouseIcon,
    "ph-identification-card": IdentificationCardIcon,
    "ph-users-three": UsersThreeIcon,
    "ph-chart-bar": ChartBarIcon,
    "ph-chart-line-up": ChartLineUpIcon,
    "ph-virus": VirusIcon,
    "ph-hand-heart": HandHeartIcon,
    "ph-pulse": PulseIcon
};

export function SidebarItem({ item, searchTerm, expandedMenus, toggleSubmenu }) {
    const location = useLocation();

    // 1. Lógica de filtro (Busca)
    if (searchTerm && !item.title.toLowerCase().includes(searchTerm.toLowerCase())) {
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
                    <CaretDownIcon className={`transition-transform duration-200 ${isExpanded ? 'rotate-180' : ''}`} />
                </button>

                <div
                    className={`pl-4 overflow-hidden transition-all duration-500 ease-in-out 
                    ${isExpanded ? 'max-h-[2000px] opacity-100' : 'max-h-0 opacity-0'}`}
                >
                    <ul className="mt-1 space-y-1 border-l border-slate-700 ml-2 pl-2">
                        {item.children?.map((subChild, idx) => (
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

    // Verifica se a rota atual é igual ao path do item
    const isActive = location.pathname === item.path;

    return (
        <li>
            <Link
                to={item.path}
                className={`flex items-center gap-3 px-3 py-2 rounded-md text-sm transition-colors border-r-2
                ${isActive
                        ? 'text-sky-400 bg-slate-800 border-sky-400 font-medium' // Estilo ATIVO
                        : 'text-slate-400 border-transparent hover:text-white hover:bg-slate-800/50' // Estilo PADRÃO
                    }`}
            >
                {IconComponent && <IconComponent size={20} weight={isActive ? "fill" : "regular"} />}
                {item.title}
            </Link>
        </li>
    );
}