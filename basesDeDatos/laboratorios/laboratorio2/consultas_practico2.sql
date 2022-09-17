-- Ejercicios Practico 2 - Parte II - Consultas

-- Ejercicio 1
SELECT Name, Region
FROM country
ORDER BY Name ASC, Region ASC;
	

-- Ejercicio 2
SELECT Name, Population
FROM city	
ORDER BY Population DESC
LIMIT 10;


-- Ejercicio 3
SELECT Name, Region, SurfaceArea, GovernmentForm
FROM country
ORDER BY SurfaceArea ASC
LIMIT 10;
	

-- Ejercicio 4
SELECT Name
FROM country
WHERE ISNULL(IndepYear) 
ORDER BY Name ASC;


-- Ejercicio 5
SELECT Name, Percentage
FROM countrylanguage
	INNER JOIN country
	ON countrylanguage.CountryCode = country.Code
	WHERE IsOfficial = 'T'
ORDER BY Name ASC;


-- Ejercicio 6
UPDATE countrylanguage
SET Percentage = 100
WHERE countrylanguage.CountryCode = 'AIA';


-- Ejercicio 7
SELECT Name AS 'City Name'
FROM city
WHERE District = 'Córdoba'
ORDER BY Name ASC;


-- Ejercicio 8
DELETE FROM city
WHERE District = 'Córdoba' AND CountryCode <> 'ARG';


-- Ejercicio 9
SELECT Name AS 'Country Name'
FROM country
WHERE HeadOfState REGEXP 'John'
ORDER BY Name ASC;


-- Ejercicio 10
SELECT Name AS 'Country Name', Population
FROM country
WHERE Population > 35000000 AND Population < 45000000
ORDER BY Population DESC;


	















