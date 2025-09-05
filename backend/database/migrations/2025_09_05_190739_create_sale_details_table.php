<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('sale_details', function (Blueprint $table) {
            $table->id(); // ID_DETALLE_VENTA

            // FKs: id_venta, id_producto
            $table->foreignId('sale_id')
                  ->constrained('sales')
                  ->cascadeOnDelete(); // si se borra la venta, se borran sus detalles

            $table->foreignId('product_id')
                  ->constrained('products');

            $table->unsignedInteger('cantidad');
            $table->decimal('precio_unitario', 12, 2);
            $table->decimal('subtotal', 12, 2);

            // Otros campos relevantes:
            $table->json('meta')->nullable();

            $table->timestamps();

            $table->index(['sale_id', 'product_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('sale_details');
    }
};

