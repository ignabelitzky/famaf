CREATE TABLE country (
	Code VARCHAR(255) PRIMARY KEY,
	Name VARCHAR(255),
	Continent VARCHAR(255),
	Region VARCHAR(255),
	SurfaceArea INT,
	IndepYear INT,
	Population INT,
	LifeExpectancy INT,
	GNP INT,
	GNPOld INT,
	LocalName VARCHAR(255),
	GovernmentForm VARCHAR(255),
	HeadOfState VARCHAR(255),
	Capital INT,
	Code2 VARCHAR(255)
);

CREATE TABLE city (
	ID INT PRIMARY KEY,
	Name VARCHAR(255),
	CountryCode VARCHAR(255),
	District VARCHAR(255),
	Population INT,
	FOREIGN KEY (CountryCode) REFERENCES country(Code)
);

CREATE TABLE countrylanguage (
	CountryCode VARCHAR(255),
	Lang VARCHAR(255),
	IsOfficial VARCHAR(255),
	Percentage FLOAT,
	PRIMARY KEY (CountryCode, Lang),
	FOREIGN KEY (CountryCode) REFERENCES country(Code)
);

CREATE TABLE continent (
	Name VARCHAR(255) PRIMARY KEY,
	Area INT,
	Porcentage FLOAT,
	MostPopulatedCity INT,
	FOREIGN KEY (MostPopulatedCity) REFERENCES city(ID)
);
