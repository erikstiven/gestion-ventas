<?php

namespace Database\Seeders;

use App\Models\Zone;
use Illuminate\Database\Seeder;

class ZoneSeeder extends Seeder
{
    public function run(): void
    {
        $zonas = [
            ['nombre_zona' => 'Zona Norte',  'descripcion' => 'Cobertura norte de la ciudad'],
            ['nombre_zona' => 'Zona Sur',    'descripcion' => 'Cobertura sur de la ciudad'],
            ['nombre_zona' => 'Zona Centro', 'descripcion' => 'Centro histórico y financiero'],
            ['nombre_zona' => 'Zona Este',   'descripcion' => null],
            ['nombre_zona' => 'Zona Oeste',  'descripcion' => null],
        ];
        foreach ($zonas as $z) { Zone::firstOrCreate(['nombre_zona' => $z['nombre_zona']], $z); }

        // Opcional: más zonas aleatorias
        Zone::factory()->count(5)->create();
    }
}
