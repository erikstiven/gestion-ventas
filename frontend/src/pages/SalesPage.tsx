import { useEffect, useState } from "react";
import { toast } from "sonner";
import { useSales } from "../stores/useSales";
import type { Sale } from "../stores/useSales";

import { Card, CardContent, CardHeader } from "../components/ui/card";
import Button from "../components/ui/button";
import { Input } from "../components/ui/input";
import Modal from "../components/ui/dialog";
import { Table, THead, Th, TBody, Td } from "../components/ui/table";
import Pagination from "../components/Pagination";
import SaleForm from "./sales/SaleForm";
import { Trash2, Plus, Search } from "lucide-react";

const fDate = (iso: string) => {
  const d = new Date(iso);
  return isNaN(d.getTime()) ? iso : d.toLocaleDateString("es-EC");
};
const fMoney = (n: number) =>
  new Intl.NumberFormat("es-EC", { style: "currency", currency: "USD" }).format(n);

export default function SalesPage() {
  const { items, page, per_page, total, loading, fetch, remove } = useSales();
  const [filters, setFilters] = useState({ search: "", start_date: "", end_date: "", year: "" });
  const [open, setOpen] = useState(false);
  const [toDelete, setToDelete] = useState<number | null>(null);

  useEffect(() => { fetch(); }, []);

  const onFilter = () => fetch(filters);
  const onClear = () => { setFilters({ search: "", start_date: "", end_date: "", year: "" }); fetch({ page: 1 }); };

  const onDelete = async () => {
    if (toDelete == null) return;
    try { await remove(toDelete); toast.success("Venta eliminada"); }
    catch (e: any) { toast.error(e?.message ?? "No se pudo eliminar"); }
    finally { setToDelete(null); }
  };

  return (
    <>
      <Card>
        <CardHeader>
          <h1 className="text-2xl font-semibold">Ventas</h1>

          {/* Toolbar compacta en una sola línea (estilo “píldora”) */}
          <div className="flex flex-wrap items-center gap-2">
            {/* buscador flexible pero con límites para que quepa todo */}
            <div className="relative flex-1 min-w-[300px] max-w-[560px]">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-zinc-400" />
              <Input
                className="pl-8 h-11"
                placeholder="Buscar cliente/vendedor"
                value={filters.search}
                onChange={(e) => setFilters(f => ({ ...f, search: e.target.value }))}
              />
            </div>

            {/* fechas y año con ancho fijo */}
            <Input type="date" className="h-11 w-[160px]"
              value={filters.start_date} onChange={(e) => setFilters(f => ({ ...f, start_date: e.target.value }))} />
            <Input type="date" className="h-11 w-[160px]"
              value={filters.end_date} onChange={(e) => setFilters(f => ({ ...f, end_date: e.target.value }))} />
            <Input type="number" className="h-11 w-[110px]" placeholder="Año"
              value={filters.year} onChange={(e) => setFilters(f => ({ ...f, year: e.target.value }))} />

            {/* acciones: mismo estilo y altura */}
            <Button variant="outline" className="h-11 rounded-full px-6" onClick={onFilter}>Filtrar</Button>
            <Button variant="outline" className="h-11 rounded-full px-6" onClick={onClear}>Limpiar</Button>

            {/* “Nueva” pegada a la derecha */}
            <div className="ml-auto">
              <Button className="h-11 rounded-full px-7" onClick={() => setOpen(true)}>
                <Plus className="mr-2 h-4 w-4" /> Nueva
              </Button>
            </div>
          </div>
        </CardHeader>

        <CardContent>
          {loading && <div className="mb-2 text-sm text-zinc-500">Cargando…</div>}

          <Table>
            <THead>
              <Th>ID</Th><Th>Fecha</Th><Th>Total</Th><Th>Cliente</Th><Th>Vendedor</Th><Th>Zona</Th><Th children={undefined}/>
            </THead>
            <TBody>
              {items.map((r: Sale) => (
                <tr key={r.id} className="border-t">
                  <Td>{r.id}</Td>
                  <Td>{fDate(r.fecha)}</Td>
                  <Td>{fMoney(Number(r.monto_total))}</Td>
                  <Td>{r.cliente?.nombre}</Td>
                  <Td>{r.vendedor?.nombre}</Td>
                  <Td>{r.zona?.nombre}</Td>
                  <Td>
                    <div className="flex justify-end">
                      <Button variant="danger" onClick={() => setToDelete(r.id)}>
                        <Trash2 className="h-4 w-4" />
                      </Button>
                    </div>
                  </Td>
                </tr>
              ))}
            </TBody>
          </Table>

          <Pagination page={page} perPage={per_page} total={total}
            onPage={(p) => fetch({ ...filters, page: p })} />
        </CardContent>
      </Card>

      <Modal open={open} onOpenChange={setOpen} title="Nueva venta">
        <SaleForm onDone={() => { setOpen(false); fetch(); }} />
      </Modal>

      <Modal open={toDelete != null} onOpenChange={() => setToDelete(null)} title="Eliminar venta">
        <p className="text-sm text-zinc-600">¿Seguro que deseas eliminar esta venta?</p>
        <div className="mt-4 flex justify-end gap-2">
          <Button variant="outline" onClick={() => setToDelete(null)}>Cancelar</Button>
          <Button variant="danger" onClick={onDelete}>Eliminar</Button>
        </div>
      </Modal>
    </>
  );
}
