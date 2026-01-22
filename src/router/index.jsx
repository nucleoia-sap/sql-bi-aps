import { HashRouter, Route, Routes } from "react-router";
import { Home } from "../pages/Home";
import { Query_QuemSomos } from "../pages/Query_QuemSomos";
import { DefaultLayout } from "../layouts/DefaultLayout";
import { Query_AQuemServimos } from "../pages/Query_QuemServimos";
import { Query_Hanseniase } from "../pages/Query_Hanseniase";
import { Query_Siaps } from "../pages/Query_Siaps";
import { Building } from "../pages/Building";

export const AppRouter = () => {
    return (
        <HashRouter>
            <Routes>

                <Route path="/documentacao" element={<DefaultLayout />}>

                    <Route path="quem-somos" element={<Query_QuemSomos />} />

                    {/* --- GRUPO: A QUEM SERVIMOS --- */}
                    <Route path="a-quem-servimos">

                        {/* 1. Quando o usuário acessar exato "/documentacao/a-quem-servimos" */}
                        <Route index element={<Query_AQuemServimos />} />

                        {/* 2. Subgrupo PCE */}
                        <Route path="pce">
                            {/* Rota final: /documentacao/a-quem-servimos/pce/hanseniase */}
                            <Route path="hanseniase" element={<Query_Hanseniase />} />

                            {/* Futuras rotas */}
                            {/* <Route path="tuberculose" element={} /> */}
                        </Route>

                    </Route>

                    {/* <Route path="o-que-fazemos" element={} /> */}
                    <Route path="nossos-resultados">
                        <Route path="siaps" element={<Query_Siaps />}></Route>
                    </Route>

                </Route>

                <Route path="/">
                    <Route index element={<Home />} />
                </Route>

                    <Route path="*" element={<Building />}></Route>
            </Routes>
        </HashRouter>
    )
}