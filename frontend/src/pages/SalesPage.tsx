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

  // solo lo necesario: search + year
  const [filters, setFilters] = useState({
    search: "",
    year: "",
  });

  const [open, setOpen] = useState(false);
  const [toDelete, setToDelete] = useState<number | null>(null);

  useEffect(() => {
    fetch();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const onFilter = () => fetch({ page: 1, ...filters });
  const onClear = () => {
    const reset = { search: "", year: "" };
    setFilters(reset);
    fetch({ page: 1, ...reset });
  };

  const onDelete = async () => {
    if (toDelete == null) return;
    try {
      await remove(toDelete);
      toast.success("Venta eliminada");
      fetch({ page, ...filters });
    } catch (e: any) {
      toast.error(e?.message ?? "No se pudo eliminar");
    } finally {
      setToDelete(null);
    }
  };

  return (
    <>
      <Card>
        <CardHeader>
          <h1 className="text-2xl font-semibold">Ventas</h1>

          {/* Toolbar en una sola fila (como Clientes) */}
          <div className="flex items-center gap-2 flex-nowrap">
            {/* Buscador compacto */}
            <div className="relative">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-zinc-400" />
              <Input
                className="pl-8 w-56 h-11"
                placeholder="Buscar cliente/vendedor"
                value={filters.search}
                onChange={(e) =>
                  setFilters((f) => ({ ...f, search: e.target.value }))
                }
                onKeyDown={(e) => {
                  if (e.key === "Enter") onFilter();
                  if (e.key === "Escape") onClear();
                }}
              />
            </div>

            {/* Año únicamente */}
            <Input
              type="number"
              className="h-11 w-[100px] text-center"
              placeholder="Año"
              value={filters.year}
              onChange={(e) =>
                setFilters((f) => ({ ...f, year: e.target.value }))
              }
            />

            {/* Acciones */}
            <Button
              variant="outline"
              className="h-11 rounded-full px-5"
              onClick={onFilter}
              disabled={loading}
            >
              Filtrar
            </Button>
            <Button
              variant="outline"
              className="h-11 rounded-full px-5"
              onClick={onClear}
              disabled={loading && filters.search === "" && filters.year === ""}
            >
              Limpiar
            </Button>

            {/* Nueva a la derecha */}
            <div className="ml-auto">
              <Button className="h-11 rounded-full px-7" onClick={() => setOpen(true)}>
                <Plus className="mr-2 h-4 w-4" />
                Nueva
              </Button>
            </div>
          </div>
        </CardHeader>

        <CardContent>
          {loading && <div className="mb-2 text-sm text-zinc-500">Cargando…</div>}

          <Table>
            <THead>
              <Th>ID</Th>
              <Th>Fecha</Th>
              <Th>Total</Th>
              <Th>Cliente</Th>
              <Th>Vendedor</Th>
              <Th>Zona</Th>
              <Th children={undefined} />
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

          <Pagination
            page={page}
            perPage={per_page}
            total={total}
            onPage={(p) => fetch({ page: p, ...filters })}
          />
        </CardContent>
      </Card>

      {/* Crear / Editar */}
      <Modal open={open} onOpenChange={setOpen} title="Nueva venta">
        <SaleForm
          onDone={() => {
            setOpen(false);
            fetch({ page: 1, ...filters });
          }}
        />
      </Modal>

      {/* Eliminar */}
      <Modal
        open={toDelete != null}
        onOpenChange={() => setToDelete(null)}
        title="Eliminar venta"
      >
        <p className="text-sm text-zinc-600">
          ¿Seguro que deseas eliminar esta venta?
        </p>
        <div className="mt-4 flex justify-end gap-2">
          <Button variant="outline" onClick={() => setToDelete(null)}>
            Cancelar
          </Button>
          <Button variant="danger" onClick={onDelete}>
            Eliminar
          </Button>
        </div>
      </Modal>
    </>
  );
}
