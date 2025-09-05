<?php

namespace Database\Seeders;

use App\Models\Seller;
use Illuminate\Database\Seeder;

class SellerSeeder extends Seeder
{
    public function run(): void
    {
        // Algunos fijos
        $base = [
            ['nombre' => 'Ana Torres',   'email' => 'ana@example.com'],
            ['nombre' => 'Luis Pérez',   'email' => 'luis@example.com'],
            ['nombre' => 'María Gómez',  'email' => 'maria@example.com'],
            ['nombre' => 'Carlos Díaz',  'email' => 'carlos@example.com'],
            ['nombre' => 'Lucía Vaca',   'email' => 'lucia@example.com'],
        ];
        foreach ($base as $s) { Seller::firstOrCreate(['email' => $s['email']], $s); }

        // Y algunos aleatorios
        Seller::factory()->count(5)->create();
    }
}
