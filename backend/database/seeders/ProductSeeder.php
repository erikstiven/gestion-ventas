<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('products')->truncate();

        $products = [
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

        DB::table('products')->insert($products);
    }
}
