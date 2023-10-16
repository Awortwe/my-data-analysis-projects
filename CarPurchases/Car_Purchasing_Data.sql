CREATE DATABASE IF NOT EXISTS carDB;
USE carDB;

CREATE TABLE IF NOT EXISTS customers
(
customer_id INT PRIMARY KEY AUTO_INCREMENT,
customer_name VARCHAR(60) NOT NULL,
customer_email VARCHAR(100) NOT NULL,
country VARCHAR(30) NOT NULL,
gender VARCHAR(10) NOT NULL,
age INT NOT NULL,
annual_salary DECIMAL(12,6) NOT NULL,
credit_card_debt DECIMAL(12,6) NOT NULL,
net_worth DECIMAL(12,6) NOT NULL,
car_purchase_amount DECIMAL(12,6) NOT NULL
);

SELECT * FROM customers;

-- --------------------------Feature Engineering---------------------------------------

-- Age Group

ALTER TABLE customers
ADD COLUMN age_group VARCHAR(20);

UPDATE customers
SET age_group =
CASE 
WHEN age BETWEEN 0 AND 29 THEN 'Teenager'
WHEN age BETWEEN 30 AND 49 THEN 'Adult'
WHEN age > 49 THEN 'Senior'
ELSE NULL
END;

-- -------------------DATA EXPLORATION-----------------------------------------------------------

UPDATE customers
SET gender = 
CASE 
WHEN gender = 0 THEN 'Male'
WHEN gender = 1 THEN 'Female'
ELSE NULL
END;

-- The number of customers for the car purchase
SELECT count(*)NumberOfCustomers
FROM customers;

-- The average annual salary of the customers;
SELECT FORMAT(avg(annual_salary), 2)Avg_Annual_Salary
FROM customers;

-- How many countries are in the table
SELECT DISTINCT country
FROM customers;

-- What is the gender distribution per annual salary
SELECT Gender, round(sum(annual_salary),2)Annual_Salary
FROM customers
GROUP BY Gender
ORDER BY Annual_Salary DESC; 

-- What is the gender distribution per credit card debt and net worth
SELECT Gender, round(sum(credit_card_debt),2)Credit_Card_Debt,
round(sum(net_worth),2)Net_Worth
FROM customers
GROUP BY Gender
ORDER BY Net_Worth DESC; 

-- What is the gender distribution per car purchase amount
SELECT Gender, round(sum(car_purchase_amount),2)Car_Purchase_Amount
FROM customers
GROUP BY Gender
ORDER BY Car_Purchase_Amount DESC; 