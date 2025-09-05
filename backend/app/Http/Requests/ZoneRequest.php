<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use App\Models\Zone;

class ZoneRequest extends FormRequest
{
    public function authorize(): bool { return true; }

    public function rules(): array
    {
        /** @var Zone|null $zone */
        $zone = $this->route('zone');

        return [
            'nombre_zona' => [
                'required','string','max:255',
                Rule::unique('zones','nombre_zona')->ignore($zone?->id)
            ],
            'descripcion' => ['nullable','string','max:255'],
            'meta'        => ['sometimes','nullable','array'],
        ];
    }
}
