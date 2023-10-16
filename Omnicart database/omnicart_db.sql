-- Creating the omnicart database
CREATE DATABASE IF NOT EXISTS `omnicart_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

USE `omnicart_db`;

-- Creating the office table
CREATE TABLE `office`(
`office_id` INT NOT NULL AUTO_INCREMENT,
`address` VARCHAR(50) NOT NULL,
`city` VARCHAR(50) NOT NULL,
`state` VARCHAR(50) NOT NULL,
PRIMARY KEY(`office_id`)
);

-- Creating department table
CREATE TABLE `department`(
`department_id` INT NOT NULL AUTO_INCREMENT,
`department_name` VARCHAR(50) NOT NULL,
PRIMARY KEY(`department_id`)
)AUTO_INCREMENT = 5;

-- Creating employees table
CREATE TABLE `employees`(
`employee_id` INT NOT NULL AUTO_INCREMENT,
`first_name` VARCHAR(50) NOT NULL,
`middle_name` VARCHAR(50) NOT NULL,
`last_name` VARCHAR(50) NOT NULL,
`email` VARCHAR(50) NOT NULL,
`job_title` VARCHAR(50) NOT NULL,
`hire_date` DATE,
`created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
`updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
);