-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-10-2023 a las 12:49:24
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mydb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `censo`
--

CREATE TABLE `censo` (
  `id_censo_anio` int(4) NOT NULL,
  `descripcion_censo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `censo`
--

INSERT INTO `censo` (`id_censo_anio`, `descripcion_censo`) VALUES
(2010, 'Censo_2010-cuadros_por muni_frac_y_radio'),
(2022, 'Censo 2022 dato provisionales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `censo_has_departamento`
--

CREATE TABLE `censo_has_departamento` (
  `id_censo_has_departamento` int(4) NOT NULL,
  `Censo_id_censo` int(4) NOT NULL,
  `Departamento_id_departamento` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `censo_has_departamento`
--

INSERT INTO `censo_has_departamento` (`id_censo_has_departamento`, `Censo_id_censo`, `Departamento_id_departamento`) VALUES
(1, 2010, '008'),
(2, 2010, '015'),
(3, 2010, '021'),
(4, 2010, '028'),
(5, 2010, '035'),
(6, 2010, '042'),
(7, 2010, '049'),
(8, 2010, '056'),
(9, 2010, '063'),
(10, 2010, '070'),
(11, 2010, '077'),
(12, 2010, '084'),
(13, 2010, '088'),
(14, 2010, '091'),
(15, 2010, '098'),
(16, 2010, '105'),
(17, 2010, '113'),
(18, 2022, '008'),
(19, 2022, '015'),
(20, 2022, '021'),
(21, 2022, '028'),
(22, 2022, '035'),
(23, 2022, '042'),
(24, 2022, '049'),
(25, 2022, '056'),
(26, 2022, '063'),
(27, 2022, '070'),
(28, 2022, '077'),
(29, 2022, '084'),
(30, 2022, '088'),
(31, 2022, '091'),
(32, 2022, '098'),
(33, 2022, '105'),
(34, 2022, '113');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuadro`
--

CREATE TABLE `cuadro` (
  `id_cuadro` int(4) NOT NULL,
  `cuadro_tematica_descripcion` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `cuadro`
--

INSERT INTO `cuadro` (`id_cuadro`, `cuadro_tematica_descripcion`) VALUES
(1, 'Caracteristicas Habitacionales'),
(2, 'Hacinamiento'),
(3, 'Equipamiento del hogar'),
(4, 'Necesidades basica insatisfecha'),
(5, 'Caracteristicas Economicas'),
(6, 'Composicion del hogar'),
(7, 'Educacion'),
(8, 'Estructura de poblacion'),
(9, 'Migraciones'),
(10, 'Instituciones Colectivas'),
(11, 'Unidades de relevamiento');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `id_departamento` varchar(3) NOT NULL,
  `nombre_departamento` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`id_departamento`, `nombre_departamento`) VALUES
('008', 'Colón'),
('015', 'Concordia'),
('021', 'Diamante'),
('028', 'Federación'),
('035', 'Federal'),
('042', 'Feliciano'),
('049', 'Gualeguay'),
('056', 'Gualeguaychú'),
('063', 'Islas'),
('070', 'La Paz'),
('077', 'Nogoyá'),
('084', 'Paraná'),
('088', 'San Salvador'),
('091', 'Tala'),
('098', 'Uruguay'),
('105', 'Victoria'),
('113', 'Villaguay');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro`
--

CREATE TABLE `registro` (
  `ID` int(11) NOT NULL,
  `Titulo_cuadro_id_registro` int(4) DEFAULT NULL,
  `Censo_has_departamento_id_registro` int(4) DEFAULT NULL,
  `url_cuadro_xlsx` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `registro`
--

INSERT INTO `registro` (`ID`, `Titulo_cuadro_id_registro`, `Censo_has_departamento_id_registro`, `url_cuadro_xlsx`) VALUES
(1, 1, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/1H-FR-Colón.xlsx'),
(2, 2, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/2H-FR-Colón.xlsx'),
(3, 3, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/3H-FR-Colón.xlsx'),
(4, 4, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/4H-FR-Colón.xlsx'),
(5, 5, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/5H-FR-Colón.xlsx'),
(6, 6, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/6H-FR-Colón.xlsx'),
(7, 7, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/7H-FR-Colón.xlsx'),
(8, 8, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/9H-FR-Colón.xlsx'),
(9, 9, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/11H-FR-Colón.xlsx'),
(10, 10, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/12H-FR-Colón.xlsx'),
(11, 11, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/13H-FR-Colón.xlsx'),
(12, 12, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/8H-FR-Colón.xlsx'),
(13, 13, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/15H-FR-Colón.xlsx'),
(14, 14, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/16H-FR-Colón.xlsx'),
(15, 15, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/17H-FR-Colón.xlsx'),
(16, 16, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/18H-FR-Colón.xlsx'),
(17, 17, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/10H-FR-Colón.xlsx'),
(18, 18, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/6P-FR-Colón.xlsx'),
(19, 19, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/5P-FR-Colón.xlsx'),
(20, 20, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/7P-FR-Colón.xlsx'),
(21, 21, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/8P-FR-Colón.xlsx'),
(22, 22, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/9P-FR-Colón.xlsx'),
(23, 23, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/10P-FR-Colón.xlsx'),
(24, 24, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/1P-FR-Colón.xlsx'),
(25, 25, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/3P-FR-Colón.xlsx'),
(26, 26, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/4P-FR-Colón.xlsx'),
(27, 27, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/2P-FR-Colón.xlsx'),
(28, 28, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/11P-FR-Colón.xlsx'),
(29, 29, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/2V-FR-Colón.xlsx'),
(30, 30, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/4V-FR-Colón.xlsx'),
(31, 31, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/5V-FR-Colón.xlsx'),
(32, 32, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/6V-FR-Colón.xlsx'),
(33, 33, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/1V-FR-Colón.xlsx'),
(34, 34, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/3V-FR-Colón.xlsx'),
(35, 35, 1, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Colón/7V-FR-Colón.xlsx'),
(36, 1, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/1H-FR-Concordia.xlsx'),
(37, 2, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/2H-FR-Concordia.xlsx'),
(38, 3, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/3H-FR-Concordia.xlsx'),
(39, 4, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/4H-FR-Concordia.xlsx'),
(40, 5, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/5H-FR-Concordia.xlsx'),
(41, 6, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/6H-FR-Concordia.xlsx'),
(42, 7, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/7H-FR-Concordia.xlsx'),
(43, 8, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/9H-FR-Concordia.xlsx'),
(44, 9, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/11H-FR-Concordia.xlsx'),
(45, 10, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/12H-FR-Concordia.xlsx'),
(46, 11, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/13H-FR-Concordia.xlsx'),
(47, 12, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/8H-FR-Concordia.xlsx'),
(48, 13, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/15H-FR-Concordia.xlsx'),
(49, 14, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/16H-FR-Concordia.xlsx'),
(50, 15, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/17H-FR-Concordia.xlsx'),
(51, 16, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/18H-FR-Concordia.xlsx'),
(52, 17, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/10H-FR-Concordia.xlsx'),
(53, 18, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/6P-FR-Concordia.xlsx'),
(54, 19, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/5P-FR-Concordia.xlsx'),
(55, 20, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/7P-FR-Concordia.xlsx'),
(56, 21, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/8P-FR-Concordia.xlsx'),
(57, 22, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/9P-FR-Concordia.xlsx'),
(58, 23, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/10P-FR-Concordia.xlsx'),
(59, 24, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/1P-FR-Concordia.xlsx'),
(60, 25, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/3P-FR-Concordia.xlsx'),
(61, 26, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/4P-FR-Concordia.xlsx'),
(62, 27, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/2P-FR-Concordia.xlsx'),
(63, 28, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/11P-FR-Concordia.xlsx'),
(64, 29, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/2V-FR-Concordia.xlsx'),
(65, 30, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/4V-FR-Concordia.xlsx'),
(66, 31, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/5V-FR-Concordia.xlsx'),
(67, 32, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/6V-FR-Concordia.xlsx'),
(68, 33, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/1V-FR-Concordia.xlsx'),
(69, 34, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/3V-FR-Concordia.xlsx'),
(70, 35, 2, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Concordia/7V-FR-Concordia.xlsx'),
(71, 1, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/1H-FR-Diamante.xlsx'),
(72, 2, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/2H-FR-Diamante.xlsx'),
(73, 3, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/3H-FR-Diamante.xlsx'),
(74, 4, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/4H-FR-Diamante.xlsx'),
(75, 5, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/5H-FR-Diamante.xlsx'),
(76, 6, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/6H-FR-Diamante.xlsx'),
(77, 7, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/7H-FR-Diamante.xlsx'),
(78, 8, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/9H-FR-Diamante.xlsx'),
(79, 9, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/11H-FR-Diamante.xlsx'),
(80, 10, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/12H-FR-Diamante.xlsx'),
(81, 11, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/13H-FR-Diamante.xlsx'),
(82, 12, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/8H-FR-Diamante.xlsx'),
(83, 13, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/15H-FR-Diamante.xlsx'),
(84, 14, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/16H-FR-Diamante.xlsx'),
(85, 15, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/17H-FR-Diamante.xlsx'),
(86, 16, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/18H-FR-Diamante.xlsx'),
(87, 17, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/10H-FR-Diamante.xlsx'),
(88, 18, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/6P-FR-Diamante.xlsx'),
(89, 19, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/5P-FR-Diamante.xlsx'),
(90, 20, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/7P-FR-Diamante.xlsx'),
(91, 21, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/8P-FR-Diamante.xlsx'),
(92, 22, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/9P-FR-Diamante.xlsx'),
(93, 23, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/10P-FR-Diamante.xlsx'),
(94, 24, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/1P-FR-Diamante.xlsx'),
(95, 25, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/3P-FR-Diamante.xlsx'),
(96, 26, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/4P-FR-Diamante.xlsx'),
(97, 27, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/2P-FR-Diamante.xlsx'),
(98, 28, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/11P-FR-Diamante.xlsx'),
(99, 29, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/2V-FR-Diamante.xlsx'),
(100, 30, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/4V-FR-Diamante.xlsx'),
(101, 31, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/5V-FR-Diamante.xlsx'),
(102, 32, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/6V-FR-Diamante.xlsx'),
(103, 33, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/1V-FR-Diamante.xlsx'),
(104, 34, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/3V-FR-Diamante.xlsx'),
(105, 35, 3, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Diamante/7V-FR-Diamante.xlsx'),
(106, 1, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/1H-FR-Federación.xlsx'),
(107, 2, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/2H-FR-Federación.xlsx'),
(108, 3, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/3H-FR-Federación.xlsx'),
(109, 4, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/4H-FR-Federación.xlsx'),
(110, 5, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/5H-FR-Federación.xlsx'),
(111, 6, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/6H-FR-Federación.xlsx'),
(112, 7, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/7H-FR-Federación.xlsx'),
(113, 8, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/9H-FR-Federación.xlsx'),
(114, 9, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/11H-FR-Federación.xlsx'),
(115, 10, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/12H-FR-Federación.xlsx'),
(116, 11, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/13H-FR-Federación.xlsx'),
(117, 12, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/8H-FR-Federación.xlsx'),
(118, 13, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/15H-FR-Federación.xlsx'),
(119, 14, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/16H-FR-Federación.xlsx'),
(120, 15, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/17H-FR-Federación.xlsx'),
(121, 16, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/18H-FR-Federación.xlsx'),
(122, 17, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/10H-FR-Federación.xlsx'),
(123, 18, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/6P-FR-Federación.xlsx'),
(124, 19, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/5P-FR-Federación.xlsx'),
(125, 20, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/7P-FR-Federación.xlsx'),
(126, 21, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/8P-FR-Federación.xlsx'),
(127, 22, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/9P-FR-Federación.xlsx'),
(128, 23, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/10P-FR-Federación.xlsx'),
(129, 24, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/1P-FR-Federación.xlsx'),
(130, 25, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/3P-FR-Federación.xlsx'),
(131, 26, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/4P-FR-Federación.xlsx'),
(132, 27, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/2P-FR-Federación.xlsx'),
(133, 28, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/11P-FR-Federación.xlsx'),
(134, 29, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/2V-FR-Federación.xlsx'),
(135, 30, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/4V-FR-Federación.xlsx'),
(136, 31, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/5V-FR-Federación.xlsx'),
(137, 32, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/6V-FR-Federación.xlsx'),
(138, 33, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/1V-FR-Federación.xlsx'),
(139, 34, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/3V-FR-Federación.xlsx'),
(140, 35, 4, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federación/7V-FR-Federación.xlsx'),
(141, 1, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/1H-FR-Federal.xlsx'),
(142, 2, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/2H-FR-Federal.xlsx'),
(143, 3, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/3H-FR-Federal.xlsx'),
(144, 4, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/4H-FR-Federal.xlsx'),
(145, 5, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/5H-FR-Federal.xlsx'),
(146, 6, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/6H-FR-Federal.xlsx'),
(147, 7, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/7H-FR-Federal.xlsx'),
(148, 8, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/9H-FR-Federal.xlsx'),
(149, 9, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/11H-FR-Federal.xlsx'),
(150, 10, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/12H-FR-Federal.xlsx'),
(151, 11, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/13H-FR-Federal.xlsx'),
(152, 12, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/8H-FR-Federal.xlsx'),
(153, 13, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/15H-FR-Federal.xlsx'),
(154, 14, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/16H-FR-Federal.xlsx'),
(155, 15, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/17H-FR-Federal.xlsx'),
(156, 16, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/18H-FR-Federal.xlsx'),
(157, 17, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/10H-FR-Federal.xlsx'),
(158, 18, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/6P-FR-Federal.xlsx'),
(159, 19, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/5P-FR-Federal.xlsx'),
(160, 20, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/7P-FR-Federal.xlsx'),
(161, 21, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/8P-FR-Federal.xlsx'),
(162, 22, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/9P-FR-Federal.xlsx'),
(163, 23, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/10P-FR-Federal.xlsx'),
(164, 24, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/1P-FR-Federal.xlsx'),
(165, 25, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/3P-FR-Federal.xlsx'),
(166, 26, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/4P-FR-Federal.xlsx'),
(167, 27, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/2P-FR-Federal.xlsx'),
(168, 28, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/11P-FR-Federal.xlsx'),
(169, 29, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/2V-FR-Federal.xlsx'),
(170, 30, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/4V-FR-Federal.xlsx'),
(171, 31, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/5V-FR-Federal.xlsx'),
(172, 32, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/6V-FR-Federal.xlsx'),
(173, 33, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/1V-FR-Federal.xlsx'),
(174, 34, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/3V-FR-Federal.xlsx'),
(175, 35, 5, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Federal/7V-FR-Federal.xlsx'),
(176, 1, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/1H-FR-Feliciano.xlsx'),
(177, 2, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/2H-FR-Feliciano.xlsx'),
(178, 3, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/3H-FR-Feliciano.xlsx'),
(179, 4, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/4H-FR-Feliciano.xlsx'),
(180, 5, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/5H-FR-Feliciano.xlsx'),
(181, 6, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/6H-FR-Feliciano.xlsx'),
(182, 7, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/7H-FR-Feliciano.xlsx'),
(183, 8, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/9H-FR-Feliciano.xlsx'),
(184, 9, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/11H-FR-Feliciano.xlsx'),
(185, 10, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/12H-FR-Feliciano.xlsx'),
(186, 11, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/13H-FR-Feliciano.xlsx'),
(187, 12, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/8H-FR-Feliciano.xlsx'),
(188, 13, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/15H-FR-Feliciano.xlsx'),
(189, 14, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/16H-FR-Feliciano.xlsx'),
(190, 15, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/17H-FR-Feliciano.xlsx'),
(191, 16, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/18H-FR-Feliciano.xlsx'),
(192, 17, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/10H-FR-Feliciano.xlsx'),
(193, 18, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/6P-FR-Feliciano.xlsx'),
(194, 19, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/5P-FR-Feliciano.xlsx'),
(195, 20, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/7P-FR-Feliciano.xlsx'),
(196, 21, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/8P-FR-Feliciano.xlsx'),
(197, 22, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/9P-FR-Feliciano.xlsx'),
(198, 23, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/10P-FR-Feliciano.xlsx'),
(199, 24, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/1P-FR-Feliciano.xlsx'),
(200, 25, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/3P-FR-Feliciano.xlsx'),
(201, 26, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/4P-FR-Feliciano.xlsx'),
(202, 27, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/2P-FR-Feliciano.xlsx'),
(203, 28, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/11P-FR-Feliciano.xlsx'),
(204, 29, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/2V-FR-Feliciano.xlsx'),
(205, 30, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/4V-FR-Feliciano.xlsx'),
(206, 31, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/5V-FR-Feliciano.xlsx'),
(207, 32, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/6V-FR-Feliciano.xlsx'),
(208, 33, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/1V-FR-Feliciano.xlsx'),
(209, 34, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/3V-FR-Feliciano.xlsx'),
(210, 35, 6, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Feliciano/7V-FR-Feliciano.xlsx'),
(211, 1, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/1H-FR-Gualeguay.xlsx'),
(212, 2, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/2H-FR-Gualeguay.xlsx'),
(213, 3, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/3H-FR-Gualeguay.xlsx'),
(214, 4, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/4H-FR-Gualeguay.xlsx'),
(215, 5, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/5H-FR-Gualeguay.xlsx'),
(216, 6, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/6H-FR-Gualeguay.xlsx'),
(217, 7, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/7H-FR-Gualeguay.xlsx'),
(218, 8, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/9H-FR-Gualeguay.xlsx'),
(219, 9, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/11H-FR-Gualeguay.xlsx'),
(220, 10, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/12H-FR-Gualeguay.xlsx'),
(221, 11, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/13H-FR-Gualeguay.xlsx'),
(222, 12, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/8H-FR-Gualeguay.xlsx'),
(223, 13, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/15H-FR-Gualeguay.xlsx'),
(224, 14, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/16H-FR-Gualeguay.xlsx'),
(225, 15, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/17H-FR-Gualeguay.xlsx'),
(226, 16, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/18H-FR-Gualeguay.xlsx'),
(227, 17, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/10H-FR-Gualeguay.xlsx'),
(228, 18, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/6P-FR-Gualeguay.xlsx'),
(229, 19, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/5P-FR-Gualeguay.xlsx'),
(230, 20, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/7P-FR-Gualeguay.xlsx'),
(231, 21, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/8P-FR-Gualeguay.xlsx'),
(232, 22, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/9P-FR-Gualeguay.xlsx'),
(233, 23, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/10P-FR-Gualeguay.xlsx'),
(234, 24, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/1P-FR-Gualeguay.xlsx'),
(235, 25, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/3P-FR-Gualeguay.xlsx'),
(236, 26, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/4P-FR-Gualeguay.xlsx'),
(237, 27, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/2P-FR-Gualeguay.xlsx'),
(238, 28, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/11P-FR-Gualeguay.xlsx'),
(239, 29, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/2V-FR-Gualeguay.xlsx'),
(240, 30, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/4V-FR-Gualeguay.xlsx'),
(241, 31, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/5V-FR-Gualeguay.xlsx'),
(242, 32, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/6V-FR-Gualeguay.xlsx'),
(243, 33, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/1V-FR-Gualeguay.xlsx'),
(244, 34, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/3V-FR-Gualeguay.xlsx'),
(245, 35, 7, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguay/7V-FR-Gualeguay.xlsx'),
(246, 1, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/1H-FR-Gualeguaychú.xlsx'),
(247, 2, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/2H-FR-Gualeguaychú.xlsx'),
(248, 3, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/3H-FR-Gualeguaychú.xlsx'),
(249, 4, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/4H-FR-Gualeguaychú.xlsx'),
(250, 5, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/5H-FR-Gualeguaychú.xlsx'),
(251, 6, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/6H-FR-Gualeguaychú.xlsx'),
(252, 7, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/7H-FR-Gualeguaychú.xlsx'),
(253, 8, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/9H-FR-Gualeguaychú.xlsx'),
(254, 9, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/11H-FR-Gualeguaychú.xlsx'),
(255, 10, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/12H-FR-Gualeguaychú.xlsx'),
(256, 11, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/13H-FR-Gualeguaychú.xlsx'),
(257, 12, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/8H-FR-Gualeguaychú.xlsx'),
(258, 13, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/15H-FR-Gualeguaychú.xlsx'),
(259, 14, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/16H-FR-Gualeguaychú.xlsx'),
(260, 15, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/17H-FR-Gualeguaychú.xlsx'),
(261, 16, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/18H-FR-Gualeguaychú.xlsx'),
(262, 17, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/10H-FR-Gualeguaychú.xlsx'),
(263, 18, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/6P-FR-Gualeguaychú.xlsx'),
(264, 19, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/5P-FR-Gualeguaychú.xlsx'),
(265, 20, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/7P-FR-Gualeguaychú.xlsx'),
(266, 21, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/8P-FR-Gualeguaychú.xlsx'),
(267, 22, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/9P-FR-Gualeguaychú.xlsx'),
(268, 23, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/10P-FR-Gualeguaychú.xlsx'),
(269, 24, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/1P-FR-Gualeguaychú.xlsx'),
(270, 25, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/3P-FR-Gualeguaychú.xlsx'),
(271, 26, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/4P-FR-Gualeguaychú.xlsx'),
(272, 27, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/2P-FR-Gualeguaychú.xlsx'),
(273, 28, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/11P-FR-Gualeguaychú.xlsx'),
(274, 29, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/2V-FR-Gualeguaychú.xlsx'),
(275, 30, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/4V-FR-Gualeguaychú.xlsx'),
(276, 31, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/5V-FR-Gualeguaychú.xlsx'),
(277, 32, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/6V-FR-Gualeguaychú.xlsx'),
(278, 33, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/1V-FR-Gualeguaychú.xlsx'),
(279, 34, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/3V-FR-Gualeguaychú.xlsx'),
(280, 35, 8, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Gualeguaychú/7V-FR-Gualeguaychú.xlsx'),
(281, 1, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/1H-FR-Islas.xlsx'),
(282, 2, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/2H-FR-Islas.xlsx'),
(283, 3, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/3H-FR-Islas.xlsx'),
(284, 4, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/4H-FR-Islas.xlsx'),
(285, 5, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/5H-FR-Islas.xlsx'),
(286, 6, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/6H-FR-Islas.xlsx'),
(287, 7, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/7H-FR-Islas.xlsx'),
(288, 8, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/9H-FR-Islas.xlsx'),
(289, 9, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/11H-FR-Islas.xlsx'),
(290, 10, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/12H-FR-Islas.xlsx'),
(291, 11, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/13H-FR-Islas.xlsx'),
(292, 12, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/8H-FR-Islas.xlsx'),
(293, 13, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/15H-FR-Islas.xlsx'),
(294, 14, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/16H-FR-Islas.xlsx'),
(295, 15, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/17H-FR-Islas.xlsx'),
(296, 16, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/18H-FR-Islas.xlsx'),
(297, 17, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/10H-FR-Islas.xlsx'),
(298, 18, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/6P-FR-Islas.xlsx'),
(299, 19, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/5P-FR-Islas.xlsx'),
(300, 20, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/7P-FR-Islas.xlsx'),
(301, 21, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/8P-FR-Islas.xlsx'),
(302, 22, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/9P-FR-Islas.xlsx'),
(303, 23, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/10P-FR-Islas.xlsx'),
(304, 24, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/1P-FR-Islas.xlsx'),
(305, 25, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/3P-FR-Islas.xlsx'),
(306, 26, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/4P-FR-Islas.xlsx'),
(307, 27, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/2P-FR-Islas.xlsx'),
(308, 28, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/11P-FR-Islas.xlsx'),
(309, 29, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/2V-FR-Islas.xlsx'),
(310, 30, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/4V-FR-Islas.xlsx'),
(311, 31, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/5V-FR-Islas.xlsx'),
(312, 32, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/6V-FR-Islas.xlsx'),
(313, 33, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/1V-FR-Islas.xlsx'),
(314, 34, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/3V-FR-Islas.xlsx'),
(315, 35, 9, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Islas/7V-FR-Islas.xlsx'),
(316, 1, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/1H-FR-La Paz.xlsx'),
(317, 2, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/2H-FR-La Paz.xlsx'),
(318, 3, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/3H-FR-La Paz.xlsx'),
(319, 4, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/4H-FR-La Paz.xlsx'),
(320, 5, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/5H-FR-La Paz.xlsx'),
(321, 6, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/6H-FR-La Paz.xlsx'),
(322, 7, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/7H-FR-La Paz.xlsx'),
(323, 8, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/9H-FR-La Paz.xlsx'),
(324, 9, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/11H-FR-La Paz.xlsx'),
(325, 10, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/12H-FR-La Paz.xlsx'),
(326, 11, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/13H-FR-La Paz.xlsx'),
(327, 12, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/8H-FR-La Paz.xlsx'),
(328, 13, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/15H-FR-La Paz.xlsx'),
(329, 14, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/16H-FR-La Paz.xlsx'),
(330, 15, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/17H-FR-La Paz.xlsx'),
(331, 16, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/18H-FR-La Paz.xlsx'),
(332, 17, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/10H-FR-La Paz.xlsx'),
(333, 18, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/6P-FR-La Paz.xlsx'),
(334, 19, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/5P-FR-La Paz.xlsx'),
(335, 20, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/7P-FR-La Paz.xlsx'),
(336, 21, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/8P-FR-La Paz.xlsx'),
(337, 22, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/9P-FR-La Paz.xlsx'),
(338, 23, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/10P-FR-La Paz.xlsx'),
(339, 24, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/1P-FR-La Paz.xlsx'),
(340, 25, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/3P-FR-La Paz.xlsx'),
(341, 26, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/4P-FR-La Paz.xlsx'),
(342, 27, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/2P-FR-La Paz.xlsx'),
(343, 28, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/11P-FR-La Paz.xlsx'),
(344, 29, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/2V-FR-La Paz.xlsx'),
(345, 30, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/4V-FR-La Paz.xlsx'),
(346, 31, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/5V-FR-La Paz.xlsx'),
(347, 32, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/6V-FR-La Paz.xlsx'),
(348, 33, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/1V-FR-La Paz.xlsx'),
(349, 34, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/3V-FR-La Paz.xlsx'),
(350, 35, 10, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/La Paz/7V-FR-La Paz.xlsx'),
(351, 1, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/1H-FR-Nogoyá.xlsx'),
(352, 2, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/2H-FR-Nogoyá.xlsx'),
(353, 3, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/3H-FR-Nogoyá.xlsx'),
(354, 4, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/4H-FR-Nogoyá.xlsx'),
(355, 5, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/5H-FR-Nogoyá.xlsx'),
(356, 6, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/6H-FR-Nogoyá.xlsx'),
(357, 7, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/7H-FR-Nogoyá.xlsx'),
(358, 8, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/9H-FR-Nogoyá.xlsx'),
(359, 9, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/11H-FR-Nogoyá.xlsx'),
(360, 10, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/12H-FR-Nogoyá.xlsx'),
(361, 11, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/13H-FR-Nogoyá.xlsx'),
(362, 12, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/8H-FR-Nogoyá.xlsx'),
(363, 13, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/15H-FR-Nogoyá.xlsx'),
(364, 14, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/16H-FR-Nogoyá.xlsx'),
(365, 15, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/17H-FR-Nogoyá.xlsx'),
(366, 16, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/18H-FR-Nogoyá.xlsx'),
(367, 17, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/10H-FR-Nogoyá.xlsx'),
(368, 18, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/6P-FR-Nogoyá.xlsx'),
(369, 19, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/5P-FR-Nogoyá.xlsx'),
(370, 20, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/7P-FR-Nogoyá.xlsx'),
(371, 21, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/8P-FR-Nogoyá.xlsx'),
(372, 22, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/9P-FR-Nogoyá.xlsx'),
(373, 23, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/10P-FR-Nogoyá.xlsx'),
(374, 24, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/1P-FR-Nogoyá.xlsx'),
(375, 25, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/3P-FR-Nogoyá.xlsx'),
(376, 26, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/4P-FR-Nogoyá.xlsx'),
(377, 27, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/2P-FR-Nogoyá.xlsx'),
(378, 28, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/11P-FR-Nogoyá.xlsx'),
(379, 29, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/2V-FR-Nogoyá.xlsx'),
(380, 30, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/4V-FR-Nogoyá.xlsx'),
(381, 31, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/5V-FR-Nogoyá.xlsx'),
(382, 32, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/6V-FR-Nogoyá.xlsx'),
(383, 33, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/1V-FR-Nogoyá.xlsx'),
(384, 34, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/3V-FR-Nogoyá.xlsx'),
(385, 35, 11, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Nogoyá/7V-FR-Nogoyá.xlsx'),
(386, 1, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/1H-FR-Paraná.xlsx'),
(387, 2, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/2H-FR-Paraná.xlsx'),
(388, 3, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/3H-FR-Paraná.xlsx'),
(389, 4, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/4H-FR-Paraná.xlsx'),
(390, 5, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/5H-FR-Paraná.xlsx'),
(391, 6, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/6H-FR-Paraná.xlsx');
INSERT INTO `registro` (`ID`, `Titulo_cuadro_id_registro`, `Censo_has_departamento_id_registro`, `url_cuadro_xlsx`) VALUES
(392, 7, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/7H-FR-Paraná.xlsx'),
(393, 8, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/9H-FR-Paraná.xlsx'),
(394, 9, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/11H-FR-Paraná.xlsx'),
(395, 10, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/12H-FR-Paraná.xlsx'),
(396, 11, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/13H-FR-Paraná.xlsx'),
(397, 12, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/8H-FR-Paraná.xlsx'),
(398, 13, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/15H-FR-Paraná.xlsx'),
(399, 14, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/16H-FR-Paraná.xlsx'),
(400, 15, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/17H-FR-Paraná.xlsx'),
(401, 16, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/18H-FR-Paraná.xlsx'),
(402, 17, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/10H-FR-Paraná.xlsx'),
(403, 18, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/6P-FR-Paraná.xlsx'),
(404, 19, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/5P-FR-Paraná.xlsx'),
(405, 20, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/7P-FR-Paraná.xlsx'),
(406, 21, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/8P-FR-Paraná.xlsx'),
(407, 22, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/9P-FR-Paraná.xlsx'),
(408, 23, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/10P-FR-Paraná.xlsx'),
(409, 24, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/1P-FR-Paraná.xlsx'),
(410, 25, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/3P-FR-Paraná.xlsx'),
(411, 26, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/4P-FR-Paraná.xlsx'),
(412, 27, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/2P-FR-Paraná.xlsx'),
(413, 28, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/11P-FR-Paraná.xlsx'),
(414, 29, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/2V-FR-Paraná.xlsx'),
(415, 30, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/4V-FR-Paraná.xlsx'),
(416, 31, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/5V-FR-Paraná.xlsx'),
(417, 32, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/6V-FR-Paraná.xlsx'),
(418, 33, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/1V-FR-Paraná.xlsx'),
(419, 34, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/3V-FR-Paraná.xlsx'),
(420, 35, 12, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Paraná/7V-FR-Paraná.xlsx'),
(421, 1, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/1H-FR-San Salvador.xlsx'),
(422, 2, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/2H-FR-San Salvador.xlsx'),
(423, 3, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/3H-FR-San Salvador.xlsx'),
(424, 4, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/4H-FR-San Salvador.xlsx'),
(425, 5, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/5H-FR-San Salvador.xlsx'),
(426, 6, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/6H-FR-San Salvador.xlsx'),
(427, 7, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/7H-FR-San Salvador.xlsx'),
(428, 8, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/9H-FR-San Salvador.xlsx'),
(429, 9, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/11H-FR-San Salvador.xlsx'),
(430, 10, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/12H-FR-San Salvador.xlsx'),
(431, 11, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/13H-FR-San Salvador.xlsx'),
(432, 12, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/8H-FR-San Salvador.xlsx'),
(433, 13, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/15H-FR-San Salvador.xlsx'),
(434, 14, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/16H-FR-San Salvador.xlsx'),
(435, 15, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/17H-FR-San Salvador.xlsx'),
(436, 16, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/18H-FR-San Salvador.xlsx'),
(437, 17, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/10H-FR-San Salvador.xlsx'),
(438, 18, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/6P-FR-San Salvador.xlsx'),
(439, 19, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/5P-FR-San Salvador.xlsx'),
(440, 20, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/7P-FR-San Salvador.xlsx'),
(441, 21, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/8P-FR-San Salvador.xlsx'),
(442, 22, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/9P-FR-San Salvador.xlsx'),
(443, 23, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/10P-FR-San Salvador.xlsx'),
(444, 24, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/1P-FR-San Salvador.xlsx'),
(445, 25, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/3P-FR-San Salvador.xlsx'),
(446, 26, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/4P-FR-San Salvador.xlsx'),
(447, 27, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/2P-FR-San Salvador.xlsx'),
(448, 28, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/11P-FR-San Salvador.xlsx'),
(449, 29, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/2V-FR-San Salvador.xlsx'),
(450, 30, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/4V-FR-San Salvador.xlsx'),
(451, 31, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/5V-FR-San Salvador.xlsx'),
(452, 32, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/6V-FR-San Salvador.xlsx'),
(453, 33, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/1V-FR-San Salvador.xlsx'),
(454, 34, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/3V-FR-San Salvador.xlsx'),
(455, 35, 13, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/San Salvador/7V-FR-San Salvador.xlsx'),
(456, 1, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/1H-FR-Tala.xlsx'),
(457, 2, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/2H-FR-Tala.xlsx'),
(458, 3, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/3H-FR-Tala.xlsx'),
(459, 4, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/4H-FR-Tala.xlsx'),
(460, 5, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/5H-FR-Tala.xlsx'),
(461, 6, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/6H-FR-Tala.xlsx'),
(462, 7, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/7H-FR-Tala.xlsx'),
(463, 8, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/9H-FR-Tala.xlsx'),
(464, 9, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/11H-FR-Tala.xlsx'),
(465, 10, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/12H-FR-Tala.xlsx'),
(466, 11, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/13H-FR-Tala.xlsx'),
(467, 12, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/8H-FR-Tala.xlsx'),
(468, 13, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/15H-FR-Tala.xlsx'),
(469, 14, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/16H-FR-Tala.xlsx'),
(470, 15, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/17H-FR-Tala.xlsx'),
(471, 16, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/18H-FR-Tala.xlsx'),
(472, 17, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/10H-FR-Tala.xlsx'),
(473, 18, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/6P-FR-Tala.xlsx'),
(474, 19, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/5P-FR-Tala.xlsx'),
(475, 20, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/7P-FR-Tala.xlsx'),
(476, 21, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/8P-FR-Tala.xlsx'),
(477, 22, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/9P-FR-Tala.xlsx'),
(478, 23, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/10P-FR-Tala.xlsx'),
(479, 24, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/1P-FR-Tala.xlsx'),
(480, 25, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/3P-FR-Tala.xlsx'),
(481, 26, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/4P-FR-Tala.xlsx'),
(482, 27, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/2P-FR-Tala.xlsx'),
(483, 28, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/11P-FR-Tala.xlsx'),
(484, 29, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/2V-FR-Tala.xlsx'),
(485, 30, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/4V-FR-Tala.xlsx'),
(486, 31, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/5V-FR-Tala.xlsx'),
(487, 32, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/6V-FR-Tala.xlsx'),
(488, 33, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/1V-FR-Tala.xlsx'),
(489, 34, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/3V-FR-Tala.xlsx'),
(490, 35, 14, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Tala/7V-FR-Tala.xlsx'),
(491, 1, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/1H-FR-Uruguay.xlsx'),
(492, 2, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/2H-FR-Uruguay.xlsx'),
(493, 3, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/3H-FR-Uruguay.xlsx'),
(494, 4, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/4H-FR-Uruguay.xlsx'),
(495, 5, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/5H-FR-Uruguay.xlsx'),
(496, 6, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/6H-FR-Uruguay.xlsx'),
(497, 7, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/7H-FR-Uruguay.xlsx'),
(498, 8, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/9H-FR-Uruguay.xlsx'),
(499, 9, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/11H-FR-Uruguay.xlsx'),
(500, 10, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/12H-FR-Uruguay.xlsx'),
(501, 11, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/13H-FR-Uruguay.xlsx'),
(502, 12, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/8H-FR-Uruguay.xlsx'),
(503, 13, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/15H-FR-Uruguay.xlsx'),
(504, 14, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/16H-FR-Uruguay.xlsx'),
(505, 15, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/17H-FR-Uruguay.xlsx'),
(506, 16, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/18H-FR-Uruguay.xlsx'),
(507, 17, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/10H-FR-Uruguay.xlsx'),
(508, 18, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/6P-FR-Uruguay.xlsx'),
(509, 19, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/5P-FR-Uruguay.xlsx'),
(510, 20, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/7P-FR-Uruguay.xlsx'),
(511, 21, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/8P-FR-Uruguay.xlsx'),
(512, 22, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/9P-FR-Uruguay.xlsx'),
(513, 23, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/10P-FR-Uruguay.xlsx'),
(514, 24, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/1P-FR-Uruguay.xlsx'),
(515, 25, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/3P-FR-Uruguay.xlsx'),
(516, 26, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/4P-FR-Uruguay.xlsx'),
(517, 27, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/2P-FR-Uruguay.xlsx'),
(518, 28, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/11P-FR-Uruguay.xlsx'),
(519, 29, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/2V-FR-Uruguay.xlsx'),
(520, 30, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/4V-FR-Uruguay.xlsx'),
(521, 31, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/5V-FR-Uruguay.xlsx'),
(522, 32, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/6V-FR-Uruguay.xlsx'),
(523, 33, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/1V-FR-Uruguay.xlsx'),
(524, 34, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/3V-FR-Uruguay.xlsx'),
(525, 35, 15, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Uruguay/7V-FR-Uruguay.xlsx'),
(526, 1, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/1H-FR-Victoria.xlsx'),
(527, 2, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/2H-FR-Victoria.xlsx'),
(528, 3, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/3H-FR-Victoria.xlsx'),
(529, 4, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/4H-FR-Victoria.xlsx'),
(530, 5, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/5H-FR-Victoria.xlsx'),
(531, 6, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/6H-FR-Victoria.xlsx'),
(532, 7, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/7H-FR-Victoria.xlsx'),
(533, 8, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/9H-FR-Victoria.xlsx'),
(534, 9, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/11H-FR-Victoria.xlsx'),
(535, 10, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/12H-FR-Victoria.xlsx'),
(536, 11, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/13H-FR-Victoria.xlsx'),
(537, 12, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/8H-FR-Victoria.xlsx'),
(538, 13, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/15H-FR-Victoria.xlsx'),
(539, 14, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/16H-FR-Victoria.xlsx'),
(540, 15, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/17H-FR-Victoria.xlsx'),
(541, 16, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/18H-FR-Victoria.xlsx'),
(542, 17, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/10H-FR-Victoria.xlsx'),
(543, 18, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/6P-FR-Victoria.xlsx'),
(544, 19, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/5P-FR-Victoria.xlsx'),
(545, 20, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/7P-FR-Victoria.xlsx'),
(546, 21, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/8P-FR-Victoria.xlsx'),
(547, 22, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/9P-FR-Victoria.xlsx'),
(548, 23, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/10P-FR-Victoria.xlsx'),
(549, 24, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/1P-FR-Victoria.xlsx'),
(550, 25, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/3P-FR-Victoria.xlsx'),
(551, 26, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/4P-FR-Victoria.xlsx'),
(552, 27, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/2P-FR-Victoria.xlsx'),
(553, 28, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/11P-FR-Victoria.xlsx'),
(554, 29, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/2V-FR-Victoria.xlsx'),
(555, 30, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/4V-FR-Victoria.xlsx'),
(556, 31, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/5V-FR-Victoria.xlsx'),
(557, 32, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/6V-FR-Victoria.xlsx'),
(558, 33, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/1V-FR-Victoria.xlsx'),
(559, 34, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/3V-FR-Victoria.xlsx'),
(560, 35, 16, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Victoria/7V-FR-Victoria.xlsx'),
(561, 1, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/1H-FR-Villaguay.xlsx'),
(562, 2, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/2H-FR-Villaguay.xlsx'),
(563, 3, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/3H-FR-Villaguay.xlsx'),
(564, 4, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/4H-FR-Villaguay.xlsx'),
(565, 5, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/5H-FR-Villaguay.xlsx'),
(566, 6, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/6H-FR-Villaguay.xlsx'),
(567, 7, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/7H-FR-Villaguay.xlsx'),
(568, 8, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/9H-FR-Villaguay.xlsx'),
(569, 9, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/11H-FR-Villaguay.xlsx'),
(570, 10, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/12H-FR-Villaguay.xlsx'),
(571, 11, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/13H-FR-Villaguay.xlsx'),
(572, 12, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/8H-FR-Villaguay.xlsx'),
(573, 13, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/15H-FR-Villaguay.xlsx'),
(574, 14, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/16H-FR-Villaguay.xlsx'),
(575, 15, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/17H-FR-Villaguay.xlsx'),
(576, 16, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/18H-FR-Villaguay.xlsx'),
(577, 17, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/10H-FR-Villaguay.xlsx'),
(578, 18, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/6P-FR-Villaguay.xlsx'),
(579, 19, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/5P-FR-Villaguay.xlsx'),
(580, 20, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/7P-FR-Villaguay.xlsx'),
(581, 21, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/8P-FR-Villaguay.xlsx'),
(582, 22, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/9P-FR-Villaguay.xlsx'),
(583, 23, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/10P-FR-Villaguay.xlsx'),
(584, 24, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/1P-FR-Villaguay.xlsx'),
(585, 25, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/3P-FR-Villaguay.xlsx'),
(586, 26, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/4P-FR-Villaguay.xlsx'),
(587, 27, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/2P-FR-Villaguay.xlsx'),
(588, 28, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/11P-FR-Villaguay.xlsx'),
(589, 29, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/2V-FR-Villaguay.xlsx'),
(590, 30, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/4V-FR-Villaguay.xlsx'),
(591, 31, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/5V-FR-Villaguay.xlsx'),
(592, 32, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/6V-FR-Villaguay.xlsx'),
(593, 33, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/1V-FR-Villaguay.xlsx'),
(594, 34, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/3V-FR-Villaguay.xlsx'),
(595, 35, 17, 'https://www.dgec.gob.ar/buscador/descargas/Censo 2010-cuadros por muni frac y radio/Villaguay/7V-FR-Villaguay.xlsx');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tematica`
--

CREATE TABLE `tematica` (
  `id_tematica` char(1) NOT NULL,
  `tematica_descripcion` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tematica`
--

INSERT INTO `tematica` (`id_tematica`, `tematica_descripcion`) VALUES
('H', 'hogar'),
('P', 'poblacion'),
('V', 'vivienda');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tematica_has_cuadro`
--

CREATE TABLE `tematica_has_cuadro` (
  `cuadro_id_cuadro` int(4) NOT NULL,
  `tematica_id_tematica` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tematica_has_cuadro`
--

INSERT INTO `tematica_has_cuadro` (`cuadro_id_cuadro`, `tematica_id_tematica`) VALUES
(1, 'H'),
(2, 'H'),
(3, 'H'),
(4, 'H'),
(3, 'P'),
(5, 'P'),
(6, 'P'),
(7, 'P'),
(8, 'P'),
(9, 'P'),
(1, 'V'),
(10, 'V'),
(11, 'V');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `titulo_cuadro`
--

CREATE TABLE `titulo_cuadro` (
  `ID` int(4) NOT NULL,
  `id_titulo_cuadro` int(4) NOT NULL,
  `Cuadro_id` int(4) NOT NULL,
  `Tematica_id` char(1) NOT NULL,
  `titulo_cuadro_titulo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `titulo_cuadro`
--

INSERT INTO `titulo_cuadro` (`ID`, `id_titulo_cuadro`, `Cuadro_id`, `Tematica_id`, `titulo_cuadro_titulo`) VALUES
(1, 1, 1, 'H', 'Hogares por material predominante de los pisos de la vivienda por área de gobierno local, fracción y radio censal. '),
(2, 2, 1, 'H', 'Hogares habitados según tenencia de baño por departamento, área de gobierno local, fracción y radio censal'),
(3, 3, 1, 'H', 'Hogares con baño según desagüe de inodoro por departamento, área de gobierno local, fracción y radio censal'),
(4, 4, 1, 'H', 'Hogares con baño de uso exclusivo por departamento, área de gobierno local, fracción y radio censal. Año 2010.'),
(5, 5, 1, 'H', 'Hogares habitados con baño según tengan botón, cadena o mochila para limpieza del inodoro por departamento, área de gobierno local, fracción y radio censal'),
(6, 6, 1, 'H', 'Hogares habitados según procedencia del agua para beber y cocinar por departamento, área de gobierno local, fracción y radio censal'),
(7, 7, 1, 'H', 'Hogares habitados según combustible para cocinar por departamento, área de gobierno local, fracción y radio censal'),
(8, 9, 1, 'H', 'Hogares habitados según régimen de tenencia por departamento, área de gobierno local, fracción y radio censal'),
(9, 11, 1, 'H', 'Hogares habitados según material de la cubierta exterior del techo por departamento, área de gobierno local, fracción y radio censal'),
(10, 12, 1, 'H', 'Hogares habitados según revestimiento interior o cielorraso del techo por departamento, área de gobierno local, fracción y radio censal'),
(11, 13, 1, 'H', 'Hogares habitados según tenencia de agua por departamento, área de gobierno local, fracción y radio censal'),
(12, 8, 2, 'H', 'Hogares habitados según cantidad de personas por cuarto por departamento, área de gobierno local, fracción y radio censal'),
(13, 15, 3, 'H', 'Hogares habitados según tenga o no celular por departamento, área de gobierno local, fracción y radio censal'),
(14, 16, 3, 'H', 'Hogares habitados según tenga o no computadora por departamento, área de gobierno local, fracción y radio censal'),
(15, 17, 3, 'H', 'Hogares habitados según tenga o no heladera por departamento, área de gobierno local, fracción y radio censal'),
(16, 18, 3, 'H', 'Hogares habitados según tenga o no teléfono de línea por departamento, localidad, fracción y radio censal'),
(17, 10, 4, 'H', 'Hogares habitados según cumplan algún indicador NBI por departamento, área de gobierno local,  fracción y radio censal'),
(18, 6, 5, 'P', 'Población de 14 años y más por condición de actividad por departamento, área de gobierno local, fracción y radio censal'),
(19, 5, 6, 'P', 'Población en hogares según relación de parentesco con el jefe por departamento, localidad, área de gobierno local y radio censal'),
(20, 7, 7, 'P', 'Población de 10 años y más sepan o no leer y escribir por departamento, área de gobierno local, fracción y radio censal'),
(21, 8, 7, 'P', 'Población de 5 años y más que asistió según nivel educativo que cursó y si terminó el nivel por departamento, área de gobierno local, fracción y radio censal'),
(22, 9, 7, 'P', 'Población de 3 años y más según condición de asistencia escolar por departamento, área de gobierno local, fracción y radio censal'),
(23, 10, 7, 'P', 'Población de 3 años y más que asiste según nivel educativo que cursa o cursó por departamento, área de gobierno local, fracción y radio censal'),
(24, 1, 8, 'P', 'Población según sexo por departamento, por área de gobierno local, por fracción y radio censal'),
(25, 3, 8, 'P', 'Población según grandes grupos de edad por departamentos, área de gobierno local, fracción y radio censal'),
(26, 4, 8, 'P', 'Total de población según grupos quinquenales de edad por departamento, área de gobierno local, fracción y radio censal'),
(27, 2, 9, 'P', 'Población según nacimiento en el país o en el extranjero por departamento, área de gobierno local, fracción y radio censal'),
(28, 11, 3, 'P', 'Población de 3 años y más según utiliza o no computadora por departamento, área de gobierno local, fracción y radio censal'),
(29, 2, 1, 'V', 'Viviendas particulares según tipo de vivienda por departamento, área de gobierno local, fracción y radio censal'),
(30, 4, 1, 'V', 'Viviendas particulares habitadas según calidad constructiva por departamento, área de gobierno local, fracción y radio censal'),
(31, 5, 1, 'V', 'Viviendas particulares habitadas según calidad de las conexiones a servicios básicos por departamento, área de gobierno local, fracción y radio censal'),
(32, 6, 1, 'V', 'Viviendas particulares habitadas según calidad de los materiales por departamento, área de gobierno local, fracción y radio censal'),
(33, 1, 10, 'V', 'Viviendas según tipo de vivienda agrupada por departamento, área de gobierno local, fracción y radio censal'),
(34, 3, 10, 'V', 'Viviendas colectivas según tipo de vivienda por departamento, área de gobierno local y fracción censal'),
(35, 7, 11, 'V', 'Viviendas particulares según condición de ocupación por departamentos, área de gobierno local, fracción y radio censal');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `censo`
--
ALTER TABLE `censo`
  ADD PRIMARY KEY (`id_censo_anio`);

--
-- Indices de la tabla `censo_has_departamento`
--
ALTER TABLE `censo_has_departamento`
  ADD PRIMARY KEY (`id_censo_has_departamento`),
  ADD KEY `fk_Censo_has_Departamento_Departamento1_idx` (`Departamento_id_departamento`),
  ADD KEY `fk_Censo_has_Departamento_Censo1_idx` (`Censo_id_censo`);

--
-- Indices de la tabla `cuadro`
--
ALTER TABLE `cuadro`
  ADD PRIMARY KEY (`id_cuadro`);

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`id_departamento`);

--
-- Indices de la tabla `registro`
--
ALTER TABLE `registro`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Titulo_cuadro_id_registro` (`Titulo_cuadro_id_registro`),
  ADD KEY `Censo_has_departamento_id_registro` (`Censo_has_departamento_id_registro`);

--
-- Indices de la tabla `tematica`
--
ALTER TABLE `tematica`
  ADD PRIMARY KEY (`id_tematica`);

--
-- Indices de la tabla `tematica_has_cuadro`
--
ALTER TABLE `tematica_has_cuadro`
  ADD PRIMARY KEY (`tematica_id_tematica`,`cuadro_id_cuadro`),
  ADD KEY `fk_tematica_has_cuadro_cuadro1_idx` (`cuadro_id_cuadro`),
  ADD KEY `fk_tematica_has_cuadro_tematica1_idx` (`tematica_id_tematica`);

--
-- Indices de la tabla `titulo_cuadro`
--
ALTER TABLE `titulo_cuadro`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_titulo_cuadro_Cuadro1_idx` (`Cuadro_id`),
  ADD KEY `fk_Tematica_id_titulo_cuadro_idx` (`Tematica_id`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `censo_has_departamento`
--
ALTER TABLE `censo_has_departamento`
  ADD CONSTRAINT `Censo_id_censo` FOREIGN KEY (`Censo_id_censo`) REFERENCES `censo` (`id_censo_anio`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Departamento_id_departamento` FOREIGN KEY (`Departamento_id_departamento`) REFERENCES `departamento` (`id_departamento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `registro`
--
ALTER TABLE `registro`
  ADD CONSTRAINT `registro_ibfk_1` FOREIGN KEY (`Titulo_cuadro_id_registro`) REFERENCES `titulo_cuadro` (`ID`),
  ADD CONSTRAINT `registro_ibfk_2` FOREIGN KEY (`Censo_has_departamento_id_registro`) REFERENCES `censo_has_departamento` (`id_censo_has_departamento`);

--
-- Filtros para la tabla `tematica_has_cuadro`
--
ALTER TABLE `tematica_has_cuadro`
  ADD CONSTRAINT `fk_tematica_has_cuadro_cuadro1` FOREIGN KEY (`cuadro_id_cuadro`) REFERENCES `cuadro` (`id_cuadro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tematica_has_cuadro_tematica1` FOREIGN KEY (`tematica_id_tematica`) REFERENCES `tematica` (`id_tematica`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `titulo_cuadro`
--
ALTER TABLE `titulo_cuadro`
  ADD CONSTRAINT `fk_Tematica_id_titulo_cuadro` FOREIGN KEY (`Tematica_id`) REFERENCES `tematica` (`id_tematica`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_titulo_cuadro_Cuadro1` FOREIGN KEY (`Cuadro_id`) REFERENCES `cuadro` (`id_cuadro`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
