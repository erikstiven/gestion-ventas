import { useEffect } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import { toast } from "sonner";
import api from "../../api/client";
import Button from "../../components/ui/button";
import { Input } from "../../components/ui/input";
import type { ClientRow } from "../ClientsPage";

type Props = {
  openId: number | null;                 // id a editar o null para crear
  initial?: Partial<ClientRow>;          // <- datos inmediatos para prellenar
  onDone: () => void;
};

// Validación
const schema = z.object({
  nombre: z.string().trim().min(1, "Nombre requerido").min(3, "Mínimo 3 caracteres"),
  email:  z.string().trim().min(1, "Email requerido").email("Email inválido"),
  telefono: z
    .string()
    .trim()
    .optional()
    .refine((v) => !v || /^(\+5939\d{8}|09\d{8}|\+?\d{7,15})$/.test(v), {
      message: "Formato inválido. Ej: 0991234567 o +593991234567",
    }),
  direccion: z.string().trim().max(160, "Máximo 160 caracteres").optional(),
});

type FormData = z.infer<typeof schema>;

// Extrae campos del payload de la API (soporta variantes comunes)
function pickClientPayload(data: any): FormData {
  const d = (data?.data ?? data) ?? {};
  const nombre =
    d.nombre ?? d.name ?? d.full_name ?? "";
  const email =
    d.email ?? d.correo ?? d.mail ?? "";
  const telefono =
    d.telefono ?? d.phone ?? d.celular ?? d.mobile ?? "";
  const direccion =
    d.direccion ?? d.address ?? d.dirección ?? "";

  return { nombre, email, telefono, direccion };
}

export default function ClientForm({ openId, initial, onDone }: Props) {
  const {
    register,
    handleSubmit,
    reset,
    setError,
    formState: { errors, isSubmitting },
  } = useForm<FormData>({
    resolver: zodResolver(schema),
    defaultValues: { nombre: "", email: "", telefono: "", direccion: "" },
    mode: "onTouched",
  });

  // 1) Prellenar inmediatamente con 'initial' si viene desde la tabla
  useEffect(() => {
    if (initial) {
      reset({
        nombre: initial.nombre ?? "",
        email: initial.email ?? "",
        telefono: initial.telefono ?? "",
        direccion: initial.direccion ?? "",
      });
    } else if (!openId) {
      reset({ nombre: "", email: "", telefono: "", direccion: "" });
    }
  }, [initial, openId, reset]);

  // 2) Fallback: si no hay 'initial' pero sí 'openId', pedimos al backend (soportando data/data.data)
  useEffect(() => {
    let active = true;
    (async () => {
      if (!openId || initial) return; // ya prellenado
      try {
        // Si tu API usa '/clientes', cambia aquí.
        const { data } = await api.get(`/clients/${openId}`);
        if (!active) return;
        reset(pickClientPayload(data));
      } catch (e: any) {
        // No rompemos UX: dejamos el form vacío si falla,
        // pero avisamos para que revises la ruta.
        toast.error("No se pudo cargar el cliente. Verifica la ruta /clients/:id");
      }
    })();
    return () => { active = false; };
  }, [openId, initial, reset]);

  // Mapea errores 422 de Laravel a los inputs
  function map422ToErrors(err: any) {
    const apiErrors = err?.response?.data?.errors as Record<string, string[]> | undefined;
    if (!apiErrors) return false;
    Object.entries(apiErrors).forEach(([field, msgs]) => {
      const msg = Array.isArray(msgs) ? msgs[0] : String(msgs);
      if (field in schema.shape) setError(field as keyof FormData, { type: "server", message: msg });
    });
    return true;
  }

  const onSubmit = async (values: FormData) => {
    try {
      if (openId) {
        await api.put(`/clients/${openId}`, values);
        toast.success("Cliente actualizado correctamente");
      } else {
        await api.post(`/clients`, values);
        toast.success("Cliente creado correctamente");
      }
      onDone();
    } catch (e: any) {
      if (e?.response?.status === 422 && map422ToErrors(e)) {
        toast.error("Revisa los campos marcados.");
      } else {
        toast.error(e?.response?.data?.message ?? "Ocurrió un error.");
      }
    }
  };

  return (
    <form className="space-y-4" onSubmit={handleSubmit(onSubmit)} noValidate>
      <div>
        <label className="block text-sm font-medium">Nombre</label>
        <Input
          {...register("nombre")}
          placeholder="Juan Pérez"
          autoFocus
          disabled={isSubmitting}
        />
        {errors.nombre && <p className="mt-1 text-sm text-red-600">{errors.nombre.message}</p>}
      </div>

      <div>
        <label className="block text-sm font-medium">Email</label>
        <Input
          {...register("email")}
          type="email"
          placeholder="juan@example.com"
          disabled={isSubmitting}
        />
        {errors.email && <p className="mt-1 text-sm text-red-600">{errors.email.message}</p>}
      </div>

      <div>
        <label className="block text-sm font-medium">Teléfono (opcional)</label>
        <Input
          {...register("telefono")}
          inputMode="tel"
          maxLength={17}
          placeholder="0991234567 o +593991234567"
          disabled={isSubmitting}
        />
        {errors.telefono && <p className="mt-1 text-sm text-red-600">{errors.telefono.message}</p>}
      </div>

      <div>
        <label className="block text-sm font-medium">Dirección (opcional)</label>
        <Input
          {...register("direccion")}
          placeholder="Av. 9 de Octubre 123 y García Moreno"
          disabled={isSubmitting}
        />
        {errors.direccion && <p className="mt-1 text-sm text-red-600">{errors.direccion.message}</p>}
      </div>

      <div className="flex justify-end gap-2 pt-2">
        <Button type="button" variant="outline" onClick={onDone} disabled={isSubmitting}>
          Cancelar
        </Button>
        <Button type="submit" disabled={isSubmitting}>
          {openId ? "Actualizar" : "Crear"}
        </Button>
      </div>
    </form>
  );
}
