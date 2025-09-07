<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ClientSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('clients')->truncate();

        $rows = [];
        $nombres = [
            'Comercial Andrade', 'TecnoMax', 'Ferretería La 10', 'Market Sur',
            'Papelería Iris', 'Distribuidora Mar', 'Agro Loja', 'Muebles Centro'
        ];

        foreach ($nombres as $i => $n) {
            $rows[] = [
                'nombre' => $n,
                'email' => 'cliente'.($i+1).'@example.com',
                'direccion' => 'Av. '.($i+1),
                'telefono' => '099'.str_pad((string)($i+1), 7, '0', STR_PAD_LEFT),
            ];
        }

        DB::table('clients')->insert($rows);
    }
}
