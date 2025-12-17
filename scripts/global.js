// Scripts globais de cada página

/**
 * Alterna a visibilidade da Sidebar em dispositivos móveis
 */
function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('sidebar-overlay');

    if (sidebar.classList.contains('-translate-x-full')) {
        // Abrir
        sidebar.classList.remove('-translate-x-full');
        overlay.classList.remove('hidden');
    } else {
        // Fechar
        sidebar.classList.add('-translate-x-full');
        overlay.classList.add('hidden');
    }
}

/**
 * Alterna a visibilidade de submenus na sidebar
 * @param {string} id - O ID do container do submenu
 */
function toggleSubmenu(id) {
    const submenu = document.getElementById(id);
    const chevron = document.getElementById('chevron-servimos'); // Idealmente, tornar este ID dinâmico se houver mais menus

    if (submenu.classList.contains('hidden')) {
        submenu.classList.remove('hidden');
        if (chevron) chevron.classList.add('rotate-180');
    } else {
        submenu.classList.add('hidden');
        if (chevron) chevron.classList.remove('rotate-180');
    }
}

/* ==========================================================================
   FUNÇÕES DE DOCUMENTAÇÃO (ABAS E COPY)
   ========================================================================== */

/**
 * Gerencia a troca de abas (Tabs) nas páginas de documentação
 * @param {string} tabName - O ID da div de conteúdo que deve aparecer (ex: 'regras', 'sql')
 */
function openTab(tabName) {
    // 1. Esconde todo o conteúdo das abas
    const allContents = document.querySelectorAll('.tab-content');
    allContents.forEach(content => {
        content.classList.remove('active');
        // O CSS global deve ter: .tab-content { display: none; } .tab-content.active { display: block; }
        // Se estiver usando classes do Tailwind para display (ex: 'hidden'), ajuste aqui:
        // content.classList.add('hidden');
    });

    // 2. Reseta o estilo de todos os botões para o estado "inativo"
    const allButtons = document.querySelectorAll('.tab-btn');
    allButtons.forEach(btn => {
        // Remove classes de ativo
        btn.classList.remove('active', 'text-sky-600', 'border-b-2', 'border-sky-600');
        // Adiciona classes de inativo (texto cinza)
        btn.classList.add('text-slate-500');
    });

    // 3. Mostra o conteúdo da aba selecionada
    const targetContent = document.getElementById(tabName);
    if (targetContent) {
        targetContent.classList.add('active');
        // Se usar tailwind para display: targetContent.classList.remove('hidden');
    }

    // 4. Estiliza o botão clicado como "ativo"
    const targetBtn = document.getElementById('btn-' + tabName);
    if (targetBtn) {
        targetBtn.classList.remove('text-slate-500'); // Remove cinza
        targetBtn.classList.add('active', 'text-sky-600', 'border-b-2', 'border-sky-600'); // Adiciona azul e borda
    }
}

/**
 * Copia o conteúdo do bloco de código SQL para a área de transferência
 */

function copySql() {
    const codeElement = document.querySelector('code');
    if (!codeElement) return;

    const codeText = codeElement.innerText;

    navigator.clipboard.writeText(codeText).then(() => {
        // Feedback visual simples (opcional: mudar o texto do botão temporariamente)
        const btn = document.querySelector('button[onclick="copySql()"]');
        const originalText = btn.innerHTML;

        btn.innerHTML = '<i class="ph ph-check"></i> Copiado!';
        setTimeout(() => {
            btn.innerHTML = originalText;
        }, 2000);

    }).catch(err => {
        console.error('Erro ao copiar: ', err);
        alert('Não foi possível copiar o texto automaticamente.');
    });
}

// Inicializa o Highlight.js se ele estiver carregado na página
document.addEventListener('DOMContentLoaded', (event) => {
    if (typeof hljs !== 'undefined') {
        hljs.highlightAll();
    }

    // Versão do Sistema
    const versaoSistema = document.getElementById('versao-sistema');
    if (versaoSistema) {
        versaoSistema.innerText = 'v1.0.1';
    }


    /* ==========================================================================
           LÓGICA DE BUSCA DA SIDEBAR
    ========================================================================== */
    
    const searchInput = document.getElementById('sidebar-search');
    
    if (searchInput) {
        searchInput.addEventListener('input', function (e) {
            const term = e.target.value.toLowerCase().trim();
            const nav = document.querySelector('aside nav');
    
            // Prepara elemento de "Não encontrado" (Lazy creation)
            let noResultsMsg = document.getElementById('sidebar-no-results');
            if (!noResultsMsg && nav) {
                noResultsMsg = document.createElement('div');
                noResultsMsg.id = 'sidebar-no-results';
                noResultsMsg.className = 'hidden px-4 py-8 text-sm text-slate-500 text-center flex flex-col items-center gap-2 animate-fade-in';
                noResultsMsg.innerHTML = `
                        <i class="ph ph-magnifying-glass text-2xl mb-1 opacity-50"></i>
                        <p>Não foi possível achar essa query, tente novamente ou seja mais específico.</p>
                    `;
                nav.appendChild(noResultsMsg);
            }
    
            // --- ESTADO 1: LIMPAR BUSCA (Restaurar padrão) ---
            if (term === '') {
                // Esconde mensagem de erro se existir
                if (noResultsMsg) noResultsMsg.classList.add('hidden');
    
                // 1. Remove classe 'hidden' de tudo que foi filtrado
                nav.querySelectorAll('.hidden').forEach(el => {
                    // Simplificação: Reexibe os itens principais (li), reexibe o link de Visão Geral
                    // Ignora o elemento de 'no results' para não mostrá-lo acidentalmente
                    if (el.id !== 'sidebar-no-results' && (el.tagName === 'LI' || (el.tagName === 'DIV' && el.parentElement === nav))) {
                        el.classList.remove('hidden');
                    }
                });
    
                // 2. Garante que os submenus se fechem para limpar a view
                nav.querySelectorAll('[id^="submenu-"]').forEach(sub => sub.classList.add('hidden'));
    
                // 3. Reseta os ícones chevron
                nav.querySelectorAll('.ph-caret-down').forEach(icon => icon.classList.remove('rotate-180'));
    
                // 4. Garante que os links internos dos submenus estejam "prontos" para aparecer
                nav.querySelectorAll('.submenu-link').forEach(link => link.classList.remove('hidden'));
    
                // 5. Garante que Visão Geral apareça
                const visaoGeral = nav.querySelector('a[href*="index.html"]')?.parentElement;
                if (visaoGeral) visaoGeral.classList.remove('hidden');
    
                return;
            }
    
            // --- ESTADO 2: FILTRANDO ---
            let hasResults = false; // Flag para controlar se achamos algo
    
            // 1. Ocultar TUDO inicialmente (Top Level)
            // Visão Geral
            const visaoGeralContainer = nav.querySelector('a[href*="index.html"]')?.parentElement;
            if (visaoGeralContainer) visaoGeralContainer.classList.add('hidden');
    
            // Todos os itens de lista (LIs)
            nav.querySelectorAll('li').forEach(li => li.classList.add('hidden'));
    
            // Ocultar links individuais de submenu
            nav.querySelectorAll('.submenu-link').forEach(link => link.classList.add('hidden'));
    
            // 2. Verificar correspondências e reexibir
    
            // A) Verificar Visão Geral
            const visaoGeralLink = nav.querySelector('a[href*="index.html"]');
            if (visaoGeralLink && visaoGeralLink.innerText.toLowerCase().includes(term)) {
                visaoGeralContainer.classList.remove('hidden');
                hasResults = true;
            }
    
            // B) Verificar LIs (Itens principais e Submenus)
            nav.querySelectorAll('li').forEach(li => {
                let showLi = false;
    
                // Checa o link/botão principal do LI
                const mainLink = li.querySelector('.sidebar-link');
                if (mainLink && mainLink.innerText.toLowerCase().includes(term)) {
                    showLi = true;
    
                    const submenu = li.querySelector('[id^="submenu-"]');
                    if (submenu) {
                        submenu.classList.remove('hidden');
                        submenu.querySelectorAll('.submenu-link').forEach(sl => sl.classList.remove('hidden'));
                        const chevron = li.querySelector('.ph-caret-down');
                        if (chevron) chevron.classList.add('rotate-180');
                    }
                }
    
                // Checa os filhos do submenu individualmente
                const subLinks = li.querySelectorAll('.submenu-link');
                subLinks.forEach(subLink => {
                    if (subLink.innerText.toLowerCase().includes(term)) {
                        showLi = true;
                        subLink.classList.remove('hidden');
    
                        const submenu = subLink.closest('[id^="submenu-"]');
                        if (submenu) submenu.classList.remove('hidden');
    
                        const chevron = li.querySelector('.ph-caret-down');
                        if (chevron) chevron.classList.add('rotate-180');
                    }
                });
    
                if (showLi) {
                    li.classList.remove('hidden');
                    hasResults = true;
                }
            });
    
            // 3. Exibir ou Ocultar mensagem de "Não encontrado"
            if (noResultsMsg) {
                if (!hasResults) {
                    noResultsMsg.classList.remove('hidden');
                } else {
                    noResultsMsg.classList.add('hidden');
                }
            }
        });
    }
});


