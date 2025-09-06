import { useEffect } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import { toast } from "sonner";
import api from "../../api/client";
import Button from "../../components/ui/button";
import { Input } from "../../components/ui/input";
import type { Seller } from "../../stores/useSellers";

type Props = {
  openId: number | null;
  initial?: Seller;
  onDone: () => void;
};

const schema = z.object({
  nombre: z.string().min(1, "Requerido"),
  email: z.string().email("Email inválido"),
  telefono: z.string().optional().nullable(),
  documento: z
    .string()
    .regex(/^\d{10}$/, "Cédula debe tener 10 dígitos")
    .optional()
    .nullable(),
});

type FormData = z.infer<typeof schema>;

export default function SellerForm({ openId, initial, onDone }: Props) {
  const {
    register,
    handleSubmit,
    reset,
    formState: { errors, isSubmitting },
  } = useForm<FormData>({
    resolver: zodResolver(schema),
    defaultValues: {
      nombre: initial?.nombre ?? "",
      email: initial?.email ?? "",
      telefono: initial?.telefono ?? "",
      documento: initial?.documento ?? "",
    },
  });

  useEffect(() => {
    reset({
      nombre: initial?.nombre ?? "",
      email: initial?.email ?? "",
      telefono: initial?.telefono ?? "",
      documento: initial?.documento ?? "",
    });
  }, [initial, reset]);

  const onSubmit = async (data: FormData) => {
    try {
      if (openId) {
        await api.put(`/sellers/${openId}`, data);
        toast.success("Vendedor actualizado");
      } else {
        await api.post(`/sellers`, data);
        toast.success("Vendedor creado");
      }
      onDone();
    } catch (e: any) {
      toast.error(e?.response?.data?.message ?? "Error al guardar");
    }
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-3">
      <div>
        <label className="text-sm font-medium">Nombre</label>
        <Input {...register("nombre")} placeholder="Nombre del vendedor" />
        {errors.nombre && (
          <p className="text-xs text-red-600 mt-1">{errors.nombre.message}</p>
        )}
      </div>

      <div>
        <label className="text-sm font-medium">Email</label>
        <Input {...register("email")} placeholder="correo@ejemplo.com" />
        {errors.email && (
          <p className="text-xs text-red-600 mt-1">{errors.email.message}</p>
        )}
      </div>

      <div>
        <label className="text-sm font-medium">Teléfono</label>
        <Input {...register("telefono")} placeholder="0980000000" />
      </div>

      <div>
        <label className="text-sm font-medium">Cédula</label>
        <Input {...register("documento")} placeholder="Cédula (10 dígitos)" />
        {errors.documento && (
          <p className="text-xs text-red-600 mt-1">{errors.documento.message}</p>
        )}
      </div>

      <div className="flex justify-end gap-2 pt-2">
        <Button type="button" variant="outline" onClick={onDone}>
          Cancelar
        </Button>
        <Button type="submit" disabled={isSubmitting}>
          {openId ? "Actualizar" : "Crear"}
        </Button>
      </div>
    </form>
  );
}
