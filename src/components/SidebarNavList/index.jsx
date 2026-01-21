import { menuItems } from '../data/menuItens';
import { SidebarItem } from '../SidebarItem';

export const SidebarNavList = ({ searchTerm, expandedMenus, toggleSubmenu }) => {
    return (
        <nav className="flex-1 overflow-y-auto py-2 space-y-1 px-3 custom-scrollbar min-h-0">
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
    )
}