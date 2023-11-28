USE northwind;

-- Create a report showing OrderDate, ShippedDate, CustomerID, Freight of all orders placed on 21 May 1996.
SELECT OrderDate, ShippedDate, CustomerID, Freight
FROM orders
WHERE OrderDate = '1996-05-21';

-- How many customers do we have in our database?
SELECT count(*)`Number of Customers` 
FROM customers;

-- How many of our customer names begin with the letter "b"?
SELECT * FROM customers
WHERE CompanyName LIKE 'B%';

-- How many of our customer names contain the letter "s" ?
SELECT * FROM customers
WHERE CompanyName LIKE '%s%';

-- How many customers do we have in each city?
SELECT City, count(*)`Number of Customers` 
FROM customers
WHERE City IS NOT NULL
GROUP BY city
ORDER BY `Number of Customers` DESC;

-- What are the top three cities where we have our most customers?
SELECT City, count(*)`Number of Customers` 
FROM customers
WHERE City IS NOT NULL
GROUP BY city
ORDER BY `Number of Customers` DESC
LIMIT 3;

-- Who has been our top customer - please list CustomerID, CompanyName, ContactName for the customer that we have sold the most to?
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM orderdetails;

WITH total_sales as(
SELECT o.CustomerID,
sum(od.UnitPrice * od.Quantity)`Total Sales`
FROM orders o INNER JOIN orderdetails od
ON o.OrderID = od.OrderID
GROUP BY o.CustomerID
ORDER BY `Total Sales` DESC
LIMIT 1
) SELECT c.CustomerID, 
c.CompanyName, c.ContactName
FROM customers c INNER JOIN
total_sales t
ON c.CustomerID = t.CustomerID;


-- Who has been our top customer - please list CustomerID, CompanyName in the year 1997?
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM orderdetails;

WITH total_sales AS (SELECT o.CustomerID AS CustomerID, 
sum(od.UnitPrice*od.Quantity) AS TotalSales
FROM orders o INNER JOIN orderdetails od
ON o.OrderID = od.OrderID
WHERE YEAR(OrderDate) = 1997
GROUP BY o.CustomerID
ORDER BY TotalSales DESC
LIMIT 1)
SELECT c.CustomerID, c.CompanyName
FROM customers c INNER JOIN total_sales t
ON c.CustomerID = t.CustomerID;

-- Name the top 3 countries that we ship our orders to?
SELECT * FROM orders;
SELECT * FROM orderdetails;

SELECT ShipCountry, count(*)NumberOfOrders
FROM orders 
GROUP BY ShipCountry
ORDER BY NumberOfOrders DESC;

-- Which shipper do we use the most to ship our orders out through?
SELECT ShipName, count(*)NumberOfOrders
FROM orders
GROUP BY ShipName
ORDER BY NumberOfOrders DESC;

-- List the following employee information (EmployeeID, LastName, FirstName, ManagerLastName, ManagerFirstName)
SELECT EmployeeID, LastName, FirstName, Title
FROM employees
WHERE Title LIKE '%Manager%';

-- What are the last names of all employees who were born in the month of November?
SELECT LastName
FROM employees
WHERE MONTHNAME(BirthDate) = 'November';

-- List each employee (lastname, firstname, territory) and sort the list by territory 
-- and then by employee last name. Remember employees may work for more than one territory.
SELECT * FROM employees;
SELECT * FROM territories;
SELECT * FROM employeeterritories;

SELECT e.LastName, e.FirstName, t.TerritoryDescription AS Territory
FROM employees e INNER JOIN employeeterritories et
ON e.EmployeeId = et.EmployeeID
INNER JOIN territories t 
ON t.TerritoryID = et.TerritoryID
ORDER BY Territory, e.LastName;

-- In terms of sales value, what has been our best selling product of all time?
SELECT * FROM products;
SELECT * FROM orderdetails;

SELECT p.ProductName,
sum(od.UnitPrice*od.Quantity)TotalSales
FROM products p INNER JOIN
orderdetails od ON 
p.ProductID = od.ProductID
GROUP BY od.ProductID
ORDER BY TotalSales DESC
LIMIT 1;

-- In terms of sales value, and only include products that have at least been sold once, which has been our worst selling product of all time? 
SELECT p.ProductName,
sum(od.UnitPrice*od.Quantity)TotalSales
FROM products p INNER JOIN
orderdetails od ON 
p.ProductID = od.ProductID
GROUP BY od.ProductID
ORDER BY TotalSales
LIMIT 1;

-- 
