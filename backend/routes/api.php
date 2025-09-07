<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\V1\{
    ClientController,
    ZoneController,
    SellerController,
    ProductController,
    SaleController,
    ReportsController
};

Route::prefix('v1')->group(function () {
    Route::apiResource('clients', ClientController::class);
    Route::apiResource('zones', ZoneController::class);
    Route::apiResource('sellers', SellerController::class);
    Route::apiResource('products', ProductController::class);
    Route::apiResource('sales', SaleController::class)->except(['update']);

    Route::get('reports/ventas-por-zona-por-vendedor', [ReportsController::class, 'ventasPorZonaPorVendedor']);
    Route::get('reports/zonas-sin-ventas',             [ReportsController::class, 'zonasSinVentas']);
    Route::get('reports/vendedores-sin-ventas',        [ReportsController::class, 'vendedoresSinVentas']);
    Route::get('reports/ventas-por-cliente',           [ReportsController::class, 'ventasPorCliente']);
});
