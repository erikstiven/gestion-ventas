<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ZoneSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('zones')->truncate();

        $zones = [
            ['nombre_zona' => 'Zona Norte', 'descripcion' => 'Cobertura norte'],
            ['nombre_zona' => 'Zona Sur', 'descripcion' => 'Cobertura sur'],
            ['nombre_zona' => 'Zona Centro', 'descripcion' => 'Cobertura centro'],
            ['nombre_zona' => 'Zona Este', 'descripcion' => 'Cobertura este'],
            ['nombre_zona' => 'Zona Oeste', 'descripcion' => 'Cobertura oeste'],
            ['nombre_zona' => 'Zona Amazonía', 'descripcion' => 'Sin ventas para pruebas'],
            ['nombre_zona' => 'Zona Sierra Alta', 'descripcion' => 'Sin ventas para pruebas'],
            ['nombre_zona' => 'Zona Costa Lejana', 'descripcion' => 'Sin ventas para pruebas'],
        ];

        DB::table('zones')->insert($zones);
    }
}
