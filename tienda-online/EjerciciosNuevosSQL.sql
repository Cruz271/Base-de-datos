USE tienda_online;
## 1. Funciones numéricas

### 1.1. Truncar el precio de cada producto a 1 decimal
SELECT precio, TRUNCATE(precio, 1) FROM productos;

### 1.2. Redondear hacia abajo (FLOOR) y hacia arriba (CEIL) el precio

SELECT precio, FLOOR(precio), CEIL(precio) FROM productos;

-- bonus track: obtén la parte decimal del precio y filtra para obtener los que tienen un .99

SELECT 
    precio,
    FLOOR(precio) AS parte_entera,
    precio - FLOOR(precio) AS parte_decimal
FROM
    productos
WHERE
    precio - FLOOR(precio) = 0.99;
    
    -- otra manera
    SELECT 
    nombre, precio
FROM
    productos
WHERE
    precio - FLOOR(precio) = 0.99;
    /*
    el orden de ejecución SELECT FROM WHERE AS(como ultimísimo)
    */
### 1.3. Calcular el precio con IVA (21%)

SELECT 
    nombre, precio, precio * 1.21 AS precio_con_IVA
FROM
    productos;
    
    -- salen cuatro decimales vamos a poner solo dos
    SELECT 
    nombre, precio, ROUND(precio * 1.21, 2) AS precio_con_IVA
FROM
    productos;

### 1.4. Descuento del 15% aplicado sobre el precio

SELECT 
    nombre, precio, precio * 0.85 AS precio_con_descuento
FROM
    productos;
    
### 1.5. Desviación estándar y varianza del precio del catálogo

SELECT 
    VARIANCE(precio) AS varianza,
    STDDEV(precio) AS desv_estandar
FROM
    productos;
    
    -- Precio máx y min
    
    SELECT MAX(precio), MIN(precio) FROM productos; 
    
    -- NOMBRE DEL PRODUCTO CON PRECIO MAX Y MIN
    SELECT MAX(precio) FROM productos;
    SELECT nombre, precio
    FROM productos
	WHERE precio = 750;
    -- muy ineficaz.... mejor esto: 
    
    SELECT nombre, precio
    FROM productos
    WHERE precio = (SELECT MAX(precio) FROM productos)
    OR precio = (SELECT MIN(precio) FROM productos);
    
    -- Ejercicios
    
    -- 1) Calcula el stock máximo y mínimo
    
    SELECT 
    MAX(stock), MIN(stock)
FROM
    productos;
    
    -- 2) Es la semana del Black Friday y vamos a sacar un listado de 
    -- productos de electrónica con un descuento del 30%.
    explain productos;
    SELECT 
    nombre, precio, ROUND(precio * 0.70, 2), categoria
FROM
    productos
WHERE
    categoria = 'Electrónica';
    -- 3) Hemos recibido 200 unidades de cada tipo de silla. Saca un listado de nombre, stock antiguo,
    -- stock nuevo y categoria.
    explain productos;
    SELECT 
    nombre,
    stock AS stock_antiguo,
    stock + 200 AS stock_nuevo,
    categoria
FROM
    productos
    WHERE nombre like '%silla%';
    
### 1.6. Diferencia absoluta frente a un stock objetivo (600 uds.)

SELECT 
    nombre, stock, stock - 600
FROM
    productos
WHERE
    stock < 600;SELECT nombre, stock, stock-600 FROM productos WHERE stock < 600;
-- otra opción
SELECT 
    nombre, stock, stock - 600
FROM
    productos
WHERE
    stock - 600 < 0 
    ORDER BY stock - 600 DESC;


## 2. Funciones de cadena

### 2.1. Concatenar categoría y nombre con separador usando `CONCAT_WS`


### 2.2. Extraer una subcadena del nombre de cada producto (pos. 4, longitud 5)
### 2.3. Buscar la posición de una palabra dentro del nombre (por ejemplo 'Pro')
### 2.3. Buscar la posición de una palabra dentro del nombre (por ejemplo 'Pro')
### 2.4. Invertir el nombre de cada producto
### 2.5. Rellenar a la izquierda el id_producto con ceros hasta 5 dígitos
### 2.6. Enmascarar el nombre de cliente con asteriscos según su longitud
### 2.7. Reemplazar el símbolo '@' en el email para mostrarlo “ofuscado”
## 3. Funciones de fecha
### 3.1. Obtener la fecha y hora actual (NOW)
### 3.2. Formatear la fecha de pedido como “YYYY-MM”
### 3.3. Extraer el trimestre (QUARTER) de la fecha de pedido
### 3.4. Último día del mes de cada pedido
### 3.5. Diferencia en meses desde el registro de cada cliente hasta hoy
### 3.6. Semana del año de cada pago (YEARWEEK)
### 3.7. Restar 2 horas a la fecha/hora de cada pedido (SUBTIME)
### 3.8. Sumar 10 minutos a la fecha/hora de cada pago (ADDTIME)