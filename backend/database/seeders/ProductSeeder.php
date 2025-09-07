<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;

class ProductSeeder extends Seeder
{
    public function run(): void
    {
        // Si usas MySQL y hay FK, desactiva temporalmente para truncar
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        DB::table('products')->truncate();
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        $base = [
            ['nombre' => 'Producto A', 'precio' => 5.50],
            ['nombre' => 'Producto B', 'precio' => 8.25],
            ['nombre' => 'Producto C', 'precio' => 12.00],
            ['nombre' => 'Producto D', 'precio' => 15.75],
            ['nombre' => 'Producto E', 'precio' => 22.40],
            ['nombre' => 'Producto F', 'precio' => 31.90],
            ['nombre' => 'Producto G', 'precio' => 2.99],
            ['nombre' => 'Producto H', 'precio' => 18.30],
            ['nombre' => 'Producto I', 'precio' => 7.10],
            ['nombre' => 'Producto J', 'precio' => 10.00],
        ];

        $now = Carbon::now()->toDateTimeString();

        $products = array_map(function ($p) use ($now) {
            return array_merge($p, [
                'stock' => 20,
                'created_at' => $now,
                'updated_at' => $now,
            ]);
        }, $base);

        DB::table('products')->insert($products);
    }
}
