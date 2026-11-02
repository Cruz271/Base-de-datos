-- David Cruz Soria
USE tienda_online;
-- Consulta 1 (1 punto). Muestra las diez líneas de pedido con mayor importe (cantidad por precio_
-- unitario). Incluye identificador de línea, cantidad, precio unitario e importe; desempata por
-- identificador.
explain detalle_pedido;
SELECT 
    id_pedido, id_detalle, precio_unitario, cantidad
FROM
    detalle_pedido
ORDER BY precio_unitario DESC
LIMIT 10;

-- Consulta 2 (1 punto). Muestra el identificador, fecha y año de pago de los quince primeros
--  pagos por identificador. Conserva los pagos sin fecha.
SELECT 
    id_pago, fecha_pago, total_pagado
FROM
    pagos
ORDER BY fecha_pago DESC
LIMIT 15;
-- Consulta 3 (1 punto). Construye una etiqueta para cada cliente con el formato «nombre
-- <email>». Muestra el identificador y la etiqueta, ordenados por la quinta letra del nombre.
explain clientes;

-- Consulta 4 (1 punto). Suma el coste de los pedidos por número de mes, reuniendo todos los
-- años. Muestra mes e importe, ordenados por mes.
explain pedidos;
SELECT 
    MONTH(fecha_pedido), SUM(coste_total)
FROM
    pedidos
GROUP BY MONTH(fecha_pedido)
ORDER BY MONTH(fecha_pedido) ASC;
-- Consulta 5 (1 punto). Calcula el stock medio por categoría. Redondea la media a dos decimales
-- y ordena por ella de menor a mayor y por categoría.
SELECT 
    categoria, AVG(stock)
FROM
    productos
GROUP BY categoria
ORDER BY AVG(stock) ASC;
-- Consulta 6 (1 punto). Cuenta los pedidos distintos por día del mes y estado, sin distinguir mes
-- ni año. Muestra día, estado y número de pedidos; ordena por día y por número de pedidos
-- descendente.
select * from pedidos;
SELECT 
    DAY(fecha_pedido), SUM(DISTINCT (id_pedido))
FROM
    pedidos
GROUP BY DAY(fecha_pedido);
-- Consulta 7 (2 puntos). Pista: puedes usar DATEDIFF(). Relaciona cada pedido con su cliente
-- y calcula, por país, el promedio de días entre el registro del cliente y el pedido. Muestra también
-- el número de pedidos y ordena por número de pedidos descendente y país. Redondea el
-- promedio a un decimal.
explain pedidos;
SELECT 
    clientes.pais,
    COUNT(pedidos.id_pedido) AS numero_pedidos,
    ROUND(AVG(DATEDIFF( pedidos.fecha_pedido, clientes.fecha_registro)),1) AS promedio_dias
FROM
    clientes
        JOIN
    pedidos USING (id_cliente)
GROUP BY clientes.pais
ORDER BY numero_pedidos DESC , clientes.pais ASC;
-- Consulta 8 (2 puntos). Pista: puedes usar LEAST(). Por año de pedido, muestra el número de
-- pedidos, la suma de todos sus costes y la suma de los costes limitados a 1000 euros por pedido.
-- Ordena por año.
explain pedidos;
SELECT count(id_pedido), sum(coste_total), sum(least(coste_total, 1000))
FROM pedidos
 GROUP BY year(fecha_pedido);
-- Extra (0.5 puntos) ¿Ha habido algún pago en 29 de febrero? ¿Y algún pedido?
-- EJEMPLO PROFESOR PARA ENTENDER EJERCICIO 8
SELECT year(fecha_pedido),id_pedido, coste_total, least(coste_total, 1000)
FROM pedidos
ORDER BY year(fecha_pedido);
