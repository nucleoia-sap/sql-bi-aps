document.addEventListener('DOMContentLoaded', () => {
    // Aqui define quais arquivos essa página específica vai usar

    // A chave (ex: 'esf') deve bater com o id do HTML (id="code-esf")
    initSqlLoader({
        esf: '../assets/sql/SIAPS/siaps_esf.sql',
        esb: '../assets/sql/SIAPS/siaps_esb.sql',
        emulti: '../assets/sql/SIAPS/siaps_emulti.sql'
    });
});

// Mapeamento das tabelas
const tableNamesMap = {
    'esf': 'rj-sms-sandbox.sub_pav_us.siaps_consolidado',
    'esb': 'rj-sms-sandbox.sub_pav_us.siaps_consolidado_esb',
    'emulti': 'rj-sms-sandbox.sub_pav_us.siaps_consolidado_emulti'
};

// Lista para rotação
const rotationList = [
    'rj-sms-sandbox.sub_pav_us.siaps_consolidado',
    'rj-sms-sandbox.sub_pav_us.siaps_consolidado_esb',
    'rj-sms-sandbox.sub_pav_us.siaps_consolidado_emulti'
];

let currentIndex = 0;
let rotationInterval = null;
let isRotating = true; // Flag para saber se a rotação está ativa

// Função para atualizar o texto com fade
function updateTableDisplay(text) {
    const display = document.getElementById('tableNameDisplay');
    // Fade Out
    display.style.opacity = '0';
    // Aguarda a transição
    setTimeout(() => {
        display.innerText = text;
        // Fade In
        display.style.opacity = '1';
    }, 500); // 500ms corresponde a duration-500 do CSS
}

// Inicia o loop automático
function startRotation() {
    if (rotationInterval) clearInterval(rotationInterval);
    isRotating = true;
    document.getElementById('animationIndicator').classList.remove('hidden'); // Mostra indicador

    rotationInterval = setInterval(() => {
        currentIndex = (currentIndex + 1) % rotationList.length;
        updateTableDisplay(rotationList[currentIndex]);
    }, 4000); // Troca a cada 4 segundos
}

// Para o loop manual
function stopRotation() {
    if (rotationInterval) {
        clearInterval(rotationInterval);
        rotationInterval = null;
    }
    isRotating = false;
    document.getElementById('animationIndicator').classList.add('hidden'); // Esconde indicador
}

// Iniciar rotação ao carregar
window.addEventListener('load', startRotation);