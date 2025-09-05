<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ReportsController extends Controller
{
    use HandlesIndexParams;

    // 1) Zonas con mayor cantidad de ventas agrupadas por vendedor
    public function ventasPorZonaPorVendedor(Request $r)
    {
        $start = $r->query('start_date');
        $end   = $r->query('end_date');

        $q = DB::table('sales as s')
            ->join('zones as z','z.id','=','s.zone_id')
            ->join('sellers as v','v.id','=','s.seller_id')
            ->select(
                'z.id as zone_id','z.nombre_zona',
                'v.id as seller_id','v.nombre as vendedor',
                DB::raw('COUNT(s.id) as total_ventas'),
                DB::raw('SUM(s.monto_total) as total_monto')
            )
            ->when($start, fn($qq)=>$qq->where('s.fecha','>=',$start))
            ->when($end,   fn($qq)=>$qq->where('s.fecha','<=',$end))
            ->groupBy('z.id','z.nombre_zona','v.id','v.nombre')
            ->orderByDesc('total_ventas');

        return response()->json($q->paginate($this->perPage()));
    }

    // 2) Zonas sin ventas en un intervalo: usar NOT EXISTS para exactitud
    public function zonasSinVentas(Request $r)
    {
        $start = $r->query('start_date');
        $end   = $r->query('end_date');

        $q = DB::table('zones as z')
            ->select('z.id','z.nombre_zona')
            ->whereNotExists(function($sub) use ($start,$end){
                $sub->from('sales as s')
                    ->whereColumn('s.zone_id','z.id')
                    ->when($start, fn($qq)=>$qq->where('s.fecha','>=',$start))
                    ->when($end,   fn($qq)=>$qq->where('s.fecha','<=',$end));
            })
            ->orderBy('z.nombre_zona');

        return response()->json($q->paginate($this->perPage()));
    }

    // 3) Vendedores sin ventas en un intervalo
    public function vendedoresSinVentas(Request $r)
    {
        $start = $r->query('start_date');
        $end   = $r->query('end_date');

        $q = DB::table('sellers as v')
            ->select('v.id','v.nombre','v.email')
            ->whereNotExists(function($sub) use ($start,$end){
                $sub->from('sales as s')
                    ->whereColumn('s.seller_id','v.id')
                    ->when($start, fn($qq)=>$qq->where('s.fecha','>=',$start))
                    ->when($end,   fn($qq)=>$qq->where('s.fecha','<=',$end));
            })
            ->orderBy('v.nombre');

        return response()->json($q->paginate($this->perPage()));
    }

    // 4) Ventas por cliente (2020-2023) + filtro ?year=YYYY opcional
    public function ventasPorCliente(Request $r)
    {
        $year = $r->query('year');

        $years = [2020,2021,2022,2023];
        $selects = [
            'c.id as id_cliente',
            'c.nombre as nombre_cliente',
            DB::raw('COALESCE(MAX(z.nombre_zona), NULL) as zona'),
        ];
        foreach ($years as $y) {
            $selects[] = DB::raw("SUM(CASE WHEN YEAR(s.fecha) = $y THEN s.monto_total ELSE 0 END) as y$y");
        }

        $q = DB::table('clients as c')
            ->leftJoin('sales as s','s.client_id','=','c.id')
            ->leftJoin('zones as z','z.id','=','s.zone_id')
            ->select($selects)
            ->when($year, fn($qq)=>$qq->whereYear('s.fecha', (int)$year))
            ->groupBy('c.id','c.nombre')
            ->orderBy('c.id');

        $res = $q->paginate($this->perPage());

        $mapped = collect($res->items())->map(function($row){
            return [
                'id_cliente'     => (int)$row->id_cliente,
                'nombre_cliente' => $row->nombre_cliente,
                'ventas'         => [
                    '2020' => (float)($row->y2020 ?? 0),
                    '2021' => (float)($row->y2021 ?? 0),
                    '2022' => (float)($row->y2022 ?? 0),
                    '2023' => (float)($row->y2023 ?? 0),
                ],
                'zona'           => $row->zona,
            ];
        });

        return response()->json([
            'data'         => $mapped,
            'current_page' => $res->currentPage(),
            'per_page'     => $res->perPage(),
            'total'        => $res->total(),
        ]);
    }
}
