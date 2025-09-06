// src/pages/DashboardPage.tsx
import { useEffect, useState, type ReactNode } from 'react';
import api from '../api/client';
import { Card, CardContent, CardHeader } from '../components/ui/card';
import { Table, THead, Th, TBody, Td } from '../components/ui/table';
import Button from '../components/ui/button';
import { Input } from '../components/ui/input';

const fMoney = (n:number) =>
  new Intl.NumberFormat('es-EC', { style:'currency', currency:'USD', minimumFractionDigits:2 }).format(n);

/* ---------- UI helper ---------- */
type FilterBarProps = {
  children: ReactNode;
  onApply: () => void;
  onClear: () => void;
  applyLabel?: string;
};
function FilterBar({ children, onApply, onClear, applyLabel = 'Aplicar' }: FilterBarProps){
  return (
    <div className="flex flex-wrap items-center gap-2">
      <div className="flex flex-wrap items-center gap-2">{children}</div>
      <div className="ml-auto flex items-center gap-2">
        <Button variant="outline" className="h-11 rounded-full px-6" onClick={onApply}>
          {applyLabel}
        </Button>
        <Button variant="outline" className="h-11 rounded-full px-6"  onClick={onClear}>
          Limpiar
        </Button>
      </div>
    </div>
  );
}

/* ---------- helpers ---------- */
const yearsBetween = (a?: number, b?: number): number[] => {
  if (typeof a !== 'number' || typeof b !== 'number') return [];
  const start = Math.min(a, b);
  const end   = Math.max(a, b);
  return Array.from({ length: end - start + 1 }, (_, i) => start + i);
};
const toYear = (v: string): number | undefined => {
  const n = Number(v);
  if (!Number.isInteger(n)) return undefined;
  if (n < 2000 || n > 2100) return undefined;
  return n;
};

export default function DashboardPage(){
  // datos
  const [zoneSales,   setZoneSales  ] = useState<any[]>([]);
  const [zonesNo,     setZonesNo    ] = useState<any[]>([]);
  const [sellersNo,   setSellersNo  ] = useState<any[]>([]);
  const [clientSales, setClientSales] = useState<any[]>([]);

  // (2) y (3): FILTRO POR AÑOS
  const [noSalesYears, setNoSalesYears] = useState({ startYear:'', endYear:'' });

  // (4) Ventas por cliente: años
  const [clientYearsInput, setClientYearsInput] = useState({ startYear:'', endYear:'' });

  // Paginación “ventas por cliente”
  const [clientPage, setClientPage] = useState(1);
  const clientPageSize = 10;

  // Toggle “Top 10 / Ver todo” para (1)
  const [showAllZones, setShowAllZones] = useState(false);

  useEffect(() => { loadReports(); }, []);

  async function loadReports(overrides?: {
    noSalesStartYear?: string; noSalesEndYear?: string;
    clientStartYear?: string; clientEndYear?: string;
  }){
    const nsStartY = overrides?.noSalesStartYear ?? noSalesYears.startYear;
    const nsEndY   = overrides?.noSalesEndYear   ?? noSalesYears.endYear;

    const cStartY = overrides?.clientStartYear ?? clientYearsInput.startYear;
    const cEndY   = overrides?.clientEndYear   ?? clientYearsInput.endYear;

    const qs = (o:Record<string,string>) => {
      const q = new URLSearchParams();
      Object.entries(o).forEach(([k,v]) => { if (v) q.set(k,v); });
      return q.toString() ? `?${q.toString()}` : '';
    };

    // (1) Zonas con más ventas por vendedor — SIN filtros
    const z1 = await api.get(`/reports/ventas-por-zona-por-vendedor`);
    setZoneSales(z1.data?.data ?? z1.data ?? []);

    // (2) y (3): por AÑOS -> convierto a start_date/end_date
    const yA = toYear(nsStartY);
    const yB = toYear(nsEndY);
    if (typeof yA === 'number' && typeof yB === 'number') {
      const start_date = `${Math.min(yA,yB)}-01-01`;
      const end_date   = `${Math.max(yA,yB)}-12-31`;
      const [z2, z3] = await Promise.all([
        api.get(`/reports/zonas-sin-ventas${qs({ start_date, end_date })}`),
        api.get(`/reports/vendedores-sin-ventas${qs({ start_date, end_date })}`)
      ]);
      setZonesNo  (z2.data?.data ?? z2.data ?? []);
      setSellersNo(z3.data?.data ?? z3.data ?? []);
    } else {
      setZonesNo([]); setSellersNo([]);
    }

    // (4) Ventas por cliente — por AÑO
    const y1 = toYear(cStartY);
    const y2 = toYear(cEndY);
    if (typeof y1 === 'number' && typeof y2 === 'number') {
      const start_date = `${Math.min(y1,y2)}-01-01`;
      const end_date   = `${Math.max(y1,y2)}-12-31`;
      const r = await api.get(`/reports/ventas-por-cliente${qs({ start_date, end_date })}`);
      setClientSales(r.data?.data ?? r.data ?? []);
      setClientPage(1);
    } else {
      setClientSales([]);
      setClientPage(1);
    }
  }

  const noData = (arr:any[]) => arr.length === 0;

  // Años visibles en la tabla de clientes
  const yStart = toYear(clientYearsInput.startYear);
  const yEnd   = toYear(clientYearsInput.endYear);
  const clientYears = yearsBetween(yStart, yEnd);

  // Paginación clientes
  const clientSlice = clientSales.slice(
    (clientPage - 1) * clientPageSize,
    clientPage * clientPageSize
  );

  return (
    <div className="space-y-8">
      <Card>
        <CardHeader>
          <div className="space-y-1">
            <h1 className="text-2xl font-semibold">Dashboard</h1>
            <p className="text-zinc-600 text-sm">Reportes clave con filtros.</p>
          </div>
        </CardHeader>

        <CardContent className="space-y-8">
          {/* 1) Zonas con más ventas por vendedor (sin filtros) */}
          <section className="space-y-3">
            <div className="flex items-center justify-between">
              <h2 className="text-lg font-semibold">Zonas con más ventas por vendedor</h2>
              {!noData(zoneSales) && zoneSales.length > 10 && (
                <Button
                  variant="outline"
                  className="h-9 rounded-full px-4"
                  onClick={() => setShowAllZones(v => !v)}
                >
                  {showAllZones ? 'Ver top 10' : 'Ver todo'}
                </Button>
              )}
            </div>

            <Table>
              <THead>
                <Th>Zona</Th>
                <Th>Vendedor</Th>
                <Th><div className="text-right">Ventas</div></Th>
                <Th><div className="text-right">Monto</div></Th>
              </THead>
              <TBody>
                {noData(zoneSales) ? (
                  <tr><td colSpan={4} className="text-center py-2">Sin datos</td></tr>
                ) : (
                  (() => {
                    const sorted = [...zoneSales].sort(
                      (a,b) => (b.total_ventas - a.total_ventas) || (b.total_monto - a.total_monto)
                    );
                    const rows = showAllZones ? sorted : sorted.slice(0,10);
                    return rows.map((r:any, i:number) => (
                      <tr key={i} className="border-t">
                        <Td>{r.nombre_zona}</Td>
                        <Td>{r.vendedor}</Td>
                        <Td><div className="text-right">{r.total_ventas}</div></Td>
                        <Td><div className="text-right">{fMoney(Number(r.total_monto))}</div></Td>
                      </tr>
                    ));
                  })()
                )}
              </TBody>
            </Table>
          </section>

          {/* Separador */}
          <div className="h-px bg-zinc-200 my-2" />

          {/* 2) y 3) — Filtro por AÑO */}
          <section className="space-y-4">
            <div className="flex items-center justify-between">
              <h2 className="text-lg font-semibold">Zonas sin ventas y Vendedores sin ventas</h2>
              {toYear(noSalesYears.startYear) && toYear(noSalesYears.endYear) && (
                <span className="text-sm text-zinc-500">
                  Años: {Math.min(Number(noSalesYears.startYear), Number(noSalesYears.endYear))}
                  {' '}→{' '}
                  {Math.max(Number(noSalesYears.startYear), Number(noSalesYears.endYear))}
                </span>
              )}
            </div>

            <FilterBar
              onApply={() => loadReports({
                noSalesStartYear: noSalesYears.startYear,
                noSalesEndYear: noSalesYears.endYear
              })}
              onClear={() => { setNoSalesYears({ startYear:'', endYear:'' }); loadReports({ noSalesStartYear:'', noSalesEndYear:'' }); }}
            >
              <Input
                type="number"
                inputMode="numeric"
                placeholder="Año inicio"
                className="h-11 w-[140px]"
                value={noSalesYears.startYear}
                onChange={e => setNoSalesYears(v => ({ ...v, startYear: e.target.value }))}
              />
              <Input
                type="number"
                inputMode="numeric"
                placeholder="Año fin"
                className="h-11 w-[140px]"
                value={noSalesYears.endYear}
                onChange={e => setNoSalesYears(v => ({ ...v, endYear: e.target.value }))}
              />
            </FilterBar>

            <section className="grid gap-6 md:grid-cols-2">
              {/* Zonas sin ventas */}
              <div className="space-y-3">
                <h3 className="font-medium">Zonas sin ventas</h3>
                <Table>
                  <THead><Th>Zona</Th></THead>
                  <TBody>
                    {!(toYear(noSalesYears.startYear) && toYear(noSalesYears.endYear)) ? (
                      <tr><td className="text-center py-2">Ingrese los años y aplique.</td></tr>
                    ) : noData(zonesNo) ? (
                      <tr><td className="text-center py-2">Sin datos</td></tr>
                    ) : (
                      zonesNo.map((z:any, i:number) => (
                        <tr key={i} className="border-t"><Td>{z.nombre_zona}</Td></tr>
                      ))
                    )}
                  </TBody>
                </Table>
              </div>

              {/* Vendedores sin ventas */}
              <div className="space-y-3">
                <h3 className="font-medium">Vendedores sin ventas</h3>
                <Table>
                  <THead><Th>Vendedor</Th><Th>Email</Th></THead>
                  <TBody>
                    {!(toYear(noSalesYears.startYear) && toYear(noSalesYears.endYear)) ? (
                      <tr><td colSpan={2} className="text-center py-2">Ingrese los años y aplique.</td></tr>
                    ) : noData(sellersNo) ? (
                      <tr><td colSpan={2} className="text-center py-2">Sin datos</td></tr>
                    ) : (
                      sellersNo.map((v:any, i:number) => (
                        <tr key={i} className="border-t">
                          <Td>{v.nombre}</Td>
                          <Td>{v.email}</Td>
                        </tr>
                      ))
                    )}
                  </TBody>
                </Table>
              </div>
            </section>
          </section>

          {/* Separador */}
          <div className="h-px bg-zinc-200 my-2" />

          {/* 4) Ventas por cliente (Años) */}
          <section className="space-y-3">
            <div className="flex items-center gap-3">
              <h2 className="text-lg font-semibold">Ventas por cliente</h2>
            </div>

            <FilterBar
              onApply={() => loadReports({ clientStartYear: clientYearsInput.startYear, clientEndYear: clientYearsInput.endYear })}
              onClear={() => { setClientYearsInput({ startYear:'', endYear:'' }); loadReports({ clientStartYear:'', clientEndYear:'' }); }}
              applyLabel="Aplicar"
            >
              <Input
                type="number"
                inputMode="numeric"
                placeholder="Año inicio"
                className="h-11 w-[140px]"
                value={clientYearsInput.startYear}
                onChange={e => setClientYearsInput(v => ({ ...v, startYear: e.target.value }))}
              />
              <Input
                type="number"
                inputMode="numeric"
                placeholder="Año fin"
                className="h-11 w-[140px]"
                value={clientYearsInput.endYear}
                onChange={e => setClientYearsInput(v => ({ ...v, endYear: e.target.value }))}
              />
            </FilterBar>

            <Table>
              <THead>
                <Th>ID Cliente</Th>
                <Th>Cliente</Th>
                <Th>Zona</Th>
                {yearsBetween(toYear(clientYearsInput.startYear), toYear(clientYearsInput.endYear))
                  .map(y => <Th key={y}><div className="text-right">{y}</div></Th>)}
              </THead>
              <TBody>
                {yearsBetween(toYear(clientYearsInput.startYear), toYear(clientYearsInput.endYear)).length === 0 ? (
                  <tr><td colSpan={4} className="text-center py-2">Ingrese Año inicio y Año fin y presione “Aplicar”.</td></tr>
                ) : (
                  clientSlice.length === 0 ? (
                    <tr><td colSpan={
                      3 + yearsBetween(toYear(clientYearsInput.startYear), toYear(clientYearsInput.endYear)).length
                    } className="text-center py-2">Sin datos</td></tr>
                  ) : (
                    clientSlice.map((r:any, i:number) => (
                      <tr key={i} className="border-t">
                        <Td>{r.id_cliente}</Td>
                        <Td>{r.nombre_cliente}</Td>
                        <Td>{r.zona}</Td>
                        {yearsBetween(toYear(clientYearsInput.startYear), toYear(clientYearsInput.endYear)).map(y => {
                          const val = (r[`y${y}`] ?? (r.ventas?.[String(y)] ?? 0));
                          return <Td key={y}><div className="text-right">{val}</div></Td>;
                        })}
                      </tr>
                    ))
                  )
                )}
              </TBody>
            </Table>

            {clientSales.length > clientPageSize && (
              <div className="flex items-center justify-between pt-1">
                <div className="text-sm text-zinc-600">
                  Mostrando {(clientPage - 1) * clientPageSize + 1}–{Math.min(clientPage * clientPageSize, clientSales.length)} de {clientSales.length}
                </div>
                <div className="flex items-center gap-2">
                  <Button
                    variant="outline"
                    className="h-9 rounded-full px-4"
                    disabled={clientPage === 1}
                    onClick={() => setClientPage(p => Math.max(1, p - 1))}
                  >
                    Anterior
                  </Button>
                  <div className="text-sm">
                    {clientPage} / {Math.max(1, Math.ceil(clientSales.length / clientPageSize))}
                  </div>
                  <Button
                    variant="outline"
                    className="h-9 rounded-full px-4"
                    disabled={clientPage >= Math.ceil(clientSales.length / clientPageSize)}
                    onClick={() => setClientPage(p => Math.min(Math.ceil(clientSales.length / clientPageSize), p + 1))}
                  >
                    Siguiente
                  </Button>
                </div>
              </div>
            )}
          </section>
        </CardContent>
      </Card>
    </div>
  );
}
