<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ProductRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        return [
            'nombre'      => ['required','string','max:255'],
            'descripcion' => ['nullable','string'],
            'precio'      => ['required','numeric','min:0'],
            'stock'       => ['required','integer','min:0'],
            'categoria'   => ['nullable','string','max:100'],
            'activo'      => ['sometimes','boolean'],
            'meta'        => ['sometimes','nullable','array'],
        ];
    }
}
