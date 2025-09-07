<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\SellerRequest;
use App\Http\Resources\SellerResource;
use App\Models\Seller;
use Illuminate\Http\Request;

class SellerController extends Controller
{
    use HandlesIndexParams;

    /**
     * Listado paginado de vendedores.
     * Soporta búsqueda (nombre, email, documento) y orden por columnas permitidas.
     */
    public function index(Request $request)
    {
        // columnas permitidas para ordenar y columna por defecto
        [$col, $dir] = $this->sortParams(
            ['id', 'nombre', 'email', 'documento', 'created_at'],
            'id'
        );

        $q = Seller::query();

        if ($s = trim((string) $request->query('search', ''))) {
            $q->where(function ($w) use ($s) {
                $w->where('nombre', 'like', "%$s%")
                  ->orWhere('email', 'like', "%$s%")
                  ->orWhere('documento', 'like', "%$s%")
                  ->orWhere('document', 'like', "%$s%")
                  ->orWhere('cedula', 'like', "%$s%");
            });
        }

        // Sanitizar columna/dirección (por seguridad)
        $allowed = ['id', 'nombre', 'email', 'documento', 'created_at'];
        if (! in_array($col, $allowed, true)) {
            $col = 'id';
        }
        $dir = strtolower((string) $dir) === 'asc' ? 'asc' : 'desc';

        $q->orderBy($col, $dir);

        return SellerResource::collection(
            $q->paginate($this->perPage())->appends($request->query())
        );
    }

    /**
     * Crear un vendedor.
     * Usa SellerRequest para la validación.
     */
    public function store(SellerRequest $request)
    {
        $data = $request->validated();

        $seller = Seller::create($data);

        return (new SellerResource($seller))
            ->response()
            ->setStatusCode(201);
    }

    /**
     * Mostrar un vendedor.
     */
    public function show(Seller $seller)
    {
        return new SellerResource($seller);
    }

    /**
     * Actualizar un vendedor.
     */
    public function update(SellerRequest $request, Seller $seller)
    {
        $data = $request->validated();

        $seller->update($data);

        return new SellerResource($seller);
    }

    /**
     * Eliminar (soft delete) un vendedor.
     */
    public function destroy(Seller $seller)
    {
        $seller->delete();

        return response()->noContent();
    }
}
