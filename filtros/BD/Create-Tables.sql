-- MySQL Script generated by MySQL Workbench
-- Wed Oct 11 12:44:31 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `CUADROS` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CUADROS` DEFAULT CHARACTER SET utf8 ;
USE `CUADROS` ;

-- -----------------------------------------------------
-- Table `mydb`.`Censo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CUADROS`.`Censo` ;

CREATE TABLE IF NOT EXISTS `CUADROS`.`Censo` (
  `id_censo_anio` INT NOT NULL,
  `censo_descripcion` VARCHAR(255) NOT NULL,
  `file_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_censo_anio`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Departamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CUADROS`.`Departamento` ;

CREATE TABLE IF NOT EXISTS `CUADROS`.`Departamento` (
  `id_departamento` VARCHAR(3) NOT NULL,
  `nombre_departamento` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_departamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tematica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CUADROS`.`Tematica` ;

CREATE TABLE IF NOT EXISTS `CUADROS`.`Tematica` (
  `id_tematica` CHAR NOT NULL,
  `tematica_descripcion` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_tematica`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cuadro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CUADROS`.`Cuadro` ;

CREATE TABLE IF NOT EXISTS `CUADROS`.`Cuadro` (
  `id_cuadro` INT NOT NULL,
  `cuadro_id_tematica` CHAR NOT NULL,
  `cuadro_id_departamento` VARCHAR(3) NOT NULL,
  `cuadro_descripcion` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_cuadro`, `cuadro_id_tematica`, `cuadro_id_departamento`),
  INDEX `id_tematica_idx` (`cuadro_id_tematica` ASC),
  CONSTRAINT `fk_cuadro_id_tematica`
    FOREIGN KEY (`cuadro_id_tematica`)
    REFERENCES `CUADROS`.`Tematica`(`id_tematica`),
  CONSTRAINT `fk_cuadro_id_departamento`
    FOREIGN KEY (`cuadro_id_departamento`)
    REFERENCES `CUADROS`.`Departamento`(`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.``CuadroTitulo``
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CUADROS`.`Cuadro_has_Titulo` (
  `id_cuadro_titulo` INT NOT NULL,
  `cuadro_titulo` VARCHAR(255) NOT NULL,
  `url_cuadro` VARCHAR(255) NOT NULL,
  `cuadro_id` INT NOT NULL,
  PRIMARY KEY (`id_cuadro_titulo`),
  CONSTRAINT `fk_cuadro_titulo_id_cuadro`
    FOREIGN KEY (`cuadro_id`)
    REFERENCES `CUADROS`.`Cuadro`(`id_cuadro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `mydb`.`Tematica_has_Departamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CUADROS`.`Tematica_has_Departamento` ;

CREATE TABLE IF NOT EXISTS `CUADROS`.`Tematica_has_Departamento` (
  `Tematica_id_tematica` CHAR NOT NULL,
  `Departamento_id_departamento` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`Tematica_id_tematica`, `Departamento_id_departamento`),
  INDEX `fk_Tematica_has_Departamento_Departamento1_idx` (`Departamento_id_departamento` ASC),
  INDEX `fk_Tematica_has_Departamento_Tematica_idx` (`Tematica_id_tematica` ASC),
  CONSTRAINT `fk_Tematica_has_Departamento_Tematica`
    FOREIGN KEY (`Tematica_id_tematica`)
    REFERENCES `CUADROS`.`Tematica` (`id_tematica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tematica_has_Departamento_Departamento1`
    FOREIGN KEY (`Departamento_id_departamento`)
    REFERENCES `CUADROS`.`Departamento` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Censo_has_Departamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CUADROS`.`Censo_has_Departamento` ;

CREATE TABLE IF NOT EXISTS `CUADROS`.`Censo_has_Departamento` (
  `Censo_id_censo` INT NOT NULL,
  `Departamento_id_departamento` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`Censo_id_censo`, `Departamento_id_departamento`),
  INDEX `fk_Censo_has_Departamento_Departamento1_idx` (`Departamento_id_departamento` ASC) ,
  INDEX `fk_Censo_has_Departamento_Censo1_idx` (`Censo_id_censo` ASC) ,
  CONSTRAINT `fk_Censo_has_Departamento_Censo1`
    FOREIGN KEY (`Censo_id_censo`)
    REFERENCES `CUADROS`.`Censo` (`id_censo_anio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Censo_has_Departamento_Departamento1`
    FOREIGN KEY (`Departamento_id_departamento`)
    REFERENCES `CUADROS`.`Departamento` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
