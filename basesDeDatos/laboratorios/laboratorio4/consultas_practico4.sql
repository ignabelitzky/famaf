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
  `Language` char(30) NOT NULL DEFAULT '',
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
FROM city
	INNER JOIN country ON city.CountryCode = country.Code
WHERE city.Population < 10000
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
INNER JOIN country ON country.Code = city.CountryCode AND country.Continent <> 'Asia'
WHERE city.Population >=
	(SELECT MIN(country.Population) FROM country
	WHERE country.Continent = 'Asia');


-- Ejercicio 4
-- Listar aquellos países junto a sus idiomas no oficiales, que superen en
-- porcentaje de hablantes a cada uno de los idiomas oficiales del país.
