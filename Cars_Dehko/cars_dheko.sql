CREATE DATABASE IF NOT EXISTS carsDatabase;
USE carsDatabase;

-- Read Cars Data
SELECT * FROM cars;

-- Total Cars: To get count of the total records
SELECT count(*)'Total Cars'
FROM cars;

-- The manager asked the employee, how many cars will be available in 2023?
SELECT * FROM cars;
SELECT year, count(*)TotalCars
FROM cars
GROUP BY year
HAVING year = 2023;

-- The manager asked the employee, how many cars will be available in 2020, 2021,2022?
SELECT year, count(*)TotalCars
FROM cars
GROUP BY year
HAVING year IN(2020, 2021, 2022)
ORDER BY TotalCars DESC;

-- Client asked me to print the total of all cars by year. I don't see all the details
SELECT year, count(*)TotalCars
FROM cars
GROUP BY year
ORDER BY TotalCars DESC;

-- Client asked for the number of diesel cars in 2020
SELECT * FROM cars;

SELECT year, count(*)TotalDieselCars
FROM cars
GROUP BY year, fuel
HAVING fuel = 'Diesel' AND year = 2020; 

-- Client asked for the number of petrol cars in 2020
SELECT year, count(*)TotalPetrolCars
FROM cars
GROUP BY year, fuel
HAVING year = 2020 AND fuel = 'Petrol';

-- The manager told the employee to give a print All fuel cars(petrol, diesel, CNG) come by all year.
SELECT * FROM cars;
SELECT Fuel, Year, count(*)NumberOfCars
FROM cars
GROUP BY Fuel, Year;

-- Manager said there more than 100 cars in a given year, which year had more than 100 cars
SELECT Year, count(*)TotalCars
FROM cars
GROUP BY Year
HAVING TotalCars > 100
ORDER BY TotalCars DESC;

-- The manager said to the employee All cars count details between 2015 and 2023; we need a complete list.
SELECT Year, count(*)TotalCars 
FROM cars
GROUP BY Year
HAVING Year BETWEEN 2015 AND 2023;

-- The manager said to the employee All cars details between 2015 and 2023; we need a complete list.
SELECT * FROM cars
WHERE Year BETWEEN 2015 AND 2023;

-- END --