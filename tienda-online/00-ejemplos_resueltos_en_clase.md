# Ejemplos resueltos en la BBDD tiendaonline_completa.

USE tienda_online; -- Para indicar en qué base de datos vamos a trabajar.

## 1) Selección básica de datos y renombrado de columnas

-- Listado simple de nombres y correos de todos los clientes.

SELECT nombre, email -- la columna de la tabla de la BBDD se llama email, no correo, y pongo * para seleccionar todo SELECT *
FROM clientes;

-- Catálogo: nombre y precio de todos los productos.

show tables; -- para ver las tablas
explain productos; -- para ver qué columnas hay

-- SOLUCIÓN
SELECT nombre, precio
FROM productos; 

-- Pedidos con su fecha y estado.
explain pedidos;

SELECT fecha_pedido, estado
FROM pedidos;

-- Pagos: método y monto registrados.

explain pagos;

SELECT metodo_pago, total_pagado
FROM pagos;

-- Detalle de líneas: producto y cantidad por cada detalle_pedido.

show tables;
explain detalle_pedido;

SELECT id_producto, cantidad
FROM detalle_pedido;

-- Clientes con fecha de registro (orden natural de inserción).
-- Lo que te pidan o lo que tu consideres en un momento dado. Lo del orden de inserción es el orden por defecto, y las tablas salen ordenadas por meterlo
-- si quisiera ordenar utilizo ORDER BY al final de la query.
explain clientes;
SELECT nombre, fecha_registro
FROM clientes;

SELECT nombre, fecha_registro FROM clientes ORDER BY fecha_registro DESC; -- ASC también podría ser claro.
-- Productos con su categoría asociada (solo columnas principales).

explain productos;
SELECT nombre, categoria
FROM productos;

-- IDs de pedidos y su total.

explain pedidos;
SELECT id_pedido, coste_total
FROM pedidos;

-- IDs de pagos con su fecha de pago.

explain pagos;

SELECT id_pago, fecha_pago
FROM pagos;

-- Relación básica: id_pedido e id_producto de detalle_pedido.

SELECT id_pedido, id_producto
FROM detalle_pedido;


## 2) Filtros con WHERE (comparadores, lógicos, BETWEEN, IN, LIKE, NULL)

-- Clientes registrados en 2024.

SELECT * FROM clientes WHERE YEAR (fecha_registro) = 2024;

-- Productos con precio > 200.

SELECT * FROM productos; -- VER LAS COLUMNAS 
SELECT * FROM productos WHERE precio>200;

-- Pedidos con estado = 'pendiente' y total > 500.

SELECT * FROM pedidos; -- VER LAS COLUMNAS 
SELECT * FROM pedidos WHERE estado = 'pendiente' AND coste_total >500; -- coge la tabla pedidos los saca y va linea a linea si es o no pendiente y luego comprueba si es mayor de 500
-- OJO CON LOS TIPOS DE DATOR: '10' < '2' pero 10 > 2

-- Pagos cuyo método IN ('tarjeta','paypal'). 

explain pagos;
SELECT * FROM pagos WHERE metodo_pago = 'tarjeta' OR metodo_pago = 'paypal';
	-- otra alternativa de resolución 
    SELECT * FROM pagos WHERE metodo_pago IN ('tarjeta', 'paypal');
    
-- Productos con stock entre 300 y 400.

SELECT * FROM productos WHERE stock >= 300 AND stock >= 400;
SELECT * FROM productos WHERE stock BETWEEN 300 AND 400; -- es otra manera de hacerlo más fácil
SELECT * FROM productos WHERE stock IN (300,400); -- AQUÍ SOLO SALEN LOS QUE TENGAN O 300 O 400


-- Clientes de país IN ('España','México','Argentina').

SELECT * FROM clientes WHERE pais IN ('España', 'México', 'Argentina');

-- Productos cuyo nombre contenga Silla.

SELECT * FROM productos WHERE nombre like '%silla%';
-- contenga -> %palabra%
-- empiece -> palabra%
-- termine -> %palabra
-- si usamos _illa (que empiece por un solo carácter, sea cual sea, y luego ya contenga illa, por lo que me encontraría milla por ejemplo si existiese. 

-- Pedidos con fecha_pedido en abril de 2023.

explain pedidos;
SELECT * FROM pedidos WHERE month (fecha_pedido) = 4 AND  year(fecha_pedido) = 2023; -- si voy con numeros uso el =  y si voy con letras pues uso el like
SELECT * FROM pedidos WHERE fecha_pedido LIKE '2023-04%'; -- esta es la primera opción que ha puesto el profesor pero no me gust tanto 

-- Pagos con fecha_pago IS NULL (simularía no pagados si existieran).

-- SELECT * FROM pagos WHERE fecha_pago = NULL; -- esto es algo que no funciona porque no puedes comparar con cosas que no existen claro... asi que usamos operador solo con el null
SELECT * FROM pagos WHERE fecha_pago is NULL; -- también podemos usar is not NULL.

-- Detalles donde cantidad sea 3 o más pero el precio_unitario menor que 50.

SELECT * FROM detalle_pedido
	WHERE cantidad >= 3 AND precio_unitario < 50;
-- 
## 3) Ordenación, límite y duplicados (ORDER BY, LIMIT, DISTINCT)

-- Top 10 productos más caros.
-- SELECT * FROM tienda_online.productos order by precio DESC;
SELECT 
    *
FROM
    tienda_online.productos
ORDER BY precio DESC
LIMIT 10;
-- Últimos 20 pedidos por fecha_pedido DESC.
SELECT * FROM pedidos ORDER BY fecha_pedido DESC LIMIT 20;
-- Clientes más recientes por fecha_registro.
SELECT * FROM clientes ORDER BY fecha_registro DESC;
-- Primeros 5 productos con menor stock.
-- DISTINCT de categorías de productos disponibles.
select DISTINCT categoria from productos; -- elimina filas duplicadas, vamos que me dice que es lo que tenemos en total

select DISTINCT is_producto,categoria from productos; -- Aquó no hay nada duplicado.

-- Países distintos de los clientes registrados.
SELECT DISTINCT pais FROM clientes;
-- Pagos ordenados por monto DESC (mayor a menor).
-- Pedidos ordenados por total ASC.
-- Primeros 10 clientes por orden alfabético del nombre.
SELECT * FROM clientes order by nombre ASC;
-- Top 5 productos más baratos en la categoría “Accesorios”.
SELECT 
    *
FROM
    productos
WHERE
    categoria = 'Accesorios'
ORDER BY precio ASC;


