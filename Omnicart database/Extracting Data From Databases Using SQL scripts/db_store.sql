-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db_store
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db_store` ;

-- -----------------------------------------------------
-- Schema db_store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_store` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db_store` ;

-- -----------------------------------------------------
-- Table `db_store`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_store`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `birth_date` DATE NULL DEFAULT NULL,
  `phone` VARCHAR(50) NULL DEFAULT NULL,
  `address` VARCHAR(50) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `points` INT NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_store`.`order_item_notes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_store`.`order_item_notes` (
  `note_id` INT NOT NULL,
  `order_Id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `note` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`note_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_store`.`order_statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_store`.`order_statuses` (
  `order_status_id` TINYINT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`order_status_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_store`.`shippers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_store`.`shippers` (
  `shipper_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `company_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`shipper_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_store`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_store`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `status` TINYINT NOT NULL DEFAULT '1',
  `comments` VARCHAR(2000) NULL DEFAULT NULL,
  `shipped_date` DATE NULL DEFAULT NULL,
  `shipper_id` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  CONSTRAINT `fk_orders_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `db_store`.`customers` (`customer_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_order_statuses`
    FOREIGN KEY (`status`)
    REFERENCES `db_store`.`order_statuses` (`order_status_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_shippers`
    FOREIGN KEY (`shipper_id`)
    REFERENCES `db_store`.`shippers` (`shipper_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `fk_orders_customers_idx` ON `db_store`.`orders` (`customer_id` ASC) VISIBLE;

CREATE INDEX `fk_orders_shippers_idx` ON `db_store`.`orders` (`shipper_id` ASC) VISIBLE;

CREATE INDEX `fk_orders_order_statuses_idx` ON `db_store`.`orders` (`status` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `db_store`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_store`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(50) NOT NULL,
  `quantity_in_stock` INT NOT NULL,
  `unit_price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_store`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_store`.`order_items` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `unit_price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`order_id`, `product_id`),
  CONSTRAINT `fk_order_items_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `db_store`.`orders` (`order_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_products`
    FOREIGN KEY (`product_id`)
    REFERENCES `db_store`.`products` (`product_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `fk_order_items_products_idx` ON `db_store`.`order_items` (`product_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
