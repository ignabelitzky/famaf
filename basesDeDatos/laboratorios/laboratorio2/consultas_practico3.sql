-- BBDD Laboratorio Practico III: Joins y conjuntos

Use world;

-- PARTE I - Consultas
-- Ejercicio 1
-- Lista el nombre de la ciudad, nombre del país, región y forma de gobierno de las 10 ciudades más pobladas del mundo.
SELECT city.Name as 'City Name', country.Name as 'Country Name', country.Region, city.Population, country.GovernmentForm
FROM country
	INNER JOIN city
	ON city.CountryCode = country.Code
ORDER BY city.Population DESC
LIMIT 10;


-- Ejercicio 2
-- Listar los 10 países con menor población del mundo, junto a sus ciudades capitales
-- (Hint: puede que uno de estos países no tenga ciudad capital asignada, en este caso deberá mostrar "NULL").
SELECT country.Name as 'Country Name', city.Name as 'Capital Name', country.Population
FROM country
	LEFT JOIN city
	ON country.Capital = city.ID
ORDER BY country.Population ASC
LIMIT 10;


-- Ejercicio 3
-- Listar el nombre, continente y todos los lenguajes oficiales de cada país.
-- (Hint: habrá más de una fila por país si tiene varios idiomas oficiales).
SELECT country.Name as 'Country Name', continent.Name as 'Continent Name', countrylanguage.Lang as 'Language'
FROM country, continent
	INNER JOIN countrylanguage
	ON countrylanguage.IsOfficial = 'T'
WHERE countrylanguage.CountryCode = country.Code and country.Continent = continent.Name;


-- Ejercicio 4
-- Listar el nombre del país y nombre de capital, de los 20 países con mayor superficie del mundo.
SELECT country.Name as 'Country Name', city.Name as 'Capital Name'
FROM country
	INNER JOIN city
	ON country.Capital = city.ID
ORDER BY country.Population DESC 
LIMIT 20;


-- Ejercicio 5
-- Listar las ciudades junto a sus idiomas oficiales (ordenado por la población de la ciudad)
-- y el porcentaje de hablantes del idioma.
SELECT city.Name, countrylanguage.Lang, country.Population, countrylanguage.Percentage 
FROM city
	INNER JOIN countrylanguage
	ON countrylanguage.IsOfficial = 'T' and countrylanguage.CountryCode = city.CountryCode 
ORDER BY city.Population DESC, countrylanguage.Percentage DESC;


-- Ejercicio 6
-- Listar los 10 países con mayor población y los 10 países con menor población
-- (que tengan al menos 100 habitantes) en la misma consulta.
(SELECT country.Name as 'Country Name', country.Population
FROM country
WHERE country.Population > 99
ORDER BY country.Population DESC
LIMIT 10)
UNION
(SELECT country.Name, country.Population
FROM country
WHERE country.Population > 99
ORDER BY country.Population ASC
LIMIT 10);


-- Ejercicio 7
-- Listar aquellos países cuyos lenguajes oficiales son el Inglés y el Francés
-- (Hint: no debería haber filas duplicadas).
SELECT country.Name AS 'Country Name'
FROM country
	INNER JOIN countrylanguage
	ON (countrylanguage.Lang = 'English' or countrylanguage.Lang = 'French') and countrylanguage.IsOfficial = 'T'
		and countrylanguage.CountryCode = country.Code
GROUP BY Name
ORDER BY country.Name ASC;


-- Ejercicio 8
-- Listar aquellos países que tengan hablantes del Inglés pero no del Español en su población.
