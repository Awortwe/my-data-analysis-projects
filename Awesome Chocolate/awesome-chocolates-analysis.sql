SHOW TABLES;

USE `awesome chocolates`;

/*
INTERMEDIATE PROBLEMS
1. Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?
2. How many shipments (sales) each of the sales persons had in the month of January 2022?
3. Which product sells more boxes? Milk Bars or Eclairs?
4. Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?
5. Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?

HARD PROBLEMS
1. What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?
2. Which salespersons did not make any shipments in the first 7 days of January 2022?
3. How many times we shipped more than 1,000 boxes in each month?
4. Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months?
5. India or Australia? Who buys more chocolate boxes on a monthly basis?
*/

-- Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?
SELECT * FROM sales
WHERE Amount > 2000 AND Boxes < 100;

-- How many shipments (sales) each of the sales persons had in the month of January 2022?
SELECT * FROM people;
SELECT * FROM sales;

SELECT p.Salesperson, count(s.SPID)Shipments
FROM people p inner join sales s
ON p.SPID = s.SPID
WHERE s.SaleDate BETWEEN '2022-01-01' AND '2022-01-31'
GROUP BY s.SPID
ORDER BY Shipments DESC;

-- Which product sells more boxes? Milk Bars or Eclairs?
SELECT * FROM sales;
SELECT * FROM products;

SELECT p.Product, sum(s.Boxes)Boxes
FROM products p INNER JOIN sales s
USING(PID)
GROUP BY PID
HAVING p.Product IN ('Milk Bars', 'Eclairs')
ORDER BY Boxes DESC;

-- Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?
SELECT p.Product, sum(s.Boxes)Boxes
FROM products p INNER JOIN sales s
ON p.PID = s.PID
WHERE s.SaleDate BETWEEN '2022-02-01' AND '2022-02-07'
GROUP BY p.PID
HAVING p.Product IN ('Milk bars', 'Eclairs')
ORDER BY Boxes DESC;




-- Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?
SELECT *,
CASE
WHEN DAYNAME(SaleDate) = 'Wednesday' THEN 'Wednesday Shipment'
ELSE null
END`Shipment`
FROM sales
WHERE Customers < 100 AND Boxes < 100;


-- What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?
SELECT * FROM people;
SELECT * FROM sales;

SELECT DISTINCT p.Salesperson
FROM people p
INNER JOIN sales s
ON p.SPID = s.SPID
WHERE s.SaleDate BETWEEN '2022-01-01' AND '2022-01-07';

-- Which salespersons did not make any shipments in the first 7 days of January 2022?
SELECT DISTINCT p.Salesperson 
FROM people p 
WHERE p.SPID NOT IN(
SELECT DISTINCT s.SPID 
FROM sales s
WHERE s.SaleDate BETWEEN '2022-01-01' AND '2022-01-07');

-- How many times we shipped more than 1,000 boxes in each month?
SELECT YEAR(SaleDate)`Year`, MONTHNAME(SaleDate)`Month`, count(*)`Times We Shipped More Than 1K boxes`
FROM sales
WHERE boxes > 1000
GROUP BY YEAR(SaleDate), MONTHNAME(SaleDate)
ORDER BY YEAR(SaleDate), MONTHNAME(SaleDate);

-- Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months?
SELECT * FROM sales;
SELECT * FROM geo;
SELECT * FROM products;

SET @product_name = 'After Nines';
SET @country_name = 'New Zealand';

SELECT YEAR(SaleDate)`Year`, MONTHNAME(SaleDate)`Month`,
IF(sum(boxes) > 1, 'Yes','No')`Status`
FROM sales s INNER JOIN geo g
ON s.GeoID = g.GeoID
INNER JOIN products p 
ON s.PID = p.PID
WHERE p.Product = @product_name 
AND g.Geo = @country_name
GROUP BY YEAR(SaleDate), MONTHNAME(SaleDate)
ORDER BY YEAR(SaleDate), MONTHNAME(SaleDate);

-- India or Australia? Who buys more chocolate boxes on a monthly basis?
SELECT * FROM sales;
SELECT * FROM geo;

select year(saledate) `Year`, monthname(saledate) `Month`,
sum(CASE WHEN g.geo='India' = 1 THEN boxes ELSE 0 END) `India Boxes`,
sum(CASE WHEN g.geo='Australia' = 1 THEN boxes ELSE 0 END) `Australia Boxes`
from sales s
join geo g on g.GeoID=s.GeoID
group by year(saledate), month(saledate)
order by year(saledate), month(saledate);
