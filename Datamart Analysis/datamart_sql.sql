DROP DATABASE IF EXISTS datamart_db;
CREATE SCHEMA IF NOT EXISTS datamart_db;
USE datamart_db;

SELECT * FROM datamart;
DESCRIBE datamart;

SELECT InitialQuantity,
REGEXP_REPLACE(InitialQuantity, '[^0-9]+', '') AS Extracted_Numbers,
REGEXP_REPLACE(InitialQuantity, '[^a-zA-Z]', '') AS Extracted_Text
FROM 
datamart;

ALTER table datamart
ADD COLUMN InitialQuant INT;

ALTER TABLE datamart
ADD COLUMN Unit VARCHAR(30);

UPDATE datamart
SET InitialQuant = REGEXP_REPLACE(InitialQuantity, '[^0-9]+', '');

UPDATE datamart
SET Unit = REGEXP_REPLACE(InitialQuantity, '[^a-zA-Z]', '');

UPDATE datamart
SET UnitPrice = REGEXP_REPLACE(UnitPrice, '[^0-9.]+', '');

ALTER TABLE datamart
DROP COLUMN InitialQuantity;

ALTER TABLE datamart
CHANGE COLUMN InitialQuant InitialQuantity INT;

UPDATE datamart
SET CurrentQuantity = REGEXP_REPLACE(CurrentQuantity, '[^0-9]+', '');

DESCRIBE datamart;

SELECT * FROM datamart;

UPDATE datamart
SET PurchaseDate = 
CASE
WHEN PurchaseDate LIKE '%/%' THEN DATE_FORMAT(str_to_date(PurchaseDate, '%d/%m/%Y'), '%Y-%m-%d')
ELSE NULL
END;

ALTER TABLE datamart
MODIFY COLUMN PurchaseDate DATE;

UPDATE datamart
SET ExpiryDate =
CASE
WHEN ExpiryDate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(ExpiryDate, '%d/%m/%Y'), '%Y-%m-%d')
ELSE NULL 
END;

ALTER TABLE datamart
MODIFY COLUMN ExpiryDate DATE;

ALTER TABLE datamart
MODIFY COLUMN UnitPrice DECIMAL(10,2);

ALTER TABLE datamart
MODIFY COLUMN `Purchase Price` DECIMAL(10,2);

ALTER TABLE datamart
CHANGE COLUMN `Purchase Price` PurchasePrice DECIMAL(10,2); 

ALTER TABLE datamart
MODIFY COLUMN CurrentQuantity INT;

ALTER TABLE datamart
ADD COLUMN MarkupProfit DECIMAL(10,2);

ALTER TABLE datamart
ADD COLUMN SellingPrice DECIMAL(10,2);

UPDATE datamart
SET MarkupProfit = (UnitPrice*0.2);

UPDATE datamart
SET SellingPrice = UnitPrice + MarkupProfit;

SELECT * FROM datamart;