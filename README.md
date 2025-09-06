# Gestión de Ventas (Laravel 12 + React 19)

Proyecto full‑stack para gestionar **clientes, zonas, vendedores, productos y ventas**. Incluye reportes y colecciones Postman.

## Tech
- Backend: Laravel 12, MySQL, Eloquent, Pest/PHPUnit
- Frontend: React 19, Axios, Zustand, Tailwind, React Router
- QA: Postman/Newman

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
PHP 8.2+, Composer, Node 18+, MySQL 8+, Postman (opcional Newman).

## Backend (Laravel)
```bash
cd backend
cp .env.example .env
# Ajusta DB_* en .env
composer install
php artisan key:generate

# Migraciones
php artisan migrate
# o reset + seed de ejemplo
# php artisan migrate:fresh --seed

# Servidor local
php artisan serve  # http://127.0.0.1:8000
```

### Base URL
`http://127.0.0.1:8000/api/v1`

### Filtros comunes
- `page`, `per_page`
- `search`
- `sort`
- Ventas: `start_date`, `end_date`
- Reporte por cliente: `year`

### Reportes
1) `/reports/ventas-por-zona-por-vendedor?start_date=YYYY-MM-DD&end_date=YYYY-MM-DD`  
2) `/reports/zonas-sin-ventas?start_date=YYYY-MM-DD&end_date=YYYY-MM-DD`  
3) `/reports/vendedores-sin-ventas?start_date=YYYY-MM-DD&end_date=YYYY-MM-DD`  
4) `/reports/ventas-por-cliente` (opcional `?year=2020`)


## Postman
Importa:
- `postman/ventas-api-v1.seed-reports.postman_collection.json`
- `postman/ventas-api-v1.crud-all.postman_collection.json`
- `postman/ventas-local.postman_environment.json` (define `base_url`)

### Runner
- Ejecuta carpeta **Seed** y luego **Reports**.
- CRUD en **CRUD ALL** (Clients/Zones/Sellers/Products/Sales).


