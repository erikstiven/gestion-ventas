import { useEffect, useState } from "react";
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

export default function SalesPage() {
  const { items, page, per_page, total, loading, fetch, remove } = useSales();
  const [filters, setFilters] = useState({
    search: "",
    start_date: "",
    end_date: "",
    year: "",
  });

  const [open, setOpen] = useState(false);
  const [toDelete, setToDelete] = useState<number | null>(null);

  useEffect(() => {
    fetch();
  }, []);

  return (
    <>
      <Card>
        <CardHeader>
          <h1 className="text-2xl font-semibold">Ventas</h1>

          {/* Corrección: grid consistente para filtros + botón a la derecha */}
          <div className="grid gap-2 sm:grid-cols-6 items-center">
            <div className="relative sm:col-span-2">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-zinc-400" />
              <Input
                className="pl-8"
                placeholder="Buscar cliente/vendedor"
                value={filters.search}
                onChange={(e) => setFilters((f) => ({ ...f, search: e.target.value }))}
              />
            </div>

            <Input
              type="date"
              value={filters.start_date}
              onChange={(e) => setFilters((f) => ({ ...f, start_date: e.target.value }))}
            />
            <Input
              type="date"
              value={filters.end_date}
              onChange={(e) => setFilters((f) => ({ ...f, end_date: e.target.value }))}
            />
            <Input
              type="number"
              placeholder="Año"
              value={filters.year}
              onChange={(e) => setFilters((f) => ({ ...f, year: e.target.value }))}
            />

            <Button variant="outline" onClick={() => fetch(filters)}>
              Filtrar
            </Button>

            <div className="sm:col-span-6 text-right">
              <Button onClick={() => setOpen(true)}>
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
                  <Td>{r.fecha}</Td>
                  <Td>${(r.monto_total as any)?.toFixed?.(2) ?? r.monto_total}</Td>
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
            onPage={(p) => fetch({ ...filters, page: p })}
          />
        </CardContent>
      </Card>

      <Modal open={open} onOpenChange={setOpen} title="Nueva venta">
        <SaleForm
          onDone={() => {
            setOpen(false);
            fetch();
          }}
        />
      </Modal>

      <Modal open={toDelete != null} onOpenChange={() => setToDelete(null)} title="Eliminar venta">
        <p className="text-sm text-zinc-600">¿Seguro que deseas eliminar esta venta?</p>
        <div className="mt-4 flex justify-end gap-2">
          <Button variant="outline" onClick={() => setToDelete(null)}>
            Cancelar
          </Button>
          <Button
            variant="danger"
            onClick={async () => {
              if (toDelete != null) {
                await remove(toDelete);
                setToDelete(null);
              }
            }}
          >
            Eliminar
          </Button>
        </div>
      </Modal>
    </>
  );
}
