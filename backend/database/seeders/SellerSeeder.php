<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class SellerSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('sellers')->truncate();

        $data = [
            ['nombre' => 'Juan Pérez',      'email' => 'juan.perez@example.com',      'telefono' => '0980001111', 'documento' => '0102030405'],
            ['nombre' => 'Carla Rojas',     'email' => 'carla.rojas@example.com',     'telefono' => '0980002222', 'documento' => '0203040506'],
            ['nombre' => 'Luis Andrade',    'email' => 'luis.andrade@example.com',    'telefono' => '0980003333', 'documento' => '0304050607'],
            ['nombre' => 'María Torres',    'email' => 'maria.torres@example.com',    'telefono' => '0980004444', 'documento' => '0405060708'],
            ['nombre' => 'Pedro Cedeño',    'email' => 'pedro.cedeno@example.com',    'telefono' => '0980005555', 'documento' => '0506070809'],
            ['nombre' => 'Elena Cabrera',   'email' => 'elena.cabrera@example.com',   'telefono' => '0980006666', 'documento' => '0607080910'],
            ['nombre' => 'Sandra Morales',  'email' => 'sandra.morales@example.com',  'telefono' => '0980007777', 'documento' => '0708091011'],
            ['nombre' => 'Diego Almeida',   'email' => 'diego.almeida@example.com',   'telefono' => '0980008888', 'documento' => '0809101112'],
            ['nombre' => 'Rafael Mena',     'email' => 'rafael.mena@example.com',     'telefono' => '0980009999', 'documento' => '0910111213'],
            ['nombre' => 'Patricia Salas',  'email' => 'patricia.salas@example.com',  'telefono' => '0980010000', 'documento' => '1011121314'],
        ];

        DB::table('sellers')->insert($data);
    }
}
