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
  `usas_experiencia` VARCHAR(2) NOT NULL,
  `usas_biografia` VARCHAR(500) NOT NULL DEFAULT 'Soy un excelente docente dedicado a compartir mi conocimiento',
  `usas_fechacreacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
  `ase_fecha` TIMESTAMP NOT NULL,
  `ase_horainicial` VARCHAR(10) NOT NULL,
  `ase_horafinal` VARCHAR(10) NOT NULL,
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
-- Table `comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comentario` (
  `come_id` INT(11) NOT NULL,
  `asesoria_ase_id` INT(11) NOT NULL,
  `usuario_usu_documento` VARCHAR(45) NOT NULL,
  `come_contenido` VARCHAR(500) NOT NULL,
  `come_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`come_id`),
  INDEX `fk_Comentarios_asesoria1_idx` (`asesoria_ase_id` ASC),
  UNIQUE INDEX `come_id_UNIQUE` (`come_id` ASC),
  CONSTRAINT `fk_Comentarios_asesoria1`
    FOREIGN KEY (`asesoria_ase_id`)
    REFERENCES `asesoria` (`ase_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asesor_asignatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asesor_asignatura` (
  `asesor_usuario_usu_documento` VARCHAR(45) NOT NULL,
  `asignatura_asig_id` INT(11) NOT NULL,
  PRIMARY KEY (`asesor_usuario_usu_documento`, `asignatura_asig_id`),
  INDEX `fk_asesor_has_asignatura_asignatura1_idx` (`asignatura_asig_id` ASC),
  INDEX `fk_asesor_has_asignatura_asesor1_idx` (`asesor_usuario_usu_documento` ASC),
  CONSTRAINT `fk_asesor_has_asignatura_asesor1`
    FOREIGN KEY (`asesor_usuario_usu_documento`)
    REFERENCES `asesor` (`usuario_usu_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asesor_has_asignatura_asignatura1`
    FOREIGN KEY (`asignatura_asig_id`)
    REFERENCES `asignatura` (`asig_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


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

INSERT INTO `asignatura` (`asig_nombre`) VALUES
('Análisis de Algoritmos'),
('Base de Datos'),
('Cálculo Diferencial'),
('Cálculo Integral'),
('Cálculo Multivariable'),
('Ecuaciones Diferenciales'),
('Estructuras de Datos'),
('Física Electromagnética'),
('Física Mecánica'),
('Física Ondulatoria'),
('Paradigmas de Programación'),
('Programación Estructurada'),
('Programación Orientada a Objetos');
