-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-07-2022 a las 20:07:32
-- Versión del servidor: 10.4.16-MariaDB
-- Versión de PHP: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `waiter_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth`
--

CREATE TABLE `auth` (
  `id` int(11) NOT NULL,
  `auth_code` int(11) NOT NULL,
  `tip_percentage` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `auth`
--

INSERT INTO `auth` (`id`, `auth_code`, `tip_percentage`, `created_at`, `updated_at`) VALUES
(3, 12345678, 6, '2022-07-12 12:19:26', '2022-07-12 12:19:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `client`
--

CREATE TABLE `client` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `client`
--

INSERT INTO `client` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'alphonse', '2022-07-12 12:19:26', '2022-07-12 12:19:26'),
(2, 'Bertha', '2022-07-12 12:19:26', '2022-07-12 12:19:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `invoice`
--

CREATE TABLE `invoice` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `waiter_id` int(11) NOT NULL,
  `tabl_id` int(11) NOT NULL,
  `products_description` varchar(500) COLLATE utf8mb4_spanish_ci NOT NULL,
  `tip` int(11) NOT NULL,
  `total_without_tip` double NOT NULL,
  `total_with_tip` double NOT NULL,
  `payed` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `invoice`
--

INSERT INTO `invoice` (`id`, `client_id`, `waiter_id`, `tabl_id`, `products_description`, `tip`, `total_without_tip`, `total_with_tip`, `payed`, `created_at`, `updated_at`) VALUES
(2, 1, 1, 1, '2 bottles of water', 6, 5, 5.3, 0, '2022-07-12 17:30:31', '2022-07-12 17:30:31'),
(3, 2, 1, 1, '4 bottles of water', 6, 10, 10.6, 0, '2022-07-12 17:32:50', '2022-07-12 17:32:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tabl`
--

CREATE TABLE `tabl` (
  `id` int(11) NOT NULL,
  `location` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `capacity` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `tabl`
--

INSERT INTO `tabl` (`id`, `location`, `capacity`, `created_at`, `updated_at`) VALUES
(1, 'north', 5, '2022-07-12 12:19:26', '2022-07-12 12:19:26'),
(2, 'south', 2, '2022-07-12 12:19:26', '2022-07-12 12:19:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `waiter`
--

CREATE TABLE `waiter` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `waiter`
--

INSERT INTO `waiter` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Albert', '2022-07-12 12:19:26', '2022-07-12 12:19:26'),
(2, 'Bertrand', '2022-07-12 12:19:26', '2022-07-12 12:19:26');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auth`
--
ALTER TABLE `auth`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_code` (`auth_code`);

--
-- Indices de la tabla `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `waiter_id` (`waiter_id`),
  ADD KEY `tabl_id` (`tabl_id`);

--
-- Indices de la tabla `tabl`
--
ALTER TABLE `tabl`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `waiter`
--
ALTER TABLE `waiter`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auth`
--
ALTER TABLE `auth`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `client`
--
ALTER TABLE `client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `invoice`
--
ALTER TABLE `invoice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tabl`
--
ALTER TABLE `tabl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `waiter`
--
ALTER TABLE `waiter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `client_id` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tabl_id` FOREIGN KEY (`tabl_id`) REFERENCES `tabl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `waiter_id` FOREIGN KEY (`waiter_id`) REFERENCES `waiter` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
