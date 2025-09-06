import { BrowserRouter, Routes, Route } from "react-router-dom";
import { Toaster } from "sonner";
import AppLayout from "./layouts/AppLayout";
// Importar las páginas base existentes
import DashboardPage from "./pages/DashboardPage";
import ClientsPage from "./pages/ClientsPage";
import SalesPage from "./pages/SalesPage";
// Importar nuevas páginas
import SellersPage from "./pages/SellersPage";
import ZonesPage from "./pages/ZonesPage";

export default function App() {
  return (
    <BrowserRouter>
      {/* Componente para notificaciones */}
      <Toaster />
      <Routes>
        <Route path="/" element={<AppLayout />}>
          {/* Ruta raíz o dashboard */}
          <Route index element={<DashboardPage />} />
          <Route path="clientes" element={<ClientsPage />} />
          <Route path="ventas" element={<SalesPage />} />
          {/* Rutas de los nuevos módulos */}
          <Route path="vendedores" element={<SellersPage />} />
          <Route path="zonas" element={<ZonesPage />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}