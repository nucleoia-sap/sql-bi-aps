document.addEventListener('DOMContentLoaded', () => {
    // Aqui define quais arquivos essa página específica vai usar

    // A chave (ex: 'esf') deve bater com o id do HTML (id="code-esf")
    initSqlLoader({
        quem_somos: '../assets/sql/QUEM_SOMOS/quem_somos.sql'
    });
});