USE tienda_online;
-- 1.¿Qué productos tiene más stock?
select*from productos order by stock desc limit 1;
-- 2.¿Qué clientes son de España?
select * from clientes where pais="España";
-- 3.¿Qué productos ha comprado Ana?
select *
from productos
join detalle_pedido using(id_producto)
join pedidos using(id_pedido)
join clientes using(id_cliente)
where clientes.nombre like "Ana %";
-- 4.Cuánto ha pagado Ana?
select id_cliente, sum(precio_unitario * cantidad)
from productos
join detalle_pedido using(id_producto)
join pedidos using(id_pedido)
join clientes using(id_cliente)
where clientes.nombre like "Ana %"
group by id_cliente;
-- 5.¿Cuántos pagos han sido realizados con tarjeta?
select count(id_pago) from pagos
where metodo_pago = "tarjeta";

-- 6.¿Cuántos pedidos se han entregado?
select count(id_pedido) from pedidos;
-- 7.¿Cuántos clientes son de Chile?
select * from clientes where pais="Chile";
-- 8. Producto más caro.
select*from productos order by precio desc limit 1;