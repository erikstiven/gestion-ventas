<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use App\Models\Client;

class ClientRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        /** @var Client|null $client */
        $client = $this->route('client'); // Model binding o id

        return [
            'nombre'    => ['required','string','max:255'],
            'email'     => [
                'required','email','max:255',
                Rule::unique('clients','email')->ignore($client?->id)
            ],
            'telefono'  => ['nullable','string','max:30'],
            'direccion' => ['nullable','string','max:255'],
            'meta'      => ['sometimes','nullable','array'],
        ];
    }
}
