import { useNavigate, Link } from "react-router";
import { HammerIcon, ArrowLeftIcon, InfoIcon } from "@phosphor-icons/react";
import { Sidebar } from "../../components/Sidebar";

export function Building() {
    const navigate = useNavigate();

    return (
        <div className="flex h-screen">
            <Sidebar />
            <div className="flex-1 flex flex-col items-center justify-center p-6 bg-white relative overflow-hidden h-full min-h-[80vh]">

                {/* --- CSS da Animação Flutuante (Injetado localmente para garantir funcionamento) --- */}
                <style>{`
                @keyframes float {
                    0% { transform: translateY(0px); }
                    50% { transform: translateY(-20px); }
                    100% { transform: translateY(0px); }
                }
                .animate-float {
                    animation: float 4s ease-in-out infinite;
                }
            `}</style>

                {/* --- Elementos Decorativos de Fundo --- */}
                <div className="absolute top-0 right-0 w-96 h-96 bg-sky-50 rounded-full blur-3xl -mr-48 -mt-48 opacity-60 pointer-events-none"></div>
                <div className="absolute bottom-0 left-0 w-96 h-96 bg-slate-50 rounded-full blur-3xl -ml-48 -mb-48 opacity-60 pointer-events-none"></div>

                {/* --- Conteúdo Central --- */}
                <div className="relative z-10 text-center max-w-lg">

                    {/* Ilustração/Ícone Animado */}
                    <div className="flex justify-center mb-8">
                        <div className="relative">
                            <div className="absolute inset-0 bg-sky-100 rounded-full scale-150 blur-2xl opacity-50 animate-pulse"></div>
                            <div className="bg-white border-4 border-slate-50 shadow-2xl rounded-3xl p-8 animate-float relative z-10">
                                <HammerIcon size={72} weight="fill" className="text-sky-500" />
                            </div>
                        </div>
                    </div>

                    {/* Textos */}
                    <h2 className="text-3xl font-bold text-slate-900 mb-4">Módulo em Construção</h2>
                    <p className="text-slate-500 text-lg leading-relaxed mb-10">
                        Esta Query ainda não foi finalizada ou está em fase inicial de desenvolvimento. Nossa equipe está
                        trabalhando para disponibilizar estes dados o mais breve possível.
                    </p>

                    {/* Ações */}
                    <div className="flex flex-col sm:flex-row items-center justify-center gap-4">
                        <button
                            onClick={() => navigate(-1)}
                            className="flex items-center gap-2 bg-slate-900 text-white px-8 py-3 rounded-xl font-semibold hover:bg-slate-800 transition-all shadow-lg hover:shadow-slate-200 active:scale-95 w-full sm:w-auto justify-center"
                        >
                            <ArrowLeftIcon size={20} weight="bold" /> Voltar à página anterior
                        </button>

                        <Link
                            to="/"
                            className="flex items-center gap-2 text-slate-500 hover:text-sky-600 px-8 py-3 rounded-xl font-medium transition-colors w-full sm:w-auto justify-center"
                        >
                            Ir para o Início
                        </Link>
                    </div>
                </div>

                {/* --- Footer da Página --- */}
                <div className="absolute bottom-8 text-slate-400 text-sm flex items-center gap-2">
                    <InfoIcon size={16} />
                    Acompanhe as atualizações na página inicial.
                </div>
            </div>
        </div>
    );
}