<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class ProductFactory extends Factory
{
    public function definition(): array
    {
        return [
            'nombre'     => $this->faker->unique()->words(3, true),
            'descripcion'=> $this->faker->optional()->sentence(12),
            'precio'     => $this->faker->randomFloat(2, 5, 500), // 5.00 - 500.00
            'stock'      => $this->faker->numberBetween(50, 500), // alto para no agotar en seeding
            'categoria'  => $this->faker->optional()->randomElement(['Electrónica','Ropa','Hogar','Deportes','Accesorios']),
            'activo'     => true,
            'meta'       => null,
        ];
    }
}
