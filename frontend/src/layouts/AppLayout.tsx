import { NavLink, Outlet } from "react-router-dom";

export default function AppLayout(){
  const link = ({isActive}:{isActive:boolean}) =>
    `px-3 py-2 rounded-xl text-sm ${isActive ? "bg-emerald-600 text-white" : "border hover:bg-zinc-50"}`;
  return (
    <div className="min-h-screen">
      <header className="border-b bg-white">
        <div className="mx-auto max-w-6xl px-4 py-3 flex items-center justify-between">
          <div className="font-semibold">Gestión de Ventas</div>
          <nav className="flex gap-2">
            <NavLink to="/" className={link}>Dashboard</NavLink>
            <NavLink to="/clientes" className={link}>Clientes</NavLink>
            <NavLink to="/ventas" className={link}>Ventas</NavLink>
          </nav>
        </div>
      </header>
      <main className="mx-auto max-w-6xl px-4 py-6"><Outlet/></main>
    </div>
  );
}
