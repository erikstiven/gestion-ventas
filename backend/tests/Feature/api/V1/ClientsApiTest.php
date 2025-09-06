<?php

namespace Tests\Feature\Api\V1;

use Tests\TestCase;
use App\Models\Client;
use Illuminate\Foundation\Testing\RefreshDatabase;

class ClientsApiTest extends TestCase
{
    use RefreshDatabase;

    /** @test */
    public function lista_clientes_paginados_y_por_busqueda()
    {
        // Crea algunos datos
        Client::factory()->create(['nombre' => 'Ana']);
        Client::factory()->create(['nombre' => 'Bruno']);
        Client::factory()->create(['nombre' => 'Carla']);

        // Busca por "a" y pagina de 2
        $res = $this->getJson('/api/v1/clients?per_page=2&search=a');

        $res->assertOk()
            ->assertJsonStructure(['data','links','meta']);

        // Asegura que meta.per_page = 2
        $this->assertSame(2, $res->json('meta.per_page'));
    }
}
