<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Zone extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'nombre_zona',
        'descripcion',
        'meta',
    ];

    protected $casts = [
        'meta' => 'array',
    ];

    // Relaciones
    public function sales()
    {
        return $this->hasMany(Sale::class, 'zone_id');
    }
}
