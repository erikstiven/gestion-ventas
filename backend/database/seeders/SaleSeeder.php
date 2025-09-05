<?php

namespace Database\Seeders;

use App\Models\{Client, Seller, Zone, Product, Sale, SaleDetail};
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;  // Asegúrate de importar Log

class SaleSeeder extends Seeder
{
    public function run(): void
    {
        $clients  = Client::pluck('id')->all();
        $sellers  = Seller::pluck('id')->all();
        $zones    = Zone::pluck('id')->all();
        $products = Product::select('id', 'precio', 'stock')->get();

        if (empty($clients) || empty($sellers) || empty($zones) || $products->isEmpty()) {
            return;
        }

        // Ventas distribuidas entre 2020 y 2023 (como exige el reporte)
        $years = [2020, 2021, 2022, 2023];
        $totalSales = 300; // ajusta volumen si deseas

        for ($i = 0; $i < $totalSales; $i++) {
            DB::transaction(function () use ($clients, $sellers, $zones, $products, $years) {
                $clientId = $clients[array_rand($clients)];
                $sellerId = $sellers[array_rand($sellers)];
                $zoneId   = $zones[array_rand($zones)];

                $year  = $years[array_rand($years)];
                $month = rand(1, 12);
                $day   = rand(1, 28);
                $hour  = rand(8, 20);
                $min   = rand(0, 59);
                $fecha = sprintf('%04d-%02d-%02d %02d:%02d:00', $year, $month, $day, $hour, $min);

                $sale = Sale::create([
                    'client_id'   => $clientId,
                    'seller_id'   => $sellerId,
                    'zone_id'     => $zoneId,
                    'fecha'       => $fecha,
                    'monto_total' => 0, // se recalcula abajo
                    'metodo_pago' => rand(0, 1) ? 'tarjeta' : 'efectivo',
                    'estado'      => 'pagada',
                ]);

                // 1 a 5 ítems por venta
                $itemsCount = rand(1, 5);
                $monto      = 0.0;

                for ($k = 0; $k < $itemsCount; $k++) {
                    $p = $products->random();

                    // Cantidad razonable según stock disponible
                    $maxQty = max(1, min(10, (int)$p->stock));
                    $qty    = rand(1, $maxQty);

                    // Asegúrate de que no decremente el stock a un valor negativo
                    if ($p->stock > 0) {
                        $qty = min($qty, $p->stock);  // Ajusta la cantidad si es mayor que el stock disponible

                        $precioUnit = (float)$p->precio;
                        $sub        = $precioUnit * $qty;
                        $monto     += $sub;

                        SaleDetail::create([
                            'sale_id'        => $sale->id,
                            'product_id'     => $p->id,
                            'cantidad'       => $qty,
                            'precio_unitario'=> $precioUnit,
                            'subtotal'       => $sub,
                        ]);

                        // Descontar stock solo si hay suficiente
                        $p->decrement('stock', $qty);  // Esto asegura que el decremento no sea negativo
                    } else {
                        Log::warning("Producto con ID {$p->id} no tiene suficiente stock.");
                    }
                }

                $sale->update(['monto_total' => $monto]);
            });
        }
    }
}
