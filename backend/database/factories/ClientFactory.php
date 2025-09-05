<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class ClientFactory extends Factory
{
    public function definition(): array
    {
        return [
            'nombre'    => $this->faker->name(),
            'email'     => $this->faker->unique()->safeEmail(),
            'telefono'  => $this->faker->optional()->numerify('09########'),
            'direccion' => $this->faker->optional()->streetAddress(),
            'meta'      => null,
        ];
    }
}
