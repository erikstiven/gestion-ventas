import { useEffect } from "react";
import { useForm, type SubmitHandler, type Resolver } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import { toast } from "sonner";

import Button from "../../components/ui/button";
import { Input } from "../../components/ui/input";

import { useClients } from "../../stores/useClients";
import type { Client } from "../../stores/useClients";

const schema = z.object({
  nombre: z.string().min(2, "Ingresa al menos 2 caracteres"),
  email: z.string().email("Correo inválido"),
  telefono: z.string().optional(),
  direccion: z.string().optional(),
});
type FormData = z.infer<typeof schema>;
const resolver = zodResolver(schema) as unknown as Resolver<FormData>;

export default function ClientForm({
  openId, onDone,
}: { openId?: number | null; onDone: () => void; }) {
  const { create, update, items } = useClients();
  const { register, handleSubmit, reset, formState: { errors, isSubmitting } } =
    useForm<FormData>({ resolver, defaultValues: { nombre: "", email: "", telefono: "", direccion: "" } });

  useEffect(() => {
    if (openId) {
      const c = items.find(i => i.id === openId) as Client | undefined;
      if (c) reset({ nombre: c.nombre, email: c.email, telefono: c.telefono ?? "", direccion: c.direccion ?? "" });
    } else {
      reset({ nombre: "", email: "", telefono: "", direccion: "" });
    }
  }, [openId, items, reset]);

  const onSubmit: SubmitHandler<FormData> = async (d) => {
    try {
      if (openId) { await update(openId, d); toast.success("Cliente actualizado"); }
      else { await create(d); toast.success("Cliente creado"); }
      onDone();
    } catch (e: any) {
      toast.error(e?.message ?? "No se pudo guardar");
    }
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-3">
      <div>
        <label className="text-sm">Nombre</label>
        <Input {...register("nombre")} />
        <p className="text-xs text-red-600">{errors.nombre?.message}</p>
      </div>
      <div>
        <label className="text-sm">Email</label>
        <Input type="email" {...register("email")} />
        <p className="text-xs text-red-600">{errors.email?.message}</p>
      </div>
      <div className="grid gap-3 sm:grid-cols-2">
        <div>
          <label className="text-sm">Teléfono</label>
          <Input {...register("telefono")} />
        </div>
        <div>
          <label className="text-sm">Dirección</label>
          <Input {...register("direccion")} />
        </div>
      </div>

      <div className="flex justify-end gap-2">
        <Button variant="outline" type="button" onClick={onDone}>Cancelar</Button>
        <Button disabled={isSubmitting}>{openId ? "Guardar" : "Crear"}</Button>
      </div>
    </form>
  );
}
