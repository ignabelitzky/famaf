USE sakila

-- Ejercicio 1
-- Cree una tabla de `directors` con las columnas: Nombre, Apellido, Número de Películas.
DROP TABLE IF EXISTS `directors`;
CREATE TABLE `directors` (
	`director_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`first_name` VARCHAR(64) NOT NULL,
	`last_name` VARCHAR(64) NOT NULl,
	`no_of_films` INT NOT NULL,
	PRIMARY KEY (director_id),
	CONSTRAINT fk_director_actor_id FOREIGN KEY (director_id) REFERENCES actor (actor_id) ON DELETE CASCADE ON UPDATE CASCADE);


-- Ejercicio 2
-- El top 5 de actrices y actores de la tabla `actors` que tienen la mayor experiencia
-- (i.e. el mayor número de películas filmadas) son también directores de las películas
-- en las que participaron. Basados en esta información, inserten, utilizando una subquery
-- los valores correspondientes en la tabla `directors`.
INSERT INTO directors (first_name, last_name, no_of_films)
WITH most_experienced_performers AS (
	SELECT actor_id, COUNT(*) AS no_of_films
	FROM film_actor 
	GROUP BY (actor_id)
	ORDER BY no_of_films DESC 
	LIMIT 5
), most_experienced_performers_names AS (
	SELECT first_name, last_name, no_of_films
	FROM actor a1
		INNER JOIN most_experienced_performers a2
		ON (a1.actor_id = a2.actor_id)
) SELECT * FROM most_experienced_performers_names;


-- Ejercicio 3
-- Agregue una columna `premium_customer` que tendrá un valor 'T' o 'F' de acuerdo a si el
-- cliente es "premium" o no. Por defecto ningún cliente será premium.
ALTER TABLE customer
ADD COLUMN premium_customer ENUM('T', 'F') NOT NULL DEFAULT 'F';


-- Ejercicio 4
-- Modifique la tabla customer. Marque con 'T' en la columna `premium_customer` de los 10
-- clientes con mayor dinero gastado en la plataforma.
UPDATE customer SET customer.premium_customer = 'T'
WHERE customer.customer_id IN (
	SELECT premium.customer_id
	FROM (
		SELECT customer_id, SUM(amount) AS total_spent
		FROM payment
		GROUP BY customer_id
		ORDER BY total_spent DESC
		LIMIT 10
	) AS premium
);


-- Ejercicio 5
-- Listar, ordenados por cantidad de películas (de mayor a menor), los distintos ratings de las
-- películas existentes (Hint: rating se refiere en este caso a la clasificación
-- según edad: G, PG, R, etc).
SELECT rating, COUNT(*) AS amount
FROM film
GROUP BY rating
ORDER BY amount DESC;


-- Ejercicio 6
-- ¿Cuáles fueron la primera y última fecha donde hubo pagos?
SELECT MIN(payment_date) AS opening, MAX(payment_date) AS closing 
FROM payment;

-- Otra forma
(SELECT payment.payment_date
FROM payment
WHERE payment_date = (SELECT MIN(payment.payment_date) FROM payment))
UNION
(SELECT payment.payment_date
FROM payment
WHERE payment_date = (SELECT MAX(payment.payment_date) FROM payment));


-- Ejercicio 7
-- Calcule, por cada mes, el promedio de pagos (Hint: vea la manera de extraer el nombre del mes de una fecha).
SELECT MONTHNAME(payment.payment_date) AS monthDate, AVG(payment.amount)
FROM payment
GROUP BY monthDate;


-- Ejercicio 8
-- Listar los 10 distritos que tuvieron mayor cantidad de alquileres (con la cantidad total de alquileres).
WITH rental_districts AS (
	SELECT rental_id, c.customer_id, district
	FROM rental r
		INNER JOIN customer c ON (r.customer_id = c.customer_id)
		INNER JOIN address a ON (c.address_id = a.address_id)
)
SELECT district, COUNT(*) AS total_rentals
FROM rental_districts
GROUP BY district
ORDER BY total_rentals DESC
LIMIT 10;


-- Ejercicio 9
-- Modifique la table `inventory_id` agregando una columna `stock` que sea un número entero y representa la
-- cantidad de copias de una misma película que tiene determinada tienda. El número por defecto debería ser 5 copias.
ALTER TABLE inventory
ADD COLUMN stock INT NOT NULL DEFAULT 5;


-- Ejercicio 10
-- Cree un trigger `update_stock` que, cada vez que se agregue un nuevo registro a la tabla rental, haga un update en la tabla
-- `inventory` restando una copia al stock de la película rentada (Hint: revisar que el rental no tiene información directa sobre
-- la tienda, sino sobre el cliente, que está asociado a una tienda en particular).





