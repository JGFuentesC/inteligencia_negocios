-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cubo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cubo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cubo` DEFAULT CHARACTER SET utf8mb3 ;
USE `cubo` ;

-- -----------------------------------------------------
-- Table `cubo`.`cat_antiguedad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_antiguedad` (
  `id` INT NOT NULL,
  `dim_antiguedad` VARCHAR(14) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cat_contabilidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_contabilidad` (
  `id` INT NOT NULL,
  `dim_contabilidad` VARCHAR(22) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cat_credito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_credito` (
  `id` INT NOT NULL,
  `dim_credito` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cat_credito_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_credito_proveedor` (
  `id` INT NOT NULL,
  `dim_credito_proveedor` VARCHAR(17) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cat_dependientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_dependientes` (
  `id` INT NOT NULL,
  `dim_dependientes` VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cat_edad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_edad` (
  `id` INT NOT NULL,
  `dim_edad` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cat_empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_empleados` (
  `id` INT NOT NULL,
  `dim_empleados` VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cat_escolaridad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_escolaridad` (
  `id` INT NOT NULL,
  `dim_escolaridad` VARCHAR(12) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cat_estado_civil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_estado_civil` (
  `id` INT NOT NULL,
  `dim_estado_civil` VARCHAR(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cat_familia_ayuda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_familia_ayuda` (
  `id` INT NOT NULL,
  `dim_familia_ayuda` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cat_giro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_giro` (
  `id` INT NOT NULL,
  `dim_giro` VARCHAR(31) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cat_hora_apertura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_hora_apertura` (
  `id` INT NOT NULL,
  `dim_hora_apertura` VARCHAR(3) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cat_hora_cierre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_hora_cierre` (
  `id` INT NOT NULL,
  `dim_hora_cierre` VARCHAR(4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cat_medios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_medios` (
  `dim_medio` VARCHAR(26) NULL DEFAULT NULL,
  `id_medio` INT NOT NULL,
  PRIMARY KEY (`id_medio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cat_sat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_sat` (
  `id` INT NOT NULL,
  `dim_sat` CHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cat_sexo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_sexo` (
  `id` INT NOT NULL,
  `dim_sexo` CHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cat_ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cat_ventas` (
  `id` INT NOT NULL,
  `dim_ventas` VARCHAR(22) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`cubo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`cubo` (
  `id_edad` INT NULL DEFAULT NULL,
  `id_sexo` INT NULL DEFAULT NULL,
  `id_escolaridad` INT NULL DEFAULT NULL,
  `id_dependientes` INT NULL DEFAULT NULL,
  `id_estado_civil` INT NULL DEFAULT NULL,
  `id_familia_ayuda` INT NULL DEFAULT NULL,
  `id_antiguedad` INT NULL DEFAULT NULL,
  `id_hora_apertura` INT NULL DEFAULT NULL,
  `id_hora_cierre` INT NULL DEFAULT NULL,
  `id_giro` INT NULL DEFAULT NULL,
  `id_empleados` INT NULL DEFAULT NULL,
  `id_ventas` INT NULL DEFAULT NULL,
  `id_contabilidad` INT NULL DEFAULT NULL,
  `id_sat` INT NULL DEFAULT NULL,
  `id_credito` INT NULL DEFAULT NULL,
  `id_credito_proveedor` INT NULL DEFAULT NULL,
  `count_pymes` INT NULL DEFAULT NULL,
  `sum_edad` INT NULL DEFAULT NULL,
  `sum_ventas` FLOAT NULL DEFAULT NULL,
  INDEX `fk_antig_idx` (`id_antiguedad` ASC) VISIBLE,
  INDEX `fk_conta_idx` (`id_contabilidad` ASC) VISIBLE,
  INDEX `fk_cred_prov_idx` (`id_credito_proveedor` ASC) VISIBLE,
  INDEX `fk_dep_idx` (`id_dependientes` ASC) VISIBLE,
  INDEX `fk_edad_idx` (`id_edad` ASC) VISIBLE,
  INDEX `fk_emp_idx` (`id_empleados` ASC) VISIBLE,
  INDEX `fk_escolaridad_idx` (`id_escolaridad` ASC) VISIBLE,
  INDEX `fk_edo_civil_idx` (`id_estado_civil` ASC) VISIBLE,
  INDEX `fk_familia_ayuda_idx` (`id_familia_ayuda` ASC) VISIBLE,
  INDEX `fk_giro_idx` (`id_giro` ASC) VISIBLE,
  INDEX `fk_apertura_idx` (`id_hora_apertura` ASC) VISIBLE,
  INDEX `fk_cierre_idx` (`id_hora_cierre` ASC) VISIBLE,
  INDEX `fk_sat_idx` (`id_sat` ASC) VISIBLE,
  INDEX `fk_ventas_idx` (`id_ventas` ASC) VISIBLE,
  INDEX `fk_sexo_idx` (`id_sexo` ASC) VISIBLE,
  INDEX `fk_credito_idx` (`id_credito` ASC) VISIBLE,
  CONSTRAINT `fk_antig`
    FOREIGN KEY (`id_antiguedad`)
    REFERENCES `cubo`.`cat_antiguedad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conta`
    FOREIGN KEY (`id_contabilidad`)
    REFERENCES `cubo`.`cat_contabilidad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cred_prov`
    FOREIGN KEY (`id_credito_proveedor`)
    REFERENCES `cubo`.`cat_credito_proveedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dep`
    FOREIGN KEY (`id_dependientes`)
    REFERENCES `cubo`.`cat_dependientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_edad`
    FOREIGN KEY (`id_edad`)
    REFERENCES `cubo`.`cat_edad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emp`
    FOREIGN KEY (`id_empleados`)
    REFERENCES `cubo`.`cat_empleados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_escolaridad`
    FOREIGN KEY (`id_escolaridad`)
    REFERENCES `cubo`.`cat_escolaridad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_edo_civil`
    FOREIGN KEY (`id_estado_civil`)
    REFERENCES `cubo`.`cat_estado_civil` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_familia_ayuda`
    FOREIGN KEY (`id_familia_ayuda`)
    REFERENCES `cubo`.`cat_familia_ayuda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_giro`
    FOREIGN KEY (`id_giro`)
    REFERENCES `cubo`.`cat_giro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_apertura`
    FOREIGN KEY (`id_hora_apertura`)
    REFERENCES `cubo`.`cat_hora_apertura` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cierre`
    FOREIGN KEY (`id_hora_cierre`)
    REFERENCES `cubo`.`cat_hora_cierre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sat`
    FOREIGN KEY (`id_sat`)
    REFERENCES `cubo`.`cat_sat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas`
    FOREIGN KEY (`id_ventas`)
    REFERENCES `cubo`.`cat_ventas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sexo`
    FOREIGN KEY (`id_sexo`)
    REFERENCES `cubo`.`cat_sexo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_credito`
    FOREIGN KEY (`id_credito`)
    REFERENCES `cubo`.`cat_credito` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cubo`.`tbl_medios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cubo`.`tbl_medios` (
  `id_emprendedor` CHAR(9) NULL DEFAULT NULL,
  `id_medio` INT NULL DEFAULT NULL,
  `id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_medios_idx` (`id_medio` ASC) VISIBLE,
  CONSTRAINT `fk_medios`
    FOREIGN KEY (`id_medio`)
    REFERENCES `cubo`.`cat_medios` (`id_medio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
