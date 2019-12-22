-- MySQL Script generated by MySQL Workbench
-- Sun Dec 22 12:17:37 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema inventario_drel
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema inventario_drel
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `inventario_drel` DEFAULT CHARACTER SET utf8 ;
USE `inventario_drel` ;

-- -----------------------------------------------------
-- Table `inventario_drel`.`area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario_drel`.`area` (
  `idarea` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `estado` TINYINT NULL DEFAULT 1,
  `flag` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`idarea`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario_drel`.`marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario_drel`.`marca` (
  `idmarca` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL,
  `estado` TINYINT NULL DEFAULT 1,
  `flag` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`idmarca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario_drel`.`tipo_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario_drel`.`tipo_usuario` (
  `idtipo_usuario` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) NULL,
  `estado` TINYINT NULL DEFAULT 1,
  `flag` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`idtipo_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario_drel`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario_drel`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `idtipousuario` INT NULL,
  `nombres` VARCHAR(250) NULL,
  `apellidos` VARCHAR(250) NULL,
  `celular` VARCHAR(9) NULL,
  `correo` VARCHAR(250) NULL,
  `fecha` DATE NULL DEFAULT NOW(),
  `usuario` VARCHAR(45) NULL,
  `estado` TINYINT NULL DEFAULT 1,
  `flag` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`idusuario`),
  INDEX `fk_usuario_tipo_usuario_idx` (`idtipousuario` ASC) VISIBLE,
  UNIQUE INDEX `usuario_UNIQUE` (`usuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_tipo_usuario`
    FOREIGN KEY (`idtipousuario`)
    REFERENCES `inventario_drel`.`tipo_usuario` (`idtipo_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario_drel`.`tipo_equipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario_drel`.`tipo_equipo` (
  `idtipo_equipo` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) NULL,
  `estado` TINYINT NULL DEFAULT 1,
  `flag` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`idtipo_equipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario_drel`.`equipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario_drel`.`equipo` (
  `idequipo` INT NOT NULL AUTO_INCREMENT,
  `idmarca` INT NULL,
  `idtipo_equipo` INT NULL,
  `nombre_equio` VARCHAR(100) NULL,
  `usuario_equipo` VARCHAR(100) NULL,
  `procesador` VARCHAR(250) NULL,
  `memoria_ram` VARCHAR(250) NULL,
  `disco_duro` VARCHAR(250) NULL,
  `ip` VARCHAR(45) NULL,
  `mascara_sub_red` VARCHAR(45) NULL,
  `puerta_enlace` VARCHAR(45) NULL,
  `dns_preferido` VARCHAR(45) NULL,
  `dns_alternativo` VARCHAR(45) NULL,
  `dominio` TINYINT NULL,
  `antivirus` TINYINT NULL,
  `sistema_operativo` VARCHAR(100) NULL,
  `fecha` DATE NULL DEFAULT now(),
  `estado` TINYINT NULL DEFAULT 1,
  `flag` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`idequipo`),
  INDEX `fk_usuario_equipo_marca_idx` (`idmarca` ASC) VISIBLE,
  INDEX `fk_usuario_equipo_tipo_equipo_idx` (`idtipo_equipo` ASC) VISIBLE,
  CONSTRAINT `fk_equipo_marca`
    FOREIGN KEY (`idmarca`)
    REFERENCES `inventario_drel`.`marca` (`idmarca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipo_tipo_equipo`
    FOREIGN KEY (`idtipo_equipo`)
    REFERENCES `inventario_drel`.`tipo_equipo` (`idtipo_equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario_drel`.`usuario_equipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario_drel`.`usuario_equipo` (
  `idusuario_equipo` INT NOT NULL AUTO_INCREMENT,
  `idarea` INT NULL,
  `idusuario` INT NULL,
  `idequipo` INT NULL,
  `fecha` DATETIME NULL DEFAULT now(),
  `estado` TINYINT NULL DEFAULT 1,
  `flag` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`idusuario_equipo`),
  INDEX `fk_usuario_equipo_equipo_idx` (`idequipo` ASC) VISIBLE,
  INDEX `fk_usuario_equipo_usuario_idx` (`idusuario` ASC) VISIBLE,
  INDEX `fk_usuario_equipo_area_idx` (`idarea` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_equipo_equipo`
    FOREIGN KEY (`idequipo`)
    REFERENCES `inventario_drel`.`equipo` (`idequipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_equipo_usuario`
    FOREIGN KEY (`idusuario`)
    REFERENCES `inventario_drel`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_equipo_area`
    FOREIGN KEY (`idarea`)
    REFERENCES `inventario_drel`.`area` (`idarea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario_drel`.`impresoras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario_drel`.`impresoras` (
  `idimpresoras` INT NOT NULL AUTO_INCREMENT,
  `idarea` INT NULL,
  `descripcion` VARCHAR(250) NULL,
  `estado` TINYINT NULL DEFAULT 1,
  `flag` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`idimpresoras`),
  INDEX `fk_impresoras_area_idx` (`idarea` ASC) VISIBLE,
  CONSTRAINT `fk_impresoras_area`
    FOREIGN KEY (`idarea`)
    REFERENCES `inventario_drel`.`area` (`idarea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario_drel`.`soporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario_drel`.`soporte` (
  `idsoporte` INT NOT NULL AUTO_INCREMENT,
  `idusuario_emisor` INT NULL,
  `mensaje` TEXT NULL,
  `fecha` DATETIME NULL DEFAULT now(),
  `estado` TINYINT NULL DEFAULT 0,
  `flag` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`idsoporte`),
  INDEX `fk_soporte_usuario_idx` (`idusuario_emisor` ASC) VISIBLE,
  CONSTRAINT `fk_soporte_usuario`
    FOREIGN KEY (`idusuario_emisor`)
    REFERENCES `inventario_drel`.`usuario_equipo` (`idusuario_equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;