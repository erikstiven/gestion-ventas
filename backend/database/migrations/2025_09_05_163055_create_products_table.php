<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id(); // ID_PRODUCTO
            $table->string('nombre');
            $table->text('descripcion')->nullable();
            $table->decimal('precio', 12, 2);
            $table->unsignedInteger('stock')->default(0);
            $table->string('categoria')->nullable();
            // Otros campos relevantes:
            $table->boolean('activo')->default(true);
            $table->json('meta')->nullable();

            $table->timestamps();
            $table->softDeletes();

            $table->index(['nombre', 'categoria']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
