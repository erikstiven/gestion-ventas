-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-09-2025 a las 01:47:14
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
(8, 'Muebles Centro', 'cliente8@example.com', '0990000008', 'Av. 8', NULL, NULL, NULL, NULL),
(9, 'Textiles Quito', 'cliente9@example.com', '0990000009', 'Av. 9', NULL, NULL, NULL, NULL),
(10, 'Bazar Norte', 'cliente10@example.com', '0990000010', 'Av. 10', NULL, NULL, NULL, NULL),
(11, 'Farmacia Vida', 'cliente11@example.com', '0990000011', 'Av. 11', NULL, NULL, NULL, NULL),
(12, 'Boutique Azul', 'cliente12@example.com', '0990000012', 'Av. 12', NULL, NULL, NULL, NULL),
(13, 'Panadería Aroma', 'cliente13@example.com', '0990000013', 'Av. 13', NULL, NULL, NULL, NULL),
(14, 'Cárnicos El Buen Corte', 'cliente14@example.com', '0990000014', 'Av. 14', NULL, NULL, NULL, NULL),
(15, 'Automotriz Sierra', 'cliente15@example.com', '0990000015', 'Av. 15', NULL, NULL, NULL, NULL),
(16, 'Gastro Sur', 'cliente16@example.com', '0990000016', 'Av. 16', NULL, NULL, NULL, NULL),
(17, 'Hotel Costa', 'cliente17@example.com', '0990000017', 'Av. 17', NULL, NULL, NULL, NULL),
(18, 'Servicios Andes', 'cliente18@example.com', '0990000018', 'Av. 18', NULL, NULL, NULL, NULL),
(19, 'Clínica Norte', 'cliente19@example.com', '0990000019', 'Av. 19', NULL, NULL, NULL, NULL),
(20, 'Licores Oro', 'cliente20@example.com', '0990000020', 'Av. 20', NULL, NULL, NULL, NULL);

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
(1, 'Producto A', NULL, 5.50, 0, NULL, 1, NULL, NULL, NULL, NULL),
(2, 'Producto B', NULL, 8.25, 0, NULL, 1, NULL, NULL, NULL, NULL),
(3, 'Producto C', NULL, 12.00, 0, NULL, 1, NULL, NULL, NULL, NULL),
(4, 'Producto D', NULL, 15.75, 0, NULL, 1, NULL, NULL, NULL, NULL),
(5, 'Producto E', NULL, 22.40, 0, NULL, 1, NULL, NULL, NULL, NULL),
(6, 'Producto F', NULL, 31.90, 0, NULL, 1, NULL, NULL, NULL, NULL),
(7, 'Producto G', NULL, 2.99, 0, NULL, 1, NULL, NULL, NULL, NULL),
(8, 'Producto H', NULL, 18.30, 0, NULL, 1, NULL, NULL, NULL, NULL),
(9, 'Producto I', NULL, 7.10, 0, NULL, 1, NULL, NULL, NULL, NULL),
(10, 'Producto J', NULL, 10.00, 0, NULL, 1, NULL, NULL, NULL, NULL);

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
(1, 18, 2, 2, '2021-06-20 00:00:00', 62.99, NULL, 'pagada', NULL, NULL, NULL, NULL),
(2, 11, 4, 3, '2021-11-17 00:00:00', 221.34, NULL, 'pagada', NULL, NULL, NULL, NULL),
(3, 9, 2, 1, '2025-02-15 00:00:00', 50.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(4, 9, 5, 1, '2021-11-11 00:00:00', 114.75, NULL, 'pagada', NULL, NULL, NULL, NULL),
(5, 18, 5, 4, '2020-06-15 00:00:00', 92.90, NULL, 'pagada', NULL, NULL, NULL, NULL),
(6, 12, 5, 2, '2022-08-02 00:00:00', 2.99, NULL, 'pagada', NULL, NULL, NULL, NULL),
(7, 3, 5, 2, '2025-08-01 00:00:00', 123.30, NULL, 'pagada', NULL, NULL, NULL, NULL),
(8, 8, 5, 1, '2022-08-03 00:00:00', 43.86, NULL, 'pagada', NULL, NULL, NULL, NULL),
(9, 14, 5, 4, '2025-10-04 00:00:00', 80.30, NULL, 'pagada', NULL, NULL, NULL, NULL),
(10, 12, 4, 4, '2023-10-18 00:00:00', 92.85, NULL, 'pagada', NULL, NULL, NULL, NULL),
(11, 6, 1, 2, '2021-07-08 00:00:00', 65.98, NULL, 'pagada', NULL, NULL, NULL, NULL),
(12, 11, 5, 3, '2023-07-27 00:00:00', 257.46, NULL, 'pagada', NULL, NULL, NULL, NULL),
(13, 1, 5, 2, '2022-09-26 00:00:00', 21.25, NULL, 'pagada', NULL, NULL, NULL, NULL),
(14, 15, 1, 1, '2022-06-25 00:00:00', 69.72, NULL, 'pagada', NULL, NULL, NULL, NULL),
(15, 5, 2, 1, '2025-10-24 00:00:00', 145.95, NULL, 'pagada', NULL, NULL, NULL, NULL),
(16, 20, 5, 2, '2023-09-11 00:00:00', 126.20, NULL, 'pagada', NULL, NULL, NULL, NULL),
(17, 16, 5, 2, '2020-12-27 00:00:00', 70.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(18, 5, 1, 4, '2021-09-06 00:00:00', 42.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(19, 7, 4, 2, '2021-01-03 00:00:00', 42.10, NULL, 'pagada', NULL, NULL, NULL, NULL),
(20, 18, 5, 3, '2025-03-19 00:00:00', 114.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(21, 11, 2, 2, '2022-05-13 00:00:00', 110.71, NULL, 'pagada', NULL, NULL, NULL, NULL),
(22, 15, 4, 2, '2024-05-27 00:00:00', 37.05, NULL, 'pagada', NULL, NULL, NULL, NULL),
(23, 3, 1, 1, '2020-05-18 00:00:00', 27.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(24, 12, 5, 3, '2021-01-01 00:00:00', 151.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(25, 3, 3, 4, '2020-09-12 00:00:00', 54.90, NULL, 'pagada', NULL, NULL, NULL, NULL),
(26, 15, 3, 3, '2025-09-28 00:00:00', 146.25, NULL, 'pagada', NULL, NULL, NULL, NULL),
(27, 18, 3, 1, '2020-10-14 00:00:00', 111.35, NULL, 'pagada', NULL, NULL, NULL, NULL),
(28, 19, 3, 3, '2025-09-05 00:00:00', 8.25, NULL, 'pagada', NULL, NULL, NULL, NULL),
(29, 13, 2, 3, '2025-11-22 00:00:00', 100.11, NULL, 'pagada', NULL, NULL, NULL, NULL),
(30, 13, 3, 1, '2023-10-23 00:00:00', 97.07, NULL, 'pagada', NULL, NULL, NULL, NULL),
(31, 17, 1, 4, '2022-07-05 00:00:00', 60.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(32, 13, 5, 2, '2020-01-25 00:00:00', 51.96, NULL, 'pagada', NULL, NULL, NULL, NULL),
(33, 15, 2, 3, '2022-08-23 00:00:00', 87.90, NULL, 'pagada', NULL, NULL, NULL, NULL),
(34, 12, 3, 3, '2024-12-02 00:00:00', 39.75, NULL, 'pagada', NULL, NULL, NULL, NULL),
(35, 9, 3, 1, '2023-09-01 00:00:00', 78.70, NULL, 'pagada', NULL, NULL, NULL, NULL),
(36, 11, 5, 2, '2022-12-05 00:00:00', 36.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(37, 9, 1, 3, '2025-01-12 00:00:00', 23.75, NULL, 'pagada', NULL, NULL, NULL, NULL),
(38, 7, 2, 4, '2023-09-19 00:00:00', 139.40, NULL, 'pagada', NULL, NULL, NULL, NULL),
(39, 10, 1, 2, '2025-04-09 00:00:00', 47.45, NULL, 'pagada', NULL, NULL, NULL, NULL),
(40, 12, 4, 3, '2022-12-12 00:00:00', 125.95, NULL, 'pagada', NULL, NULL, NULL, NULL),
(41, 4, 2, 1, '2023-07-22 00:00:00', 55.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(42, 7, 4, 4, '2023-02-03 00:00:00', 54.90, NULL, 'pagada', NULL, NULL, NULL, NULL),
(43, 6, 1, 2, '2022-02-23 00:00:00', 127.07, NULL, 'pagada', NULL, NULL, NULL, NULL),
(44, 9, 4, 4, '2020-12-07 00:00:00', 41.25, NULL, 'pagada', NULL, NULL, NULL, NULL),
(45, 3, 3, 4, '2025-07-23 00:00:00', 113.80, NULL, 'pagada', NULL, NULL, NULL, NULL),
(46, 3, 4, 2, '2021-07-09 00:00:00', 67.20, NULL, 'pagada', NULL, NULL, NULL, NULL),
(47, 2, 3, 2, '2025-02-13 00:00:00', 73.20, NULL, 'pagada', NULL, NULL, NULL, NULL),
(48, 17, 2, 3, '2022-08-26 00:00:00', 8.97, NULL, 'pagada', NULL, NULL, NULL, NULL),
(49, 7, 5, 1, '2021-10-11 00:00:00', 5.98, NULL, 'pagada', NULL, NULL, NULL, NULL),
(50, 20, 1, 1, '2020-10-27 00:00:00', 78.75, NULL, 'pagada', NULL, NULL, NULL, NULL),
(51, 16, 3, 3, '2021-04-08 00:00:00', 117.78, NULL, 'pagada', NULL, NULL, NULL, NULL),
(52, 8, 1, 4, '2024-03-12 00:00:00', 127.44, NULL, 'pagada', NULL, NULL, NULL, NULL),
(53, 7, 1, 2, '2022-02-20 00:00:00', 83.40, NULL, 'pagada', NULL, NULL, NULL, NULL),
(54, 4, 4, 4, '2024-08-09 00:00:00', 31.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(55, 4, 3, 4, '2020-10-02 00:00:00', 250.30, NULL, 'pagada', NULL, NULL, NULL, NULL),
(56, 5, 1, 4, '2021-06-28 00:00:00', 78.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(57, 2, 2, 3, '2021-06-20 00:00:00', 287.30, NULL, 'pagada', NULL, NULL, NULL, NULL),
(58, 10, 5, 1, '2023-12-01 00:00:00', 95.65, NULL, 'pagada', NULL, NULL, NULL, NULL),
(59, 9, 5, 3, '2023-01-11 00:00:00', 92.80, NULL, 'pagada', NULL, NULL, NULL, NULL),
(60, 7, 3, 1, '2024-12-09 00:00:00', 74.25, NULL, 'pagada', NULL, NULL, NULL, NULL),
(61, 4, 5, 3, '2023-02-12 00:00:00', 201.88, NULL, 'pagada', NULL, NULL, NULL, NULL),
(62, 17, 1, 1, '2021-06-17 00:00:00', 104.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(63, 15, 1, 1, '2020-05-22 00:00:00', 129.89, NULL, 'pagada', NULL, NULL, NULL, NULL),
(64, 5, 3, 3, '2025-08-10 00:00:00', 70.38, NULL, 'pagada', NULL, NULL, NULL, NULL),
(65, 10, 5, 4, '2021-11-21 00:00:00', 300.20, NULL, 'pagada', NULL, NULL, NULL, NULL),
(66, 2, 3, 2, '2021-03-10 00:00:00', 154.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(67, 8, 1, 2, '2023-02-05 00:00:00', 11.96, NULL, 'pagada', NULL, NULL, NULL, NULL),
(68, 4, 3, 3, '2021-02-15 00:00:00', 24.75, NULL, 'pagada', NULL, NULL, NULL, NULL),
(69, 17, 1, 4, '2022-02-22 00:00:00', 52.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(70, 10, 1, 2, '2021-11-22 00:00:00', 30.26, NULL, 'pagada', NULL, NULL, NULL, NULL),
(71, 17, 1, 4, '2024-01-12 00:00:00', 63.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(72, 10, 1, 1, '2025-01-23 00:00:00', 166.60, NULL, 'pagada', NULL, NULL, NULL, NULL),
(73, 6, 4, 2, '2021-08-28 00:00:00', 112.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(74, 5, 5, 1, '2022-08-01 00:00:00', 42.99, NULL, 'pagada', NULL, NULL, NULL, NULL),
(75, 17, 2, 4, '2023-09-05 00:00:00', 14.95, NULL, 'pagada', NULL, NULL, NULL, NULL),
(76, 11, 5, 4, '2024-04-03 00:00:00', 197.25, NULL, 'pagada', NULL, NULL, NULL, NULL),
(77, 16, 3, 4, '2025-01-12 00:00:00', 175.06, NULL, 'pagada', NULL, NULL, NULL, NULL),
(78, 20, 5, 1, '2021-11-21 00:00:00', 88.39, NULL, 'pagada', NULL, NULL, NULL, NULL),
(79, 13, 2, 1, '2022-07-21 00:00:00', 151.95, NULL, 'pagada', NULL, NULL, NULL, NULL),
(80, 1, 2, 2, '2022-11-22 00:00:00', 208.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(81, 5, 3, 1, '2023-01-22 00:00:00', 167.75, NULL, 'pagada', NULL, NULL, NULL, NULL),
(82, 17, 4, 2, '2023-09-23 00:00:00', 185.40, NULL, 'pagada', NULL, NULL, NULL, NULL),
(83, 8, 1, 3, '2021-02-01 00:00:00', 8.97, NULL, 'pagada', NULL, NULL, NULL, NULL),
(84, 11, 3, 3, '2025-07-03 00:00:00', 91.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(85, 19, 1, 3, '2023-07-12 00:00:00', 168.60, NULL, 'pagada', NULL, NULL, NULL, NULL),
(86, 6, 3, 4, '2025-07-10 00:00:00', 83.29, NULL, 'pagada', NULL, NULL, NULL, NULL),
(87, 20, 3, 3, '2025-12-25 00:00:00', 8.97, NULL, 'pagada', NULL, NULL, NULL, NULL),
(88, 9, 1, 3, '2022-02-07 00:00:00', 80.70, NULL, 'pagada', NULL, NULL, NULL, NULL),
(89, 17, 4, 4, '2022-06-27 00:00:00', 73.20, NULL, 'pagada', NULL, NULL, NULL, NULL),
(90, 8, 4, 3, '2023-12-10 00:00:00', 34.89, NULL, 'pagada', NULL, NULL, NULL, NULL),
(91, 17, 3, 2, '2024-11-21 00:00:00', 137.60, NULL, 'pagada', NULL, NULL, NULL, NULL),
(92, 5, 5, 2, '2021-09-01 00:00:00', 223.30, NULL, 'pagada', NULL, NULL, NULL, NULL),
(93, 3, 4, 1, '2023-12-08 00:00:00', 83.16, NULL, 'pagada', NULL, NULL, NULL, NULL),
(94, 1, 3, 3, '2021-02-03 00:00:00', 36.20, NULL, 'pagada', NULL, NULL, NULL, NULL),
(95, 2, 4, 3, '2023-04-20 00:00:00', 296.35, NULL, 'pagada', NULL, NULL, NULL, NULL),
(96, 19, 2, 3, '2020-02-03 00:00:00', 211.95, NULL, 'pagada', NULL, NULL, NULL, NULL),
(97, 1, 1, 3, '2023-02-28 00:00:00', 129.10, NULL, 'pagada', NULL, NULL, NULL, NULL),
(98, 17, 4, 4, '2020-04-08 00:00:00', 27.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(99, 12, 3, 3, '2021-12-01 00:00:00', 114.45, NULL, 'pagada', NULL, NULL, NULL, NULL),
(100, 5, 2, 4, '2025-05-17 00:00:00', 111.05, NULL, 'pagada', NULL, NULL, NULL, NULL),
(101, 5, 3, 1, '2020-05-16 00:00:00', 36.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(102, 4, 1, 2, '2020-04-18 00:00:00', 24.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(103, 12, 1, 3, '2024-01-13 00:00:00', 27.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(104, 20, 3, 3, '2024-11-17 00:00:00', 54.05, NULL, 'pagada', NULL, NULL, NULL, NULL),
(105, 8, 1, 2, '2024-04-27 00:00:00', 159.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(106, 14, 1, 3, '2023-06-16 00:00:00', 74.75, NULL, 'pagada', NULL, NULL, NULL, NULL),
(107, 18, 5, 2, '2022-11-25 00:00:00', 31.90, NULL, 'pagada', NULL, NULL, NULL, NULL),
(108, 18, 5, 2, '2024-12-20 00:00:00', 63.80, NULL, 'pagada', NULL, NULL, NULL, NULL),
(109, 13, 5, 1, '2025-10-04 00:00:00', 84.73, NULL, 'pagada', NULL, NULL, NULL, NULL),
(110, 8, 3, 2, '2021-07-02 00:00:00', 59.99, NULL, 'pagada', NULL, NULL, NULL, NULL),
(111, 17, 4, 3, '2025-08-07 00:00:00', 99.30, NULL, 'pagada', NULL, NULL, NULL, NULL),
(112, 5, 2, 2, '2020-12-25 00:00:00', 198.90, NULL, 'pagada', NULL, NULL, NULL, NULL),
(113, 1, 4, 3, '2025-12-28 00:00:00', 120.97, NULL, 'pagada', NULL, NULL, NULL, NULL),
(114, 10, 2, 4, '2023-03-28 00:00:00', 129.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(115, 8, 5, 4, '2022-07-17 00:00:00', 24.75, NULL, 'pagada', NULL, NULL, NULL, NULL),
(116, 10, 3, 1, '2021-01-15 00:00:00', 120.40, NULL, 'pagada', NULL, NULL, NULL, NULL),
(117, 18, 3, 3, '2020-12-26 00:00:00', 119.60, NULL, 'pagada', NULL, NULL, NULL, NULL),
(118, 8, 1, 2, '2020-10-10 00:00:00', 72.99, NULL, 'pagada', NULL, NULL, NULL, NULL),
(119, 10, 2, 4, '2025-03-12 00:00:00', 102.75, NULL, 'pagada', NULL, NULL, NULL, NULL),
(120, 5, 2, 1, '2025-03-02 00:00:00', 86.55, NULL, 'pagada', NULL, NULL, NULL, NULL),
(121, 13, 2, 4, '2022-05-28 00:00:00', 47.25, NULL, 'pagada', NULL, NULL, NULL, NULL),
(122, 7, 5, 2, '2023-08-01 00:00:00', 179.26, NULL, 'pagada', NULL, NULL, NULL, NULL),
(123, 1, 2, 1, '2021-10-01 00:00:00', 237.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(124, 13, 5, 3, '2024-10-19 00:00:00', 131.10, NULL, 'pagada', NULL, NULL, NULL, NULL),
(125, 20, 2, 2, '2024-02-09 00:00:00', 151.40, NULL, 'pagada', NULL, NULL, NULL, NULL),
(126, 13, 3, 2, '2024-08-28 00:00:00', 175.45, NULL, 'pagada', NULL, NULL, NULL, NULL),
(127, 18, 4, 4, '2023-09-06 00:00:00', 23.60, NULL, 'pagada', NULL, NULL, NULL, NULL),
(128, 6, 1, 1, '2020-08-01 00:00:00', 73.36, NULL, 'pagada', NULL, NULL, NULL, NULL),
(129, 14, 4, 1, '2023-06-28 00:00:00', 35.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(130, 14, 5, 4, '2025-01-05 00:00:00', 246.60, NULL, 'pagada', NULL, NULL, NULL, NULL),
(131, 6, 3, 1, '2020-01-01 00:00:00', 34.40, NULL, 'pagada', NULL, NULL, NULL, NULL),
(132, 10, 3, 4, '2022-08-24 00:00:00', 53.98, NULL, 'pagada', NULL, NULL, NULL, NULL),
(133, 18, 2, 3, '2022-08-03 00:00:00', 184.60, NULL, 'pagada', NULL, NULL, NULL, NULL),
(134, 8, 5, 2, '2022-03-14 00:00:00', 127.60, NULL, 'pagada', NULL, NULL, NULL, NULL),
(135, 9, 1, 3, '2021-08-04 00:00:00', 117.20, NULL, 'pagada', NULL, NULL, NULL, NULL),
(136, 8, 5, 4, '2023-01-20 00:00:00', 57.98, NULL, 'pagada', NULL, NULL, NULL, NULL),
(137, 3, 5, 4, '2024-12-21 00:00:00', 43.74, NULL, 'pagada', NULL, NULL, NULL, NULL),
(138, 2, 1, 2, '2021-04-03 00:00:00', 36.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(139, 12, 4, 4, '2025-06-09 00:00:00', 178.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(140, 5, 1, 4, '2022-06-26 00:00:00', 31.90, NULL, 'pagada', NULL, NULL, NULL, NULL),
(141, 2, 2, 2, '2023-04-27 00:00:00', 5.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(142, 9, 5, 4, '2022-11-16 00:00:00', 181.05, NULL, 'pagada', NULL, NULL, NULL, NULL),
(143, 2, 2, 4, '2020-02-02 00:00:00', 17.10, NULL, 'pagada', NULL, NULL, NULL, NULL),
(144, 3, 4, 1, '2020-12-06 00:00:00', 135.20, NULL, 'pagada', NULL, NULL, NULL, NULL),
(145, 4, 3, 1, '2024-12-01 00:00:00', 31.90, NULL, 'pagada', NULL, NULL, NULL, NULL),
(146, 8, 3, 1, '2020-10-02 00:00:00', 44.80, NULL, 'pagada', NULL, NULL, NULL, NULL),
(147, 1, 1, 1, '2022-04-22 00:00:00', 59.52, NULL, 'pagada', NULL, NULL, NULL, NULL),
(148, 6, 4, 3, '2022-04-14 00:00:00', 76.75, NULL, 'pagada', NULL, NULL, NULL, NULL),
(149, 13, 4, 3, '2025-11-02 00:00:00', 58.67, NULL, 'pagada', NULL, NULL, NULL, NULL),
(150, 2, 2, 3, '2021-04-26 00:00:00', 107.35, NULL, 'pagada', NULL, NULL, NULL, NULL),
(151, 9, 4, 4, '2020-12-17 00:00:00', 166.20, NULL, 'pagada', NULL, NULL, NULL, NULL),
(152, 4, 5, 1, '2020-04-07 00:00:00', 175.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(153, 15, 3, 4, '2023-12-10 00:00:00', 60.88, NULL, 'pagada', NULL, NULL, NULL, NULL),
(154, 10, 2, 1, '2021-05-09 00:00:00', 34.36, NULL, 'pagada', NULL, NULL, NULL, NULL),
(155, 17, 4, 4, '2024-02-23 00:00:00', 180.70, NULL, 'pagada', NULL, NULL, NULL, NULL),
(156, 18, 4, 2, '2023-01-26 00:00:00', 168.97, NULL, 'pagada', NULL, NULL, NULL, NULL),
(157, 18, 4, 1, '2021-10-12 00:00:00', 52.49, NULL, 'pagada', NULL, NULL, NULL, NULL),
(158, 3, 4, 2, '2021-10-24 00:00:00', 22.40, NULL, 'pagada', NULL, NULL, NULL, NULL),
(159, 14, 2, 1, '2023-09-21 00:00:00', 89.60, NULL, 'pagada', NULL, NULL, NULL, NULL),
(160, 5, 4, 1, '2025-01-03 00:00:00', 123.55, NULL, 'pagada', NULL, NULL, NULL, NULL),
(161, 6, 1, 2, '2020-11-22 00:00:00', 62.55, NULL, 'pagada', NULL, NULL, NULL, NULL),
(162, 5, 1, 2, '2022-11-23 00:00:00', 33.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(163, 20, 1, 2, '2021-03-27 00:00:00', 130.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(164, 15, 3, 4, '2023-03-15 00:00:00', 33.80, NULL, 'pagada', NULL, NULL, NULL, NULL),
(165, 10, 2, 4, '2022-02-11 00:00:00', 139.56, NULL, 'pagada', NULL, NULL, NULL, NULL),
(166, 12, 1, 4, '2021-04-08 00:00:00', 54.90, NULL, 'pagada', NULL, NULL, NULL, NULL),
(167, 17, 4, 4, '2022-10-18 00:00:00', 113.79, NULL, 'pagada', NULL, NULL, NULL, NULL),
(168, 20, 5, 1, '2020-08-16 00:00:00', 49.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(169, 8, 2, 4, '2024-04-05 00:00:00', 138.20, NULL, 'pagada', NULL, NULL, NULL, NULL),
(170, 7, 3, 2, '2021-12-27 00:00:00', 73.20, NULL, 'pagada', NULL, NULL, NULL, NULL),
(171, 20, 5, 2, '2024-11-09 00:00:00', 91.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(172, 4, 3, 1, '2025-04-04 00:00:00', 159.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(173, 8, 3, 2, '2025-04-18 00:00:00', 14.20, NULL, 'pagada', NULL, NULL, NULL, NULL),
(174, 16, 5, 1, '2020-04-18 00:00:00', 69.10, NULL, 'pagada', NULL, NULL, NULL, NULL),
(175, 4, 1, 4, '2023-03-01 00:00:00', 281.80, NULL, 'pagada', NULL, NULL, NULL, NULL),
(176, 17, 2, 2, '2021-09-14 00:00:00', 14.95, NULL, 'pagada', NULL, NULL, NULL, NULL),
(177, 20, 1, 1, '2023-01-11 00:00:00', 36.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(178, 18, 3, 2, '2022-09-12 00:00:00', 146.40, NULL, 'pagada', NULL, NULL, NULL, NULL),
(179, 9, 1, 3, '2020-10-11 00:00:00', 14.20, NULL, 'pagada', NULL, NULL, NULL, NULL),
(180, 6, 2, 1, '2020-11-08 00:00:00', 7.10, NULL, 'pagada', NULL, NULL, NULL, NULL),
(181, 14, 2, 2, '2022-12-12 00:00:00', 20.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(182, 5, 2, 2, '2021-04-22 00:00:00', 299.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(183, 15, 1, 4, '2025-05-15 00:00:00', 102.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(184, 17, 1, 1, '2020-05-24 00:00:00', 27.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(185, 18, 3, 4, '2022-05-25 00:00:00', 43.35, NULL, 'pagada', NULL, NULL, NULL, NULL),
(186, 11, 1, 3, '2020-12-27 00:00:00', 74.20, NULL, 'pagada', NULL, NULL, NULL, NULL),
(187, 4, 1, 4, '2022-02-12 00:00:00', 24.75, NULL, 'pagada', NULL, NULL, NULL, NULL),
(188, 11, 4, 2, '2022-03-05 00:00:00', 94.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(189, 11, 4, 3, '2023-07-10 00:00:00', 90.90, NULL, 'pagada', NULL, NULL, NULL, NULL),
(190, 3, 3, 4, '2022-06-07 00:00:00', 227.74, NULL, 'pagada', NULL, NULL, NULL, NULL),
(191, 20, 2, 3, '2022-01-01 00:00:00', 31.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(192, 1, 2, 3, '2021-02-17 00:00:00', 111.74, NULL, 'pagada', NULL, NULL, NULL, NULL),
(193, 14, 4, 3, '2023-10-05 00:00:00', 107.66, NULL, 'pagada', NULL, NULL, NULL, NULL),
(194, 10, 1, 3, '2022-10-14 00:00:00', 160.60, NULL, 'pagada', NULL, NULL, NULL, NULL),
(195, 19, 1, 4, '2020-11-15 00:00:00', 30.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(196, 20, 3, 3, '2024-02-05 00:00:00', 77.09, NULL, 'pagada', NULL, NULL, NULL, NULL),
(197, 6, 1, 4, '2025-12-26 00:00:00', 47.15, NULL, 'pagada', NULL, NULL, NULL, NULL),
(198, 5, 5, 4, '2021-06-19 00:00:00', 183.42, NULL, 'pagada', NULL, NULL, NULL, NULL),
(199, 4, 4, 1, '2023-07-28 00:00:00', 203.35, NULL, 'pagada', NULL, NULL, NULL, NULL),
(200, 10, 1, 1, '2023-09-07 00:00:00', 127.60, NULL, 'pagada', NULL, NULL, NULL, NULL),
(201, 5, 3, 1, '2024-10-16 00:00:00', 63.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(202, 6, 5, 3, '2024-10-25 00:00:00', 77.25, NULL, 'pagada', NULL, NULL, NULL, NULL),
(203, 15, 2, 1, '2021-04-05 00:00:00', 98.76, NULL, 'pagada', NULL, NULL, NULL, NULL),
(204, 13, 3, 3, '2022-02-17 00:00:00', 22.40, NULL, 'pagada', NULL, NULL, NULL, NULL),
(205, 4, 3, 4, '2023-11-16 00:00:00', 144.10, NULL, 'pagada', NULL, NULL, NULL, NULL),
(206, 4, 3, 1, '2024-01-03 00:00:00', 86.05, NULL, 'pagada', NULL, NULL, NULL, NULL),
(207, 11, 5, 1, '2020-05-12 00:00:00', 74.35, NULL, 'pagada', NULL, NULL, NULL, NULL),
(208, 17, 4, 4, '2023-01-22 00:00:00', 81.45, NULL, 'pagada', NULL, NULL, NULL, NULL),
(209, 20, 5, 3, '2023-08-25 00:00:00', 93.15, NULL, 'pagada', NULL, NULL, NULL, NULL),
(210, 6, 5, 2, '2022-04-19 00:00:00', 27.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(211, 14, 3, 2, '2021-09-22 00:00:00', 156.85, NULL, 'pagada', NULL, NULL, NULL, NULL),
(212, 4, 5, 4, '2022-10-13 00:00:00', 121.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(213, 8, 4, 4, '2025-01-06 00:00:00', 83.77, NULL, 'pagada', NULL, NULL, NULL, NULL),
(214, 18, 2, 4, '2020-11-05 00:00:00', 159.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(215, 11, 1, 2, '2023-09-13 00:00:00', 15.75, NULL, 'pagada', NULL, NULL, NULL, NULL),
(216, 1, 1, 4, '2024-06-15 00:00:00', 10.00, NULL, 'pagada', NULL, NULL, NULL, NULL),
(217, 4, 5, 2, '2022-12-02 00:00:00', 150.30, NULL, 'pagada', NULL, NULL, NULL, NULL),
(218, 17, 5, 4, '2024-03-26 00:00:00', 16.50, NULL, 'pagada', NULL, NULL, NULL, NULL),
(219, 9, 3, 2, '2022-01-16 00:00:00', 81.30, NULL, 'pagada', NULL, NULL, NULL, NULL),
(220, 8, 2, 1, '2022-07-25 00:00:00', 52.40, NULL, 'pagada', NULL, NULL, NULL, NULL);

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
(1, 1, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(2, 1, 3, 5, 12.00, 60.00, NULL, NULL, NULL),
(3, 2, 4, 5, 15.75, 78.75, NULL, NULL, NULL),
(4, 2, 10, 5, 10.00, 50.00, NULL, NULL, NULL),
(5, 2, 5, 4, 22.40, 89.60, NULL, NULL, NULL),
(6, 2, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(7, 3, 10, 5, 10.00, 50.00, NULL, NULL, NULL),
(8, 4, 3, 3, 12.00, 36.00, NULL, NULL, NULL),
(9, 4, 4, 5, 15.75, 78.75, NULL, NULL, NULL),
(10, 5, 4, 1, 15.75, 15.75, NULL, NULL, NULL),
(11, 5, 7, 5, 2.99, 14.95, NULL, NULL, NULL),
(12, 5, 9, 2, 7.10, 14.20, NULL, NULL, NULL),
(13, 5, 3, 4, 12.00, 48.00, NULL, NULL, NULL),
(14, 6, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(15, 7, 9, 4, 7.10, 28.40, NULL, NULL, NULL),
(16, 7, 8, 3, 18.30, 54.90, NULL, NULL, NULL),
(17, 7, 10, 4, 10.00, 40.00, NULL, NULL, NULL),
(18, 8, 7, 2, 2.99, 5.98, NULL, NULL, NULL),
(19, 8, 7, 2, 2.99, 5.98, NULL, NULL, NULL),
(20, 8, 6, 1, 31.90, 31.90, NULL, NULL, NULL),
(21, 9, 9, 1, 7.10, 7.10, NULL, NULL, NULL),
(22, 9, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(23, 10, 2, 2, 8.25, 16.50, NULL, NULL, NULL),
(24, 10, 8, 2, 18.30, 36.60, NULL, NULL, NULL),
(25, 10, 2, 1, 8.25, 8.25, NULL, NULL, NULL),
(26, 10, 4, 2, 15.75, 31.50, NULL, NULL, NULL),
(27, 11, 7, 2, 2.99, 5.98, NULL, NULL, NULL),
(28, 11, 3, 5, 12.00, 60.00, NULL, NULL, NULL),
(29, 12, 8, 3, 18.30, 54.90, NULL, NULL, NULL),
(30, 12, 6, 4, 31.90, 127.60, NULL, NULL, NULL),
(31, 12, 4, 4, 15.75, 63.00, NULL, NULL, NULL),
(32, 12, 7, 4, 2.99, 11.96, NULL, NULL, NULL),
(33, 13, 4, 1, 15.75, 15.75, NULL, NULL, NULL),
(34, 13, 1, 1, 5.50, 5.50, NULL, NULL, NULL),
(35, 14, 3, 3, 12.00, 36.00, NULL, NULL, NULL),
(36, 14, 7, 3, 2.99, 8.97, NULL, NULL, NULL),
(37, 14, 2, 3, 8.25, 24.75, NULL, NULL, NULL),
(38, 15, 4, 5, 15.75, 78.75, NULL, NULL, NULL),
(39, 15, 5, 2, 22.40, 44.80, NULL, NULL, NULL),
(40, 15, 5, 1, 22.40, 22.40, NULL, NULL, NULL),
(41, 16, 8, 2, 18.30, 36.60, NULL, NULL, NULL),
(42, 16, 5, 4, 22.40, 89.60, NULL, NULL, NULL),
(43, 17, 1, 4, 5.50, 22.00, NULL, NULL, NULL),
(44, 17, 3, 4, 12.00, 48.00, NULL, NULL, NULL),
(45, 18, 1, 2, 5.50, 11.00, NULL, NULL, NULL),
(46, 18, 4, 2, 15.75, 31.50, NULL, NULL, NULL),
(47, 19, 1, 1, 5.50, 5.50, NULL, NULL, NULL),
(48, 19, 8, 2, 18.30, 36.60, NULL, NULL, NULL),
(49, 20, 2, 3, 8.25, 24.75, NULL, NULL, NULL),
(50, 20, 3, 4, 12.00, 48.00, NULL, NULL, NULL),
(51, 20, 2, 5, 8.25, 41.25, NULL, NULL, NULL),
(52, 21, 4, 5, 15.75, 78.75, NULL, NULL, NULL),
(53, 21, 7, 4, 2.99, 11.96, NULL, NULL, NULL),
(54, 21, 10, 2, 10.00, 20.00, NULL, NULL, NULL),
(55, 22, 4, 1, 15.75, 15.75, NULL, NULL, NULL),
(56, 22, 9, 3, 7.10, 21.30, NULL, NULL, NULL),
(57, 23, 1, 5, 5.50, 27.50, NULL, NULL, NULL),
(58, 24, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(59, 24, 6, 1, 31.90, 31.90, NULL, NULL, NULL),
(60, 24, 8, 2, 18.30, 36.60, NULL, NULL, NULL),
(61, 24, 10, 5, 10.00, 50.00, NULL, NULL, NULL),
(62, 25, 8, 3, 18.30, 54.90, NULL, NULL, NULL),
(63, 26, 6, 1, 31.90, 31.90, NULL, NULL, NULL),
(64, 26, 4, 1, 15.75, 15.75, NULL, NULL, NULL),
(65, 26, 9, 1, 7.10, 7.10, NULL, NULL, NULL),
(66, 26, 8, 5, 18.30, 91.50, NULL, NULL, NULL),
(67, 27, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(68, 27, 2, 1, 8.25, 8.25, NULL, NULL, NULL),
(69, 27, 9, 1, 7.10, 7.10, NULL, NULL, NULL),
(70, 27, 4, 4, 15.75, 63.00, NULL, NULL, NULL),
(71, 28, 2, 1, 8.25, 8.25, NULL, NULL, NULL),
(72, 29, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(73, 29, 7, 5, 2.99, 14.95, NULL, NULL, NULL),
(74, 29, 7, 4, 2.99, 11.96, NULL, NULL, NULL),
(75, 30, 3, 4, 12.00, 48.00, NULL, NULL, NULL),
(76, 30, 7, 3, 2.99, 8.97, NULL, NULL, NULL),
(77, 30, 9, 1, 7.10, 7.10, NULL, NULL, NULL),
(78, 30, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(79, 31, 3, 5, 12.00, 60.00, NULL, NULL, NULL),
(80, 32, 7, 4, 2.99, 11.96, NULL, NULL, NULL),
(81, 32, 10, 4, 10.00, 40.00, NULL, NULL, NULL),
(82, 33, 1, 3, 5.50, 16.50, NULL, NULL, NULL),
(83, 33, 8, 3, 18.30, 54.90, NULL, NULL, NULL),
(84, 33, 2, 2, 8.25, 16.50, NULL, NULL, NULL),
(85, 34, 4, 1, 15.75, 15.75, NULL, NULL, NULL),
(86, 34, 3, 2, 12.00, 24.00, NULL, NULL, NULL),
(87, 35, 1, 3, 5.50, 16.50, NULL, NULL, NULL),
(88, 35, 9, 2, 7.10, 14.20, NULL, NULL, NULL),
(89, 35, 3, 4, 12.00, 48.00, NULL, NULL, NULL),
(90, 36, 3, 3, 12.00, 36.00, NULL, NULL, NULL),
(91, 37, 10, 1, 10.00, 10.00, NULL, NULL, NULL),
(92, 37, 2, 1, 8.25, 8.25, NULL, NULL, NULL),
(93, 37, 1, 1, 5.50, 5.50, NULL, NULL, NULL),
(94, 38, 9, 4, 7.10, 28.40, NULL, NULL, NULL),
(95, 38, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(96, 38, 1, 3, 5.50, 16.50, NULL, NULL, NULL),
(97, 38, 9, 3, 7.10, 21.30, NULL, NULL, NULL),
(98, 39, 8, 1, 18.30, 18.30, NULL, NULL, NULL),
(99, 39, 7, 5, 2.99, 14.95, NULL, NULL, NULL),
(100, 39, 9, 2, 7.10, 14.20, NULL, NULL, NULL),
(101, 40, 9, 2, 7.10, 14.20, NULL, NULL, NULL),
(102, 40, 1, 3, 5.50, 16.50, NULL, NULL, NULL),
(103, 40, 4, 5, 15.75, 78.75, NULL, NULL, NULL),
(104, 40, 2, 2, 8.25, 16.50, NULL, NULL, NULL),
(105, 41, 4, 2, 15.75, 31.50, NULL, NULL, NULL),
(106, 41, 3, 2, 12.00, 24.00, NULL, NULL, NULL),
(107, 42, 8, 3, 18.30, 54.90, NULL, NULL, NULL),
(108, 43, 6, 3, 31.90, 95.70, NULL, NULL, NULL),
(109, 43, 5, 1, 22.40, 22.40, NULL, NULL, NULL),
(110, 43, 7, 3, 2.99, 8.97, NULL, NULL, NULL),
(111, 44, 2, 5, 8.25, 41.25, NULL, NULL, NULL),
(112, 45, 10, 1, 10.00, 10.00, NULL, NULL, NULL),
(113, 45, 8, 2, 18.30, 36.60, NULL, NULL, NULL),
(114, 45, 5, 3, 22.40, 67.20, NULL, NULL, NULL),
(115, 46, 5, 3, 22.40, 67.20, NULL, NULL, NULL),
(116, 47, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(117, 48, 7, 3, 2.99, 8.97, NULL, NULL, NULL),
(118, 49, 7, 2, 2.99, 5.98, NULL, NULL, NULL),
(119, 50, 4, 5, 15.75, 78.75, NULL, NULL, NULL),
(120, 51, 7, 2, 2.99, 5.98, NULL, NULL, NULL),
(121, 51, 6, 2, 31.90, 63.80, NULL, NULL, NULL),
(122, 51, 3, 2, 12.00, 24.00, NULL, NULL, NULL),
(123, 51, 3, 2, 12.00, 24.00, NULL, NULL, NULL),
(124, 52, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(125, 52, 4, 3, 15.75, 47.25, NULL, NULL, NULL),
(126, 52, 9, 2, 7.10, 14.20, NULL, NULL, NULL),
(127, 52, 4, 4, 15.75, 63.00, NULL, NULL, NULL),
(128, 53, 4, 2, 15.75, 31.50, NULL, NULL, NULL),
(129, 53, 9, 1, 7.10, 7.10, NULL, NULL, NULL),
(130, 53, 5, 2, 22.40, 44.80, NULL, NULL, NULL),
(131, 54, 4, 2, 15.75, 31.50, NULL, NULL, NULL),
(132, 55, 5, 2, 22.40, 44.80, NULL, NULL, NULL),
(133, 55, 6, 5, 31.90, 159.50, NULL, NULL, NULL),
(134, 55, 3, 3, 12.00, 36.00, NULL, NULL, NULL),
(135, 55, 10, 1, 10.00, 10.00, NULL, NULL, NULL),
(136, 56, 3, 4, 12.00, 48.00, NULL, NULL, NULL),
(137, 56, 10, 3, 10.00, 30.00, NULL, NULL, NULL),
(138, 57, 5, 4, 22.40, 89.60, NULL, NULL, NULL),
(139, 57, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(140, 57, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(141, 57, 8, 5, 18.30, 91.50, NULL, NULL, NULL),
(142, 58, 10, 2, 10.00, 20.00, NULL, NULL, NULL),
(143, 58, 6, 1, 31.90, 31.90, NULL, NULL, NULL),
(144, 58, 2, 1, 8.25, 8.25, NULL, NULL, NULL),
(145, 58, 9, 5, 7.10, 35.50, NULL, NULL, NULL),
(146, 59, 5, 2, 22.40, 44.80, NULL, NULL, NULL),
(147, 59, 3, 4, 12.00, 48.00, NULL, NULL, NULL),
(148, 60, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(149, 60, 2, 5, 8.25, 41.25, NULL, NULL, NULL),
(150, 61, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(151, 61, 5, 3, 22.40, 67.20, NULL, NULL, NULL),
(152, 61, 6, 3, 31.90, 95.70, NULL, NULL, NULL),
(153, 61, 7, 2, 2.99, 5.98, NULL, NULL, NULL),
(154, 62, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(155, 62, 4, 2, 15.75, 31.50, NULL, NULL, NULL),
(156, 62, 10, 4, 10.00, 40.00, NULL, NULL, NULL),
(157, 63, 9, 5, 7.10, 35.50, NULL, NULL, NULL),
(158, 63, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(159, 63, 4, 4, 15.75, 63.00, NULL, NULL, NULL),
(160, 63, 9, 4, 7.10, 28.40, NULL, NULL, NULL),
(161, 64, 9, 4, 7.10, 28.40, NULL, NULL, NULL),
(162, 64, 3, 3, 12.00, 36.00, NULL, NULL, NULL),
(163, 64, 7, 2, 2.99, 5.98, NULL, NULL, NULL),
(164, 65, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(165, 65, 4, 2, 15.75, 31.50, NULL, NULL, NULL),
(166, 65, 3, 3, 12.00, 36.00, NULL, NULL, NULL),
(167, 65, 6, 5, 31.90, 159.50, NULL, NULL, NULL),
(168, 66, 5, 3, 22.40, 67.20, NULL, NULL, NULL),
(169, 66, 6, 1, 31.90, 31.90, NULL, NULL, NULL),
(170, 66, 8, 3, 18.30, 54.90, NULL, NULL, NULL),
(171, 67, 7, 4, 2.99, 11.96, NULL, NULL, NULL),
(172, 68, 2, 3, 8.25, 24.75, NULL, NULL, NULL),
(173, 69, 1, 3, 5.50, 16.50, NULL, NULL, NULL),
(174, 69, 9, 5, 7.10, 35.50, NULL, NULL, NULL),
(175, 70, 7, 4, 2.99, 11.96, NULL, NULL, NULL),
(176, 70, 8, 1, 18.30, 18.30, NULL, NULL, NULL),
(177, 71, 4, 4, 15.75, 63.00, NULL, NULL, NULL),
(178, 72, 1, 1, 5.50, 5.50, NULL, NULL, NULL),
(179, 72, 3, 3, 12.00, 36.00, NULL, NULL, NULL),
(180, 72, 5, 4, 22.40, 89.60, NULL, NULL, NULL),
(181, 72, 9, 5, 7.10, 35.50, NULL, NULL, NULL),
(182, 73, 5, 5, 22.40, 112.00, NULL, NULL, NULL),
(183, 74, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(184, 74, 10, 4, 10.00, 40.00, NULL, NULL, NULL),
(185, 75, 7, 5, 2.99, 14.95, NULL, NULL, NULL),
(186, 76, 6, 5, 31.90, 159.50, NULL, NULL, NULL),
(187, 76, 4, 1, 15.75, 15.75, NULL, NULL, NULL),
(188, 76, 1, 4, 5.50, 22.00, NULL, NULL, NULL),
(189, 77, 7, 4, 2.99, 11.96, NULL, NULL, NULL),
(190, 77, 6, 4, 31.90, 127.60, NULL, NULL, NULL),
(191, 77, 9, 5, 7.10, 35.50, NULL, NULL, NULL),
(192, 78, 6, 1, 31.90, 31.90, NULL, NULL, NULL),
(193, 78, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(194, 78, 1, 1, 5.50, 5.50, NULL, NULL, NULL),
(195, 78, 3, 4, 12.00, 48.00, NULL, NULL, NULL),
(196, 79, 4, 1, 15.75, 15.75, NULL, NULL, NULL),
(197, 79, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(198, 79, 4, 4, 15.75, 63.00, NULL, NULL, NULL),
(199, 80, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(200, 80, 4, 4, 15.75, 63.00, NULL, NULL, NULL),
(201, 80, 5, 5, 22.40, 112.00, NULL, NULL, NULL),
(202, 81, 2, 1, 8.25, 8.25, NULL, NULL, NULL),
(203, 81, 6, 5, 31.90, 159.50, NULL, NULL, NULL),
(204, 82, 6, 3, 31.90, 95.70, NULL, NULL, NULL),
(205, 82, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(206, 82, 2, 2, 8.25, 16.50, NULL, NULL, NULL),
(207, 83, 7, 3, 2.99, 8.97, NULL, NULL, NULL),
(208, 84, 8, 5, 18.30, 91.50, NULL, NULL, NULL),
(209, 85, 8, 3, 18.30, 54.90, NULL, NULL, NULL),
(210, 85, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(211, 85, 3, 2, 12.00, 24.00, NULL, NULL, NULL),
(212, 85, 1, 3, 5.50, 16.50, NULL, NULL, NULL),
(213, 86, 9, 5, 7.10, 35.50, NULL, NULL, NULL),
(214, 86, 5, 2, 22.40, 44.80, NULL, NULL, NULL),
(215, 86, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(216, 87, 7, 3, 2.99, 8.97, NULL, NULL, NULL),
(217, 88, 1, 3, 5.50, 16.50, NULL, NULL, NULL),
(218, 88, 9, 2, 7.10, 14.20, NULL, NULL, NULL),
(219, 88, 10, 5, 10.00, 50.00, NULL, NULL, NULL),
(220, 89, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(221, 90, 6, 1, 31.90, 31.90, NULL, NULL, NULL),
(222, 90, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(223, 91, 6, 4, 31.90, 127.60, NULL, NULL, NULL),
(224, 91, 10, 1, 10.00, 10.00, NULL, NULL, NULL),
(225, 92, 6, 3, 31.90, 95.70, NULL, NULL, NULL),
(226, 92, 6, 4, 31.90, 127.60, NULL, NULL, NULL),
(227, 93, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(228, 93, 7, 4, 2.99, 11.96, NULL, NULL, NULL),
(229, 93, 9, 2, 7.10, 14.20, NULL, NULL, NULL),
(230, 93, 3, 2, 12.00, 24.00, NULL, NULL, NULL),
(231, 94, 9, 2, 7.10, 14.20, NULL, NULL, NULL),
(232, 94, 1, 4, 5.50, 22.00, NULL, NULL, NULL),
(233, 95, 4, 3, 15.75, 47.25, NULL, NULL, NULL),
(234, 95, 6, 4, 31.90, 127.60, NULL, NULL, NULL),
(235, 95, 6, 1, 31.90, 31.90, NULL, NULL, NULL),
(236, 95, 5, 4, 22.40, 89.60, NULL, NULL, NULL),
(237, 96, 8, 3, 18.30, 54.90, NULL, NULL, NULL),
(238, 96, 8, 2, 18.30, 36.60, NULL, NULL, NULL),
(239, 96, 4, 3, 15.75, 47.25, NULL, NULL, NULL),
(240, 96, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(241, 97, 5, 2, 22.40, 44.80, NULL, NULL, NULL),
(242, 97, 9, 2, 7.10, 14.20, NULL, NULL, NULL),
(243, 97, 4, 4, 15.75, 63.00, NULL, NULL, NULL),
(244, 97, 9, 1, 7.10, 7.10, NULL, NULL, NULL),
(245, 98, 1, 5, 5.50, 27.50, NULL, NULL, NULL),
(246, 99, 2, 5, 8.25, 41.25, NULL, NULL, NULL),
(247, 99, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(248, 100, 2, 3, 8.25, 24.75, NULL, NULL, NULL),
(249, 100, 1, 1, 5.50, 5.50, NULL, NULL, NULL),
(250, 100, 3, 3, 12.00, 36.00, NULL, NULL, NULL),
(251, 100, 5, 2, 22.40, 44.80, NULL, NULL, NULL),
(252, 101, 3, 3, 12.00, 36.00, NULL, NULL, NULL),
(253, 102, 3, 2, 12.00, 24.00, NULL, NULL, NULL),
(254, 103, 1, 5, 5.50, 27.50, NULL, NULL, NULL),
(255, 104, 2, 1, 8.25, 8.25, NULL, NULL, NULL),
(256, 104, 1, 5, 5.50, 27.50, NULL, NULL, NULL),
(257, 104, 8, 1, 18.30, 18.30, NULL, NULL, NULL),
(258, 105, 6, 5, 31.90, 159.50, NULL, NULL, NULL),
(259, 106, 1, 5, 5.50, 27.50, NULL, NULL, NULL),
(260, 106, 4, 3, 15.75, 47.25, NULL, NULL, NULL),
(261, 107, 6, 1, 31.90, 31.90, NULL, NULL, NULL),
(262, 108, 6, 2, 31.90, 63.80, NULL, NULL, NULL),
(263, 109, 7, 2, 2.99, 5.98, NULL, NULL, NULL),
(264, 109, 4, 5, 15.75, 78.75, NULL, NULL, NULL),
(265, 110, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(266, 110, 3, 2, 12.00, 24.00, NULL, NULL, NULL),
(267, 110, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(268, 111, 6, 2, 31.90, 63.80, NULL, NULL, NULL),
(269, 111, 9, 5, 7.10, 35.50, NULL, NULL, NULL),
(270, 112, 10, 5, 10.00, 50.00, NULL, NULL, NULL),
(271, 112, 9, 3, 7.10, 21.30, NULL, NULL, NULL),
(272, 112, 6, 4, 31.90, 127.60, NULL, NULL, NULL),
(273, 113, 7, 3, 2.99, 8.97, NULL, NULL, NULL),
(274, 113, 5, 5, 22.40, 112.00, NULL, NULL, NULL),
(275, 114, 1, 3, 5.50, 16.50, NULL, NULL, NULL),
(276, 114, 1, 5, 5.50, 27.50, NULL, NULL, NULL),
(277, 114, 4, 4, 15.75, 63.00, NULL, NULL, NULL),
(278, 114, 1, 4, 5.50, 22.00, NULL, NULL, NULL),
(279, 115, 2, 3, 8.25, 24.75, NULL, NULL, NULL),
(280, 116, 10, 5, 10.00, 50.00, NULL, NULL, NULL),
(281, 116, 5, 1, 22.40, 22.40, NULL, NULL, NULL),
(282, 116, 3, 4, 12.00, 48.00, NULL, NULL, NULL),
(283, 117, 5, 4, 22.40, 89.60, NULL, NULL, NULL),
(284, 117, 10, 3, 10.00, 30.00, NULL, NULL, NULL),
(285, 118, 10, 5, 10.00, 50.00, NULL, NULL, NULL),
(286, 118, 10, 2, 10.00, 20.00, NULL, NULL, NULL),
(287, 118, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(288, 119, 2, 1, 8.25, 8.25, NULL, NULL, NULL),
(289, 119, 2, 5, 8.25, 41.25, NULL, NULL, NULL),
(290, 119, 3, 1, 12.00, 12.00, NULL, NULL, NULL),
(291, 119, 2, 5, 8.25, 41.25, NULL, NULL, NULL),
(292, 120, 9, 1, 7.10, 7.10, NULL, NULL, NULL),
(293, 120, 7, 5, 2.99, 14.95, NULL, NULL, NULL),
(294, 120, 1, 3, 5.50, 16.50, NULL, NULL, NULL),
(295, 120, 3, 4, 12.00, 48.00, NULL, NULL, NULL),
(296, 121, 4, 3, 15.75, 47.25, NULL, NULL, NULL),
(297, 122, 6, 2, 31.90, 63.80, NULL, NULL, NULL),
(298, 122, 7, 4, 2.99, 11.96, NULL, NULL, NULL),
(299, 122, 2, 3, 8.25, 24.75, NULL, NULL, NULL),
(300, 122, 4, 5, 15.75, 78.75, NULL, NULL, NULL),
(301, 123, 9, 2, 7.10, 14.20, NULL, NULL, NULL),
(302, 123, 6, 3, 31.90, 95.70, NULL, NULL, NULL),
(303, 123, 6, 4, 31.90, 127.60, NULL, NULL, NULL),
(304, 124, 4, 1, 15.75, 15.75, NULL, NULL, NULL),
(305, 124, 4, 5, 15.75, 78.75, NULL, NULL, NULL),
(306, 124, 8, 2, 18.30, 36.60, NULL, NULL, NULL),
(307, 125, 3, 5, 12.00, 60.00, NULL, NULL, NULL),
(308, 125, 9, 4, 7.10, 28.40, NULL, NULL, NULL),
(309, 125, 4, 4, 15.75, 63.00, NULL, NULL, NULL),
(310, 126, 5, 4, 22.40, 89.60, NULL, NULL, NULL),
(311, 126, 9, 1, 7.10, 7.10, NULL, NULL, NULL),
(312, 126, 4, 5, 15.75, 78.75, NULL, NULL, NULL),
(313, 127, 9, 1, 7.10, 7.10, NULL, NULL, NULL),
(314, 127, 1, 3, 5.50, 16.50, NULL, NULL, NULL),
(315, 128, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(316, 128, 7, 2, 2.99, 5.98, NULL, NULL, NULL),
(317, 128, 9, 4, 7.10, 28.40, NULL, NULL, NULL),
(318, 128, 7, 2, 2.99, 5.98, NULL, NULL, NULL),
(319, 129, 9, 4, 7.10, 28.40, NULL, NULL, NULL),
(320, 129, 9, 1, 7.10, 7.10, NULL, NULL, NULL),
(321, 130, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(322, 130, 8, 5, 18.30, 91.50, NULL, NULL, NULL),
(323, 130, 10, 5, 10.00, 50.00, NULL, NULL, NULL),
(324, 130, 6, 1, 31.90, 31.90, NULL, NULL, NULL),
(325, 131, 3, 1, 12.00, 12.00, NULL, NULL, NULL),
(326, 131, 5, 1, 22.40, 22.40, NULL, NULL, NULL),
(327, 132, 7, 2, 2.99, 5.98, NULL, NULL, NULL),
(328, 132, 2, 2, 8.25, 16.50, NULL, NULL, NULL),
(329, 132, 4, 2, 15.75, 31.50, NULL, NULL, NULL),
(330, 133, 5, 5, 22.40, 112.00, NULL, NULL, NULL),
(331, 133, 3, 3, 12.00, 36.00, NULL, NULL, NULL),
(332, 133, 8, 2, 18.30, 36.60, NULL, NULL, NULL),
(333, 134, 6, 4, 31.90, 127.60, NULL, NULL, NULL),
(334, 135, 10, 5, 10.00, 50.00, NULL, NULL, NULL),
(335, 135, 5, 3, 22.40, 67.20, NULL, NULL, NULL),
(336, 136, 10, 3, 10.00, 30.00, NULL, NULL, NULL),
(337, 136, 1, 4, 5.50, 22.00, NULL, NULL, NULL),
(338, 136, 7, 2, 2.99, 5.98, NULL, NULL, NULL),
(339, 137, 8, 1, 18.30, 18.30, NULL, NULL, NULL),
(340, 137, 9, 2, 7.10, 14.20, NULL, NULL, NULL),
(341, 137, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(342, 137, 2, 1, 8.25, 8.25, NULL, NULL, NULL),
(343, 138, 3, 3, 12.00, 36.00, NULL, NULL, NULL),
(344, 139, 8, 5, 18.30, 91.50, NULL, NULL, NULL),
(345, 139, 1, 4, 5.50, 22.00, NULL, NULL, NULL),
(346, 139, 9, 4, 7.10, 28.40, NULL, NULL, NULL),
(347, 139, 8, 2, 18.30, 36.60, NULL, NULL, NULL),
(348, 140, 6, 1, 31.90, 31.90, NULL, NULL, NULL),
(349, 141, 1, 1, 5.50, 5.50, NULL, NULL, NULL),
(350, 142, 2, 5, 8.25, 41.25, NULL, NULL, NULL),
(351, 142, 3, 3, 12.00, 36.00, NULL, NULL, NULL),
(352, 142, 8, 2, 18.30, 36.60, NULL, NULL, NULL),
(353, 142, 5, 3, 22.40, 67.20, NULL, NULL, NULL),
(354, 143, 10, 1, 10.00, 10.00, NULL, NULL, NULL),
(355, 143, 9, 1, 7.10, 7.10, NULL, NULL, NULL),
(356, 144, 8, 2, 18.30, 36.60, NULL, NULL, NULL),
(357, 144, 9, 1, 7.10, 7.10, NULL, NULL, NULL),
(358, 144, 8, 5, 18.30, 91.50, NULL, NULL, NULL),
(359, 145, 6, 1, 31.90, 31.90, NULL, NULL, NULL),
(360, 146, 5, 2, 22.40, 44.80, NULL, NULL, NULL),
(361, 147, 2, 1, 8.25, 8.25, NULL, NULL, NULL),
(362, 147, 3, 2, 12.00, 24.00, NULL, NULL, NULL),
(363, 147, 7, 3, 2.99, 8.97, NULL, NULL, NULL),
(364, 147, 8, 1, 18.30, 18.30, NULL, NULL, NULL),
(365, 148, 2, 5, 8.25, 41.25, NULL, NULL, NULL),
(366, 148, 9, 5, 7.10, 35.50, NULL, NULL, NULL),
(367, 149, 7, 3, 2.99, 8.97, NULL, NULL, NULL),
(368, 149, 9, 2, 7.10, 14.20, NULL, NULL, NULL),
(369, 149, 9, 5, 7.10, 35.50, NULL, NULL, NULL),
(370, 150, 2, 5, 8.25, 41.25, NULL, NULL, NULL),
(371, 150, 5, 2, 22.40, 44.80, NULL, NULL, NULL),
(372, 150, 9, 3, 7.10, 21.30, NULL, NULL, NULL),
(373, 151, 5, 4, 22.40, 89.60, NULL, NULL, NULL),
(374, 151, 10, 4, 10.00, 40.00, NULL, NULL, NULL),
(375, 151, 8, 2, 18.30, 36.60, NULL, NULL, NULL),
(376, 152, 5, 1, 22.40, 22.40, NULL, NULL, NULL),
(377, 152, 4, 4, 15.75, 63.00, NULL, NULL, NULL),
(378, 152, 5, 4, 22.40, 89.60, NULL, NULL, NULL),
(379, 153, 7, 2, 2.99, 5.98, NULL, NULL, NULL),
(380, 153, 8, 3, 18.30, 54.90, NULL, NULL, NULL),
(381, 154, 7, 4, 2.99, 11.96, NULL, NULL, NULL),
(382, 154, 5, 1, 22.40, 22.40, NULL, NULL, NULL),
(383, 155, 8, 2, 18.30, 36.60, NULL, NULL, NULL),
(384, 155, 1, 3, 5.50, 16.50, NULL, NULL, NULL),
(385, 155, 6, 4, 31.90, 127.60, NULL, NULL, NULL),
(386, 156, 5, 5, 22.40, 112.00, NULL, NULL, NULL),
(387, 156, 7, 3, 2.99, 8.97, NULL, NULL, NULL),
(388, 156, 3, 4, 12.00, 48.00, NULL, NULL, NULL),
(389, 157, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(390, 157, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(391, 157, 1, 3, 5.50, 16.50, NULL, NULL, NULL),
(392, 158, 5, 1, 22.40, 22.40, NULL, NULL, NULL),
(393, 159, 5, 4, 22.40, 89.60, NULL, NULL, NULL),
(394, 160, 5, 2, 22.40, 44.80, NULL, NULL, NULL),
(395, 160, 4, 5, 15.75, 78.75, NULL, NULL, NULL),
(396, 161, 2, 5, 8.25, 41.25, NULL, NULL, NULL),
(397, 161, 9, 3, 7.10, 21.30, NULL, NULL, NULL),
(398, 162, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(399, 163, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(400, 163, 10, 4, 10.00, 40.00, NULL, NULL, NULL),
(401, 163, 4, 1, 15.75, 15.75, NULL, NULL, NULL),
(402, 163, 2, 5, 8.25, 41.25, NULL, NULL, NULL),
(403, 164, 8, 1, 18.30, 18.30, NULL, NULL, NULL),
(404, 164, 1, 1, 5.50, 5.50, NULL, NULL, NULL),
(405, 164, 10, 1, 10.00, 10.00, NULL, NULL, NULL),
(406, 165, 7, 4, 2.99, 11.96, NULL, NULL, NULL),
(407, 165, 6, 4, 31.90, 127.60, NULL, NULL, NULL),
(408, 166, 8, 3, 18.30, 54.90, NULL, NULL, NULL),
(409, 167, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(410, 167, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(411, 167, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(412, 167, 5, 2, 22.40, 44.80, NULL, NULL, NULL),
(413, 168, 1, 5, 5.50, 27.50, NULL, NULL, NULL),
(414, 168, 1, 4, 5.50, 22.00, NULL, NULL, NULL),
(415, 169, 6, 3, 31.90, 95.70, NULL, NULL, NULL),
(416, 169, 1, 2, 5.50, 11.00, NULL, NULL, NULL),
(417, 169, 4, 2, 15.75, 31.50, NULL, NULL, NULL),
(418, 170, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(419, 171, 8, 5, 18.30, 91.50, NULL, NULL, NULL),
(420, 172, 6, 5, 31.90, 159.50, NULL, NULL, NULL),
(421, 173, 9, 2, 7.10, 14.20, NULL, NULL, NULL),
(422, 174, 8, 3, 18.30, 54.90, NULL, NULL, NULL),
(423, 174, 9, 2, 7.10, 14.20, NULL, NULL, NULL),
(424, 175, 3, 4, 12.00, 48.00, NULL, NULL, NULL),
(425, 175, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(426, 175, 2, 4, 8.25, 33.00, NULL, NULL, NULL),
(427, 175, 6, 4, 31.90, 127.60, NULL, NULL, NULL),
(428, 176, 7, 5, 2.99, 14.95, NULL, NULL, NULL),
(429, 177, 3, 3, 12.00, 36.00, NULL, NULL, NULL),
(430, 178, 8, 5, 18.30, 91.50, NULL, NULL, NULL),
(431, 178, 8, 3, 18.30, 54.90, NULL, NULL, NULL),
(432, 179, 9, 2, 7.10, 14.20, NULL, NULL, NULL),
(433, 180, 9, 1, 7.10, 7.10, NULL, NULL, NULL),
(434, 181, 10, 2, 10.00, 20.00, NULL, NULL, NULL),
(435, 182, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(436, 182, 10, 5, 10.00, 50.00, NULL, NULL, NULL),
(437, 182, 5, 5, 22.40, 112.00, NULL, NULL, NULL),
(438, 182, 6, 2, 31.90, 63.80, NULL, NULL, NULL),
(439, 183, 2, 5, 8.25, 41.25, NULL, NULL, NULL),
(440, 183, 2, 5, 8.25, 41.25, NULL, NULL, NULL),
(441, 183, 10, 2, 10.00, 20.00, NULL, NULL, NULL),
(442, 184, 1, 5, 5.50, 27.50, NULL, NULL, NULL),
(443, 185, 7, 4, 2.99, 11.96, NULL, NULL, NULL),
(444, 185, 9, 4, 7.10, 28.40, NULL, NULL, NULL),
(445, 185, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(446, 186, 1, 5, 5.50, 27.50, NULL, NULL, NULL),
(447, 186, 8, 1, 18.30, 18.30, NULL, NULL, NULL),
(448, 186, 9, 4, 7.10, 28.40, NULL, NULL, NULL),
(449, 187, 2, 3, 8.25, 24.75, NULL, NULL, NULL),
(450, 188, 9, 2, 7.10, 14.20, NULL, NULL, NULL),
(451, 188, 1, 3, 5.50, 16.50, NULL, NULL, NULL),
(452, 188, 6, 2, 31.90, 63.80, NULL, NULL, NULL),
(453, 189, 8, 3, 18.30, 54.90, NULL, NULL, NULL),
(454, 189, 3, 3, 12.00, 36.00, NULL, NULL, NULL),
(455, 190, 3, 2, 12.00, 24.00, NULL, NULL, NULL),
(456, 190, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(457, 190, 2, 5, 8.25, 41.25, NULL, NULL, NULL),
(458, 190, 6, 5, 31.90, 159.50, NULL, NULL, NULL),
(459, 191, 4, 2, 15.75, 31.50, NULL, NULL, NULL),
(460, 192, 3, 5, 12.00, 60.00, NULL, NULL, NULL),
(461, 192, 3, 2, 12.00, 24.00, NULL, NULL, NULL),
(462, 192, 2, 3, 8.25, 24.75, NULL, NULL, NULL),
(463, 192, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(464, 193, 7, 4, 2.99, 11.96, NULL, NULL, NULL),
(465, 193, 6, 3, 31.90, 95.70, NULL, NULL, NULL),
(466, 194, 1, 3, 5.50, 16.50, NULL, NULL, NULL),
(467, 194, 1, 3, 5.50, 16.50, NULL, NULL, NULL),
(468, 194, 6, 4, 31.90, 127.60, NULL, NULL, NULL),
(469, 195, 10, 3, 10.00, 30.00, NULL, NULL, NULL),
(470, 196, 10, 1, 10.00, 10.00, NULL, NULL, NULL),
(471, 196, 8, 2, 18.30, 36.60, NULL, NULL, NULL),
(472, 196, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(473, 196, 1, 5, 5.50, 27.50, NULL, NULL, NULL),
(474, 197, 5, 1, 22.40, 22.40, NULL, NULL, NULL),
(475, 197, 2, 3, 8.25, 24.75, NULL, NULL, NULL),
(476, 198, 7, 5, 2.99, 14.95, NULL, NULL, NULL),
(477, 198, 7, 1, 2.99, 2.99, NULL, NULL, NULL),
(478, 198, 6, 5, 31.90, 159.50, NULL, NULL, NULL),
(479, 198, 7, 2, 2.99, 5.98, NULL, NULL, NULL),
(480, 199, 10, 3, 10.00, 30.00, NULL, NULL, NULL),
(481, 199, 2, 3, 8.25, 24.75, NULL, NULL, NULL),
(482, 199, 8, 2, 18.30, 36.60, NULL, NULL, NULL),
(483, 199, 5, 5, 22.40, 112.00, NULL, NULL, NULL),
(484, 200, 6, 4, 31.90, 127.60, NULL, NULL, NULL),
(485, 201, 4, 4, 15.75, 63.00, NULL, NULL, NULL),
(486, 202, 10, 3, 10.00, 30.00, NULL, NULL, NULL),
(487, 202, 4, 3, 15.75, 47.25, NULL, NULL, NULL),
(488, 203, 1, 1, 5.50, 5.50, NULL, NULL, NULL),
(489, 203, 3, 5, 12.00, 60.00, NULL, NULL, NULL),
(490, 203, 9, 3, 7.10, 21.30, NULL, NULL, NULL),
(491, 203, 7, 4, 2.99, 11.96, NULL, NULL, NULL),
(492, 204, 5, 1, 22.40, 22.40, NULL, NULL, NULL),
(493, 205, 6, 1, 31.90, 31.90, NULL, NULL, NULL),
(494, 205, 6, 3, 31.90, 95.70, NULL, NULL, NULL),
(495, 205, 2, 2, 8.25, 16.50, NULL, NULL, NULL),
(496, 206, 5, 2, 22.40, 44.80, NULL, NULL, NULL),
(497, 206, 2, 5, 8.25, 41.25, NULL, NULL, NULL),
(498, 207, 9, 1, 7.10, 7.10, NULL, NULL, NULL),
(499, 207, 5, 1, 22.40, 22.40, NULL, NULL, NULL),
(500, 207, 2, 1, 8.25, 8.25, NULL, NULL, NULL),
(501, 207, 8, 2, 18.30, 36.60, NULL, NULL, NULL),
(502, 208, 2, 1, 8.25, 8.25, NULL, NULL, NULL),
(503, 208, 8, 4, 18.30, 73.20, NULL, NULL, NULL),
(504, 209, 5, 3, 22.40, 67.20, NULL, NULL, NULL),
(505, 209, 7, 5, 2.99, 14.95, NULL, NULL, NULL),
(506, 209, 1, 2, 5.50, 11.00, NULL, NULL, NULL),
(507, 210, 1, 5, 5.50, 27.50, NULL, NULL, NULL),
(508, 211, 9, 3, 7.10, 21.30, NULL, NULL, NULL),
(509, 211, 5, 2, 22.40, 44.80, NULL, NULL, NULL),
(510, 211, 4, 5, 15.75, 78.75, NULL, NULL, NULL),
(511, 211, 3, 1, 12.00, 12.00, NULL, NULL, NULL),
(512, 212, 10, 4, 10.00, 40.00, NULL, NULL, NULL),
(513, 212, 10, 5, 10.00, 50.00, NULL, NULL, NULL),
(514, 212, 4, 2, 15.75, 31.50, NULL, NULL, NULL),
(515, 213, 5, 2, 22.40, 44.80, NULL, NULL, NULL),
(516, 213, 10, 3, 10.00, 30.00, NULL, NULL, NULL),
(517, 213, 7, 3, 2.99, 8.97, NULL, NULL, NULL),
(518, 214, 6, 5, 31.90, 159.50, NULL, NULL, NULL),
(519, 215, 4, 1, 15.75, 15.75, NULL, NULL, NULL),
(520, 216, 10, 1, 10.00, 10.00, NULL, NULL, NULL),
(521, 217, 6, 2, 31.90, 63.80, NULL, NULL, NULL),
(522, 217, 3, 4, 12.00, 48.00, NULL, NULL, NULL),
(523, 217, 1, 2, 5.50, 11.00, NULL, NULL, NULL),
(524, 217, 1, 5, 5.50, 27.50, NULL, NULL, NULL),
(525, 218, 2, 2, 8.25, 16.50, NULL, NULL, NULL),
(526, 219, 9, 3, 7.10, 21.30, NULL, NULL, NULL),
(527, 219, 3, 5, 12.00, 60.00, NULL, NULL, NULL),
(528, 220, 3, 2, 12.00, 24.00, NULL, NULL, NULL),
(529, 220, 9, 4, 7.10, 28.40, NULL, NULL, NULL);

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
(8, 'Diego Almeida', 'diego.almeida@example.com', '0980008888', '0809101112', NULL, NULL, NULL, NULL),
(9, 'Rafael Mena', 'rafael.mena@example.com', '0980009999', '0910111213', NULL, NULL, NULL, NULL),
(10, 'Patricia Salas', 'patricia.salas@example.com', '0980010000', '1011121314', NULL, NULL, NULL, NULL);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=221;

--
-- AUTO_INCREMENT de la tabla `sale_details`
--
ALTER TABLE `sale_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=530;

--
-- AUTO_INCREMENT de la tabla `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
