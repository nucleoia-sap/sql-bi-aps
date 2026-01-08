document.addEventListener('DOMContentLoaded', () => {
    // Aqui define quais arquivos essa página específica vai usar

    // A chave (ex: 'esf') deve bater com o id do HTML (id="code-esf")
    initSqlLoader({
        hanseniase: '../assets/sql/hanseniase/hanseniase.sql'
    });
});