// src/data/menuItems.js

export const menuItems = [
    {
        title: "Visão Geral",
        icon: "ph-house",
        path: "/",
        type: "link"
    },
    {
        title: "BI APS (Atenção Primária)",
        type: "group", // Título de seção
        children: [
            {
                title: "Query - QUEM SOMOS",
                icon: "ph-identification-card",
                path: "/quem-somos",
                type: "link"
            },
            {
                title: "A QUEM SERVIMOS",
                icon: "ph-users-three",
                type: "submenu", // Tem filhos
                children: [
                    {
                        title: "Query - A QUEM SERVIMOS",
                        path: "/a-quem-servimos",
                        type: "link"
                    },
                    {
                        title: "Perfil clínico-epidemiológico",
                        icon: "ph-chart-bar",
                        type: "submenu", // Submenu aninhado
                        marquee: true, // Aquele efeito de texto longo
                        children: [
                            { title: "Query - Hanseníase", path: "/hanseniase", type: "link" },
                            { title: "Query - Tuberculose", path: "/tuberculose", type: "link" },
                            { title: "Query - Sífilis", path: "/sifilis", type: "link" },
                            { title: "Query - Hepatites", path: "/hepatites", type: "link" }
                        ]
                    }
                ]
            },
            {
                title: "Nossos resultados",
                icon: "ph-chart-line-up",
                type: "submenu",
                children: [
                    // ... adicionei alguns exemplos baseados no HTML
                    { title: "Query - Sistemas de Informação", path: "/siaps", type: "link" },
                    {
                        title: "Doenças Crônicas Transmissíveis",
                        icon: "ph-virus",
                        type: "submenu",
                        marquee: true,
                        children: [
                            { title: "Query - Exemplo", path: "/exemplo-dct", type: "link" }
                        ]
                    }
                ]
            }
        ]
    }
];