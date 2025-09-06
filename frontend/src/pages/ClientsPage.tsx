import { useEffect, useState } from "react";
import { useClients } from "../stores/useClients";
import type { Client } from "../stores/useClients";

import { Card, CardContent, CardHeader } from "../components/ui/card";
import Button from "../components/ui/button";
import { Input } from "../components/ui/input";
import Modal from "../components/ui/dialog";
import { Table, THead, Th, TBody, Td } from "../components/ui/table";
import Pagination from "../components/Pagination";
import ClientForm from "./clients/ClientForm";
import { Pencil, Trash2, Plus, Search } from "lucide-react";

export default function ClientsPage(){
  const { items, page, per_page, total, loading, fetch, remove } = useClients();
  const [term,setTerm] = useState("");
  const [openForm,setOpenForm] = useState<null|number>(null);
  const [toDelete,setToDelete] = useState<number|null>(null);

  useEffect(()=>{ fetch(); },[]);

  return (
    <>
      <Card>
        <CardHeader>
          <h1 className="text-2xl font-semibold">Clientes</h1>
          <div className="flex gap-2">
            <div className="relative">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-zinc-400"/>
              <Input className="pl-8 w-64" placeholder="Buscar…" value={term} onChange={e=>setTerm(e.target.value)}/>
            </div>
            <Button variant="outline" onClick={()=>fetch({page:1,search:term})}>Filtrar</Button>
            <Button onClick={()=>setOpenForm(null)}><Plus className="mr-2 h-4 w-4"/>Nuevo</Button>
          </div>
        </CardHeader>
        <CardContent>
          {loading && <div className="mb-2 text-sm text-zinc-500">Cargando…</div>}
          <Table>
            <THead><Th>ID</Th><Th>Nombre</Th><Th>Email</Th><Th>Teléfono</Th><Th children={undefined}/></THead>
            <TBody>
              {items.map((c:Client)=>(
                <tr key={c.id} className="border-t">
                  <Td>{c.id}</Td><Td>{c.nombre}</Td><Td>{c.email}</Td><Td>{c.telefono ?? "—"}</Td>
                  <Td>
                    <div className="flex justify-end gap-2">
                      <Button variant="outline" onClick={()=>setOpenForm(c.id)}><Pencil className="h-4 w-4"/></Button>
                      <Button variant="danger" onClick={()=>setToDelete(c.id)}><Trash2 className="h-4 w-4"/></Button>
                    </div>
                  </Td>
                </tr>
              ))}
            </TBody>
          </Table>
          <Pagination page={page} perPage={per_page} total={total} onPage={(p)=>fetch({page:p,search:term})}/>
        </CardContent>
      </Card>

      <Modal open={openForm !== null && openForm !== -1}
             onOpenChange={()=>setOpenForm(-1)} title={openForm ? "Editar cliente" : "Nuevo cliente"}>
        <ClientForm openId={openForm ?? null} onDone={()=>setOpenForm(-1)} />
      </Modal>

      <Modal open={toDelete!=null} onOpenChange={()=>setToDelete(null)} title="Eliminar cliente">
        <p className="text-sm text-zinc-600">Esta acción no se puede deshacer.</p>
        <div className="mt-4 flex justify-end gap-2">
          <Button variant="outline" onClick={()=>setToDelete(null)}>Cancelar</Button>
          <Button variant="danger" onClick={async()=>{ if(toDelete!=null){ await remove(toDelete); setToDelete(null); } }}>Eliminar</Button>
        </div>
      </Modal>
    </>
  );
}
