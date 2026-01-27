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
                path: "/documentacao/quem-somos",
                type: "link"
            },
            {
                title: "A QUEM SERVIMOS",
                icon: "ph-users-three",
                type: "submenu", // Tem filhos
                children: [
                    {
                        title: "Query - A QUEM SERVIMOS",
                        path: "/documentacao/a-quem-servimos",
                        type: "link"
                    },
                    {
                        title: "Perfil clínico-epidemiológico",
                        icon: "ph-chart-bar",
                        type: "submenu", // Submenu aninhado
                        marquee: true, // efeito de texto longo
                        children: [
                            { title: "Query - Hanseníase", path: "/documentacao/a-quem-servimos/pce/hanseniase", type: "link" },
                            { title: "Query - Tuberculose", path: "/documentacao/a-quem-servimos/pce/tuberculose", type: "link" },
                            { title: "Query - Sífilis", path: "/documentacao/a-quem-servimos/pce/sifilis", type: "link" },
                            { title: "Query - Hepatites", path: "/documentacao/a-quem-servimos/pce/hepatites", type: "link" }
                        ]
                    }
                ]
            },
            {
                title: "Nossos resultados",
                icon: "ph-chart-line-up",
                type: "submenu",
                children: [
                    { title: "Query - SIAPS", path: "/documentacao/nossos-resultados/siaps", type: "link" },
                    { title: "Query - Unidade Amiga da primeira infância (UAPI)", path: "/documentacao/nossos-resultados/uapi", type: "link" },
                    { title: "Query - Accountability", path: "/documentacao/nossos-resultados/accountabilty", type: "link" },
                    {
                        title: "Linhas de Cuidados",
                        icon: "ph-virus",
                        type: "submenu",
                        marquee: true,
                        children: [
                            {
                                title: "(DCT) Doenças Crônicas Transmissíveis",
                                icon: "ph-virus",
                                type: "submenu",
                                marquee: true,
                                children: [
                                    { title: "Query - Tuberculose", path: "documentacao/nossos-resultados/linhas-de-cuidado/dct/tuberculose", type: "link" },
                                    { title: "Query - Sífilis", path: "/documentacao/nossos-resultados/linhas-de-cuidado/dct/sifilis", type: "link" },
                                    { title: "Query - Hanseníase", path: "/documentacao/nossos-resultados/linhas-de-cuidado/dct/hanseniase", type: "link" },
                                    { title: "Query - Hepatites", path: "/documentacao/nossos-resultados/linhas-de-cuidado/dct/hepatites", type: "link" },
                                    { title: "Query - HIV-AIDS", path: "/documentacao/nossos-resultados/linhas-de-cuidado/dct/hiv-aids", type: "link" },
                                    { title: "Query - Laboratório", path: "/documentacao/nossos-resultados/linhas-de-cuidado/dct/laboratorio", type: "link" },
                                ]
                            },
                            {
                                title: "(DCNT) Doenças Crônicas Não Transmissíveis",
                                icon: "ph-pulse",
                                type: "submenu",
                                marquee: true,
                                children: [
                                    { title: "Query - Hipertensão", path: "/documentacao/nossos-resultados/linhas-de-cuidados/dcnt/hipertensao", type: "link" },
                                    { title: "Query - Diabetes", path: "/documentacao/nossos-resultados/linhas-de-cuidados/dcnt/diabetes", type: "link" },
                                    { title: "Query - PICS", path: "/documentacao/nossos-resultados/linhas-de-cuidados/dcnt/pics", type: "link" },
                                    { title: "Query - CÂNCER", path: "/documentacao/nossos-resultados/linhas-de-cuidados/dcnt/cancer", type: "link" },
                                    { title: "Query - Saúde Bucal", path: "/documentacao/nossos-resultados/linhas-de-cuidados/dcnt/saude-bucal", type: "link" },
                                    { title: "Query - Saúde do Trabalhador", path: "/documentacao/nossos-resultados/linhas-de-cuidados/dcnt/saude-do-trabalhador", type: "link" },
                                    { title: "Query - Policlínicas", path: "/documentacao/nossos-resultados/linhas-de-cuidados/dcnt/policlinicas", type: "link" }
                                ]
                            },
                            {
                                title: "Ciclos de Vida",
                                icon: "ph-hand-heart",
                                type: "submenu",
                                marquee: true,
                                children: [
                                    { title: "Query - Saúde da Pessoa Idosa", path: "/documentacao/nossos-resultados/linhas-de-cuidados/ciclo-de-vidas/spi", type: "link" },
                                    { title: "Query - Saúde da Mulher", path: "/documentacao/nossos-resultados/linhas-de-cuidados/ciclo-de-vidas/sm", type: "link" },
                                    { title: "Query - Saúde do Homem", path: "/documentacao/nossos-resultados/linhas-de-cuidados/ciclo-de-vidas/sh", type: "link" },
                                    { title: "Query - Saúde da Criança e do Adolescente", path: "/documentacao/nossos-resultados/linhas-de-cuidados/ciclo-de-vidas/sca", type: "link" }
                                ]
                            },
                        ]
                    }
                ]
            }
        ]
    }
];