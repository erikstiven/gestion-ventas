<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\ClientRequest;
use App\Http\Resources\ClientResource;
use App\Models\Client;
use Illuminate\Http\Request;

class ClientController extends Controller
{
    use HandlesIndexParams;

    public function index(Request $request)
    {
        [$col,$dir] = $this->sortParams(['id','nombre','email','created_at'],'id');
        $q = Client::query();

        if ($s = trim((string) $request->query('search',''))) {
            $q->where(function($w) use ($s){
                $w->where('nombre','like',"%$s%")->orWhere('email','like',"%$s%");
            });
        }

        $q->orderBy($col,$dir);
        return ClientResource::collection($q->paginate($this->perPage())->appends($request->query()));
    }

    public function store(ClientRequest $request)
    {
        $client = Client::create($request->validated());
        return new ClientResource($client);
    }

    public function show(Client $client)
    {
        return new ClientResource($client);
    }

    public function update(ClientRequest $request, Client $client)
    {
        $client->update($request->validated());
        return new ClientResource($client);
    }

    public function destroy(Client $client)
    {
        $client->delete();
        return response()->noContent();
    }
}
