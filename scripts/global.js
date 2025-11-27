// scripts globais de cada página

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
});
