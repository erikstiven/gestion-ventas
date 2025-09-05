<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Validator;
use App\Models\Product;

class SaleStoreRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'client_id' => ['required','integer', Rule::exists('clients','id')->whereNull('deleted_at')],
            'seller_id' => ['required','integer', Rule::exists('sellers','id')->whereNull('deleted_at')],
            'zone_id'   => ['required','integer', Rule::exists('zones','id')->whereNull('deleted_at')],

            'fecha'     => ['required','date','before_or_equal:now'],

            'detalles'                        => ['required','array','min:1'],
            'detalles.*.product_id'           => ['required','integer', Rule::exists('products','id')->whereNull('deleted_at'), 'distinct'],
            'detalles.*.cantidad'             => ['required','integer','min:1'],
            'detalles.*.precio_unitario'      => ['required','numeric','min:0'],

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
            'detalles.*.product_id.distinct' => 'No repita el mismo producto en más de una línea.',
        ];
    }

    /**
     * Validaciones de negocio extra (stock y/o validar precio contra el producto).
     */
    public function withValidator(Validator $validator): void
    {
        $validator->after(function (Validator $v) {
            $detalles = (array) $this->input('detalles', []);

            foreach ($detalles as $i => $d) {
                // Validar stock disponible (opcional)
                if (!empty($d['product_id']) && !empty($d['cantidad'])) {
                    $p = Product::query()->whereKey($d['product_id'])->first();
                    if ($p && $p->stock < (int) $d['cantidad']) {
                        $v->errors()->add("detalles.$i.cantidad", "Stock insuficiente para el producto {$p->nombre} (disponible: {$p->stock}).");
                    }
                }

            }
        });
    }
}
