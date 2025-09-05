<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\ZoneRequest;
use App\Http\Resources\ZoneResource;
use App\Models\Zone;
use Illuminate\Http\Request;

class ZoneController extends Controller
{
    use HandlesIndexParams;

    public function index(Request $request)
    {
        [$col,$dir] = $this->sortParams(['id','nombre_zona','created_at'],'id');
        $q = Zone::query();

        if ($s = trim((string) $request->query('search',''))) {
            $q->where('nombre_zona', 'like', "%$s%");
        }

        $q->orderBy($col, $dir);

        return ZoneResource::collection(
            $q->paginate($this->perPage())->appends($request->query())
        );
    }

    public function store(ZoneRequest $request)
    {
        $zone = Zone::create($request->validated());
        return (new ZoneResource($zone))->response()->setStatusCode(201);
    }

    public function show(Zone $zone)
    {
        return new ZoneResource($zone);
    }

    public function update(ZoneRequest $request, Zone $zone)
    {
        $zone->update($request->validated());
        return new ZoneResource($zone);
    }

    public function destroy(Zone $zone)
    {
        $zone->delete();
        return response()->noContent();
    }
}
