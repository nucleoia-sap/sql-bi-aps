import React, { useState } from 'react';

import { Sidebar } from '../../components/Sidebar';
import { Main } from '../../components/Main';
import { ContainerMain } from '../../components/ContainerMain';
import { HeroSection } from '../../components/HeroSection';
import { TitleHome } from '../../components/TitleHome';
import { ListCards } from '../../components/ListCards';

// --- COMPONENTE PRINCIPAL ---

export function Home() {
    const [isSidebarOpen, setIsSidebarOpen] = useState(false);

    return (
        <ContainerMain>

            {/* Aba Lateral */}
            <Sidebar isOpen={isSidebarOpen} toggleSidebar={() => setIsSidebarOpen(!isSidebarOpen)} />

            {/* Conteúdo Principal */}
            <Main>
                {/* Hero Section */}
                <HeroSection />

                {/* Título Acesso Rápido */}
                <TitleHome>
                    Acesso Rápido
                </TitleHome>

                {/* Lista de Cards */}
                <ListCards />
            </Main>
        </ContainerMain>
    );
}