# Gestión de Ventas (Laravel 12 + React 19)

Proyecto full‑stack para gestionar **clientes, zonas, vendedores, productos y ventas**.  
Incluye reportes y colecciones Postman.

## Tech
- Backend: Laravel 12, MySQL, Eloquent, Pest/PHPUnit
- Frontend: React 19, Axios, Zustand, Tailwind, React Router
- QA: Postman

## Estructura
```
gestion-ventas/
├─ backend/
├─ frontend/
├─ postman/
│  ├─ ventas-api-v1.seed-reports.postman_collection.json
│  ├─ ventas-api-v1.crud-all.postman_collection.json
│  └─ ventas-local.postman_environment.json
└─ README.md
```

## Requisitos
- PHP 8.2+
- Composer
- Node 18+
- MySQL 8+
- Postman

## Backend (Laravel)
```bash
cd backend
cp .env.example .env
# Ajusta DB_* en .env según tu MySQL
composer install
php artisan key:generate
php artisan migrate --seed
php artisan serve


## Frontend (React + Vite)
cd frontend
npm install
npm run dev

```

## Scripts comunes
- **Backend tests**: `php artisan test` o `./vendor/bin/pest`
- **Frontend lint**: `npm run lint`
- **Build frontend**: `npm run build`

## QA (Postman)
Antes de probar la API, asegúrate de tener la base de datos vacía y migrada:
```bash
cd backend
php artisan migrate
```

Para probar la API se incluyen colecciones y un environment en la carpeta`postman`.
1. Abre la aplicación Postman.
2. Importa los archivos:
   - `postman/Ventas API v1 — CRUD ALL.postman_collection.json`
   - `postman/Ventas API v1 — Seed + Reports.postman_collection.json`
   - `postman/ventas-local.postman_environment.json`
3. Selecciona el environment **ventas-local**.
4. Abre la colección que quieras probar y presiona el botón **Run** (arriba a la derecha en Postman).
5. Se ejecutarán automáticamente todas las requests definidas en esa colección.
las requests directamente desde Postman.
```
---
Proyecto técnico de prueba: Gestión de Ventas (Laravel + React) = 100% Cumplido
👨‍💻 Autor: Pir Erik Quisnia