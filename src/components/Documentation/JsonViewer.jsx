import { useState, useEffect, useRef } from 'react';
import { WarningIcon, SpinnerGapIcon, CopyIcon, CheckIcon, BracketsCurlyIcon } from "@phosphor-icons/react";
import hljs from 'highlight.js';
import 'highlight.js/styles/atom-one-dark.css';

export const JsonViewer = ({ filePath }) => {
    const [code, setCode] = useState("");
    const [copied, setCopied] = useState(false);
    const [isError, setIsError] = useState(false);
    const [isVisible, setIsVisible] = useState(false);

    const codeRef = useRef(null);

    useEffect(() => {
        setIsVisible(false);
        setIsError(false);

        const timeoutId = setTimeout(() => {
            fetch(filePath)
                .then(response => {
                    if (!response.ok) throw new Error("Arquivo não encontrado");
                    return response.text();
                })
                .then(text => {
                    // Validação de erro do Vite (retorna HTML 404 em vez de erro)
                    if (text.trim().startsWith("<!DOCTYPE html>") || text.trim().startsWith("<html")) {
                        throw new Error("Arquivo inválido (404 HTML)");
                    }

                    // Tenta formatar o JSON para ficar bonito (Indentation: 2 espaços)
                    try {
                        const jsonObject = JSON.parse(text);
                        const formattedJson = JSON.stringify(jsonObject, null, 2);
                        setCode(formattedJson);
                    } catch (e) {
                        // Se não for um JSON válido, mostra o texto cru mesmo
                        setCode(text);
                    }
                })
                .catch(err => {
                    setIsError(true);
                    setCode(`// Erro ao carregar: ${filePath}\n// Detalhe: ${err.message}`);
                });
        }, 150);

        return () => clearTimeout(timeoutId);
    }, [filePath]);

    // Aplica o Highlight (Agora com language-json)
    useEffect(() => {
        if (codeRef.current && code) {
            const el = codeRef.current;
            delete el.dataset.highlighted;

            // Define explicitamente como JSON para o highlight.js
            el.className = 'language-json';
            hljs.highlightElement(el);

            setTimeout(() => {
                setIsVisible(true);
            }, 50);
        }
    }, [code]);

    const handleCopy = () => {
        navigator.clipboard.writeText(code);
        setCopied(true);
        setTimeout(() => setCopied(false), 2000);
    };

    return (
        <div className="relative group mt-4">

            {/* Botão de Copiar */}
            <button
                onClick={handleCopy}
                className={`absolute top-4 right-4 bg-slate-700 hover:bg-slate-600 text-white text-xs px-3 py-1.5 rounded flex items-center gap-2 transition-all duration-200 z-10 ${isVisible ? 'opacity-0 group-hover:opacity-100' : 'opacity-0'}`}
            >
                {copied ? <CheckIcon size={14} /> : <CopyIcon size={14} />}
                {copied ? "Copiado!" : "Copiar"}
            </button>

            <div className={`code-block bg-[#282c34] rounded-lg overflow-hidden border transition-colors duration-300 ${isError ? 'border-red-500' : 'border-slate-700'} min-h-[100px] relative`}>

                {/* Loading Spinner */}
                <div className={`absolute inset-0 flex items-center justify-center transition-opacity duration-300 ${isVisible ? 'opacity-0 pointer-events-none' : 'opacity-100'}`}>
                    <SpinnerGapIcon size={32} className="text-slate-500 animate-spin" />
                </div>

                {/* Mensagem de Erro */}
                {isError && isVisible && (
                    <div className="bg-red-500/10 text-red-400 text-xs px-4 py-2 border-b border-red-500/20 flex items-center gap-2 animate-fade-in">
                        <WarningIcon size={16} /> Falha no carregamento
                    </div>
                )}

                {/* Bloco de Código */}
                <pre className={`m-0 p-4 pt-6 text-sm overflow-x-auto custom-scrollbar transition-opacity duration-500 ease-in-out ${isVisible ? 'opacity-100' : 'opacity-0'}`}>
                    <code ref={codeRef} className="language-json font-mono shadow-none bg-transparent block">
                        {code}
                    </code>
                </pre>
            </div>
        </div>
    );
};