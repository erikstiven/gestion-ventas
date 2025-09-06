import { useEffect } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import { toast } from "sonner";
import api from "../../api/client";
import Button from "../../components/ui/button";
import { Input } from "../../components/ui/input";
import type { Zone } from "../../stores/useZones";

type Props = {
  /** ID de la zona a editar. Si es null se crea una nueva */
  openId: number | null;
  /** Valores iniciales para prellenar el formulario */
  initial?: Partial<Zone>;
  /** Función a ejecutar al completar la operación */
  onDone: () => void;
};

// Esquema de validación para zonas
const schema = z.object({
  nombre_zona: z.string().trim().min(1, "Nombre requerido"),
  descripcion: z.string().trim().max(160, "Máximo 160 caracteres").optional(),
});

type FormData = z.infer<typeof schema>;

function pickZonePayload(data: any): FormData {
  const d = (data?.data ?? data) ?? {};
  const nombre_zona = d.nombre_zona ?? d.nombre ?? d.name ?? "";
  const descripcion = d.descripcion ?? d.description ?? "";
  return { nombre_zona, descripcion };
}

export default function ZoneForm({ openId, initial, onDone }: Props) {
  const {
    register,
    handleSubmit,
    reset,
    setError,
    formState: { errors, isSubmitting },
  } = useForm<FormData>({
    resolver: zodResolver(schema),
    defaultValues: { nombre_zona: "", descripcion: "" },
    mode: "onTouched",
  });

  // Prellenado con initial
  useEffect(() => {
    if (initial) {
      reset({
        nombre_zona: initial.nombre_zona ?? "",
        descripcion: initial.descripcion ?? "",
      });
    } else if (!openId) {
      reset({ nombre_zona: "", descripcion: "" });
    }
  }, [initial, openId, reset]);

  // Si no hay initial pero sí openId, obtener datos del servidor
  useEffect(() => {
    let active = true;
    (async () => {
      if (!openId || initial) return;
      try {
        const { data } = await api.get(`/zones/${openId}`);
        if (!active) return;
        reset(pickZonePayload(data));
      } catch (e: any) {
        toast.error("No se pudo cargar la zona.");
      }
    })();
    return () => {
      active = false;
    };
  }, [openId, initial, reset]);

  // Mapea errores del backend a los campos del formulario
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
        await api.put(`/zones/${openId}`, values);
        toast.success("Zona actualizada correctamente");
      } else {
        await api.post(`/zones`, values);
        toast.success("Zona creada correctamente");
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
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-4 p-6">
      <div>
        <label className="block text-sm font-medium mb-1">Nombre de zona</label>
        <Input {...register("nombre_zona")}
        />
        {errors.nombre_zona && <p className="text-sm text-red-600 mt-1">{errors.nombre_zona.message}</p>}
      </div>
      <div>
        <label className="block text-sm font-medium mb-1">Descripción (opcional)</label>
        <Input {...register("descripcion")}
        />
        {errors.descripcion && <p className="text-sm text-red-600 mt-1">{errors.descripcion.message}</p>}
      </div>
      <div className="flex justify-end gap-2">
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