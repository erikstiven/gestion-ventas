<?php

namespace Tests\Feature\Api\V1;

use Tests\TestCase;
use App\Models\Zone;
use Illuminate\Foundation\Testing\RefreshDatabase;

class ReportsApiTest extends TestCase
{
    use RefreshDatabase;

    /** @test */
    public function devuelve_zonas_sin_ventas_en_rango()
    {
        // Creamos una zona sin ventas
        Zone::factory()->create(['nombre_zona' => 'Z1']);

        $res = $this->getJson('/api/v1/reports/zonas-sin-ventas?start_date=2023-01-01&end_date=2023-12-31');

        $res->assertOk()
            ->assertJsonStructure(['data','links','meta'])
            ->assertJsonFragment(['nombre_zona' => 'Z1']);
    }
}
