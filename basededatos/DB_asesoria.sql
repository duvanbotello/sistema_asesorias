-- MySQL Script generated by MySQL Workbench
-- mié 27 nov 2019 01:13:15 -05
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Table `tipodocumento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipodocumento` (
  `tipodoc_id` INT(11) NOT NULL AUTO_INCREMENT,
  `tipodoc_nombre` VARCHAR(45) NOT NULL,
  `tipodoc_descripcion` VARCHAR(300) NULL,
  PRIMARY KEY (`tipodoc_id`),
  UNIQUE INDEX `tipodoc_nombre_UNIQUE` (`tipodoc_nombre` ASC),
  UNIQUE INDEX `tipodoc_id_UNIQUE` (`tipodoc_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuario` (
  `usu_documento` VARCHAR(45) NOT NULL,
  `tipodoc_id` INT(11) NOT NULL,
  `usu_nombres` VARCHAR(45) NOT NULL,
  `usu_apellidos` VARCHAR(45) NOT NULL,
  `usu_fechanac` DATE NULL DEFAULT NULL,
  `usu_correo` VARCHAR(80) NOT NULL,
  `usu_ubicacion` VARCHAR(100) NOT NULL DEFAULT 'Cúcuta',
  `usu_contrasena` VARCHAR(255) NOT NULL,
  `usu_rol_id` INT(11) NOT NULL,
  PRIMARY KEY (`usu_documento`, `tipodoc_id`),
  UNIQUE INDEX `usu_correo_UNIQUE` (`usu_correo` ASC),
  INDEX `fk_usutipodoc_idx` (`tipodoc_id` ASC),
  CONSTRAINT `fk_usutipodoc`
    FOREIGN KEY (`tipodoc_id`)
    REFERENCES `tipodocumento` (`tipodoc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `asesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asesor` (
  `idasesor` INT(11) NOT NULL AUTO_INCREMENT,
  `usuario_usu_documento` VARCHAR(45) NOT NULL,
  `usas_experiencia` FLOAT(10,2) NOT NULL,
  `usas_biografia` VARCHAR(500) NOT NULL DEFAULT 'Soy un excelente docente dedicado a compartir mi conocimiento',
  `usas_fechacreacion` DATE NOT NULL,
  PRIMARY KEY (`idasesor`, `usuario_usu_documento`),
  UNIQUE INDEX `idasesor_UNIQUE` (`idasesor` ASC),
  UNIQUE INDEX `usuario_usu_documento_UNIQUE` (`usuario_usu_documento` ASC),
  CONSTRAINT `fk_usu_documento`
    FOREIGN KEY (`usuario_usu_documento`)
    REFERENCES `usuario` (`usu_documento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `asignatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asignatura` (
  `asig_id` INT(11) NOT NULL AUTO_INCREMENT,
  `asig_nombre` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`asig_id`),
  UNIQUE INDEX `asig_id_UNIQUE` (`asig_id` ASC),
  UNIQUE INDEX `asig_nombre_UNIQUE` (`asig_nombre` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `estudiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `estudiante` (
  `idestudiante` INT(11) NOT NULL AUTO_INCREMENT,
  `usuario_usu_documento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idestudiante`, `usuario_usu_documento`),
  UNIQUE INDEX `idestudiante_UNIQUE` (`idestudiante` ASC),
  INDEX `fk_estudiante_usuario1_idx` (`usuario_usu_documento` ASC),
  UNIQUE INDEX `usuario_usu_documento_UNIQUE` (`usuario_usu_documento` ASC),
  CONSTRAINT `fk_estudiante_usuario1`
    FOREIGN KEY (`usuario_usu_documento`)
    REFERENCES `usuario` (`usu_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `asesoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asesoria` (
  `ase_id` INT(11) NOT NULL AUTO_INCREMENT,
  `ase_fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ase_duracion` INT NOT NULL,
  `ase_calificacion` FLOAT(10,2) NULL,
  `ase_observacion` VARCHAR(300) NULL,
  `ase_estado` VARCHAR(1) NOT NULL DEFAULT 0,
  `asignatura_idasignatura` INT(11) NOT NULL,
  `idasesor` INT(11) NOT NULL,
  `idestudiante` INT(11) NOT NULL,
  PRIMARY KEY (`ase_id`),
  INDEX `fk_asesoria_estudiante1_idx` (`idestudiante` ASC),
  INDEX `fk_asesoria_asesor1_idx` (`idasesor` ASC),
  INDEX `fk_asesoria_asignatura1_idx` (`asignatura_idasignatura` ASC),
  UNIQUE INDEX `ase_id_UNIQUE` (`ase_id` ASC),
  CONSTRAINT `fk_asesoria_asesor1`
    FOREIGN KEY (`idasesor`)
    REFERENCES `asesor` (`idasesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asesoria_asignatura1`
    FOREIGN KEY (`asignatura_idasignatura`)
    REFERENCES `asignatura` (`asig_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asesoria_estudiante1`
    FOREIGN KEY (`idestudiante`)
    REFERENCES `estudiante` (`idestudiante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telefono` (
  `tele_id` INT(11) NOT NULL AUTO_INCREMENT,
  `tele_numero` VARCHAR(45) NOT NULL,
  `tele_tipo` VARCHAR(45) NOT NULL,
  `usuario_usu_documento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tele_id`, `tele_numero`, `tele_tipo`),
  INDEX `fk_telefono_usuario1_idx` (`usuario_usu_documento` ASC),
  UNIQUE INDEX `tele_id_UNIQUE` (`tele_id` ASC),
  CONSTRAINT `fk_telefono_usuario1`
    FOREIGN KEY (`usuario_usu_documento`)
    REFERENCES `usuario` (`usu_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `recomendados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recomendados` (
  `estudiante_idestudiante` INT(11) NOT NULL,
  `asesor_idasesor` INT(11) NOT NULL,
  PRIMARY KEY (`estudiante_idestudiante`, `asesor_idasesor`),
  INDEX `fk_estudiante_has_asesor_asesor1_idx` (`asesor_idasesor` ASC),
  INDEX `fk_estudiante_has_asesor_estudiante1_idx` (`estudiante_idestudiante` ASC),
  CONSTRAINT `fk_estudiante_has_asesor_estudiante1`
    FOREIGN KEY (`estudiante_idestudiante`)
    REFERENCES `estudiante` (`idestudiante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estudiante_has_asesor_asesor1`
    FOREIGN KEY (`asesor_idasesor`)
    REFERENCES `asesor` (`idasesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `asesor_asignatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asesor_asignatura` (
  `asesor_idasesor` INT(11) NOT NULL,
  `asignatura_asig_id` INT(11) NOT NULL,
  PRIMARY KEY (`asesor_idasesor`, `asignatura_asig_id`),
  INDEX `fk_asesor_has_asignatura_asignatura1_idx` (`asignatura_asig_id` ASC),
  INDEX `fk_asesor_has_asignatura_asesor1_idx` (`asesor_idasesor` ASC),
  CONSTRAINT `fk_asesor_has_asignatura_asesor1`
    FOREIGN KEY (`asesor_idasesor`)
    REFERENCES `asesor` (`idasesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asesor_has_asignatura_asignatura1`
    FOREIGN KEY (`asignatura_asig_id`)
    REFERENCES `asignatura` (`asig_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comentario` (
  `asesoria_ase_id` INT(11) NOT NULL,
  `usuario_usu_documento` VARCHAR(45) NOT NULL,
  `come_contenido` VARCHAR(500) NOT NULL,
  INDEX `fk_Comentarios_asesoria1_idx` (`asesoria_ase_id` ASC),
  CONSTRAINT `fk_Comentarios_asesoria1`
    FOREIGN KEY (`asesoria_ase_id`)
    REFERENCES `asesoria` (`ase_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- -----------------------------------------------------
-- DML Script
-- -----------------------------------------------------


INSERT INTO `tipodocumento` (`tipodoc_nombre`) VALUES
('Cédula de Ciudadanía'),
('Tarjeta de Identidad'),
('Pasaporte');

INSERT INTO `usuario` (`usu_documento`, `tipodoc_id`, `usu_nombres`, `usu_apellidos`, `usu_fechanac`, `usu_correo`, `usu_ubicacion`, `usu_contrasena`, `usu_rol_id`) VALUES
('1090499082', 1, 'duvan', 'botello', '2019-10-23', 'duvan@gmail.com', 'Cúcuta', '$2y$10$UKByB3zAxA2GLRJFKbvVneW2Wgh5.bB7lldmSW0de2nT2npKDAmee', 1),
('1193443881', 1, 'Fredy Ricardo', 'Cortés Ramírez', '1999-07-14', 'fred.cor.14@gmail.com', 'Cúcuta', '$2y$10$UKByB3zAxA2GLRJFKbvVneW2Wgh5.bB7lldmSW0de2nT2npKDAmee', 2),
('123456789', 1, 'Daniel', 'Luna', '1995-02-02', 'danilunaelmejor@hotmail.com', 'Cúcuta', '$2y$10$UKByB3zAxA2GLRJFKbvVneW2Wgh5.bB7lldmSW0de2nT2npKDAmee', 2),
('568221458', 1, 'Ing Jorge', 'Botello', '2019-10-24', 'profe@gmail.com', 'Cúcuta', '$2y$10$i5So.tCwM6nIGJsL2oVbcOkMYU5PCGS8Z5KLwqCIJmvpJf.DHaO0y', 2),
('89989', 1, 'Karen', 'Gelvez', '2019-11-14', 'karolesmes@hotmail.com', 'Cúcuta', '$2y$10$UKByB3zAxA2GLRJFKbvVneW2Wgh5.bB7lldmSW0de2nT2npKDAmee', 1);

INSERT INTO `estudiante` (`usuario_usu_documento`) VALUES
('1090499082'),
('89989');

INSERT INTO `asesor` (`usuario_usu_documento`, `usas_experiencia`, `usas_biografia`, `usas_fechacreacion`) VALUES
('568221458', 0.00, 'Soy un excelente docente dedicado a compartir mi conocimient', '2019-10-20'),
('1193443881', 9.34, 'Doctor en Ciencias Computacionales, Magister en Educación Virtual', '2016-06-12'),
('123456789', 8.70, 'Soy un excelente docente dedicado a compartir mi conocimiento', '2019-11-11');

INSERT INTO `telefono` (`tele_numero`, `tele_tipo`, `usuario_usu_documento`) VALUES
('5760677', '2', '1090499082'),
('3184952544', '1', '568221458'),
('8979879', '1', '89989');