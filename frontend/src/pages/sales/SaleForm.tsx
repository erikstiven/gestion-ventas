import { useEffect, useMemo, useState } from "react";
import { useForm, type SubmitHandler, type Resolver } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import { toast } from "sonner";

import Button from "../../components/ui/button";
import { Input } from "../../components/ui/input";

import { useSales } from "../../stores/useSales";
import type { SaleCreate } from "../../stores/useSales";
import { useCatalogs } from "../../stores/useCatalogs";

/* ----------------- helpers ----------------- */
const positiveId = z.coerce.number().refine(n => Number.isFinite(n) && n > 0, { message: "Seleccione una opción" });

const parseDec = (v: string | number) => {
  if (typeof v === "number") return v;
  const n = Number(String(v).replace(",", "."));
  return Number.isFinite(n) ? n : 0;
};

const todayISO = (() => {
  // Fecha local YYYY-MM-DD (sin problemas de UTC)
  const d = new Date();
  const yyyy = d.getFullYear();
  const mm = String(d.getMonth() + 1).padStart(2, "0");
  const dd = String(d.getDate()).padStart(2, "0");
  return `${yyyy}-${mm}-${dd}`;
})();

const normalizeDate = (s: string) => {
  // Asegura YYYY-MM-DD por si el navegador entrega dd/mm/yyyy
  if (s.includes("/")) {
    const [dd, mm, yyyy] = s.split(/[\/]/);
    if (dd && mm && yyyy) return `${yyyy}-${mm.padStart(2, "0")}-${dd.padStart(2, "0")}`;
  }
  return s;
};

/* ----------------- schema ----------------- */
const itemSchema = z.object({
  product_id: positiveId,
  cantidad: z.coerce.number().int().positive("Cantidad inválida"),
  precio_unitario: z
    .union([z.number(), z.string()])
    .transform(parseDec)
    .refine((n) => n > 0, { message: "Precio inválido" }),
});

const schema = z.object({
  client_id: positiveId,
  seller_id: positiveId,
  zone_id: positiveId,
  fecha: z.string().min(8, "Fecha requerida"),
  metodo_pago: z.string().optional(),
  detalles: z.array(itemSchema).min(1, "Agrega al menos un producto"),
});

type FormData = z.infer<typeof schema>;
const resolver = zodResolver(schema) as unknown as Resolver<FormData>;

/* ----------------- component ----------------- */
export default function SaleForm({ onDone }: { onDone: () => void }) {
  const { create } = useSales();
  const { fetchAll, zones, sellers, products, clients } = useCatalogs();
  const [items, setItems] = useState<FormData["detalles"]>([]);

  const {
    register, handleSubmit, setValue, reset,
    formState: { isSubmitting, errors },
  } = useForm<FormData>({
    resolver,
    defaultValues: { client_id: 0, seller_id: 0, zone_id: 0, fecha: todayISO, metodo_pago: "", detalles: [] },
  });

  useEffect(() => { fetchAll(); }, [fetchAll]);
  useEffect(() => { setValue("detalles", items as any, { shouldValidate: true }); }, [items, setValue]);

  const addItem = () =>
    setItems((prev) => [...prev, { product_id: 0, cantidad: 1, precio_unitario: 0 }]);

  const removeItem = (idx: number) =>
    setItems((prev) => prev.filter((_, i) => i !== idx));

  const total = useMemo(
    () => items.reduce((s, it) => s + parseDec(it.cantidad) * parseDec(it.precio_unitario), 0),
    [items]
  );

  const onSubmit: SubmitHandler<FormData> = async (data) => {
    try {
      const payload: SaleCreate = {
        ...data,
        fecha: normalizeDate(data.fecha),
        detalles: data.detalles.map((d) => ({
          product_id: Number(d.product_id),
          cantidad: Number(d.cantidad),
          precio_unitario: parseDec(d.precio_unitario),
        })),
      };
      await create(payload);
      toast.success("Venta creada correctamente");
      reset({ client_id: 0, seller_id: 0, zone_id: 0, fecha: todayISO, metodo_pago: "", detalles: [] });
      setItems([]);
      onDone();
    } catch (e: any) {
      // El interceptor ya muestra detalle de 422, dejamos un fallback:
      toast.error(e?.response?.data?.message ?? e?.message ?? "No se pudo crear la venta");
    }
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-3">
      {/* Fila 1: selects y fecha */}
      <div className="grid gap-3 sm:grid-cols-2">
        <div>
          <label className="text-sm">Cliente</label>
          <select {...register("client_id")} className="w-full rounded-xl border px-3 py-2">
            <option value={0}>Seleccione cliente</option>
            {(clients as any[]).map((c) => (
              <option key={c.id} value={c.id}>{c.nombre}</option>
            ))}
          </select>
          {typeof errors.client_id?.message === "string" && (
            <p className="text-xs text-red-600">{errors.client_id.message}</p>
          )}
        </div>

        <div>
          <label className="text-sm">Vendedor</label>
          <select {...register("seller_id")} className="w-full rounded-xl border px-3 py-2">
            <option value={0}>Seleccione vendedor</option>
            {(sellers as any[]).map((s) => (
              <option key={s.id} value={s.id}>{s.nombre}</option>
            ))}
          </select>
          {typeof errors.seller_id?.message === "string" && (
            <p className="text-xs text-red-600">{errors.seller_id.message}</p>
          )}
        </div>

        <div>
          <label className="text-sm">Zona</label>
          <select {...register("zone_id")} className="w-full rounded-xl border px-3 py-2">
            <option value={0}>Seleccione zona</option>
            {(zones as any[]).map((z: any) => (
              <option key={z.id} value={z.id}>{z.nombre_zona ?? z.nombre}</option>
            ))}
          </select>
          {typeof errors.zone_id?.message === "string" && (
            <p className="text-xs text-red-600">{errors.zone_id.message}</p>
          )}
        </div>

        <div>
          <label className="text-sm">Fecha</label>
          <Input type="date" max={todayISO} {...register("fecha")} />
          {typeof errors.fecha?.message === "string" && (
            <p className="text-xs text-red-600">{errors.fecha.message}</p>
          )}
        </div>
      </div>

      {/* Productos */}
      <div className="mt-2 overflow-hidden rounded-xl border">
        <div className="flex items-center justify-between border-b px-4 py-2">
          <div className="font-semibold">Productos</div>
          <Button variant="outline" type="button" onClick={addItem}>+ Agregar</Button>
        </div>

        <div className="p-4">
          {/* Tabla responsiva sin desbordes */}
          <div className="overflow-x-auto">
            <table className="min-w-full table-fixed text-sm">
              <thead className="bg-zinc-50">
                <tr>
                  <th className="w-[38%] px-2 py-1 text-left">Producto</th>
                  <th className="w-[14%] px-2 py-1 text-center">Cantidad</th>
                  <th className="w-[22%] px-2 py-1 text-right">Precio</th>
                  <th className="w-[18%] px-2 py-1 text-right">Subtotal</th>
                  <th className="w-[8%]" />
                </tr>
              </thead>
              <tbody>
                {items.map((it, idx) => (
                  <tr key={idx} className="border-t">
                    <td className="px-2 py-1">
                      <select
                        className="w-full rounded-lg border px-2 py-1"
                        value={it.product_id}
                        onChange={(e) => {
                          const id = Number(e.target.value);
                          const p = (products as any[]).find((pp) => pp.id === id);
                          setItems((prev) =>
                            prev.map((x, i) =>
                              i === idx
                                ? { ...x, product_id: id, precio_unitario: parseDec(p?.precio ?? x.precio_unitario) }
                                : x
                            )
                          );
                        }}
                      >
                        <option value={0}>Seleccione producto</option>
                        {(products as any[]).map((p) => (
                          <option key={p.id} value={p.id}>{p.nombre}</option>
                        ))}
                      </select>
                      {it.product_id === 0 && (
                        <p className="text-xs text-red-600">Seleccione un producto</p>
                      )}
                    </td>

                    <td className="px-2 py-1">
                      <Input
                        type="number"
                        inputMode="numeric"
                        className="mx-auto w-full max-w-[90px] text-center"
                        value={it.cantidad}
                        onChange={(e) =>
                          setItems((prev) =>
                            prev.map((x, i) =>
                              i === idx ? { ...x, cantidad: parseDec(e.target.value) } : x
                            )
                          )
                        }
                      />
                    </td>

                    <td className="px-2 py-1">
                      <Input
                        type="text"                // permite coma o punto
                        inputMode="decimal"
                        className="ml-auto w-full max-w-[150px] text-right"
                        value={String(it.precio_unitario).replace(".", ",")}
                        onChange={(e) =>
                          setItems((prev) =>
                            prev.map((x, i) =>
                              i === idx ? { ...x, precio_unitario: parseDec(e.target.value) } : x
                            )
                          )
                        }
                        placeholder="0,00"
                      />
                    </td>

                    <td className="px-2 py-1 text-right">
                      {(parseDec(it.cantidad) * parseDec(it.precio_unitario)).toFixed(2)}
                    </td>

                    <td className="px-2 py-1 text-right">
                      <Button variant="outline" type="button" onClick={() => removeItem(idx)}>
                        Quitar
                      </Button>
                    </td>
                  </tr>
                ))}

                {items.length === 0 && (
                  <tr>
                    <td className="px-2 py-3 text-zinc-500" colSpan={5}>
                      Sin productos aún.
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>

          {/* Total */}
          <div className="mt-3 flex justify-end">
            <div className="rounded-lg border px-3 py-2 text-right">
              <div className="text-xs text-zinc-500">Total</div>
              <div className="text-lg font-semibold">${total.toFixed(2)}</div>
            </div>
          </div>
        </div>
      </div>

      {/* Error global de items sólo si hay mensaje real */}
      {typeof errors.detalles?.message === "string" && (
        <p className="text-xs text-red-600">{errors.detalles.message}</p>
      )}

      <div className="flex justify-end gap-2">
        <Button variant="outline" type="button" onClick={onDone}>Cancelar</Button>
        <Button disabled={isSubmitting}>Crear venta</Button>
      </div>
    </form>
  );
}
