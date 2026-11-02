USE tienda_online;
show tables;
explain productos;
-- Numéricas
-- 5.1. Obtener la longitud del nombre de cada cliente
SELECT length(nombre) FROM clientes;
-- 5.2. Obtener el total de pedidos realizados
SELECT  COUNT(*) FROM pedidos;
-- 5.3. Obtener el precio promedio de los productos
SELECT AVG(precio) AS precio_promedio FROM productos;
-- 5.4. Obtener el precio más bajo de los productos
SELECT MIN(precio) AS precio_más_bajo FROM productos;
-- 5.5. Obtener el precio más alto de los productos
SELECT MAX(precio) AS precio_más_bajo FROM productos;
-- Funciones de cadena
-- 5.6. Convertir el nombre de los productos a mayúsculas
SELECT UPPER(nombre) FROM productos;
-- 5.7. Convertir el nombre de los clientes a minúsculas
SELECT lower(nombre) FROM productos;
-- 5.8. Obtener los primeros 3 caracteres del nombre de cada producto
SELECT LEFT(nombre, 3) FROM productos;
-- 5.9. Obtener los últimos 3 caracteres del nombre de cada producto
SELECT right(nombre, 3) FROM productos;
-- Funciones de fecha
-- 5.10. Obtener la fecha de hoy
SELECT NOW();
-- 5.11. Calcular cuántos días han pasado desde el registro de cada cliente hasta hoy
SELECT nombre, DATEDIFF(NOW(), fecha_registro) AS dias_pasados FROM clientes;