USE tienda_online;
# CLIENTES
## 1) Número total de clientes
SELECT COUNT(*) FROM clientes;
## 2) Número de clientes por país
SELECT pais, count(id_cliente) FROM clientes group by pais;
## 3) Número de clientes registrados por año
SELECT YEAR(fecha_registro), count(id_cliente) FROM clientes group by YEAR(fecha_registro);
## 4) Número de clientes registrados por mes (todas las fechas)
SELECT MONTH(fecha_registro), count(id_cliente) FROM clientes group by 	MONTH(fecha_registro) ORDER BY MONTH(fecha_registro) ASC;
-- ahora quiero sacarlo separandolo
SELECT YEAR(fecha_registro), MONTH(fecha_registro), count(id_cliente) FROM clientes GROUP BY YEAR(fecha_registro), MONTH(fecha_registro) ORDER BY YEAR(fecha_registro) ASC, MONTH(fecha_registro) ASC;
-- EN UNA CONSULTA DE GRUOP BY LO QUE HAY EN EL SELECT TIENE QUE ESTAR AGRUPADO (ES DECIR, EN EL GROUP BY) O AGREGADO (COUNT, AVG, MIN, MAX....)
## 5) Fecha de primer y último cliente registrado
SELECT min(fecha_registro), max(fecha_registro) FROM clientes;
## 6) Número de países distintos con clientes
SELECT COUNT(DISTINCT pais) FROM clientes;
-- pero el distinct se puede conseguir con un group by
SELECT count(*) FROM (SELECT pais FROM clientes GROUP BY pais);
## 7) Conteo de clientes con email y sin email
SELECT * FROM clientes;
explain clientes;
SELECT count(email) FROM clientes where email like '%@%';

SELECT COUNT(email) AS tiene_email FROM clientes GROUP BY right(email, 3);

SELECT REPLACE(RIGHT(email, 3), 'com', 'si') AS tiene_email, COUNT(email) FROM clientes GROUP BY REPLACE(RIGHT(email, 3), 'com', 'si');

## 8) Distribución de clientes por primera letra del nombre
SELECT 
    LEFT(nombre, 1), COUNT(*)
FROM
    clientes
GROUP BY LEFT(nombre, 1)
ORDER BY LEFT(nombre, 1);
# PRODUCTOS
explain productos;
## 9) Número total de productos
SELECT 
    COUNT(*)
FROM
    productos;
## 10) Número de productos por categoría
SELECT 
    categoria, COUNT(*) AS numero_productos
FROM
    productos
GROUP BY categoria;
## 11) Precio promedio de productos
SELECT 
    ROUND(AVG(precio), 2)
FROM
    productos;
## 12) Precio mínimo y máximo de productos
SELECT 
    MIN(PRECIO) AS precio_minimo, MAX(precio) AS precio_máximo
FROM
    productos;
## 13) Stock total de productos
SELECT 
    SUM(stock)
FROM
    productos;
## 14) Stock total por categoría
SELECT 
    categoria, SUM(stock) AS stock_acumulado
FROM
    productos
GROUP BY categoria;
## 15) Valor de inventario total (stock * precio)
SELECT 
    SUM(precio * stock)
FROM
    productos;
## 16) Valor de inventario por categoría
SELECT 
    categoria, SUM(precio)
FROM
    productos
GROUP BY categoria;
# PEDIDOS
## 18) Número total de pedidos
SELECT 
    COUNT(*)
FROM
    pedidos;
## 19) Número de pedidos por estado
SELECT 
    estado, COUNT(*)
FROM
    pedidos
GROUP BY estado;
## 20) Total facturado (suma de la columna total)
SELECT 
    SUM(coste_total)
FROM
    pedidos;
## 21) Promedio del total de pedidos
SELECT 
    AVG(coste_total)
FROM
    pedidos;
## 22) Pedido de mayor y menor importe
SELECT 
    MAX(coste_total) AS mas_caro, MIN(coste_total) AS mas_barato
FROM
    pedidos;
## 23) Número de pedidos por año
SELECT 
    COUNT(*), YEAR(fecha_pedido)
FROM
    pedidos
GROUP BY YEAR(fecha_pedido);
-- da igual la columna que cuentes
## 24) Total facturado por año
SELECT 
    SUM(coste_total) AS facturado, YEAR(fecha_pedido) AS año
FROM
    pedidos
GROUP BY YEAR(fecha_pedido);
## 25) Número de pedidos por mes de todos los años
SELECT 
    COUNT(*) AS num_pedidos, MONTH(fecha_pedido) AS mes
FROM
    pedidos
GROUP BY MONTH(fecha_pedido)
ORDER BY MONTH(fecha_pedido) ASC;
-- bonus track : num de pedidos agrupado por mes y por año
SELECT month(fecha_pedido), year(fecha_pedido),count(coste_total) from pedidos group by MONTH(fecha_pedido) , year(fecha_pedido) order by year(fecha_pedido), month(fecha_pedido);-- mirar el orden

## 26) Total facturado por estado
select estado, sum(coste_total) as facturado from pedidos group by estado;
## 27) Promedio del total por estado
select estado, avg(coste_total) as facturado_medio from pedidos group by estado;
# DETALLE_PEDIDO
## 29) Número de líneas de detalle registradas

## 30) Total de unidades vendidas (suma de cantidad)
## 31) Precio promedio de las líneas de detalle
## 32) Cantidad promedio por línea
## 33) Número de líneas por producto
## 34) Unidades totales por producto
## 35) Ingreso total por producto (cantidad * precio_unitario)

# Otros ejemplos

## 1) ¿Cuántos clientes se han registrado por año y mes?
## 2) ¿Cuántos clientes españoles se han registrado por año y mes?
## 3) Ordenas las consultas anteriores
## 4) Precio promedio agrupando por categoría e inicial del nombre con más de 3 unidades de stock
## 5) ¿Cuántos clientes cuyo nombre empieza por 'A' se han registrado cada año?
## 6) ¿Cuántos productos se han pedido en cada pedido?
## 7) Obtén el listado de los pedidos que han solicitado más de 10 productos
explain detalle_pedido;

-- SUPER IMPORTANTE PORQUE ES DONDE ESTAMOS APRENDIENDO A PILLAR INFORMACIÓN DE 2 TABLAS
SELECT productos.id_producto, productos.nombre, detalle_pedido.id_pedido, detalle_pedido.cantidad FROM productos, detalle_pedido where productos.id_producto = detalle_pedido.id_producto;
SELECT P.id_producto, P.nombre, DP.id_pedido, DP.cantidad FROM productos P, detalle_pedido DP where P.id_producto = DP.id_producto;
-- ids de producto pedidos por ana torres
SELECT 
    c.id_cliente, c.nombre, dp.id_pedido
FROM
    clientes c,
    detalle_pedido dp,
    pedidos p
WHERE
    c.id_cliente = p.id_cliente
        AND p.id_pedido = dp.id_pedido
        AND nombre LIKE '%ana torres%';
        -- ej5 Fechas en las que se ha pedido cada producto identificado por nombre
        