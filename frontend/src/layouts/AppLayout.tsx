import { NavLink, Outlet } from "react-router-dom";

/**
 * Diseño base de la aplicación. Define la barra de navegación y un contenedor
 * para renderizar las páginas hijas mediante <Outlet />.
 */
export default function AppLayout() {
  const link = ({ isActive }: { isActive: boolean }) =>
    `px-3 py-2 rounded-xl text-sm ${isActive ? 'bg-emerald-600 text-white' : 'border hover:bg-zinc-50'}`;
  return (
    <div className="container mx-auto py-6">
      <nav className="flex items-center justify-between mb-4">
        <span className="font-bold text-lg">Gestión de Ventas</span>
        <ul className="flex gap-3">
          <li>
            <NavLink to="/" className={link} end>
              Dashboard
            </NavLink>
          </li>
          <li>
            <NavLink to="/clientes" className={link}>
              Clientes
            </NavLink>
          </li>
          <li>
            <NavLink to="/ventas" className={link}>
              Ventas
            </NavLink>
          </li>
          {/* Enlaces extras añadidos como mejora */}
          <li>
            <NavLink to="/vendedores" className={link}>
              Vendedores
            </NavLink>
          </li>
          <li>
            <NavLink to="/zonas" className={link}>
              Zonas
            </NavLink>
          </li>
        </ul>
      </nav>
      <Outlet />
    </div>
  );
}