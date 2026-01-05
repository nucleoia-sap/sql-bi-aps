// componente responsável pela busca

import { MagnifyingGlass } from '@phosphor-icons/react';

export function SidebarSearch({ value, onChange }) {
    return (
        <div className="p-4">
            <div className="relative">
                <MagnifyingGlass className="absolute left-3 top-2.5 text-slate-500" size={16} />
                <input
                    type="text"
                    placeholder="Buscar query..."
                    value={value}
                    onChange={onChange}
                    className="w-full bg-slate-800 text-sm text-slate-200 rounded-md pl-9 pr-4 py-2 focus:outline-none focus:ring-1 focus:ring-sky-500 border border-slate-700 placeholder-slate-500"
                />
            </div>
        </div>
    );
}