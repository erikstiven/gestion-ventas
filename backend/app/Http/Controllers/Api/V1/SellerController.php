<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Resources\SellerResource;
use App\Models\Seller;
use Illuminate\Http\Request;

class SellerController extends Controller
{
    use HandlesIndexParams;

    public function index(Request $request)
    {
        // añadimos 'documento' a los campos permitidos para ordenar
        [$col, $dir] = $this->sortParams(['id','nombre','email','documento','created_at'], 'id');

        $q = Seller::query();

        if ($s = trim((string) $request->query('search',''))) {
            $q->where(function ($w) use ($s) {
                $w->where('nombre', 'like', "%$s%")
                  ->orWhere('email', 'like', "%$s%")
                  // busca por cédula/documento (ajusta el nombre si tu columna tiene otro)
                  ->orWhere('documento', 'like', "%$s%")
                  ->orWhere('document', 'like', "%$s%")
                  ->orWhere('cedula', 'like', "%$s%");
            });
        }

        $q->orderBy($col, $dir);

        return SellerResource::collection(
            $q->paginate($this->perPage())->appends($request->query())
        );
    }

    public function show(Seller $seller)
    {
        return new SellerResource($seller);
    }

    public function destroy(Seller $seller)
    {
        $seller->delete();
        return response()->noContent();
    }
}
