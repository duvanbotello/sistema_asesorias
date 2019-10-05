-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 05-10-2019 a las 03:58:19
-- Versión del servidor: 10.3.15-MariaDB
-- Versión de PHP: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `asesoria`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asesor`
--

CREATE TABLE `asesor` (
  `idasesor` int(11) NOT NULL,
  `id_programa` int(11) NOT NULL,
  `usuario_usu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asesoria`
--

CREATE TABLE `asesoria` (
  `ase_id` int(11) NOT NULL,
  `ase_fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `aula_id` int(11) NOT NULL,
  `cali_id` int(11) NOT NULL,
  `idestudiante` int(11) NOT NULL,
  `idasesor` int(11) NOT NULL,
  `asignatura_idasignatura` int(11) NOT NULL,
  `calificacion` int(11) DEFAULT NULL,
  `observacion` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asesor_asignatura`
--

CREATE TABLE `asesor_asignatura` (
  `idasesor_asignatura` int(11) NOT NULL,
  `asesor_idasesor` int(11) NOT NULL,
  `asignatura_idasignatura` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignatura`
--

CREATE TABLE `asignatura` (
  `idasignatura` int(11) NOT NULL,
  `descripcion` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aula`
--

CREATE TABLE `aula` (
  `aula_id` int(11) NOT NULL,
  `aula_numero` varchar(45) NOT NULL,
  `blo_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dia`
--

CREATE TABLE `dia` (
  `iddia` int(11) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `disponibilidad_asesor`
--

CREATE TABLE `disponibilidad_asesor` (
  `id_disponibilidad` int(11) NOT NULL,
  `dia` int(11) NOT NULL,
  `hora` int(11) NOT NULL,
  `asesor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `idestudiante` int(11) NOT NULL,
  `usuario_usu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `funcionalidad`
--

CREATE TABLE `funcionalidad` (
  `fun_id` int(11) NOT NULL,
  `fun_nombre` varchar(45) NOT NULL,
  `fun_descripcion` varchar(300) NOT NULL,
  `fun_url` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `funcionalidad`
--

INSERT INTO `funcionalidad` (`fun_id`, `fun_nombre`, `fun_descripcion`, `fun_url`) VALUES
(1, 'prueba', 'prueba', 'www.google.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hora`
--

CREATE TABLE `hora` (
  `idhora` int(11) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `rol_id` int(11) NOT NULL,
  `rol_nombre` varchar(45) NOT NULL,
  `rol_descripcion` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`rol_id`, `rol_nombre`, `rol_descripcion`) VALUES
(1, 'estudiante', 'rol estudiante');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rolfuncion`
--

CREATE TABLE `rolfuncion` (
  `rolfun_id` int(11) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `fun_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rolfuncionalidad`
--

CREATE TABLE `rolfuncionalidad` (
  `rol_rol_id` int(11) NOT NULL,
  `funcionalidad_fun_id` int(11) NOT NULL,
  `rolfun_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefono`
--

CREATE TABLE `telefono` (
  `tele_id` int(11) NOT NULL,
  `tele_numero` varchar(45) NOT NULL,
  `tele_tipo` varchar(45) NOT NULL,
  `usu_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipodocumento`
--

CREATE TABLE `tipodocumento` (
  `tipodoc_id` int(11) NOT NULL,
  `tipodoc_nombre` varchar(45) NOT NULL,
  `tipodoc_descripcion` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipodocumento`
--

INSERT INTO `tipodocumento` (`tipodoc_id`, `tipodoc_nombre`, `tipodoc_descripcion`) VALUES
(1, 'CEDULA', '0'),
(2, 'TARJETA IDENTIDAD', '0'),
(3, 'PASAPORTE', '0');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `usu_id` int(11) NOT NULL,
  `tipodoc_id` int(11) NOT NULL,
  `usu_nombres` varchar(45) NOT NULL,
  `usu_apellidos` varchar(45) NOT NULL,
  `usu_fechanac` date DEFAULT NULL,
  `usu_documento` varchar(45) NOT NULL,
  `usu_rol_id` int(11) NOT NULL,
  `usu_contraseña` varchar(255) NOT NULL,
  `usu_correo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usu_id`, `tipodoc_id`, `usu_nombres`, `usu_apellidos`, `usu_fechanac`, `usu_documento`, `usu_rol_id`, `usu_contraseña`, `usu_correo`) VALUES
(1, 1, 'Duvan', 'Botello', NULL, '10904999082', 1, '$2y$10$SHKbpTNHt0teXjUe9qjASe2WMwPjXpzzz.8TLuOdnzOL7WxGaLXsK', 'duvan@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_has_rol`
--

CREATE TABLE `usuario_has_rol` (
  `usuario_usu_id` int(11) NOT NULL,
  `rol_rol_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asesor`
--
ALTER TABLE `asesor`
  ADD PRIMARY KEY (`idasesor`),
  ADD UNIQUE KEY `idasesor_UNIQUE` (`idasesor`),
  ADD KEY `fk_asesor_usuario1_idx` (`usuario_usu_id`);

--
-- Indices de la tabla `asesoria`
--
ALTER TABLE `asesoria`
  ADD PRIMARY KEY (`ase_id`,`ase_fecha`),
  ADD KEY `fk_asesoria_aula1_idx` (`aula_id`),
  ADD KEY `fk_asesoria_estudiante1_idx` (`idestudiante`),
  ADD KEY `fk_asesoria_asesor1_idx` (`idasesor`),
  ADD KEY `fk_asesoria_asignatura1_idx` (`asignatura_idasignatura`);

--
-- Indices de la tabla `asesor_asignatura`
--
ALTER TABLE `asesor_asignatura`
  ADD PRIMARY KEY (`idasesor_asignatura`),
  ADD UNIQUE KEY `idasesor_asignatura_UNIQUE` (`idasesor_asignatura`),
  ADD KEY `fk_asesor_asignatura_asesor1_idx` (`asesor_idasesor`),
  ADD KEY `fk_asesor_asignatura_asignatura1_idx` (`asignatura_idasignatura`);

--
-- Indices de la tabla `asignatura`
--
ALTER TABLE `asignatura`
  ADD PRIMARY KEY (`idasignatura`);

--
-- Indices de la tabla `aula`
--
ALTER TABLE `aula`
  ADD PRIMARY KEY (`aula_id`);

--
-- Indices de la tabla `dia`
--
ALTER TABLE `dia`
  ADD PRIMARY KEY (`iddia`);

--
-- Indices de la tabla `disponibilidad_asesor`
--
ALTER TABLE `disponibilidad_asesor`
  ADD PRIMARY KEY (`id_disponibilidad`),
  ADD KEY `fk_disponibilidad_asesor_dia1_idx` (`dia`),
  ADD KEY `fk_disponibilidad_asesor_hora1_idx` (`hora`),
  ADD KEY `fk_disponibilidad_asesor_asesor1_idx` (`asesor`);

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`idestudiante`),
  ADD UNIQUE KEY `idestudiante_UNIQUE` (`idestudiante`),
  ADD KEY `fk_estudiante_usuario1_idx` (`usuario_usu_id`);

--
-- Indices de la tabla `funcionalidad`
--
ALTER TABLE `funcionalidad`
  ADD PRIMARY KEY (`fun_id`);

--
-- Indices de la tabla `hora`
--
ALTER TABLE `hora`
  ADD PRIMARY KEY (`idhora`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `rolfuncion`
--
ALTER TABLE `rolfuncion`
  ADD PRIMARY KEY (`rolfun_id`),
  ADD KEY `fk_rolfunrol_idx` (`rol_id`),
  ADD KEY `fk_rolfunfun_idx` (`fun_id`);

--
-- Indices de la tabla `rolfuncionalidad`
--
ALTER TABLE `rolfuncionalidad`
  ADD PRIMARY KEY (`rolfun_id`,`funcionalidad_fun_id`,`rol_rol_id`),
  ADD KEY `fk_rol_has_funcionalidad_funcionalidad1_idx` (`funcionalidad_fun_id`),
  ADD KEY `fk_rol_has_funcionalidad_rol1_idx` (`rol_rol_id`);

--
-- Indices de la tabla `telefono`
--
ALTER TABLE `telefono`
  ADD PRIMARY KEY (`tele_id`),
  ADD KEY `fk_teleusu_idx` (`usu_id`);

--
-- Indices de la tabla `tipodocumento`
--
ALTER TABLE `tipodocumento`
  ADD PRIMARY KEY (`tipodoc_id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usu_id`),
  ADD KEY `fk_usutipodoc_idx` (`tipodoc_id`);

--
-- Indices de la tabla `usuario_has_rol`
--
ALTER TABLE `usuario_has_rol`
  ADD PRIMARY KEY (`usuario_usu_id`,`rol_rol_id`),
  ADD KEY `fk_usuario_has_rol_rol1_idx` (`rol_rol_id`),
  ADD KEY `fk_usuario_has_rol_usuario1_idx` (`usuario_usu_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asesor`
--
ALTER TABLE `asesor`
  MODIFY `idasesor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `asesoria`
--
ALTER TABLE `asesoria`
  MODIFY `ase_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `asesor_asignatura`
--
ALTER TABLE `asesor_asignatura`
  MODIFY `idasesor_asignatura` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `aula`
--
ALTER TABLE `aula`
  MODIFY `aula_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  MODIFY `idestudiante` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `funcionalidad`
--
ALTER TABLE `funcionalidad`
  MODIFY `fun_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `rol_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `rolfuncion`
--
ALTER TABLE `rolfuncion`
  MODIFY `rolfun_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `rolfuncionalidad`
--
ALTER TABLE `rolfuncionalidad`
  MODIFY `rolfun_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `telefono`
--
ALTER TABLE `telefono`
  MODIFY `tele_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipodocumento`
--
ALTER TABLE `tipodocumento`
  MODIFY `tipodoc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
