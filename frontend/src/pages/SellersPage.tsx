import { useEffect, useState } from "react";
import { toast } from "sonner";
import { useSellers } from "../stores/useSellers";
import type { Seller } from "../stores/useSellers";

import { Card, CardContent, CardHeader } from "../components/ui/card";
import Button from "../components/ui/button";
import { Input } from "../components/ui/input";
import Modal from "../components/ui/dialog";
import { Table, THead, Th, TBody, Td } from "../components/ui/table";
import Pagination from "../components/Pagination";
import SellerForm from "./sellers/SellerForm";
import { Pencil, Trash2, Plus, Search } from "lucide-react";

export type SellerRow = Seller;

export default function SellersPage() {
  const { items, page, per_page, total, loading, fetch, remove } = useSellers();

  const [term, setTerm] = useState("");
  const [open, setOpen] = useState(false);
  const [editId, setEditId] = useState<number | null>(null);
  const [editSeller, setEditSeller] = useState<SellerRow | null>(null);
  const [toDelete, setToDelete] = useState<number | null>(null);

  useEffect(() => {
    fetch();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const applyFilter = () => fetch({ page: 1, search: term.trim() });
  const clearFilter = () => { setTerm(""); fetch({ page: 1, search: "" }); };

  const onDelete = async () => {
    if (toDelete == null) return;
    try {
      await remove(toDelete);
      toast.success("Vendedor eliminado correctamente");
      fetch({ page, search: term.trim() });
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
          <h1 className="text-2xl font-semibold">Vendedores</h1>

          <div className="flex flex-wrap items-center gap-2">
            <div className="relative">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-zinc-400" />
              <Input
                className="pl-8 w-64"
                placeholder="Buscar…"
                value={term}
                onChange={(e) => setTerm(e.target.value)}
                onKeyDown={(e) => {
                  if (e.key === "Enter") applyFilter();
                  if (e.key === "Escape") clearFilter();
                }}
              />
            </div>

            <Button variant="outline" onClick={applyFilter} disabled={loading}>
              Filtrar
            </Button>
            <Button variant="outline" onClick={clearFilter} disabled={loading || term === ""}>
              Limpiar
            </Button>
            <Button
              onClick={() => {
                setEditId(null);
                setEditSeller(null);
                setOpen(true);
              }}
            >
              <Plus className="mr-2 h-4 w-4" />
              Nuevo
            </Button>
          </div>
        </CardHeader>

        <CardContent>
          {loading && <div className="mb-2 text-sm text-zinc-500">Cargando…</div>}

          <Table>
            <THead>
              <Th>ID</Th>
              <Th>Nombre</Th>
              <Th>Email</Th>
              <Th>Teléfono</Th>
              <Th>Cédula</Th>
              <Th children={undefined}>{/* Acciones */}</Th>
            </THead>
            <TBody>
              {(items as SellerRow[]).map((s) => (
                <tr key={s.id} className="border-t">
                  <Td>{s.id}</Td>
                  <Td>{s.nombre}</Td>
                  <Td>{s.email}</Td>
                  <Td>{s.telefono ?? "—"}</Td>
                  <Td>{s.documento ?? "—"}</Td>
                  <Td>
                    <div className="flex justify-end gap-2">
                      <Button
                        variant="outline"
                        onClick={() => {
                          setEditId(s.id);
                          setEditSeller(s);
                          setOpen(true);
                        }}
                      >
                        <Pencil className="h-4 w-4" />
                      </Button>
                      <Button variant="danger" onClick={() => setToDelete(s.id)}>
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
            onPage={(p) => fetch({ page: p, search: term.trim() })}
          />
        </CardContent>
      </Card>

      {/* Crear / Editar */}
      <Modal
        open={open}
        onOpenChange={setOpen}
        title={editId ? "Editar vendedor" : "Nuevo vendedor"}
      >
        <SellerForm
          key={editId ?? 0}
          openId={editId}
          initial={editSeller ?? undefined}
          onDone={() => {
            setOpen(false);
            fetch({ page: 1, search: term.trim() });
          }}
        />
      </Modal>

      {/* Eliminar */}
      <Modal
        open={toDelete != null}
        onOpenChange={() => setToDelete(null)}
        title="Eliminar vendedor"
      >
        <p className="text-sm text-zinc-600">Esta acción no se puede deshacer.</p>
        <div className="mt-4 flex justify-end gap-2">
          <Button variant="outline" onClick={() => setToDelete(null)}>Cancelar</Button>
          <Button variant="danger" onClick={onDelete}>Eliminar</Button>
        </div>
      </Modal>
    </>
  );
}
