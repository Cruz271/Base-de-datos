use sakila;

-- ojo que hay copias físicas que no se han devuelto.
SELECT * 
FROM inventory JOIN rental USING(inventory_id) where inventory_id = 2047;

-- 1) Saca el listado de copias físicas de películas que nunca han sido alquiladas.
SELECT * 
FROM inventory LEFT JOIN rental USING(inventory_id)
WHERE rental_id IS NULL;

-- Comprobaciones para asegurar que lo estoy haciendo bien porque todavía no sé mucho SQL.
SELECT * 
FROM inventory LEFT JOIN rental USING(inventory_id)
WHERE inventory_id = 5;

SELECT * 
FROM rental 
where inventory_id = 5;
-- Conclusión: correcto, la copia física 5 no se ha alquilado.



-- 3) Saca el listado de los nombres de películas que no tienen copias físicas.
SELECT * 
FROM film LEFT JOIN inventory USING(film_id)
where inventory_id is null;

SELECT * 
FROM inventory where film_id = 38;


-- Preguntas:
-- a) ¿La peli 14 tiene algún rental?
SELECT *
-- FROM rental LEFT|RIGHT JOIN inventory USING(inventory_id)
WHERE film_id = 14;

SELECT *
FROM rental RIGHT JOIN inventory USING(inventory_id)
WHERE film_id = 14;

SELECT *
FROM rental LEFT JOIN inventory USING(inventory_id)
WHERE film_id = 14;


-- 2) Saca el listado de los nombres de películas que nunca han sido alquiladas

-- Academy dinosaur que no tiene rental_id pero sí inventory_id
-- La film_id 14,33,36,38... todas las de la consulta anterior

SELECT f.film_id,f.title,i.inventory_id,i.film_id,r.rental_id,r.inventory_id
FROM
	film f LEFT JOIN inventory i ON f.film_id = i.film_id
			LEFT JOIN rental r ON r.inventory_id = i.inventory_id
WHERE rental_id is null;
-- la solución buena es esta: 
SELECT f.film_id, f.title,COUNT(rental_id)
FROM film f LEFT JOIN inventory i ON f.film_id = i.film_id
			LEFT JOIN rental r ON r.inventory_id = i.inventory_id
            GROUP BY f.film_id
            HAVING COUNT(rental_id) = 0;
    
-- SIMULACRO EXAMEN A 
-- CONSULTA 1:  
SELECT rating, count(rating), ROUND(AVG(length), 1) FROM film GROUP BY rating ORDER BY rating ASC;
-- CONSULTA 2: 
SELECT CONCAT(first_name," ",last_name) AS name, city, length( CONCAT(first_name," ",last_name)) AS longitud_nombre FROM customer JOIN address USING(address_id) JOIN city USING(city_id) WHERE LENGTH( CONCAT(first_name," ",last_name)) >= 14 GROUP BY customer_id ORDER BY length( CONCAT(first_name," ",last_name))DESC, concat(first_name," ",last_name) ASC ;
-- CONSULTA 3: 
SELECT name, COUNT(film_id), ROUND(AVG(length), 1) FROM film JOIN film_category USING(film_id) JOIN category USING(category_id) WHERE rating like  "PG-13" GROUP BY category_id ORDER BY COUNT(film_id) DESC;
-- CONSULTA 4: 
SELECT CONCAT(first_name," ",last_name), COUNT(film_id) FROM actor JOIN film_actor USING(actor_id) JOIN film USING(film_id) WHERE last_name LIKE 'S%' GROUP BY actor_id HAVING COUNT(film_id) >= 15 ORDER BY COUNT(film_id) DESC;
-- CONSULTA 5:
SELECT concat(first_name," ",last_name), YEAR(payment_date), MONTH(payment_date), COUNT(payment_id), COUNT(customer_id), round(sum(amount), 2) FROM staff JOIN payment USING(staff_id) GROUP BY staff_id,first_name,last_name,year(payment_date),month(payment_date);


-- Consulta 1: Películas por clasificación
SELECT rating AS clasificacion, COUNT(*) AS peliculas, ROUND(AVG(length),1) AS duracion_media FROM film GROUP BY rating ORDER BY rating;

-- Consulta 2: Clientes y ciudades
SELECT CONCAT(c.first_name,' ',c.last_name) AS nombre_completo, ci.city AS ciudad, CHAR_LENGTH(CONCAT(c.first_name,' ',c.last_name)) AS longitud_nombre FROM customer c JOIN address a ON c.address_id=a.address_id JOIN city ci ON a.city_id=ci.city_id WHERE CHAR_LENGTH(CONCAT(c.first_name,' ',c.last_name))>=14 ORDER BY longitud_nombre DESC,nombre_completo ASC;

-- Consulta 3: Películas PG-13 por categoría
SELECT ca.name AS categoria, COUNT(*) AS peliculas, ROUND(AVG(f.length),1) AS duracion_media FROM film f JOIN film_category fc ON f.film_id=fc.film_id JOIN category ca ON fc.category_id=ca.category_id WHERE f.rating='PG-13' GROUP BY ca.category_id,ca.name ORDER BY peliculas DESC,categoria ASC;

-- Consulta 4: Actores con muchas películas
SELECT a.first_name AS nombre,a.last_name AS apellido,COUNT(*) AS peliculas FROM actor a JOIN film_actor fa ON a.actor_id=fa.actor_id WHERE a.last_name LIKE 'S%' GROUP BY a.actor_id,a.first_name,a.last_name HAVING COUNT(*)>=15 ORDER BY peliculas DESC,apellido ASC;

-- Consulta 5: Cobros mensuales por empleado
SELECT s.first_name AS nombre,s.last_name AS apellido,YEAR(p.payment_date) AS anio,MONTH(p.payment_date) AS mes,COUNT(*) AS pagos,COUNT(DISTINCT p.customer_id) AS clientes,ROUND(SUM(p.amount),2) AS importe_total FROM staff s JOIN payment p ON s.staff_id=p.staff_id GROUP BY s.staff_id,s.first_name,s.last_name,YEAR(p.payment_date),MONTH(p.payment_date) ORDER BY anio,mes,apellido,nombre;
