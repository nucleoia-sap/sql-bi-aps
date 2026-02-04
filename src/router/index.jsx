import { HashRouter, Route, Routes } from "react-router";
import { Home } from "../pages/Home";
import { Query_QuemSomos } from "../pages/Query_QuemSomos";
import { DefaultLayout } from "../layouts/DefaultLayout";
import { Query_AQuemServimos } from "../pages/Query_QuemServimos";
import { Query_Hanseniase } from "../pages/Query_Hanseniase";
import { Query_Siaps } from "../pages/Query_Siaps";
import { Building } from "../pages/Building";
import { Query_Tuberculose } from "../pages/Query_QS_PCE_TB";
import { Query_QuemSomos_Unidades } from "../pages/Query_QuemSomos_Unidades";
import { Query_QuemSomos_Medicos_PMM_PMPB } from "../pages/Query_QuemSomos_Medicos_PMM_PMPB";
import { Query_QuemSomos_Construcao_Do_Mapa } from "../pages/Query_QuemSomos_Construcao_Do_Mapa/index.jsx";
import { Query_QuemSomos_InfoAuxiliares } from "../pages/Query_QuemSomos_InfoAuxiliares/index.jsx";
import { Query_QuemSomos_Profissionais_esf } from "../pages/Query_QuemSomos_Profissionais_esf/index.jsx";
import { Query_QuemSomos_TurnOver } from "../pages/Query_QuemSomos_TurnOver/index.jsx";

export const AppRouter = () => {
    return (
        <HashRouter>
            <Routes>

                <Route path="/documentacao" element={<DefaultLayout />}>

                    <Route path="quem-somos">
                        <Route path="unidades" element={<Query_QuemSomos_Unidades/>}></Route>
                        <Route path="medicos-pmm-pmpb" element={<Query_QuemSomos_Medicos_PMM_PMPB />}></Route>
                        <Route path="construcao-do-mapa" element={<Query_QuemSomos_Construcao_Do_Mapa />}></Route>
                        <Route path="info-auxiliares" element={<Query_QuemSomos_InfoAuxiliares />}></Route>
                        <Route path="profissionais-esf" element={<Query_QuemSomos_Profissionais_esf />}></Route>
                        <Route path="turnover" element={<Query_QuemSomos_TurnOver/>}></Route>
                    </Route>

                    {/* --- GRUPO: A QUEM SERVIMOS --- */}
                    <Route path="a-quem-servimos">

                        {/* 1. Quando o usuário acessar exato "/documentacao/a-quem-servimos" */}
                        <Route index element={<Query_AQuemServimos />} />

                        {/* 2. Subgrupo PCE */}
                        <Route path="pce">
                            {/* Rota final: /documentacao/a-quem-servimos/pce/hanseniase */}
                            <Route path="hanseniase" element={<Query_Hanseniase />} />

                            {/* Futuras rotas */}
                            <Route path="tuberculose" element={<Query_Tuberculose />} />
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