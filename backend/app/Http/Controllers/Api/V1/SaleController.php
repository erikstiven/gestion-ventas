<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\SaleStoreRequest;
use App\Http\Resources\SaleResource;
use App\Models\{Sale, SaleDetail, Product};
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SaleController extends Controller
{
    use HandlesIndexParams;

    public function index(Request $request)
    {
        [$col,$dir] = $this->sortParams(
            ['id','fecha','monto_total','client_id','seller_id','zone_id'],
            'fecha'
        );

        $q = Sale::with(['client','seller','zone','details']);

        if ($s = trim((string) $request->query('search',''))) {
            $q->where(function($w) use ($s) {
                $w->whereHas('client', fn($qq)=>$qq->where('nombre','like',"%$s%"))
                  ->orWhereHas('seller', fn($qq)=>$qq->where('nombre','like',"%$s%"));
            });
        }

        if ($start = $request->query('start_date')) {
            $q->where('fecha','>=',$start);
        }
        if ($end = $request->query('end_date')) {
            $q->where('fecha','<=',$end);
        }
        if ($year = $request->query('year')) {
            $q->whereYear('fecha', (int) $year);
        }

        $q->orderBy($col,$dir);

        return SaleResource::collection($q->paginate($this->perPage())->appends($request->query()));
    }

    public function store(SaleStoreRequest $request)
    {
        return DB::transaction(function() use ($request) {
            $data = $request->validated();
            $det  = collect($data['detalles']);

            $monto = $det->reduce(
                fn($c,$d)=> $c + ((float)$d['precio_unitario'] * (int)$d['cantidad']), 0.0
            );

            $sale = Sale::create([
                'client_id'   => $data['client_id'],
                'seller_id'   => $data['seller_id'],
                'zone_id'     => $data['zone_id'],
                'fecha'       => $data['fecha'],
                'monto_total' => $monto,
                'metodo_pago' => $request->string('metodo_pago')->toString(),
                'estado'      => $request->string('estado')->toString() ?: 'pagada',
            ]);

            foreach ($det as $d) {
                SaleDetail::create([
                    'sale_id'         => $sale->id,
                    'product_id'      => $d['product_id'],
                    'cantidad'        => (int)$d['cantidad'],
                    'precio_unitario' => (float)$d['precio_unitario'],
                    'subtotal'        => (float)$d['precio_unitario'] * (int)$d['cantidad'],
                ]);

                // Descontar stock
                Product::where('id',$d['product_id'])->decrement('stock', (int)$d['cantidad']);
            }

            return new SaleResource($sale->load(['client','seller','zone','details']));
        });
    }

    public function show(Sale $sale)
    {
        return new SaleResource($sale->load(['client','seller','zone','details']));
    }

    public function destroy(Sale $sale)
    {
        $sale->delete();
        return response()->noContent();
    }
}
