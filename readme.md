# Documentação Técnica - BI Atenção Primária à Saúde (APS)

Bem-vindo ao repositório oficial da documentação das regras de negócio e queries SQL utilizadas no painel de monitoramento da Atenção Primária à Saúde.

Este projeto é um portal Front-End estático desenvolvido para centralizar, organizar e facilitar a leitura dos scripts SQL e definições de indicadores utilizados pela equipe de dados da Prefeitura.

---

## Tecnologias Utilizadas

O projeto foi construído focando em leveza, manutenibilidade e independência de ferramentas pesadas de build, permitindo hospedagem em qualquer servidor estático.

* **HTML5 Semântico** – estruturação limpa do conteúdo.
* **Tailwind CSS** – framework utilitário via CDN para estilização responsiva.
* **JavaScript (Vanilla)** – lógica pura para abas, sidebar e clipboard.
* **Highlight.js** – realce de sintaxe para leitura otimizada dos códigos SQL.
* **Phosphor Icons** – ícones modernos e consistentes.
* **Google Fonts (Inter)** – tipografia padrão para máxima legibilidade.

---

## Estrutura de Arquivos

A organização é modular, facilitando escalabilidade e manutenção. Novas páginas com queries devem ser inseridas em `pages/`.

```
sql-bi-aps/
│
├── index.html                  # Página Inicial (Dashboard / Visão Geral)
│
├── pages/                      # Documentação específica de cada Agravo/Indicador
│   ├── bi_aps_a_quem_servimos.html
│   ├── bi_aps_hanseniase.html
│   └── bi_aps_quem_somos.html
│
├── styles/                     # Estilos Globais
│   └── global.css              # Customizações do Tailwind e Scrollbar
│
└── scripts/                    # Lógica JavaScript Compartilhada
    └── global.js               # Funções de Sidebar, Abas e Copiar SQL
```

---

## Funcionalidades Implementadas

### **1. Sistema de Abas (Tabs)**

Cada página possui um sistema de navegação interna com três visões:

* **Regras de Negócio** – descrição textual e lógica dos critérios.
* **Script SQL** – código com highlight (tema Atom One Dark).
* **Dicionário de Dados** – tabela explicativa das colunas geradas.

Tudo isso **sem recarregamento da página**.

### **2. Copiar para Área de Transferência**

Nos blocos de SQL há um botão que copia automaticamente todo o código para facilitar uso em BigQuery, DBeaver, etc.

### **3. Design Responsivo**

* **Desktop:** sidebar fixa para navegação rápida.
* **Mobile:** menu hambúrguer + sidebar deslizante (off-canvas).

