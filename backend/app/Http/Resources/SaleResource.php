<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SaleResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'          => $this->id,
            'fecha'       => $this->fecha?->toISOString(),
            'monto_total' => (float) $this->monto_total,

            'cliente'  => $this->whenLoaded('client', fn () => [
                'id'     => $this->client_id,
                'nombre' => $this->client->nombre,
            ]),
            'vendedor' => $this->whenLoaded('seller', fn () => [
                'id'     => $this->seller_id,
                'nombre' => $this->seller->nombre,
            ]),
            'zona'     => $this->whenLoaded('zone', fn () => [
                'id'     => $this->zone_id,
                'nombre' => $this->zone->nombre_zona,
            ]),

            'detalles' => $this->whenLoaded('details', function () {
                return $this->details->map(fn ($d) => [
                    'product_id'      => $d->product_id,
                    'cantidad'        => (int) $d->cantidad,
                    'precio_unitario' => (float) $d->precio_unitario,
                    'subtotal'        => (float) $d->subtotal,
                ])->toArray();
            }),
        ];
    }
}
