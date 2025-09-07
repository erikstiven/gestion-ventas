<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;

class SaleSeeder extends Seeder
{
    public function run(): void
    {
        // Evita problemas de FK al truncar
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        DB::table('sale_details')->truncate();
        DB::table('sales')->truncate();
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        // Obtener catálogos (deben existir previamente)
        $clients  = DB::table('clients')->pluck('id')->toArray();
        $sellers  = DB::table('sellers')->pluck('id')->toArray();
        $zones    = DB::table('zones')->pluck('id')->toArray();
        $products = DB::table('products')->select('id', 'precio', 'stock')->get()->toArray();

        if (empty($clients) || empty($sellers) || empty($zones) || empty($products)) {
            throw new \Exception("Antes de correr SaleSeeder necesitas seedear clients, sellers, zones y products (cada uno con al menos 1 registro).");
        }

        $methods = ['efectivo', 'tarjeta', 'transferencia', 'depósito'];
        $states  = ['pagada', 'pendiente', 'anulada'];

        $totalSales = 20; // <-- las 20 ventas que pediste

        for ($i = 0; $i < $totalSales; $i++) {
            // Fecha aleatoria entre 2020-01-01 y 2025-12-28
            $year  = rand(2020, 2025);
            $month = rand(1, 12);
            $day   = rand(1, 28);
            $date  = Carbon::create($year, $month, $day)->toDateString();

            $clientId = $clients[array_rand($clients)];
            $sellerId = $sellers[array_rand($sellers)];
            $zoneId   = $zones[array_rand($zones)];

            // Insertar cabecera (monto_total inicialmente 0)
            $saleId = DB::table('sales')->insertGetId([
                'fecha'       => $date,
                'monto_total' => 0,
                'client_id'   => $clientId,
                'seller_id'   => $sellerId,
                'zone_id'     => $zoneId,
                'metodo_pago' => $methods[array_rand($methods)],
                'estado'      => $states[array_rand($states)],
                'created_at'  => Carbon::create($year, $month, $day)->toDateTimeString(),
                'updated_at'  => Carbon::now()->toDateTimeString(),
            ]);

            // 1 a 5 items por venta
            $items = rand(1, 5);
            $total = 0;

            for ($k = 0; $k < $items; $k++) {
                $p = $products[array_rand($products)];
                $cantidad = rand(1, 5);
                $precio   = (float) $p->precio;
                $subtotal = round($cantidad * $precio, 2);
                $total += $subtotal;

                DB::table('sale_details')->insert([
                    'sale_id'         => $saleId,
                    'product_id'      => $p->id,
                    'cantidad'        => $cantidad,
                    'precio_unitario' => $precio,
                    'subtotal'        => $subtotal,
                    'created_at'      => Carbon::now()->toDateTimeString(),
                    'updated_at'      => Carbon::now()->toDateTimeString(),
                ]);

                // Decrementar stock hasta un mínimo de 0 (no dejamos negativos)
                $currentStock = DB::table('products')->where('id', $p->id)->value('stock');
                $decrement = min($cantidad, max((int)$currentStock, 0));
                if ($decrement > 0) {
                    DB::table('products')->where('id', $p->id)->decrement('stock', $decrement);
                }
            }

            // Actualizar monto total de la venta
            DB::table('sales')->where('id', $saleId)->update([
                'monto_total' => round($total, 2)
            ]);
        }
    }
}
