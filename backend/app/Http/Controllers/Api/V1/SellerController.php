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

    public function index(Request $request)
    {
        [$col,$dir] = $this->sortParams(['id','nombre','email','created_at'],'id');
        $q = Seller::query();

        if ($s = trim((string) $request->query('search',''))) {
            $q->where(function($w) use ($s){
                $w->where('nombre','like',"%$s%")
                  ->orWhere('email','like',"%$s%");
            });
        }

        $q->orderBy($col,$dir);
        return SellerResource::collection($q->paginate($this->perPage())->appends($request->query()));
    }

    public function store(SellerRequest $request)
    {
        $seller = Seller::create($request->validated());
        return new SellerResource($seller);
    }

    public function show(Seller $seller)
    {
        return new SellerResource($seller);
    }

    public function update(SellerRequest $request, Seller $seller)
    {
        $seller->update($request->validated());
        return new SellerResource($seller);
    }

    public function destroy(Seller $seller)
    {
        $seller->delete();
        return response()->noContent();
    }
}
