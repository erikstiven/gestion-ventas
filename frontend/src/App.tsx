import { BrowserRouter, Routes, Route } from "react-router-dom";
import AppLayout from "./layouts/AppLayout";
import DashboardPage from "./pages/DashboardPage";
import ClientsPage from "./pages/ClientsPage";
import SalesPage from "./pages/SalesPage";

export default function App(){
  return (
    <BrowserRouter>
      <Routes>
        <Route element={<AppLayout/>}>
          <Route path="/" element={<DashboardPage/>}/>
          <Route path="/clientes" element={<ClientsPage/>}/>
          <Route path="/ventas" element={<SalesPage/>}/>
        </Route>
      </Routes>
    </BrowserRouter>
  );
}
