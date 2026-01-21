Segue abaixo o **conteúdo completo do arquivo `README.md`**, já **formatado em Markdown**, exatamente com a estilização e estrutura que montei para você.
Basta **copiar e salvar como `README.md` na raiz do projeto**.

---

````md
# Documentação Técnica – BI Atenção Primária à Saúde (APS)

Bem-vindo ao repositório oficial da documentação técnica das **regras de negócio**, **queries SQL** e **definições de indicadores** utilizados no painel de monitoramento da Atenção Primária à Saúde (APS).

Este projeto evoluiu de uma solução **Front-End estática (HTML + JavaScript Vanilla)** para uma aplicação moderna baseada em **React + Vite**, funcionando como um **portal centralizado de documentação de BI** para a equipe de dados da Prefeitura.

---

## ⚡ Tecnologias e Ferramentas

A versão atual do projeto foi estruturada para garantir **componentização**, **manutenibilidade** e **performance**.

- **React** – biblioteca principal para construção da interface baseada em componentes.
- **Vite** – ferramenta de build e desenvolvimento com foco em velocidade.
- **React Router** – gerenciamento de rotas e navegação entre páginas e indicadores.
- **Tailwind CSS** – estilização base e padronização visual da aplicação.
- **Highlight.js / Prism.js** – realce de sintaxe para scripts SQL.
- **Phosphor Icons** – biblioteca de ícones como componentes React reutilizáveis.

---

## 📂 Estrutura do Projeto

A aplicação segue uma arquitetura clara, separando **responsabilidades visuais, estruturais e de navegação**, alinhada às boas práticas do ecossistema React.

```text
sql-bi-aps/
│
├── src/
│   ├── components/        # Componentes reutilizáveis (Sidebar, Tabs, CodeBlock, etc.)
│   ├── layout/            # Estrutura base da aplicação (Layout principal, Header, Sidebar)
│   ├── pages/             # Páginas de conteúdo (Indicadores, Quem Somos, etc.)
│   ├── router/            # Definição centralizada das rotas (React Router)
│   ├── index.css          # Estilos globais da aplicação
│   └── main.jsx           # Ponto de entrada da aplicação React
│
├── public/                # Ativos estáticos (imagens, favicon, etc.)
├── package.json           # Dependências e scripts do projeto
├── vite.config.js         # Configuração do Vite
└── README.md              # Documentação do projeto
````

### 📌 Organização Conceitual

* **components/**
  Componentes reutilizáveis utilizados em múltiplas páginas.

* **layout/**
  Define a “casca” da aplicação, responsável pela estrutura fixa (header, sidebar, container).

* **pages/**
  Cada página representa um indicador ou seção institucional da documentação.

* **router/**
  Centraliza a definição das rotas, facilitando manutenção e escalabilidade.

* **index.css**
  Arquivo de estilos globais compartilhados por toda a aplicação.

---

## 🚀 Funcionalidades Implementadas

### 1. Navegação em SPA (Single Page Application)

A aplicação funciona como uma SPA, permitindo transições instantâneas entre indicadores sem recarregar o navegador, proporcionando melhor performance e experiência do usuário.

---

### 2. Estrutura Padronizada por Indicador

Cada indicador segue um padrão de organização, normalmente dividido em abas ou seções, como:

* **Regras de Negócio**
  Definição lógica, critérios e premissas do indicador.

* **Script SQL**
  Query utilizada no BigQuery, com realce de sintaxe e funcionalidade de cópia.

* **Dicionário de Dados**
  Descrição detalhada das tabelas, colunas e campos utilizados.

Essa padronização garante consistência, clareza e escalabilidade da documentação.

---

### 3. Sidebar com Estado Ativo

A barra lateral identifica automaticamente a rota ativa, destacando visualmente o indicador ou seção atual, facilitando a navegação e a orientação do usuário.

---

## 🛠️ Como Executar o Projeto

### 1. Instalar as dependências

```bash
npm install
```

### 2. Iniciar o servidor de desenvolvimento

```bash
npm run dev
```

### 3. Gerar build de produção

```bash
npm run build
```

---

## 📈 Objetivo do Projeto

Centralizar e padronizar a documentação técnica dos indicadores da Atenção Primária à Saúde, garantindo:

* Transparência nas regras de negócio
* Rastreabilidade das queries SQL
* Facilidade de manutenção e auditoria
* Escalabilidade para inclusão de novos indicadores

---

## 📌 Evolução do Projeto

* **Versão 1.0.3** – Documentação estática em HTML e JavaScript puro
* **Versão atual (2.0.0)** – Aplicação React com arquitetura modular e navegação SPA

---

Caso necessário, este repositório pode ser expandido para incluir ():

* novos indicadores,
* novas fontes de dados,
* ou integração com outros painéis de BI.

📄 Documentação complementar disponível em:  
[Documentação Técnica Completa – BI APS]
(https://docs.google.com/document/d/1lCqJsNq8n7KUAj1t11Dp987LgMURNxPjAoSZbv745f8/edit?usp=sharing)

```
