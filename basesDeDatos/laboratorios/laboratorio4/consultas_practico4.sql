USE `world_p4`;

-- Country table
DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `Code` char(3) NOT NULL DEFAULT '',
  `Name` char(52) NOT NULL DEFAULT '',
  `Continent` enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') NOT NULL DEFAULT 'Asia',
  `Region` char(26) NOT NULL DEFAULT '',
  `SurfaceArea` decimal(10,2) NOT NULL DEFAULT '0.00',
  `IndepYear` smallint DEFAULT NULL,
  `Population` int NOT NULL DEFAULT '0',
  `LifeExpectancy` decimal(3,1) DEFAULT NULL,
  `GNP` decimal(10,2) DEFAULT NULL,
  `GNPOld` decimal(10,2) DEFAULT NULL,
  `LocalName` char(45) NOT NULL DEFAULT '',
  `GovernmentForm` char(45) NOT NULL DEFAULT '',
  `HeadOfState` char(60) DEFAULT NULL,
  `Capital` int DEFAULT NULL,
  `Code2` char(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- City table
DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` char(35) NOT NULL DEFAULT '',
  `CountryCode` char(3) NOT NULL DEFAULT '',
  `District` char(20) NOT NULL DEFAULT '',
  `Population` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `CountryCode` (`CountryCode`),
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`CountryCode`) REFERENCES `country` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Country language table
DROP TABLE IF EXISTS `countrylanguage`;
CREATE TABLE `countrylanguage` (
  `CountryCode` char(3) NOT NULL DEFAULT '',
  `Lang` char(30) NOT NULL DEFAULT '',
  `IsOfficial` enum('T','F') NOT NULL DEFAULT 'F',
  `Percentage` decimal(4,1) NOT NULL DEFAULT '0.0',
  PRIMARY KEY (`CountryCode`,`Language`),
  KEY `CountryCode` (`CountryCode`),
  CONSTRAINT `countryLanguage_ibfk_1` FOREIGN KEY (`CountryCode`) REFERENCES `country` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Practico 4 - Parte I - Consultas

-- Ejercicio 1
-- Listar el nombre de la ciudad y el nombre del país de todas las ciudades que pertenezcan
-- a países con una población menor a 10000 habitantes.
SELECT city.Name AS 'City name', country.Name AS 'Country name'
FROM country
	INNER JOIN city ON city.CountryCode = country.Code
WHERE country.Population < 10000
ORDER BY city.Name ASC;


-- Ejercicio 2
-- Listar todas aquellas ciudades cuya población sea mayor que la población
-- promedio entre todas las ciudades.
SELECT Name AS 'City name'
FROM city
WHERE city.Population >
(SELECT AVG(city.Population) FROM city)
ORDER BY Name ASC;
						

-- Ejercicio 3
-- Listar todas aquellas ciudades no asiáticas cuya población sea igual
-- o mayor a la población total de algún país de Asia.
SELECT city.Name AS 'City name'
FROM city
INNER JOIN country ON country.Code = city.CountryCode AND country.Continent != 'Asia'
WHERE city.Population >=
	SOME(SELECT (country.Population) FROM country
	WHERE country.Continent = 'Asia');

SELECT city.Name AS 'City name'
FROM city
INNER JOIN country ON country.Code = city.CountryCode AND country.Continent != 'Asia'
WHERE city.Population >=
	(SELECT MIN(country.Population) FROM country
	WHERE country.Continent = 'Asia');


-- Ejercicio 4
-- Listar aquellos países junto a sus idiomas no oficiales, que superen en
-- porcentaje de hablantes a cada uno de los idiomas oficiales del país.
SELECT country.Name, countrylanguage.Lang AS `Language`
FROM country
INNER JOIN countrylanguage ON country.Code = countrylanguage.CountryCode AND countrylanguage.IsOfficial = 'F'
WHERE countrylanguage.Percentage > ALL(SELECT countrylanguage.Percentage FROM countrylanguage WHERE countrylanguage.CountryCode = country.Code AND countrylanguage.IsOfficial = 'T');


-- Ejercicio 5
-- Listar (sin duplicados) aquellas regiones que tengan países con una superficie menor
-- a 1000 km2 y exista (en el país) al menos una ciudad con más de 100000 habitantes.
-- (Hint: Esto puede resolverse con o sin una subquery, intenten encontrar ambas respuestas).
SELECT DISTINCT country.Region
FROM country
INNER JOIN city ON country.Code = city.CountryCode AND country.SurfaceArea < 1000 AND city.Population > 100000;


-- Ejercicio 6
-- Listar el nombre de cada país con la cantidad de habitantes de su ciudad más poblada.
-- (Hint: Hay dos maneras de llegar al mismo resultado. Usando consultas escalares o usando
-- agrupaciones, encontrar ambas).
SELECT country.Name, city.Population
FROM country
INNER JOIN city ON country.Code = city.CountryCode
WHERE city.Population = (SELECT MAX(city.Population) FROM city WHERE country.Code = city.CountryCode)
ORDER BY Name ASC;


-- Ejercicio 7
-- Listar aquellos países y sus lenguajes no oficiales cuyo porcentaje de hablantes
-- sea mayor al promedio de hablantes de los lenguajes oficiales.
WITH officialPercent AS (
	SELECT CountryCode, AVG(Percentage) AS Percent
	FROM countrylanguage c
	WHERE IsOfficial = 'T'
	GROUP BY CountryCode
)
SELECT c.Name, l.Lang
FROM country c
	INNER JOIN countrylanguage l ON (c.Code = l.CountryCode)
	INNER JOIN officialPercent o ON (c.Code = o.CountryCode)
WHERE
	l.IsOfficial = 'F' AND
	l.Percentage > o.Percent
ORDER BY Name;

SELECT country.Name, countrylanguage.Lang FROM country
INNER JOIN countrylanguage ON country.Code = countrylanguage.CountryCode AND countrylanguage.IsOfficial = 'F'
WHERE countrylanguage.Percentage > (
	SELECT AVG(countrylanguage.Percentage) 
	FROM countrylanguage 
	WHERE countrylanguage.CountryCode = country.Code AND countrylanguage.IsOfficial = 'T');


-- Ejercicio 8
-- Listar la cantidad de habitantes por continente ordenado en forma descendiente.
SELECT country.Continent, SUM(country.Population) AS 'ContinentPopulation'
FROM country
GROUP BY country.Continent
ORDER BY ContinentPopulation DESC;


-- Ejercicio 9
-- Listar el promedio de esperanza de vida (LifeExpectancy) por continente
-- con una esperanza de vida entre 40 y 70 años.
SELECT AVG(country.LifeExpectancy) AS lifeExpectancy, country.Continent
FROM country
GROUP BY country.Continent
HAVING lifeExpectancy >= 40 AND lifeExpectancy <= 70;

-- Ejercicio 10
-- Listar la cantidad máxima, mínima, promedio y suma de habitantes por continente.
SELECT MAX(country.Population), MIN(country.Population), AVG(country.Population), SUM(country.Population), country.Continent
FROM country
GROUP BY country.Continent;


SELECT * FROM countrylanguage;
