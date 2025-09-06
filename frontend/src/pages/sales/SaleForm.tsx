import { useEffect, useMemo, useState } from "react";
import { useForm, type SubmitHandler, type Resolver } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";

import Button from "../../components/ui/button";
import { Input } from "../../components/ui/input";

import { useSales } from "../../stores/useSales";
import type { SaleCreate } from "../../stores/useSales";
import { useCatalogs } from "../../stores/useCatalogs";

const itemSchema = z.object({
  product_id: z.coerce.number().int().positive(),
  cantidad: z.coerce.number().int().positive(),
  precio_unitario: z.coerce.number().positive(),
});
const schema = z.object({
  client_id: z.coerce.number().int().positive(),
  seller_id: z.coerce.number().int().positive(),
  zone_id: z.coerce.number().int().positive(),
  fecha: z.string().min(8),
  metodo_pago: z.string().optional(),
  detalles: z.array(itemSchema).min(1),
});
type FormData = z.infer<typeof schema>;
const resolver = zodResolver(schema) as unknown as Resolver<FormData>;

export default function SaleForm({ onDone }:{onDone:()=>void}) {
  const { create } = useSales();
  const { fetchAll, zones, sellers, products, clients } = useCatalogs();
  const [items, setItems] = useState<FormData["detalles"]>([]);

  const { register, handleSubmit, setValue, reset, formState:{isSubmitting, errors} } =
    useForm<FormData>({ resolver, defaultValues:{ client_id:0, seller_id:0, zone_id:0, fecha:"", metodo_pago:"", detalles:[] } });

  useEffect(()=>{ fetchAll(); },[fetchAll]);
  useEffect(()=>{ setValue("detalles", items as any, { shouldValidate:true }); },[items,setValue]);

  const addItem = () => {
    const p = products[0];
    setItems(prev => [...prev, { product_id:p?.id ?? 0, cantidad:1, precio_unitario:p?.precio ?? 0 }]);
  };
  const removeItem = (idx:number) => setItems(prev => prev.filter((_,i)=>i!==idx));
  const total = useMemo(()=> items.reduce((s,it)=>s+it.cantidad*it.precio_unitario,0),[items]);

  const onSubmit: SubmitHandler<FormData> = async (data) => {
    const payload: SaleCreate = { ...data, detalles: data.detalles };
    await create(payload);
    reset(); setItems([]); onDone();
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-3">
      <div className="grid gap-3 sm:grid-cols-2">
        <div>
          <label className="text-sm">Cliente</label>
          <select {...register("client_id")} className="w-full rounded-xl border px-3 py-2">
            {clients.map((c:any)=><option key={c.id} value={c.id}>{c.nombre}</option>)}
          </select>
        </div>
        <div>
          <label className="text-sm">Vendedor</label>
          <select {...register("seller_id")} className="w-full rounded-xl border px-3 py-2">
            {sellers.map((s:any)=><option key={s.id} value={s.id}>{s.nombre}</option>)}
          </select>
        </div>
        <div>
          <label className="text-sm">Zona</label>
          <select {...register("zone_id")} className="w-full rounded-xl border px-3 py-2">
            {zones.map((z:any)=><option key={z.id} value={z.id}>{z.nombre_zona ?? z.nombre}</option>)}
          </select>
        </div>
        <div>
          <label className="text-sm">Fecha</label>
          <Input type="date" {...register("fecha")} />
        </div>
      </div>

      <div className="mt-2 rounded-xl border">
        <div className="flex items-center justify-between border-b px-3 py-2">
          <div className="font-semibold">Productos</div>
          <Button variant="outline" type="button" onClick={addItem}>+ Agregar</Button>
        </div>
        <div className="p-3">
          <table className="w-full text-sm">
            <thead className="bg-zinc-50">
              <tr>
                <th className="px-2 py-1 text-left">Producto</th>
                <th className="px-2 py-1">Cantidad</th>
                <th className="px-2 py-1">Precio</th>
                <th className="px-2 py-1 text-right">Subtotal</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              {items.map((it, idx)=>(
                <tr key={idx} className="border-t">
                  <td className="px-2 py-1">
                    <select className="rounded-lg border px-2 py-1" value={it.product_id}
                      onChange={e=>{
                        const id=Number(e.target.value);
                        const p=products.find((pp:any)=>pp.id===id);
                        setItems(prev=>prev.map((x,i)=> i===idx ? { ...x, product_id:id, precio_unitario:p?.precio ?? x.precio_unitario } : x));
                      }}>
                      {products.map((p:any)=><option key={p.id} value={p.id}>{p.nombre}</option>)}
                    </select>
                  </td>
                  <td className="px-2 py-1">
                    <Input type="number" value={it.cantidad}
                      onChange={e=> setItems(prev=>prev.map((x,i)=> i===idx ? { ...x, cantidad:Number(e.target.value) } : x))}/>
                  </td>
                  <td className="px-2 py-1">
                    <Input type="number" value={it.precio_unitario}
                      onChange={e=> setItems(prev=>prev.map((x,i)=> i===idx ? { ...x, precio_unitario:Number(e.target.value) } : x))}/>
                  </td>
                  <td className="px-2 py-1 text-right">{(it.cantidad*it.precio_unitario).toFixed(2)}</td>
                  <td className="px-2 py-1 text-right"><Button variant="outline" type="button" onClick={()=>removeItem(idx)}>Quitar</Button></td>
                </tr>
              ))}
              {items.length===0 && <tr><td className="px-2 py-3 text-zinc-500" colSpan={5}>Sin productos aún.</td></tr>}
            </tbody>
          </table>
          <div className="mt-3 flex justify-end">
            <div className="rounded-lg border px-3 py-2 text-right">
              <div className="text-xs text-zinc-500">Total</div>
              <div className="text-lg font-semibold">${total.toFixed(2)}</div>
            </div>
          </div>
        </div>
      </div>

      {errors.detalles && <p className="text-xs text-red-600">{String(errors.detalles.message)}</p>}

      <div className="flex justify-end gap-2">
        <Button variant="outline" type="button" onClick={onDone}>Cancelar</Button>
        <Button disabled={isSubmitting}>Crear venta</Button>
      </div>
    </form>
  );
}
