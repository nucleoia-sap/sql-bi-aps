import { Outlet } from "react-router"; // ou 'react-router-dom'
import { Sidebar } from "../components/Sidebar";

export function DefaultLayout() {
    return (
        <div className="flex h-screen bg-slate-50 overflow-hidden">
            <Sidebar />

            {/* Área de conteúdo variável */}
            <main className="flex-1 overflow-y-auto relative w-full">
                {/* O Outlet renderiza a página que estiver na rota atual (QuemSomos, Hanseniase, etc) */}
                <Outlet />
            </main>
        </div>
    );
}