<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('sales', function (Blueprint $table) {
            $table->id(); // ID_VENTA

            // FKs: id_cliente, id_vendedor, id_zona
            $table->foreignId('client_id')->constrained('clients');
            $table->foreignId('seller_id')->constrained('sellers');
            $table->foreignId('zone_id')->constrained('zones');

            $table->dateTime('fecha');                // fecha/hora de la venta
            $table->decimal('monto_total', 12, 2);    // total de la venta
            // Otros campos relevantes:
            $table->string('metodo_pago')->nullable();
            $table->string('estado')->default('pagada'); // pagada|pendiente|anulada
            $table->json('meta')->nullable();

            $table->timestamps();
            $table->softDeletes();

            $table->index(['fecha']);
            $table->index(['client_id', 'seller_id', 'zone_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('sales');
    }
};
