<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class ZoneFactory extends Factory
{
    public function definition(): array
    {
        return [
            'nombre_zona' => 'Zona ' . $this->faker->unique()->randomElement(['Norte','Sur','Centro','Este','Oeste']) . ' ' . $this->faker->unique()->randomNumber(2),
            'descripcion' => $this->faker->optional()->sentence(),
            'meta'        => null,
        ];
    }
}
