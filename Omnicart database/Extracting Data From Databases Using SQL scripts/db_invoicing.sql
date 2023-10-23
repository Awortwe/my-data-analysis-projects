-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db_invoicing
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_invoicing
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_invoicing` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db_invoicing` ;

-- -----------------------------------------------------
-- Table `db_invoicing`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_invoicing`.`clients` (
  `client_id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `phone` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`client_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_invoicing`.`invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_invoicing`.`invoices` (
  `invoice_id` INT NOT NULL,
  `number` VARCHAR(50) NOT NULL,
  `client_id` INT NOT NULL,
  `invoice_total` DECIMAL(9,2) NOT NULL,
  `payment_total` DECIMAL(9,2) NOT NULL DEFAULT '0.00',
  `invoice_date` DATE NOT NULL,
  `due_date` DATE NOT NULL,
  `payment_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  CONSTRAINT `FK_client_id`
    FOREIGN KEY (`client_id`)
    REFERENCES `db_invoicing`.`clients` (`client_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `FK_client_id` ON `db_invoicing`.`invoices` (`client_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `db_invoicing`.`payment_methods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_invoicing`.`payment_methods` (
  `payment_method_id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`payment_method_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_invoicing`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_invoicing`.`payments` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `invoice_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `amount` DECIMAL(9,2) NOT NULL,
  `payment_method` TINYINT NOT NULL,
  PRIMARY KEY (`payment_id`),
  CONSTRAINT `fk_payment_client`
    FOREIGN KEY (`client_id`)
    REFERENCES `db_invoicing`.`clients` (`client_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_invoice`
    FOREIGN KEY (`invoice_id`)
    REFERENCES `db_invoicing`.`invoices` (`invoice_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_payment_method`
    FOREIGN KEY (`payment_method`)
    REFERENCES `db_invoicing`.`payment_methods` (`payment_method_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `fk_client_id_idx` ON `db_invoicing`.`payments` (`client_id` ASC) VISIBLE;

CREATE INDEX `fk_invoice_id_idx` ON `db_invoicing`.`payments` (`invoice_id` ASC) VISIBLE;

CREATE INDEX `fk_payment_payment_method_idx` ON `db_invoicing`.`payments` (`payment_method` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
