<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Sale extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'client_id',
        'seller_id',
        'zone_id',
        'fecha',
        'monto_total',
        'metodo_pago',
        'estado',
        'meta',
    ];

    protected $casts = [
        'fecha'       => 'datetime',
        'monto_total' => 'decimal:2',
        'meta'        => 'array',
    ];

    // Relaciones
    public function client()
    {
        return $this->belongsTo(Client::class, 'client_id');
    }

    public function seller()
    {
        return $this->belongsTo(Seller::class, 'seller_id');
    }

    public function zone()
    {
        return $this->belongsTo(Zone::class, 'zone_id');
    }

    public function details()
    {
        return $this->hasMany(SaleDetail::class, 'sale_id');
    }
}
