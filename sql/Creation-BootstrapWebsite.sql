-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BootstrapWebsite
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `BootstrapWebsite` ;

-- -----------------------------------------------------
-- Schema BootstrapWebsite
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BootstrapWebsite` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `BootstrapWebsite` ;

-- -----------------------------------------------------
-- Table `BootstrapWebsite`.`boss`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BootstrapWebsite`.`boss` ;

CREATE TABLE IF NOT EXISTS `BootstrapWebsite`.`boss` (
  `id_boss_factory` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(225) NOT NULL,
  `email` VARCHAR(225) NOT NULL,
  `password` VARCHAR(1000) NOT NULL, 
  PRIMARY KEY (`id_boss_factory`),
  INDEX `idx_boss_email` (`email` ASC) VISIBLE
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `BootstrapWebsite`.`factory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BootstrapWebsite`.`factory` ;

CREATE TABLE IF NOT EXISTS `BootstrapWebsite`.`factory` (
  `id_factory` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `boss_id_boss_factory` INT NOT NULL,
  `employee_count` INT NOT NULL,
  PRIMARY KEY (`id_factory`),
  INDEX `fk_factory_boss1_idx` (`boss_id_boss_factory` ASC) VISIBLE,
  CONSTRAINT `fk_factory_boss1`
    FOREIGN KEY (`boss_id_boss_factory`)
    REFERENCES `BootstrapWebsite`.`boss` (`id_boss_factory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `BootstrapWebsite`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BootstrapWebsite`.`category` ;

CREATE TABLE IF NOT EXISTS `BootstrapWebsite`.`category` (
  `id_category` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(255) NOT NULL,
  `category_description` TEXT NOT NULL,
  PRIMARY KEY (`id_category`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `BootstrapWebsite`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BootstrapWebsite`.`product` ;

CREATE TABLE IF NOT EXISTS `BootstrapWebsite`.`product` (
  `id_product` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `category_id_category` INT NOT NULL,
  PRIMARY KEY (`id_product`),
  INDEX `fk_product_category_idx` (`category_id_category` ASC) VISIBLE,
  CONSTRAINT `fk_product_category`
    FOREIGN KEY (`category_id_category`)
    REFERENCES `BootstrapWebsite`.`category` (`id_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `BootstrapWebsite`.`inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BootstrapWebsite`.`inventory` ;

CREATE TABLE IF NOT EXISTS `BootstrapWebsite`.`inventory` (
  `id_inventory` INT NOT NULL AUTO_INCREMENT,
  `available_quantity` INT NOT NULL,
  `update_date` DATE NOT NULL,
  `product_id_product` INT NOT NULL,
  `factory_id_factory` INT NOT NULL,
  PRIMARY KEY (`id_inventory`),
  INDEX `fk_inventory_product1_idx` (`product_id_product` ASC) VISIBLE,
  INDEX `fk_inventory_factory1_idx` (`factory_id_factory` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_product1`
    FOREIGN KEY (`product_id_product`)
    REFERENCES `BootstrapWebsite`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_factory1`
    FOREIGN KEY (`factory_id_factory`)
    REFERENCES `BootstrapWebsite`.`factory` (`id_factory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- Inserts

INSERT INTO category VALUES ('1','Entertainment','Made to let children play with it');

INSERT INTO factory VALUES ('1','Mattel','California, USA','1','2000');

INSERT INTO boss VALUES ('1','Stephen Johnson','st3ph@gmail.com','++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>');

INSERT INTO product VALUES('1','Barbie Signature Look Gold Disco - Barbie The Movie','Doll','20.00','1');
INSERT INTO inventory VALUES('1','600','2023-12-22','1','1');

INSERT INTO product VALUES('2','Barbie The Movie Fashion Pack','Pack','10.00','1');
INSERT INTO inventory VALUES('2','700','2023-12-22','2','1');

INSERT INTO product VALUES('3','Barbie Signature Ken Perfect Day - Barbie The Movie','Doll','100.00','1');
INSERT INTO inventory VALUES('3','500','2023-12-22','3','1');

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
