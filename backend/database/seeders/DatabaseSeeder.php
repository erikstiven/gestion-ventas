<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $this->call([
            ZoneSeeder::class,
            SellerSeeder::class,
            ClientSeeder::class,
            ProductSeeder::class,
            SaleSeeder::class,
        ]);
    }
}
