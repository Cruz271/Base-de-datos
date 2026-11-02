## O. Intro
USE tienda_online;
### Mostrar todas las tablas
show tables;
EXPLAIN PEDIDOS;
### Mostrar la estructura de la tabla clientes
explain clientes;
## 1. Consultas Básicas
### 1.1. Mostrar todos los clientes registrados
SELECT * FROM clientes;
### 1.2. Mostrar todos los productos disponibles
SELECT * FROM productos;
### 1.3. Mostrar todos los pedidos realizados
SELECT * FROM pedidos;
## 2. Consultas Básicas seleccionando campos específicos
### 2.1. Mostrar solo el nombre y el email de todos los clientes
SELECT nombre, email FROM clientes;
### 2.2. Mostrar solo el nombre y el precio de todos los productos
SELECT nombre, precio FROM productos;
### 2.3. Mostrar solo el nombre y el estado de todos los pedidos
explain pedidos;
SELECT id_pedido, estado FROM pedidos; -- Selecciono el id porque viendo con el explain no encuentro nombre de los pedidos, asi que es la mejor manera de identificar los pedidos.
## 3. Consultas con ORDER BY, SORT y LIMIT


### 3.1. Mostrar los productos ordenados por precio de mayor a menor
SELECT * FROM productos ORDER BY precio ASC;
### 3.2. Mostrar los pedidos ordenados por fecha de pedido de más reciente a más antigua
SELECT * FROM pedidos ORDER BY fecha_pedido ASC;
### 3.3. Mostrar los 5 primeros clientes registrados
SELECT nombre FROM clientes ORDER BY fecha_registro ASC LIMIT 5;
### 3.4. Mostrar los 3 últimos pedidos realizados
SELECT * FROM pedidos ORDER BY fecha_pedido DESC LIMIT 3;
## 4. Filtros avanzados (IN, BETWEEN, LIKE...)

### 4.1. Mostrar los productos cuyo precio esté entre 100 y 500 euros
SELECT * FROM productos WHERE precio BETWEEN 100 AND 500;
### 4.2. Mostrar los clientes que sean de España
SELECT * FROM clientes WHERE pais = 'España';
### 4.3. Mostrar los pedidos que tengan un estado que no sea 'pendiente'
SELECT * FROM pedidos WHERE estado != 'pendiente';
### 4.4. Mostrar los productos cuyo nombre contenga la palabra 'Laptop'
SELECT * FROM productos WHERE nombre like '%laptop%';
### 4.5. Buscar productos cuyo nombre comiencen por 'Laptop' o 'laptop'
SELECT * FROM productos WHERE nombre like '_aptop%';
### 4.6. Mostrar los clientes que tengan un email que contenga '@example.com'
SELECT * FROM clientes WHERE email like '%@example.com';
### 4.7. Mostrar los productos cuya categoría sea 'Electrónica' o 'Muebles' usando el operador IN
SELECT * FROM productos WHERE categoria IN ('Electrónica', 'Muebles');
### 4.8. Mostrar los pedidos que tengan un total entre 100 y 500 euros
SELECT * FROM pedidos WHERE coste_total BETWEEN 100 AND 500;


## 5. Ejemplos con funciones de cadenas, numéricas y de fechas
### Numéricas
#### 5.1. Obtener la longitud del nombre de cada cliente
#### 5.2. Obtener el total de pedidos realizados
#### 5.3. Obtener el precio promedio de los productos
#### 5.4. Obtener el precio más bajo de los productos
#### 5.5. Obtener el precio más alto de los productos
### Funciones de cadena
#### 5.6. Convertir el nombre de los productos a mayúsculas
#### 5.7. Convertir el nombre de los clientes a minúsculas
#### 5.8. Obtener los primeros 3 caracteres del nombre de cada producto
#### 5.9. Obtener los últimos 3 caracteres del nombre de cada producto
### Funciones de fecha
#### 5.10. Obtener la fecha de hoy
#### 5.11. Calcular cuántos días han pasado desde el registro de cada cliente hasta hoy