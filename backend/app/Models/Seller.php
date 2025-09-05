<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Seller extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'nombre',
        'email',
        'telefono',
        'documento',
        'meta',
    ];

    protected $casts = [
        'meta' => 'array',
    ];

    // Relaciones
    public function sales()
    {
        return $this->hasMany(Sale::class, 'seller_id');
    }
}
