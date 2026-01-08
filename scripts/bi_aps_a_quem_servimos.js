document.addEventListener('DOMContentLoaded', () => {
    // Aqui define quais arquivos essa página específica vai usar

    // A chave (ex: 'esf') deve bater com o id do HTML (id="code-esf")
    initSqlLoader({
        a_quem_servimos: '../assets/sql/A_QUEM_SERVIMOS/script.sql'
    });
});