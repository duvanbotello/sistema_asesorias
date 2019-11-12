-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 12-11-2019 a las 07:56:46
-- Versión del servidor: 10.4.6-MariaDB
-- Versión de PHP: 7.3.9

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
  `usuario_usu_documento` varchar(45) NOT NULL,
  `usas_experiencia` float(8,2) NOT NULL,
  `usas_biografia` varchar(500) NOT NULL DEFAULT 'Soy un excelente docente dedicado a compartir mi conocimiento',
  `usas_fechacreacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `asesor`
--

INSERT INTO `asesor` (`idasesor`, `usuario_usu_documento`, `usas_experiencia`, `usas_biografia`, `usas_fechacreacion`) VALUES
(1, '568221458', 0.00, 'Soy un excelente docente dedicado a compartir mi conocimient', '2019-10-20'),
(2, '1193443881', 9.34, 'Doctor en Ciencias Computacionales, Magister en Educación Virtual', '2016-06-12'),
(3, '123456789', 8.70, 'Soy un excelente docente dedicado a compartir mi conocimiento', '2019-11-11');

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
  `usuario_usu_documento` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `estudiante`
--

INSERT INTO `estudiante` (`idestudiante`, `usuario_usu_documento`) VALUES
(3, '1090499082'),
(4, '89989');

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
-- Estructura de tabla para la tabla `recomendados`
--

CREATE TABLE `recomendados` (
  `estudiante_idestudiante` int(11) NOT NULL,
  `asesor_idasesor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `recomendados`
--

INSERT INTO `recomendados` (`estudiante_idestudiante`, `asesor_idasesor`) VALUES
(3, 1),
(3, 2),
(4, 1),
(4, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefono`
--

CREATE TABLE `telefono` (
  `tele_id` int(11) NOT NULL,
  `tele_numero` varchar(45) NOT NULL,
  `tele_tipo` varchar(45) NOT NULL,
  `usuario_usu_documento` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `telefono`
--

INSERT INTO `telefono` (`tele_id`, `tele_numero`, `tele_tipo`, `usuario_usu_documento`) VALUES
(2, '5760677', '2', '1090499082'),
(3, '3184952544', '1', '568221458'),
(4, '8979879', '1', '89989');

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
(1, 'cedula', 'd'),
(2, 'Tarjeta de Identidad', 'Tarjeta de Identidad'),
(3, 'Pasaporte', 'Pasaporte');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `usu_documento` varchar(45) NOT NULL,
  `tipodoc_id` int(11) NOT NULL,
  `usu_nombres` varchar(45) NOT NULL,
  `usu_apellidos` varchar(45) NOT NULL,
  `usu_fechanac` date DEFAULT NULL,
  `usu_correo` varchar(80) NOT NULL,
  `usu_ubicacion` varchar(100) NOT NULL DEFAULT 'Cúcuta',
  `usu_contrasena` varchar(255) NOT NULL,
  `usu_rol_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usu_documento`, `tipodoc_id`, `usu_nombres`, `usu_apellidos`, `usu_fechanac`, `usu_correo`, `usu_ubicacion`, `usu_contrasena`, `usu_rol_id`) VALUES
('1090499082', 1, 'duvan', 'botello', '2019-10-23', 'duvan@gmail.com', 'Cúcuta', '$2y$10$UKByB3zAxA2GLRJFKbvVneW2Wgh5.bB7lldmSW0de2nT2npKDAmee', 1),
('1193443881', 1, 'Fredy Ricardo', 'Cortés Ramírez', '1999-07-14', 'fred.cor.14@gmail.com', 'Cúcuta', '$2y$10$UKByB3zAxA2GLRJFKbvVneW2Wgh5.bB7lldmSW0de2nT2npKDAmee', 2),
('123456789', 1, 'Daniel', 'Luna', '1995-02-02', 'danilunaelmejor@hotmail.com', 'Cúcuta', '$2y$10$UKByB3zAxA2GLRJFKbvVneW2Wgh5.bB7lldmSW0de2nT2npKDAmee', 2),
('568221458', 1, 'Ing Jorge', 'Botello', '2019-10-24', 'profe@gmail.com', 'Cúcuta', '$2y$10$i5So.tCwM6nIGJsL2oVbcOkMYU5PCGS8Z5KLwqCIJmvpJf.DHaO0y', 2),
('89989', 1, 'Karen', 'Gelvez', '2019-11-14', 'karolesmes@hotmail.com', 'Cúcuta', '$2y$10$UKByB3zAxA2GLRJFKbvVneW2Wgh5.bB7lldmSW0de2nT2npKDAmee', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asesor`
--
ALTER TABLE `asesor`
  ADD PRIMARY KEY (`idasesor`,`usuario_usu_documento`),
  ADD UNIQUE KEY `idasesor_UNIQUE` (`idasesor`),
  ADD KEY `fk_usu_documento` (`usuario_usu_documento`);

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
  ADD KEY `fk_estudiante_usuario1_idx` (`usuario_usu_documento`);

--
-- Indices de la tabla `hora`
--
ALTER TABLE `hora`
  ADD PRIMARY KEY (`idhora`);

--
-- Indices de la tabla `recomendados`
--
ALTER TABLE `recomendados`
  ADD PRIMARY KEY (`estudiante_idestudiante`,`asesor_idasesor`),
  ADD KEY `fk_estudiante_has_asesor_asesor1_idx` (`asesor_idasesor`),
  ADD KEY `fk_estudiante_has_asesor_estudiante1_idx` (`estudiante_idestudiante`);

--
-- Indices de la tabla `telefono`
--
ALTER TABLE `telefono`
  ADD PRIMARY KEY (`tele_id`),
  ADD KEY `fk_telefono_usuario1_idx` (`usuario_usu_documento`);

--
-- Indices de la tabla `tipodocumento`
--
ALTER TABLE `tipodocumento`
  ADD PRIMARY KEY (`tipodoc_id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usu_documento`),
  ADD UNIQUE KEY `usu_correo_UNIQUE` (`usu_correo`),
  ADD UNIQUE KEY `usu_documento_UNIQUE` (`usu_documento`),
  ADD KEY `fk_usutipodoc_idx` (`tipodoc_id`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asesor`
--
ALTER TABLE `asesor`
  ADD CONSTRAINT `fk_usu_documento` FOREIGN KEY (`usuario_usu_documento`) REFERENCES `usuario` (`usu_documento`);

--
-- Filtros para la tabla `asesoria`
--
ALTER TABLE `asesoria`
  ADD CONSTRAINT `fk_asesoria_asesor1` FOREIGN KEY (`idasesor`) REFERENCES `asesor` (`idasesor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_asesoria_asignatura1` FOREIGN KEY (`asignatura_idasignatura`) REFERENCES `asignatura` (`idasignatura`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_asesoria_aula1` FOREIGN KEY (`aula_id`) REFERENCES `aula` (`aula_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_asesoria_estudiante1` FOREIGN KEY (`idestudiante`) REFERENCES `estudiante` (`idestudiante`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `asesor_asignatura`
--
ALTER TABLE `asesor_asignatura`
  ADD CONSTRAINT `fk_asesor_asignatura_asesor1` FOREIGN KEY (`asesor_idasesor`) REFERENCES `asesor` (`idasesor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_asesor_asignatura_asignatura1` FOREIGN KEY (`asignatura_idasignatura`) REFERENCES `asignatura` (`idasignatura`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `disponibilidad_asesor`
--
ALTER TABLE `disponibilidad_asesor`
  ADD CONSTRAINT `fk_disponibilidad_asesor_asesor1` FOREIGN KEY (`asesor`) REFERENCES `asesor` (`idasesor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_disponibilidad_asesor_dia1` FOREIGN KEY (`dia`) REFERENCES `dia` (`iddia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_disponibilidad_asesor_hora1` FOREIGN KEY (`hora`) REFERENCES `hora` (`idhora`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD CONSTRAINT `fk_estudiante_usuario1` FOREIGN KEY (`usuario_usu_documento`) REFERENCES `usuario` (`usu_documento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `recomendados`
--
ALTER TABLE `recomendados`
  ADD CONSTRAINT `fk_estudiante_has_asesor_asesor1` FOREIGN KEY (`asesor_idasesor`) REFERENCES `asesor` (`idasesor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_estudiante_has_asesor_estudiante1` FOREIGN KEY (`estudiante_idestudiante`) REFERENCES `estudiante` (`idestudiante`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `telefono`
--
ALTER TABLE `telefono`
  ADD CONSTRAINT `fk_telefono_usuario1` FOREIGN KEY (`usuario_usu_documento`) REFERENCES `usuario` (`usu_documento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usutipodoc` FOREIGN KEY (`tipodoc_id`) REFERENCES `tipodocumento` (`tipodoc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
