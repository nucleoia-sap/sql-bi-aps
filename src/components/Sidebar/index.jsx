import { useState } from 'react';
import { VersionProject } from '../VersionProject';
import { MobileHeader } from '../MobileHeader';
import { SidebarSearch } from '../SidebarSearch'
import { OverlayMobile } from '../OverlayMobile';
import { SidebarContainer } from '../SidebarContainer';
import { SidebarHeader } from '../SidebarHeader';
import { SidebarNavList } from '../SidebarNavList';

export function Sidebar() {
    // Estado dos componentes 
    const [isOpen, setIsOpen] = useState(false);
    const [searchTerm, setSearchTerm] = useState('');
    const [expandedMenus, setExpandedMenus] = useState({});

    // Lógica
    const toggleSubmenu = (title) => {
        setExpandedMenus(prev => ({
            ...prev,
            [title]: !prev[title]
        }));
    };

    return (
        <>
            {/* Mobile Header */}
            <MobileHeader onToggle={() => setIsOpen(!isOpen)} />

            <SidebarContainer isOpen={isOpen}>
                {/* Header - Prefeitura */}
                <SidebarHeader />

                {/* Componente de Busca */}
                <SidebarSearch
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                />

                {/* Lista de Navegação */}
                <SidebarNavList searchTerm={searchTerm} expandedMenus={expandedMenus} toggleSubmenu={toggleSubmenu} />

                {/* Footer */}
                <VersionProject />

            </SidebarContainer>

            {/* Overlay Mobile */}

            <OverlayMobile isOpen={isOpen} onClose={() => setIsOpen(false)} />
        </>
    );
}