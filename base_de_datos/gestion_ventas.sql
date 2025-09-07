-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-09-2025 a las 06:26:10
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestion_ventas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clients`
--

CREATE TABLE `clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clients`
--

INSERT INTO `clients` (`id`, `nombre`, `email`, `telefono`, `direccion`, `meta`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Comercial Andrade', 'cliente1@example.com', '0990000001', 'Av. 1', NULL, NULL, NULL, NULL),
(2, 'TecnoMax', 'cliente2@example.com', '0990000002', 'Av. 2', NULL, NULL, NULL, NULL),
(3, 'Ferretería La 10', 'cliente3@example.com', '0990000003', 'Av. 3', NULL, NULL, NULL, NULL),
(4, 'Market Sur', 'cliente4@example.com', '0990000004', 'Av. 4', NULL, NULL, NULL, NULL),
(5, 'Papelería Iris', 'cliente5@example.com', '0990000005', 'Av. 5', NULL, NULL, NULL, NULL),
(6, 'Distribuidora Mar', 'cliente6@example.com', '0990000006', 'Av. 6', NULL, NULL, NULL, NULL),
(7, 'Agro Loja', 'cliente7@example.com', '0990000007', 'Av. 7', NULL, NULL, NULL, NULL),
(8, 'Muebles Centro', 'cliente8@example.com', '0990000008', 'Av. 8', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_09_05_163054_create_clients_table', 1),
(5, '2025_09_05_163054_create_zones_table', 1),
(6, '2025_09_05_163055_create_products_table', 1),
(7, '2025_09_05_163055_create_sellers_table', 1),
(8, '2025_09_05_163056_create_sales_table', 1),
(9, '2025_09_05_190739_create_sale_details_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(12,2) NOT NULL,
  `stock` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `categoria` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`id`, `nombre`, `descripcion`, `precio`, `stock`, `categoria`, `activo`, `meta`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Producto A', NULL, 5.50, 12, NULL, 1, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13', NULL),
(2, 'Producto B', NULL, 8.25, 0, NULL, 1, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13', NULL),
(3, 'Producto C', NULL, 12.00, 0, NULL, 1, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13', NULL),
(4, 'Producto D', NULL, 15.75, 0, NULL, 1, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13', NULL),
(5, 'Producto E', NULL, 22.40, 0, NULL, 1, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13', NULL),
(6, 'Producto F', NULL, 31.90, 6, NULL, 1, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13', NULL),
(7, 'Producto G', NULL, 2.99, 1, NULL, 1, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:34', NULL),
(8, 'Producto H', NULL, 18.30, 4, NULL, 1, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13', NULL),
(9, 'Producto I', NULL, 7.10, 9, NULL, 1, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13', NULL),
(10, 'Producto J', NULL, 10.00, 0, NULL, 1, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sales`
--

CREATE TABLE `sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `seller_id` bigint(20) UNSIGNED NOT NULL,
  `zone_id` bigint(20) UNSIGNED NOT NULL,
  `fecha` datetime NOT NULL,
  `monto_total` decimal(12,2) NOT NULL,
  `metodo_pago` varchar(255) DEFAULT NULL,
  `estado` varchar(255) NOT NULL DEFAULT 'pagada',
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sales`
--

INSERT INTO `sales` (`id`, `client_id`, `seller_id`, `zone_id`, `fecha`, `monto_total`, `metodo_pago`, `estado`, `meta`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 8, 1, 2, '2023-08-16 00:00:00', 77.85, 'transferencia', 'pendiente', NULL, '2023-08-16 05:00:00', '2025-09-07 09:19:13', NULL),
(2, 8, 1, 1, '2025-03-26 00:00:00', 29.58, 'efectivo', 'pagada', NULL, '2025-03-26 05:00:00', '2025-09-07 09:19:13', NULL),
(3, 5, 5, 8, '2023-11-25 00:00:00', 241.95, 'transferencia', 'anulada', NULL, '2023-11-25 05:00:00', '2025-09-07 09:19:13', NULL),
(4, 3, 7, 8, '2023-11-24 00:00:00', 136.85, 'transferencia', 'anulada', NULL, '2023-11-24 05:00:00', '2025-09-07 09:19:14', NULL),
(5, 5, 1, 6, '2023-06-04 00:00:00', 100.99, 'efectivo', 'pagada', NULL, '2023-06-04 05:00:00', '2025-09-07 09:19:14', NULL),
(6, 7, 8, 5, '2021-07-16 00:00:00', 70.00, 'efectivo', 'pagada', NULL, '2021-07-16 05:00:00', '2025-09-07 09:19:14', NULL),
(7, 6, 5, 6, '2021-04-28 00:00:00', 259.72, 'tarjeta', 'pendiente', NULL, '2021-04-28 05:00:00', '2025-09-07 09:19:14', NULL),
(8, 3, 5, 3, '2023-03-11 00:00:00', 302.60, 'depósito', 'anulada', NULL, '2023-03-11 05:00:00', '2025-09-07 09:19:14', NULL),
(9, 8, 7, 1, '2020-04-27 00:00:00', 187.42, 'efectivo', 'anulada', NULL, '2020-04-27 05:00:00', '2025-09-07 09:19:14', NULL),
(10, 8, 8, 2, '2022-11-12 00:00:00', 127.15, 'depósito', 'anulada', NULL, '2022-11-12 05:00:00', '2025-09-07 09:19:14', NULL),
(11, 1, 7, 4, '2023-08-23 00:00:00', 67.20, 'depósito', 'pagada', NULL, '2023-08-23 05:00:00', '2025-09-07 09:19:14', NULL),
(12, 3, 6, 4, '2024-08-06 00:00:00', 164.68, 'tarjeta', 'anulada', NULL, '2024-08-06 05:00:00', '2025-09-07 09:19:14', NULL),
(13, 4, 7, 8, '2021-08-13 00:00:00', 229.85, 'efectivo', 'pendiente', NULL, '2021-08-13 05:00:00', '2025-09-07 09:19:14', NULL),
(14, 7, 7, 7, '2022-03-23 00:00:00', 87.40, 'tarjeta', 'anulada', NULL, '2022-03-23 05:00:00', '2025-09-07 09:19:14', NULL),
(15, 7, 2, 4, '2020-05-09 00:00:00', 99.94, 'tarjeta', 'pagada', NULL, '2020-05-09 05:00:00', '2025-09-07 09:19:14', NULL),
(16, 2, 1, 2, '2025-05-02 00:00:00', 134.80, 'efectivo', 'pendiente', NULL, '2025-05-02 05:00:00', '2025-09-07 09:19:14', NULL),
(17, 3, 2, 7, '2023-08-08 00:00:00', 53.05, 'tarjeta', 'pagada', NULL, '2023-08-08 05:00:00', '2025-09-07 09:19:14', NULL),
(18, 2, 3, 4, '2020-01-16 00:00:00', 20.00, 'depósito', 'anulada', NULL, '2020-01-16 05:00:00', '2025-09-07 09:19:14', NULL),
(19, 8, 5, 4, '2024-02-11 00:00:00', 77.29, 'transferencia', 'pagada', NULL, '2024-02-11 05:00:00', '2025-09-07 09:19:14', NULL),
(20, 3, 4, 4, '2021-01-18 00:00:00', 140.55, 'tarjeta', 'pendiente', NULL, '2021-01-18 05:00:00', '2025-09-07 09:19:14', NULL),
(21, 1, 2, 2, '2025-09-06 00:00:00', 2.99, '', 'pagada', NULL, '2025-09-07 09:19:34', '2025-09-07 09:19:34', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sale_details`
--

CREATE TABLE `sale_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL,
  `precio_unitario` decimal(12,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sale_details`
--

INSERT INTO `sale_details` (`id`, `sale_id`, `product_id`, `cantidad`, `precio_unitario`, `subtotal`, `meta`, `created_at`, `updated_at`) VALUES
(1, 1, 8, 2, 18.30, 36.60, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13'),
(2, 1, 2, 5, 8.25, 41.25, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13'),
(3, 2, 9, 1, 7.10, 7.10, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13'),
(4, 2, 1, 3, 5.50, 16.50, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13'),
(5, 2, 7, 2, 2.99, 5.98, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13'),
(6, 3, 2, 3, 8.25, 24.75, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13'),
(7, 3, 6, 4, 31.90, 127.60, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13'),
(8, 3, 5, 4, 22.40, 89.60, NULL, '2025-09-07 09:19:13', '2025-09-07 09:19:13'),
(9, 4, 5, 1, 22.40, 22.40, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(10, 4, 5, 3, 22.40, 67.20, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(11, 4, 4, 3, 15.75, 47.25, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(12, 5, 7, 1, 2.99, 2.99, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(13, 5, 3, 4, 12.00, 48.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(14, 5, 10, 5, 10.00, 50.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(15, 6, 10, 1, 10.00, 10.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(16, 6, 3, 5, 12.00, 60.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(17, 7, 7, 3, 2.99, 8.97, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(18, 7, 6, 5, 31.90, 159.50, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(19, 7, 10, 5, 10.00, 50.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(20, 7, 2, 5, 8.25, 41.25, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(21, 8, 4, 4, 15.75, 63.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(22, 8, 5, 5, 22.40, 112.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(23, 8, 6, 4, 31.90, 127.60, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(24, 9, 9, 2, 7.10, 14.20, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(25, 9, 2, 5, 8.25, 41.25, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(26, 9, 3, 5, 12.00, 60.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(27, 9, 4, 4, 15.75, 63.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(28, 9, 7, 3, 2.99, 8.97, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(29, 10, 3, 3, 12.00, 36.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(30, 10, 6, 1, 31.90, 31.90, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(31, 10, 3, 1, 12.00, 12.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(32, 10, 4, 3, 15.75, 47.25, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(33, 11, 5, 3, 22.40, 67.20, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(34, 12, 7, 2, 2.99, 5.98, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(35, 12, 5, 3, 22.40, 67.20, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(36, 12, 8, 5, 18.30, 91.50, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(37, 13, 5, 4, 22.40, 89.60, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(38, 13, 3, 5, 12.00, 60.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(39, 13, 4, 3, 15.75, 47.25, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(40, 13, 2, 3, 8.25, 24.75, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(41, 13, 2, 1, 8.25, 8.25, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(42, 14, 9, 2, 7.10, 14.20, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(43, 14, 8, 1, 18.30, 18.30, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(44, 14, 8, 3, 18.30, 54.90, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(45, 15, 10, 5, 10.00, 50.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(46, 15, 3, 1, 12.00, 12.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(47, 15, 7, 2, 2.99, 5.98, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(48, 15, 7, 4, 2.99, 11.96, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(49, 15, 10, 2, 10.00, 20.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(50, 16, 8, 5, 18.30, 91.50, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(51, 16, 9, 3, 7.10, 21.30, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(52, 16, 1, 4, 5.50, 22.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(53, 17, 2, 1, 8.25, 8.25, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(54, 17, 5, 2, 22.40, 44.80, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(55, 18, 10, 2, 10.00, 20.00, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(56, 19, 1, 1, 5.50, 5.50, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(57, 19, 5, 2, 22.40, 44.80, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(58, 19, 4, 1, 15.75, 15.75, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(59, 19, 2, 1, 8.25, 8.25, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(60, 19, 7, 1, 2.99, 2.99, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(61, 20, 2, 3, 8.25, 24.75, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(62, 20, 9, 3, 7.10, 21.30, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(63, 20, 4, 5, 15.75, 78.75, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(64, 20, 4, 1, 15.75, 15.75, NULL, '2025-09-07 09:19:14', '2025-09-07 09:19:14'),
(65, 21, 7, 1, 2.99, 2.99, NULL, '2025-09-07 09:19:34', '2025-09-07 09:19:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sellers`
--

CREATE TABLE `sellers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `documento` varchar(255) DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sellers`
--

INSERT INTO `sellers` (`id`, `nombre`, `email`, `telefono`, `documento`, `meta`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Juan Pérez', 'juan.perez@example.com', '0980001111', '0102030405', NULL, NULL, NULL, NULL),
(2, 'Carla Rojas', 'carla.rojas@example.com', '0980002222', '0203040506', NULL, NULL, NULL, NULL),
(3, 'Luis Andrade', 'luis.andrade@example.com', '0980003333', '0304050607', NULL, NULL, NULL, NULL),
(4, 'María Torres', 'maria.torres@example.com', '0980004444', '0405060708', NULL, NULL, NULL, NULL),
(5, 'Pedro Cedeño', 'pedro.cedeno@example.com', '0980005555', '0506070809', NULL, NULL, NULL, NULL),
(6, 'Elena Cabrera', 'elena.cabrera@example.com', '0980006666', '0607080910', NULL, NULL, NULL, NULL),
(7, 'Sandra Morales', 'sandra.morales@example.com', '0980007777', '0708091011', NULL, NULL, NULL, NULL),
(8, 'Diego Almeida', 'diego.almeida@example.com', '0980008888', '0809101112', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zones`
--

CREATE TABLE `zones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre_zona` varchar(255) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `zones`
--

INSERT INTO `zones` (`id`, `nombre_zona`, `descripcion`, `meta`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Zona Norte', 'Cobertura norte', NULL, NULL, NULL, NULL),
(2, 'Zona Sur', 'Cobertura sur', NULL, NULL, NULL, NULL),
(3, 'Zona Centro', 'Cobertura centro', NULL, NULL, NULL, NULL),
(4, 'Zona Este', 'Cobertura este', NULL, NULL, NULL, NULL),
(5, 'Zona Oeste', 'Cobertura oeste', NULL, NULL, NULL, NULL),
(6, 'Zona Amazonía', 'Sin ventas para pruebas', NULL, NULL, NULL, NULL),
(7, 'Zona Sierra Alta', 'Sin ventas para pruebas', NULL, NULL, NULL, NULL),
(8, 'Zona Costa Lejana', 'Sin ventas para pruebas', NULL, NULL, NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clients_email_unique` (`email`),
  ADD KEY `clients_nombre_index` (`nombre`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_nombre_categoria_index` (`nombre`,`categoria`);

--
-- Indices de la tabla `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sales_seller_id_foreign` (`seller_id`),
  ADD KEY `sales_zone_id_foreign` (`zone_id`),
  ADD KEY `sales_fecha_index` (`fecha`),
  ADD KEY `sales_client_id_seller_id_zone_id_index` (`client_id`,`seller_id`,`zone_id`);

--
-- Indices de la tabla `sale_details`
--
ALTER TABLE `sale_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_details_product_id_foreign` (`product_id`),
  ADD KEY `sale_details_sale_id_product_id_index` (`sale_id`,`product_id`);

--
-- Indices de la tabla `sellers`
--
ALTER TABLE `sellers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sellers_email_unique` (`email`),
  ADD KEY `sellers_nombre_index` (`nombre`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indices de la tabla `zones`
--
ALTER TABLE `zones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `zones_nombre_zona_unique` (`nombre_zona`),
  ADD KEY `zones_nombre_zona_index` (`nombre_zona`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clients`
--
ALTER TABLE `clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `sale_details`
--
ALTER TABLE `sale_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT de la tabla `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `zones`
--
ALTER TABLE `zones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `sales_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `sellers` (`id`),
  ADD CONSTRAINT `sales_zone_id_foreign` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`id`);

--
-- Filtros para la tabla `sale_details`
--
ALTER TABLE `sale_details`
  ADD CONSTRAINT `sale_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `sale_details_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
