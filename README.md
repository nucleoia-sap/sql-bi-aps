# 🏥 Documentação Técnica – BI Atenção Primária à Saúde (APS)

Bem-vindo ao repositório oficial da documentação técnica das regras de negócio, queries SQL e definições de indicadores utilizados no painel de monitoramento da Atenção Primária à Saúde (APS).

Este projeto evoluiu de uma solução Front-End estática (HTML + JavaScript Vanilla) para uma aplicação moderna baseada em React + Vite, funcionando como um portal centralizado de documentação de BI para a equipe de dados da Prefeitura.

## ⚡ Tecnologias e Ferramentas

A versão atual do projeto foi estruturada para garantir componentização, manutenibilidade e performance.

- **React** – Biblioteca principal para construção da interface baseada em componentes.  
- **Vite** – Ferramenta de build e desenvolvimento com foco em velocidade.  
- **React Router** – Gerenciamento de rotas e navegação entre páginas e indicadores.  
- **Tailwind CSS** – Estilização base e padronização visual da aplicação.  
- **Highlight.js / Prism.js** – Realce de sintaxe para scripts SQL.  
- **Phosphor Icons** – Biblioteca de ícones como componentes React reutilizáveis.

## 📂 Estrutura do Projeto

A aplicação segue uma arquitetura modular, separando responsabilidades visuais e lógicas.

```text
sql-bi-aps/
│
├── src/
│   ├── components/        # Componentes reutilizáveis (Sidebar, Tabs, CodeBlock, etc.)
│   ├── layout/            # Estrutura base (Layout principal, Header, Sidebar)
│   ├── pages/             # Páginas de conteúdo (Indicadores, Institucional)
│   ├── router/            # Definição centralizada das rotas
│   ├── index.css          # Estilos globais
│   └── main.jsx           # Ponto de entrada da aplicação
│
├── public/                # Ativos estáticos (imagens, favicon)
├── package.json           # Dependências e scripts
├── vite.config.js         # Configuração do Vite
└── README.md              # Documentação principal
```

## 📌 Organização Conceitual

- **components/**: Lógica de UI fragmentada para fácil manutenção.  
- **layout/**: Define a "casca" da aplicação (header e sidebar fixos).  
- **pages/**: Cada página representa um indicador específico ou seção da documentação.  
- **router/**: Centraliza as rotas para facilitar a escalabilidade.

## 🚀 Funcionalidades Principais

### 1. Navegação SPA (Single Page Application)

Transições instantâneas entre indicadores sem recarregamento de página, garantindo fluidez total na consulta de dados.

### 2. Estrutura Padronizada por Indicador

Cada indicador segue um padrão visual e informativo rigoroso:

- **Regras de Negócio**: Lógica, critérios e premissas.  
- **Script SQL**: Query otimizada para BigQuery com realce de sintaxe e botão de cópia.  
- **Dicionário de Dados**: Detalhamento técnico de tabelas e colunas.

### 3. Sidebar Inteligente

Barra lateral com detecção automática de rota ativa, destacando visualmente onde o usuário está localizado no portal.

## 🛠️ Como Executar o Projeto

Certifique-se de ter o Node.js instalado em sua máquina.

### Instalar as dependências

```bash
npm install
```

### Iniciar o servidor de desenvolvimento

```bash
npm run dev
```

### Gerar build de produção

```bash
npm run build
```

## 📈 Objetivo do Projeto

Centralizar e padronizar a documentação técnica dos indicadores da APS, garantindo:

- **Transparência**: Regras de negócio acessíveis a todos.  
- **Rastreabilidade**: Consulta rápida às queries originais.  
- **Auditoria**: Facilidade em validar cálculos e métricas.  
- **Escalabilidade**: Estrutura pronta para novos indicadores.

## 📌 Evolução do Projeto

- 📅 **v1.0.3**: Documentação estática (HTML/JS legado).  
- 🚀 **v2.0.0 (Atual)**: Migração para React, arquitetura modular e navegação SPA.

## 🔗 Links Úteis

[📄 **Documentação Técnica (Clique aqui) – Google Docs**](https://docs.google.com/document/d/1lCqJsNq8n7KUAj1t11Dp987LgMURNxPjAoSZbv745f8/edit?usp=sharing)