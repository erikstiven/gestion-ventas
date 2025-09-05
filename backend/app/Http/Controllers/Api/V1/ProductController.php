<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\ProductRequest;
use App\Http\Resources\ProductResource;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    use HandlesIndexParams;

    public function index(Request $request)
    {
        [$col,$dir] = $this->sortParams(['id','nombre','precio','stock','categoria','created_at'],'id');
        $q = Product::query();

        if ($s = trim((string) $request->query('search',''))) {
            $q->where(function ($w) use ($s) {
                $w->where('nombre', 'like', "%$s%")
                  ->orWhere('categoria', 'like', "%$s%");
            });
        }

        $q->orderBy($col, $dir);

        return ProductResource::collection(
            $q->paginate($this->perPage())->appends($request->query())
        );
    }

    public function store(ProductRequest $request)
    {
        $product = Product::create($request->validated());
        return (new ProductResource($product))
            ->response()
            ->setStatusCode(201);
    }

    public function show(Product $product)
    {
        return new ProductResource($product);
    }

    public function update(ProductRequest $request, Product $product)
    {
        $product->update($request->validated());
        return new ProductResource($product);
    }

    public function destroy(Product $product)
    {
        $product->delete();
        return response()->noContent();
    }
}
