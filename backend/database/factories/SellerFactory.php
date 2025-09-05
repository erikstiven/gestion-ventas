<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class SellerFactory extends Factory
{
    public function definition(): array
    {
        return [
            'nombre'   => $this->faker->name(),
            'email'    => $this->faker->unique()->safeEmail(),
            'telefono' => $this->faker->optional()->numerify('09########'),
            'documento'=> $this->faker->optional()->numerify('##########'),
            'meta'     => null,
        ];
    }
}
