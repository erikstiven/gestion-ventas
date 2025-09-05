<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SellerResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'      => $this->id,
            'nombre'  => $this->nombre,
            'email'   => $this->email,
            'telefono'=> $this->telefono,
        ];
    }
}
