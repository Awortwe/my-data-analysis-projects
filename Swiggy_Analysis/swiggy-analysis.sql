-- HOW MANY RESTAURANTS HAVE A RATING GREATER THAN 4.5?
SELECT count(*)`Number of Restaurants` 
FROM swiggy
WHERE rating > 4.5;

-- WHICH IS THE TOP 1 CITY WITH THE HIGHEST NUMBER OF RESTAURANTS?
SELECT city, count(*)`Number of Restaurants` 
FROM swiggy
GROUP BY city
ORDER BY `Number of Restaurants` DESC
LIMIT 1;

-- HOW MANY RESTAURANTS HAVE THE WORD "PIZZA" IN THEIR NAME?
SELECT count(*)`Number of Pizza Restaurants`
FROM swiggy
WHERE restaurant_name LIKE '%Pizza%';

-- WHAT IS THE MOST COMMON CUISINE AMONG THE RESTAURANTS IN THE DATASET?
SELECT cuisine, count(*)`number` 
FROM swiggy
GROUP BY cuisine
ORDER BY `number` DESC;

-- WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY?
SELECT restaurant_name, city,
round(avg(rating),2)`Average Rating`
FROM swiggy
GROUP BY restaurant_name, city
ORDER BY `Average Rating` DESC;

-- WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'RECOMMENDED' MENUCATEGORY FOR EACH RESTAURANT?
SELECT max(price)`Highest Price` 
FROM swiggy
WHERE menu_category = 'Recommended';

-- FIND THE TOP 5 MOST EXPENSIVE RESTAURANTS THAT OFFER CUISINE OTHER THAN INDIAN CUISINE.
SELECT DISTINCT restaurant_name, cost_per_person
FROM swiggy
WHERE cuisine <> 'Indian'
ORDER BY cost_per_person DESC
LIMIT 5;

-- FIND THE RESTAURANTS THAT HAVE AN AVERAGE COST WHICH IS HIGHER THAN THE TOTAL AVERAGE COST OF ALL RESTAURANTS TOGETHER.
SELECT restaurant_name, cost_per_person
FROM swiggy
WHERE cost_per_person >
(SELECT avg(cost_per_person) 
FROM swiggy);

-- RETRIEVE THE DETAILS OF RESTAURANTS THAT HAVE THE SAME NAME BUT ARE LOCATED IN DIFFERENT CITIES.
SELECT DISTINCT t1.restaurant_name,
t1.city, t2.city
FROM swiggy t1  JOIN swiggy t2
ON t1.restaurant_name = t2.restaurant_name
AND t1.city <> t2.city;

-- WHICH RESTAURANT OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE'CATEGORY?
SELECT restaurant_name, count(item)`Number of items`
FROM swiggy
WHERE menu_category = 'Main Course'
GROUP BY restaurant_name
ORDER BY `Number of items` DESC
LIMIT 1; 

-- LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGEATARIAN IN ALPHABETICAL ORDER OF RESTAURANT NAME.
SELECT DISTINCT restaurant_name,
(count(CASE WHEN veg_or_nonveg = 'Veg' THEN 1 END)*100/count(*)) AS vegetarian_percentage
FROM swiggy
GROUP BY restaurant_name
HAVING  vegetarian_percentage = 100.00
ORDER BY restaurant_name;



-- WHICH IS THE RESTAURANT PROVIDING THE LOWEST AVERAGE PRICE FOR ALL ITEMS?
SELECT restaurant_name, round(avg(price), 2)`Average Price`
FROM swiggy
GROUP BY restaurant_name
ORDER BY `Average Price`
LIMIT 1;


-- WHICH TOP 5 RESTAURANT OFFERS HIGHEST NUMBER OF CATEGORIES?
SELECT DISTINCT restaurant_name, count(DISTINCT menu_category)`Number of Category` 
FROM swiggy
GROUP BY restaurant_name
ORDER BY `Number of Category` DESC
LIMIT 5;

-- WHICH RESTAURANT PROVIDES THE HIGHEST PERCENTAGE OF NON-VEGEATARIAN FOOD?
SELECT DISTINCT restaurant_name,
(count(CASE WHEN veg_or_nonveg = 'Non-veg' THEN 1 END)*100/count(*)) AS `Non-veg Percentage`
FROM swiggy
GROUP BY restaurant_name
ORDER BY `Non-veg Percentage` DESC
LIMIT 1;

USE swiggy;

SELECT * FROM swiggy;
