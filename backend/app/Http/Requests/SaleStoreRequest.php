<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class SaleStoreRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'client_id' => ['required','exists:clients,id'],
            'seller_id' => ['required','exists:sellers,id'],
            'zone_id'   => ['required','exists:zones,id'],
            'fecha'     => ['required','date'],

            'detalles'  => ['required','array','min:1'],

            'detalles.*.product_id'      => ['required','exists:products,id'],
            'detalles.*.cantidad'        => ['required','integer','min:1'],
            'detalles.*.precio_unitario' => ['required','numeric','min:0'],

            // Campos opcionales
            'metodo_pago' => ['sometimes','nullable','string','max:50'],
            'estado'      => ['sometimes','nullable','string','max:50'],
            'meta'        => ['sometimes','nullable','array'],
        ];
    }

    public function messages(): array
    {
        return [
            'detalles.required' => 'Debe incluir al menos un detalle de venta.',
            'detalles.min'      => 'Debe incluir al menos un detalle de venta.',
        ];
    }
}
