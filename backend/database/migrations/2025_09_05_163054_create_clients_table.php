<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('clients', function (Blueprint $table) {
            $table->id(); // ID_CLIENTE
            $table->string('nombre');
            $table->string('email')->unique();
            $table->string('telefono', 30)->nullable();
            $table->string('direccion')->nullable();
            // Otros campos relevantes (flexible):
            $table->json('meta')->nullable();

            $table->timestamps();
            $table->softDeletes();

            $table->index(['nombre']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('clients');
    }
};
