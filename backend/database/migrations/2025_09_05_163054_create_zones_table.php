<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('zones', function (Blueprint $table) {
            $table->id(); // ID_ZONA
            $table->string('nombre_zona')->unique();
            $table->string('descripcion')->nullable();
            // Otros campos relevantes:
            $table->json('meta')->nullable();

            $table->timestamps();
            $table->softDeletes();

            $table->index(['nombre_zona']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('zones');
    }
};
