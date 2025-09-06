<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class SaleSeeder extends Seeder
{
    public function run(): void
    {
        // Evita problemas de FK al truncar
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        DB::table('sale_details')->truncate();
        DB::table('sales')->truncate();
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        // Catálogos
        $zones    = DB::table('zones')->pluck('id', 'nombre_zona');   // nombre => id
        $sellers  = DB::table('sellers')->pluck('id', 'nombre');      // nombre => id
        $clients  = DB::table('clients')->pluck('id')->toArray();
        $products = DB::table('products')->get();

        // Zonas y vendedores que SÍ tendrán ventas (otros quedarán sin ventas)
        $activeZones = collect(['Zona Norte', 'Zona Sur', 'Zona Centro', 'Zona Este'])
            ->map(fn ($n) => $zones[$n] ?? null)->filter()->values()->all();

        $activeSellers = collect(['Juan Pérez', 'Carla Rojas', 'Luis Andrade', 'María Torres', 'Pedro Cedeño'])
            ->map(fn ($n) => $sellers[$n] ?? null)->filter()->values()->all();

        $totalSales = 220;

        for ($i = 0; $i < $totalSales; $i++) {
            // Fecha entre 2020 y 2025
            $year  = rand(2020, 2025);
            $month = rand(1, 12);
            $day   = rand(1, 28);
            $date  = Carbon::create($year, $month, $day)->toDateString();

            $clientId  = $clients[array_rand($clients)];
            $zoneId    = $activeZones[array_rand($activeZones)];
            $sellerId  = $activeSellers[array_rand($activeSellers)];

            // Cabecera: OJO nombres en inglés
            $saleId = DB::table('sales')->insertGetId([
                'fecha'      => $date,
                'monto_total'=> 0,   // se recalcula abajo
                'client_id'  => $clientId,
                'seller_id'  => $sellerId,
                'zone_id'    => $zoneId,
            ]);

            // 1–4 ítems por venta
            $items = rand(1, 4);
            $total = 0;

            for ($k = 0; $k < $items; $k++) {
                $p         = $products[rand(0, $products->count() - 1)];
                $cantidad  = rand(1, 5);
                $precio    = (float) $p->precio;
                $subtotal  = $cantidad * $precio;
                $total    += $subtotal;

                // Tabla de detalles: ajusta nombres si tu migración usa otros
                DB::table('sale_details')->insert([
                    'sale_id'         => $saleId,
                    'product_id'      => $p->id,
                    'cantidad'        => $cantidad,       // si tu migración usa 'quantity', cambia aquí
                    'precio_unitario' => $precio,         // si usa 'unit_price', cambia aquí
                    'subtotal'        => $subtotal,
                ]);
            }

            DB::table('sales')->where('id', $saleId)->update(['monto_total' => $total]);
        }
    }
}
