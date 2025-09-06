<?php

return [
    'paths' => ['api/*'], // si luego usas Sanctum: añade 'sanctum/csrf-cookie'
    'allowed_methods' => ['*'],
    'allowed_origins' => ['http://localhost:5173','http://127.0.0.1:5173'],
    'allowed_origins_patterns' => [],
    'allowed_headers' => ['*'],
    'exposed_headers' => [],
    'max_age' => 0,
    'supports_credentials' => false, // pon true si enviarás cookies/credenciales
];
