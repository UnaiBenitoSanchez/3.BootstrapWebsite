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
INSERT INTO product VALUES('1','Barbie Signature Look Gold Disco - Barbie The Movie','This collectible Barbie® doll sparkles in a sequined disco jumpsuit inspired by her character\'s look in the Barbie™ movie. Her dazzling ensemble is complete with a big disco-inspired mane, metallic jewelry and gold heels.','74.99','img/mattel1.jpg','1');
INSERT INTO inventory VALUES('1','1000','2023-12-22','1','1');
INSERT INTO product VALUES('2','Barbie The Movie Fashion Pack','This Barbie® collectible clothing set recreates three iconic outfits from the Barbie™ movie. Each set comes with shoes and accessories so fans can dress their dolls just like Barbie, the character in the movie.','74.99','img/mattel2.jpg','1');
INSERT INTO inventory VALUES('2','2000','2023-12-22','2','1');
INSERT INTO product VALUES('3','Barbie Signature Ken Perfect Day - Barbie The Movie','Inspired by Ken\'s character in the Barbie™ movie, this Ken® doll is wearing a matching striped beach outfit. With his surfboard, he\'s having the time of his life in Barbie Land! This Ken® doll is a tribute to the Barbie™ movie, making it the perfect gift for fans and collectors.','49.99','img/mattel3.jpg','1');
INSERT INTO inventory VALUES('3','1500','2023-12-22','3','1');
INSERT INTO product VALUES('4','Barbie Cutie Reveal Serie Phantasy Unicorn','Open the box and you\'ll see inside a soft plush unicorn and four surprise bags. Remove the rainbow unicorn costume and you\'ll find a Barbie doll with long hair and sparkly details. Open the surprise bags and discover sparkly clothes, accessories, a sponge-comb and a mini unicorn.','34.99','img/mattel4.jpg','1');
INSERT INTO inventory VALUES('4','1000','2023-12-22','4','1');
INSERT INTO product VALUES('5','Barbie Cutie Reveal Serie Jungle Friends Tiger','Barbie Cutie Reveal Jungle Series dolls offer the cutest unboxing experience with 10 surprises! Discover a charming Elephant, lovable Tiger, bright Toucan or cheeky Monkey, then remove the plush costume to reveal a posable Barbie doll with long, colorful hair. Which doll will you reveal?','32.99','img/mattel5.jpg','1');
INSERT INTO inventory VALUES('5','2000','2023-12-22','5','1');
INSERT INTO product VALUES('6','Disney Frozen Queen Anna & Elsa Snow Queen','Set of two classic dolls, Queen Anna and Snow Queen Elsa. Finely detailed features; Elsa snow queen costume includes satin dress with shimmering lavender organza cape and sleeves. Queen Anna costume includes layered green satin dress with glitter, lined cape and tiara. Beautifully styled, rooted hair; molded shoes and boots.','54.46','img/mattel6.jpg','1');
INSERT INTO inventory VALUES('6','1500','2023-12-22','6','1');

-- Lego
INSERT INTO boss VALUES ('2','Ole Kirk Christiansen','0l3@gmail.com','++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>');
INSERT INTO factory VALUES ('2','Lego','456 Oak St','Houston','Texas','USA','6000');
INSERT INTO factory_boss VALUES ('2','2');
INSERT INTO product VALUES('7','Millennium Falcon','Packed with authentic details! Highly realistic detailing makes this an impressive display item. Relive the Star Wars™ saga.
Includes two crews, so you can recreate both classic and new movies.','849.99','img/lego1.jpg','1');
INSERT INTO inventory VALUES('7','1200','2024-01-03','7','2');
INSERT INTO product VALUES('8','Orient Express Train','A paragon of French luxury and an engineering marvel for railroad enthusiasts around the world, the Orient-Express has been stirring imaginations for over 140 years. This new LEGO® Ideas set features interpretations of the train\'s most perfected details along with 8 new character minifigures - it\'s your ticket to endless play and display possibilities!','299.99','img/lego2.jpg','1');
INSERT INTO inventory VALUES('8','2300','2024-01-03','8','2');
INSERT INTO product VALUES('9','Avengers Tower','Recreate the colossal style and grand scale of the Avengers universe\'s most iconic building with the 5201-piece Avengers Tower set. Standing approximately 90 cm tall, this monumental set is more than just a spectacular display piece. It includes a stellar cast of 31 figures that allows you to recreate the battles of the Infinity saga in a multitude of different ways.','499.00','img/lego3.jpg','1');
INSERT INTO inventory VALUES('9','1100','2024-01-03','9','2');
INSERT INTO product VALUES('10','Cherry Blossoms','As well as being a celebration gift for kids, the brick-built blossoms make a great gift for grown-ups, who will be delighted to receive these unique flowers onValentine’s Day or Mother’s Day. Once complete, the set makes a beautiful piece of floral decor that will add a touch of spring joy to any space. It can also be combined with other LEGO flowers (sold separately) to create a vibrant bouquet.','14.99','img/lego4.jpg','1');
INSERT INTO inventory VALUES('10','1200','2024-01-03','10','2');
INSERT INTO product VALUES('11','Disney Ariel Mini Castle','Fans of Disney Princess buildable toys and The Little Mermaid movie aged 12 and up will enjoy endless imaginative role play with this mini model of Ariel’s enchanting palace. Mini Disney Ariel’s Castle (40708) is covered in golden details, incorporates various underwater features and includes an Ariel mini-doll figure. This portable buildable playset is part of the Mini Disney range of companion construction toys, sold separately.','39.99','img/lego5.jpg','1');
INSERT INTO inventory VALUES('11','2300','2024-01-03','11','2');
INSERT INTO product VALUES('12','Natural History Museum','Discover the first-ever museum to join the Modular Buildings collection. Home to an array of brick-built exhibits it features dual skylights that allow light to permeate the building’s 2 levels, illuminating the towering brachiosaurus skeleton and collection of treasures within.','299.99','img/lego6.jpg','1');
INSERT INTO inventory VALUES('12','1100','2024-01-03','12','2');

-- Nerf
INSERT INTO boss VALUES ('3','Reyn Guyer','r3yn@gmail.com','++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>');
INSERT INTO factory VALUES ('3','Nerf','789 Pine St','Columbus','Ohio','USA','4000');
INSERT INTO factory_boss VALUES ('3','3');
INSERT INTO product VALUES('13','SMG-Zesty de Nerf Fortnite','The Nerf Fortnite SMG-Zesty Launcher SMG-Zesty is inspired by Fortnite\'s Zesty wrapper, which mirrors the look of the popular video game\'s wrapper. The launcher has a removable barrel and a detachable stock so you can customize it in different ways. Attach them, detach them.... It\'s up to you! Remove them when you\'re in close combat for a more compact launcher.','37.99','img/nerf1.jpg','1');
INSERT INTO inventory VALUES('13','2100','2024-01-03','13','3');
INSERT INTO product VALUES('14','Nerf Ultra Select','Nerf - Ultra Select, a Nerf Ultra launcher that combines range, speed and precision. It is automatic and has 2 compartments in its integrated clip. It can throw 20 Nerf Ultra and Ultra AccuStrike darts for greater accuracy....','32.99','img/nerf2.jpg','1');
INSERT INTO inventory VALUES('14','1800','2024-01-03','14','3');
INSERT INTO product VALUES('15','Nerf DinoSquad Stegosmash','Hold your ground as a dart-throwing defender with the Nerf DinoSquad Stego-Smash launcher! It features an incredible dinosaur design that replicates the appearance of a Stegosaurus dinosaur. Throw yourself into "dinotastic" fun with this one dart launcher; load a dart through the front of the barrel, pull the lever back to prime the launcher and pull the trigger to launch the dart at the target.','19.99','img/nerf3.jpg','1');
INSERT INTO inventory VALUES('15','2050','2024-01-03','15','3');
INSERT INTO product VALUES('16','Nerf DinoSquad Rex-Rampage','A motorized launcher that roars like the king of the dinosaurs!!! It has a 10 dart holder in the butt so you have projectiles for easy reloading. Includes 20 Nerf foam darts for quick firing.','20.98','img/nerf4.jpg','1');
INSERT INTO inventory VALUES('16','2100','2024-01-03','16','3');
INSERT INTO product VALUES('17','Nerf Alpha Strike Slinger SD-1','The Slinger SD-1 Aiming Set includes 1 launcher, 2 target pieces and 4 Nerf Elite darts. The launcher launches 1 dart at a time and is easy to use. Insert 1 dart into the barrel, pull the handle to set it up and pull the trigger to launch 1 dart. Practice your aiming skills with the 2 target pieces that you can put together to form 1 whole target.','7.99','img/nerf5.jpg','1');
INSERT INTO inventory VALUES('17','1800','2024-01-03','17','3');
INSERT INTO product VALUES('18','Nerf Alpha Strike - Mission Set','This 31-piece Nerf Alpha Strike Mission Set includes 4 launchers, 25 darts and targets to practice your aim and play Nerf games. Perfect for gifts, parties or play anytime! Includes 2 Stinger SD-1 launchers, 1 Cobra RC-6 launcher, 1 Tiger DB-2 launcher and 2 target pieces that can be snapped together to form 1 whole target.','24.99','img/nerf6.jpg','1');
INSERT INTO inventory VALUES('18','2050','2024-01-03','18','3');


-- Playtime Co.
INSERT INTO boss VALUES ('4','Elliot Ludwig','3ll1ot@gmail.com','++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>');
INSERT INTO factory VALUES ('4','Playtime Co.','101 Maple St','Los Angeles','California','USA','8000');
INSERT INTO factory_boss VALUES ('4','4');
INSERT INTO product VALUES('19','Bobby BearHug','A kind, caring soul, Bobby BearHug shows compassion for everyone, and for everything. People and places and things, large or small, are all receivers of her love. Each is enriched by this attention and affection, and in turn, so is she.','50.00','img/playtime1.jpg','1');
INSERT INTO inventory VALUES('19','1000','2024-01-03','19','4');
INSERT INTO product VALUES('20','Bubba Bubbaphant','Bubba Bubbaphant is the brains of the critters. Bright and attentive, he keeps his friends steady and always steers them to make smart choices, that way they all might grow up to be bright and brilliant, each in their own right.','30.00','img/playtime2.jpg','1');
INSERT INTO inventory VALUES('20','2000','2024-01-03','20','4');
INSERT INTO product VALUES('21','CraftyCorn','A conscious observer of both color and creativity in the world. CraftyCorn understands the importance of art, and sharing it with others. Crayons, pencils, paint, or words on the page. CraftyCorn can see beauty in anything imagined given shape.','20.00','img/playtime3.jpg','1');
INSERT INTO inventory VALUES('21','3000','2024-01-03','21','4');
INSERT INTO product VALUES('22','DogDay','This is DogDay, the sunny, strong, and determined leader of our critters! Each trusts him to find the bright side in any situation, and to have a friendly word of encouragement should they feel down. He\'ll always keep his friends going, no matter what.','50.00','img/playtime4.jpg','1');
INSERT INTO inventory VALUES('22','1000','2024-01-03','22','4');
INSERT INTO product VALUES('23','Hoppy Hopscotch','Unafraid to hop where others might sit, Hoppy is the friend everyone needs to maintain their energy and enthusiasm. While sometimes loud or impatient, she\'ll always hop besides her friends, even if it means slowing up once in a while to keep their pace.','30.00','img/playtime5.jpg','1');
INSERT INTO inventory VALUES('23','2000','2024-01-03','23','4');
INSERT INTO product VALUES('24','KickinChicken','This is KickinChicken, the cool kid of the crew, and he maintains that sense of cool through anything, even in the most tense of situations. Knock him down, and he\'ll pick himself up, brush himself off, and ask: "What\'s next?"','20.00','img/playtime6.jpg','1');
INSERT INTO inventory VALUES('24','3000','2024-01-03','24','4');
INSERT INTO product VALUES('25','PickyPiggy','What\'s more important than play and learning? PickyPiggy knows the answer. A playful body and keen mind are fueled by what\'s put into them, which is why she encourages her friends to eat a well-balanced diet. Secretly, PB&J\'s are her favorite food.','20.00','img/playtime7.jpg','1');
INSERT INTO inventory VALUES('25','3000','2024-01-03','25','4');
INSERT INTO product VALUES('26','CatNap','CatNap is a calming presence for the critters and ensures he and his friends always have the right amount of sleep to jumpstart the morning\'s play! End of the day, there\'s nothing CatNap enjoys more than watching his friends sleep soundly.','20.00','img/playtime8.jpg','1');
INSERT INTO inventory VALUES('26','3000','2024-01-03','26','4');

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

-- Event to delete from Barbie Cutie Reveal Serie Phantasy Unicorn 
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_unicorn 
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Cutie Reveal Serie Phantasy Unicorn'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Cutie Reveal Serie Phantasy Unicorn');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Cutie Reveal Serie Phantasy Unicorn'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Cutie Reveal Serie Phantasy Unicorn')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Barbie Cutie Reveal Serie Phantasy Unicorn 
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_unicorn
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Cutie Reveal Serie Phantasy Unicorn'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Cutie Reveal Serie Phantasy Unicorn');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Cutie Reveal Serie Phantasy Unicorn'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Cutie Reveal Serie Phantasy Unicorn')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from Barbie Cutie Reveal Serie Jungle Friends Tiger 
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_tiger 
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Cutie Reveal Serie Jungle Friends Tiger'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Cutie Reveal Serie Jungle Friends Tiger');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Cutie Reveal Serie Jungle Friends Tiger'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Cutie Reveal Serie Jungle Friends Tiger')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to CatNap 
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_tiger
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Cutie Reveal Serie Jungle Friends Tiger'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Cutie Reveal Serie Jungle Friends Tiger');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Cutie Reveal Serie Jungle Friends Tiger'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Barbie Cutie Reveal Serie Jungle Friends Tiger')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from Disney Frozen Queen Anna & Elsa Snow Queen 
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_elsaAna
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Disney Frozen Queen Anna & Elsa Snow Queen'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Disney Frozen Queen Anna & Elsa Snow Queen');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Disney Frozen Queen Anna & Elsa Snow Queen'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Disney Frozen Queen Anna & Elsa Snow Queen')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Disney Frozen Queen Anna & Elsa Snow Queen 
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_elsaAna 
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Disney Frozen Queen Anna & Elsa Snow Queen'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Disney Frozen Queen Anna & Elsa Snow Queen');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Disney Frozen Queen Anna & Elsa Snow Queen'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Disney Frozen Queen Anna & Elsa Snow Queen')), 'Add');
END;
//
DELIMITER ;

-- Lego--------------------------------------------------------------------------------------------------------------
-- Event to delete from Millennium Falcon
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_Millennium_Falcon
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN

  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Millennium Falcon'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Millennium Falcon');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Millennium Falcon'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Millennium Falcon')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Millennium Falcon
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_Millennium_Falcon
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Millennium Falcon'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Millennium Falcon');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Millennium Falcon'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Millennium Falcon')), 'Add');
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

-- Event to delete from Cherry Blossoms 
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_cherry
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Cherry Blossoms'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Cherry Blossoms');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Cherry Blossoms'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Cherry Blossoms')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Cherry Blossoms 
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_cherry 
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Cherry Blossoms'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Cherry Blossoms');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Cherry Blossoms'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Cherry Blossoms')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from Disney Ariel Mini Castle 
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_ariel 
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Disney Ariel Mini Castle'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Disney Ariel Mini Castle');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Disney Ariel Mini Castle'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Disney Ariel Mini Castle')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Disney Ariel Mini Castle 
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_ariel 
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Disney Ariel Mini Castle'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Disney Ariel Mini Castle');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Disney Ariel Mini Castle'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Disney Ariel Mini Castle')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from Natural History Museum 
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_museum
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Natural History Museum'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Natural History Museum');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Natural History Museum'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Natural History Museum')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Natural History Museum 
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_museum 
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Natural History Museum'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Natural History Museum');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Natural History Museum'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Natural History Museum')), 'Add');
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

-- Event to delete from Nerf DinoSquad Rex-Rampage 
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_rex 
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf DinoSquad Rex-Rampage'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf DinoSquad Rex-Rampage');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf DinoSquad Rex-Rampage'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf DinoSquad Rex-Rampage')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Nerf DinoSquad Rex-Rampage 
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_rex 
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf DinoSquad Rex-Rampage'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf DinoSquad Rex-Rampage');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf DinoSquad Rex-Rampage'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf DinoSquad Rex-Rampage')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from Nerf Alpha Strike Slinger SD-1 
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_slinger
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Alpha Strike Slinger SD-1'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Alpha Strike Slinger SD-1');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Alpha Strike Slinger SD-1'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Alpha Strike Slinger SD-1')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Nerf Alpha Strike Slinger SD-1 
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_slinger 
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Alpha Strike Slinger SD-1'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Alpha Strike Slinger SD-1');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Alpha Strike Slinger SD-1'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Alpha Strike Slinger SD-1')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from Nerf Alpha Strike - Mission Set 
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_mission
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Alpha Strike - Mission Set'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Alpha Strike - Mission Set');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Alpha Strike - Mission Set'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Alpha Strike - Mission Set')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Nerf Alpha Strike - Mission Set 
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_mission
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Alpha Strike - Mission Set'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Alpha Strike - Mission Set');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Alpha Strike - Mission Set'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Nerf Alpha Strike - Mission Set')), 'Add');
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

-- Event to delete from DogDay
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_DogDay
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'DogDay'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'DogDay');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'DogDay'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'DogDay')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to DogDay
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_DogDay
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'DogDay'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'DogDay');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'DogDay'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'DogDay')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from Hoppy Hopscotch
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_Hoppy_Hopscotch
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Hoppy Hopscotch'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Hoppy Hopscotch');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Hoppy Hopscotch'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Hoppy Hopscotch')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to Hoppy Hopscotch
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_Hoppy_Hopscotch
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Hoppy Hopscotch'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Hoppy Hopscotch');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Hoppy Hopscotch'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Hoppy Hopscotch')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from KickinChicken
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_KickinChicken
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'KickinChicken'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'KickinChicken');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'KickinChicken'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'KickinChicken')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to KickinChicken
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_KickinChicken
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'KickinChicken'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'KickinChicken');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'KickinChicken'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'KickinChicken')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from PickyPiggy 
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_PickyPiggy 
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'PickyPiggy'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'PickyPiggy');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'PickyPiggy'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'PickyPiggy')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to PickyPiggy 
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_PickyPiggy 
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'PickyPiggy'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'PickyPiggy');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'PickyPiggy'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'PickyPiggy')), 'Add');
END;
//
DELIMITER ;

-- Event to delete from CatNap 
DELIMITER //
CREATE EVENT IF NOT EXISTS subtract_quantity_event_CatNap 
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'CatNap'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = GREATEST(available_quantity - 100, 0)
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'CatNap');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'CatNap'),(SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'Catnap')), 'Subtract');
END;
//
DELIMITER ;

-- Event to add to CatNap 
DELIMITER //
CREATE EVENT IF NOT EXISTS add_quantity_event_CatNap 
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
  SET @current_quantity := (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'CatNap'));

  UPDATE BootstrapWebsite.inventory
  SET available_quantity = available_quantity + 100
  WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'CatNap');

  INSERT INTO BootstrapWebsite.inventory_history (product_id_product, change_quantity, change_type)
  VALUES ((SELECT id_product FROM BootstrapWebsite.product WHERE name = 'CatNap'), (SELECT available_quantity FROM BootstrapWebsite.inventory WHERE product_id_product = (SELECT id_product FROM BootstrapWebsite.product WHERE name = 'CatNap')), 'Add');
END;
//
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
