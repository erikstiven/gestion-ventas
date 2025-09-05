<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use App\Models\Seller;

class SellerRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        /** @var Seller|null $seller */
        $seller = $this->route('seller');

        return [
            'nombre'   => ['required','string','max:255'],
            'email'    => [
                'required','email','max:255',
                Rule::unique('sellers','email')->ignore($seller?->id)
            ],
            'telefono' => ['nullable','string','max:30'],
            'documento'=> ['nullable','string','max:50'],
            'meta'     => ['sometimes','nullable','array'],
        ];
    }
}
