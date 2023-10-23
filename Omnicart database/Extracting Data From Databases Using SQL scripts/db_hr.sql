-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db_hr
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db_hr` ;

-- -----------------------------------------------------
-- Schema db_hr
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_hr` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db_hr` ;

-- -----------------------------------------------------
-- Table `db_hr`.`offices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_hr`.`offices` (
  `office_id` INT NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`office_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_hr`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_hr`.`employees` (
  `employee_id` INT NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `job_title` VARCHAR(50) NOT NULL,
  `salary` INT NOT NULL,
  `reports_to` INT NULL DEFAULT NULL,
  `office_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `fk_employees_managers`
    FOREIGN KEY (`reports_to`)
    REFERENCES `db_hr`.`employees` (`employee_id`),
  CONSTRAINT `fk_employees_offices`
    FOREIGN KEY (`office_id`)
    REFERENCES `db_hr`.`offices` (`office_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `fk_employees_offices_idx` ON `db_hr`.`employees` (`office_id` ASC) VISIBLE;

CREATE INDEX `fk_employees_employees_idx` ON `db_hr`.`employees` (`reports_to` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
