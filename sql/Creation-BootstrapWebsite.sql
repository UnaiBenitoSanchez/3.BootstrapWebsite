-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BootstrapWebsite
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `BootstrapWebsite`;

-- -----------------------------------------------------
-- Schema BootstrapWebsite
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BootstrapWebsite` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `BootstrapWebsite`;

-- -----------------------------------------------------
-- Table `BootstrapWebsite`.`boss`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BootstrapWebsite`.`boss`;

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
DROP TABLE IF EXISTS `BootstrapWebsite`.`factory`;

CREATE TABLE IF NOT EXISTS `BootstrapWebsite`.`factory` (
  `id_factory` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `street_address` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `state` VARCHAR(255) NOT NULL,
  `country` VARCHAR(255) NOT NULL,
  `employee_count` INT NOT NULL,
  PRIMARY KEY (`id_factory`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `BootstrapWebsite`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BootstrapWebsite`.`category`;

CREATE TABLE IF NOT EXISTS `BootstrapWebsite`.`category` (
  `id_category` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(255) NOT NULL,
  `category_description` TEXT NOT NULL,
  PRIMARY KEY (`id_category`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `BootstrapWebsite`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BootstrapWebsite`.`product`;

CREATE TABLE IF NOT EXISTS `BootstrapWebsite`.`product` (
  `id_product` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  `category_id_category` INT NOT NULL,
  PRIMARY KEY (`id_product`),
  INDEX `fk_product_category_idx` (`category_id_category` ASC) VISIBLE,
  CONSTRAINT `fk_product_category`
    FOREIGN KEY (`category_id_category`)
    REFERENCES `BootstrapWebsite`.`category` (`id_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `BootstrapWebsite`.`inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BootstrapWebsite`.`inventory`;

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
    ON UPDATE NO ACTION
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `BootstrapWebsite`.`inventory_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BootstrapWebsite`.`inventory_history`;

CREATE TABLE IF NOT EXISTS `BootstrapWebsite`.`inventory_history` (
  `id_history` INT NOT NULL AUTO_INCREMENT,
  `product_id_product` INT NOT NULL,
  `change_quantity` INT NOT NULL,
  `change_type` VARCHAR(50) NOT NULL,
  `change_timestamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_history`),
  INDEX `fk_inventory_history_product1_idx` (`product_id_product` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_history_product1`
    FOREIGN KEY (`product_id_product`)
    REFERENCES `BootstrapWebsite`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `BootstrapWebsite`.`factory_boss`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BootstrapWebsite`.`factory_boss`;

CREATE TABLE IF NOT EXISTS `BootstrapWebsite`.`factory_boss` (
  `factory_id_factory` INT NOT NULL,
  `boss_id_boss_factory` INT NOT NULL,
  PRIMARY KEY (`factory_id_factory`, `boss_id_boss_factory`),
  CONSTRAINT `fk_factory_boss_factory`
    FOREIGN KEY (`factory_id_factory`)
    REFERENCES `BootstrapWebsite`.`factory` (`id_factory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_factory_boss_boss`
    FOREIGN KEY (`boss_id_boss_factory`)
    REFERENCES `BootstrapWebsite`.`boss` (`id_boss_factory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- Inserts-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO category VALUES ('1','Entertainment','Made to let children play with it');

-- Mattel
INSERT INTO boss VALUES ('1','Harold Matson','h4r0ld@gmail.com','++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>');
INSERT INTO factory VALUES ('1','Mattel','123 Main St','Los Angeles','California','USA','2000');
INSERT INTO factory_boss VALUES ('1','1');
INSERT INTO product VALUES('1','Barbie Signature Look Gold Disco - Barbie The Movie','Doll','20.00','img/mattel1.jpg','1');
INSERT INTO inventory VALUES('1','1000','2023-12-22','1','1');
INSERT INTO product VALUES('2','Barbie The Movie Fashion Pack','Pack','10.00','img/mattel2.jpg','1');
INSERT INTO inventory VALUES('2','2000','2023-12-22','2','1');
INSERT INTO product VALUES('3','Barbie Signature Ken Perfect Day - Barbie The Movie','Doll','100.00','img/mattel3.jpg','1');
INSERT INTO inventory VALUES('3','1500','2023-12-22','3','1');

-- Lego
INSERT INTO boss VALUES ('2','Ole Kirk Christiansen','0l3@gmail.com','++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>');
INSERT INTO factory VALUES ('2','Lego','456 Oak St','Houston','Texas','USA','6000');
INSERT INTO factory_boss VALUES ('2','2');
INSERT INTO product VALUES('4','Bouquet of Roses','Mountable','59.99','img/lego1.jpg','1');
INSERT INTO inventory VALUES('4','1200','2024-01-03','4','2');
INSERT INTO product VALUES('5','Orient Express Train','Mountable','299.99','img/lego2.jpg','1');
INSERT INTO inventory VALUES('5','2300','2024-01-03','5','2');
INSERT INTO product VALUES('6','Avengers Tower','Mountable','499.00','img/lego3.jpg','1');
INSERT INTO inventory VALUES('6','1100','2024-01-03','6','2');

-- Nerf
INSERT INTO boss VALUES ('3','Reyn Guyer','r3yn@gmail.com','++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>');
INSERT INTO factory VALUES ('3','Nerf','789 Pine St','Columbus','Ohio','USA','4000');
INSERT INTO factory_boss VALUES ('3','3');
INSERT INTO product VALUES('7','SMG-Zesty de Nerf Fortnite','Nerf gun','20.00','img/nerf1.jpg','1');
INSERT INTO inventory VALUES('7','2100','2024-01-03','7','3');
INSERT INTO product VALUES('8','Nerf Ultra Select','Nerf gun','10.00','img/nerf2.jpg','1');
INSERT INTO inventory VALUES('8','1800','2024-01-03','8','3');
INSERT INTO product VALUES('9','Nerf DinoSquad Stegosmash','Nerf gun','100.00','img/nerf3.jpg','1');
INSERT INTO inventory VALUES('9','2050','2024-01-03','9','3');

-- Playtime Co.
INSERT INTO boss VALUES ('4','Elliot Ludwig','3ll1ot@gmail.com','++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>');
INSERT INTO factory VALUES ('4','Playtime Co.','101 Maple St','Los Angeles','California','USA','8000');
INSERT INTO factory_boss VALUES ('4','4');
INSERT INTO product VALUES('10','Bobby BearHug','A kind, caring soul, Bobby BearHug shows compassion for everyone, and for everything. People and places and things, large or small, are all receivers of her love. Each is enriched by this attention and affection, and in turn, so is she.','50.00','img/playtime1.jpg','1');
INSERT INTO inventory VALUES('10','1000','2024-01-03','10','4');
INSERT INTO product VALUES('11','Bubba Bubbaphant','Bubba Bubbaphant is the brains of the critters. Bright and attentive, he keeps his friends steady and always steers them to make smart choices, that way they all might grow up to be bright and brilliant, each in their own right.','30.00','img/playtime2.jpg','1');
INSERT INTO inventory VALUES('11','2000','2024-01-03','11','4');
INSERT INTO product VALUES('12','CraftyCorn','A conscious observer of both color and creativity in the world. CraftyCorn understands the importance of art, and sharing it with others. Crayons, pencils, paint, or words on the page. CraftyCorn can see beauty in anything imagined given shape.','20.00','img/playtime3.jpg','1');
INSERT INTO inventory VALUES('12','3000','2024-01-03','12','4');
INSERT INTO product VALUES('13','DogDay','This is DogDay, the sunny, strong, and determined leader of our critters! Each trusts him to find the bright side in any situation, and to have a friendly word of encouragement should they feel down. He\'ll always keep his friends going, no matter what.','50.00','img/playtime4.jpg','1');
INSERT INTO inventory VALUES('13','1000','2024-01-03','13','4');
INSERT INTO product VALUES('14','Hoppy Hopscotch','Unafraid to hop where others might sit, Hoppy is the friend everyone needs to maintain their energy and enthusiasm. While sometimes loud or impatient, she\'ll always hop besides her friends, even if it means slowing up once in a while to keep their pace.','30.00','img/playtime5.jpg','1');
INSERT INTO inventory VALUES('14','2000','2024-01-03','14','4');
INSERT INTO product VALUES('15','KickinChicken','This is KickinChicken, the cool kid of the crew, and he maintains that sense of cool through anything, even in the most tense of situations. Knock him down, and he\'ll pick himself up, brush himself off, and ask: "What\'s next?"','20.00','img/playtime6.jpg','1');
INSERT INTO inventory VALUES('15','3000','2024-01-03','15','4');
INSERT INTO product VALUES('16','PickyPiggy ','What\'s more important than play and learning? PickyPiggy knows the answer. A playful body and keen mind are fueled by what\'s put into them, which is why she encourages her friends to eat a well-balanced diet. Secretly, PB&J\'s are her favorite food.','20.00','img/playtime7.jpg','1');
INSERT INTO inventory VALUES('16','3000','2024-01-03','16','4');
INSERT INTO product VALUES('17','CatNap ','CatNap is a calming presence for the critters and ensures he and his friends always have the right amount of sleep to jumpstart the morning\'s play! End of the day, there\'s nothing CatNap enjoys more than watching his friends sleep soundly.','20.00','img/playtime8.jpg','1');
INSERT INTO inventory VALUES('17','3000','2024-01-03','17','4');

-- Scripts----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Mattel------------------------------------------------------------------------------------------------------------
-- Event to delete from Barbie Signature Look Gold Disco - Barbie The Movie
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_Barbie_Signature_Look
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN

  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Signature Look Gold Disco - Barbie The Movie'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Signature Look Gold Disco - Barbie The Movie');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Signature Look Gold Disco - Barbie The Movie'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Signature Look Gold Disco - Barbie The Movie')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Barbie Signature Look Gold Disco - Barbie The Movie
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_Barbie_Signature_Look
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Signature Look Gold Disco - Barbie The Movie'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Signature Look Gold Disco - Barbie The Movie');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Signature Look Gold Disco - Barbie The Movie'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Signature Look Gold Disco - Barbie The Movie')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from Barbie The Movie Fashion Pack
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_Barbie_The_Movie_Fashion_Pack
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie The Movie Fashion Pack'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie The Movie Fashion Pack');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie The Movie Fashion Pack'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie The Movie Fashion Pack')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Barbie The Movie Fashion Pack
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_Barbie_The_Movie_Fashion_Pack
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie The Movie Fashion Pack'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie The Movie Fashion Pack');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie The Movie Fashion Pack'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie The Movie Fashion Pack')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from Barbie Signature Ken Perfect Day - Barbie The Movie
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_Barbie_Signature_Ken
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Signature Ken Perfect Day - Barbie The Movie'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Signature Ken Perfect Day - Barbie The Movie');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Signature Ken Perfect Day - Barbie The Movie'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Signature Ken Perfect Day - Barbie The Movie')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Barbie Signature Ken Perfect Day - Barbie The Movie
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_Barbie_Signature_Ken
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Signature Ken Perfect Day - Barbie The Movie'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Signature Ken Perfect Day - Barbie The Movie');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Signature Ken Perfect Day - Barbie The Movie'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Signature Ken Perfect Day - Barbie The Movie')), 'Add');
END;
//
DELIMITER ;

-- Lego--------------------------------------------------------------------------------------------------------------
-- Event to delete from Bouquet of Roses
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_Bouquet_of_Roses
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN

  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bouquet of Roses'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bouquet of Roses');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bouquet of Roses'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bouquet of Roses')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Bouquet of Roses
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_Bouquet_of_Roses
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bouquet of Roses'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bouquet of Roses');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bouquet of Roses'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bouquet of Roses')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from Orient Express Train
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_Orient_Express_Train
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Orient Express Train'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Orient Express Train');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Orient Express Train'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Orient Express Train')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Orient Express Train
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_Orient_Express_Train
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Orient Express Train'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Orient Express Train');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Orient Express Train'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Orient Express Train')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from Avengers Tower
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_Avengers_Tower
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Avengers Tower'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Avengers Tower');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Avengers Tower'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Avengers Tower')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Avengers Tower
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_Avengers_Tower
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Avengers Tower'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Avengers Tower');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Avengers Tower'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Avengers Tower')), 'Add');
END;
//
DELIMITER ;

-- Nerf--------------------------------------------------------------------------------------------------------------
-- Event to delete from SMG-Zesty de Nerf Fortnite
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_SMG_Zesty_de_Nerf_Fortnite
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN

  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'SMG-Zesty de Nerf Fortnite'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'SMG-Zesty de Nerf Fortnite');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'SMG-Zesty de Nerf Fortnite'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'SMG-Zesty de Nerf Fortnite')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to SMG-Zesty de Nerf Fortnite
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_SMG_Zesty_de_Nerf_Fortnite
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'SMG-Zesty de Nerf Fortnite'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'SMG-Zesty de Nerf Fortnite');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'SMG-Zesty de Nerf Fortnite'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'SMG-Zesty de Nerf Fortnite')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from Nerf Ultra Select
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_Nerf_Ultra_Select
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Ultra Select'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Ultra Select');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Ultra Select'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Ultra Select')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Nerf Ultra Select
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_Nerf_Ultra_Select
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Ultra Select'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Ultra Select');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Ultra Select'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Ultra Select')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from Nerf DinoSquad Stegosmash
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_Nerf_DinoSquad_Stegosmash
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf DinoSquad Stegosmash'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf DinoSquad Stegosmash');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf DinoSquad Stegosmash'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf DinoSquad Stegosmash')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Nerf DinoSquad Stegosmash
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_Nerf_DinoSquad_Stegosmash
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf DinoSquad Stegosmash'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf DinoSquad Stegosmash');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf DinoSquad Stegosmash'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf DinoSquad Stegosmash')), 'Add');
END;
//
DELIMITER ;

-- Playtime Co.------------------------------------------------------------------------------------------------------
-- Event to delete from Bobby BearHug
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_bobbybearhug
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bobby BearHug'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bobby BearHug');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bobby BearHug'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bobby BearHug')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Bobby BearHug
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_bobbybearhug
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bobby BearHug'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bobby BearHug');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bobby BearHug'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bobby BearHug')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from Bubba Bubbaphant
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN

  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bubba Bubbaphant'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bubba Bubbaphant');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bubba Bubbaphant'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bubba Bubbaphant')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Bubba Bubbaphant
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bubba Bubbaphant'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bubba Bubbaphant');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bubba Bubbaphant'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Bubba Bubbaphant')), 'Add');
END;
//
DELIMITER ;


-- Event to delete from CraftyCorn
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_CraftyCorn
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'CraftyCorn'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'CraftyCorn');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'CraftyCorn'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'CraftyCorn')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to CraftyCorn
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_CraftyCorn
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'CraftyCorn'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'CraftyCorn');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'CraftyCorn'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'CraftyCorn')), 'Add');
END;
//
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
