/*
PROYECTO: E-commerce Data Analysis (SQL + Power BI)
AUTOR: Raimundo Bilbao
OBJETIVO: Extraer KPIs financieros y operativos para toma de decisiones estratégicas.
HERRAMIENTAS: MySQL / Python (Generación de datos) / Power BI (Visualización futura).
*/

-- Preguntas Stakeholders -- 
/*
1. Crecimiento Histórico: ¿Cuál ha sido la evolución de las ventas mensuales desde 2020? ¿Existen patrones de estacionalidad claros?
2. Rendimiento Geográfico: ¿Cuál es el país de Latinoamérica que más ingresos aporta y cuál tiene el ticket promedio (AOV) más alto?
3. Rentabilidad por Producto: ¿Qué categorías de productos generan el mayor margen de beneficio neto y cuáles tienen costos demasiado elevados en relación con su precio de venta?
4. Fidelización y Recurrencia: ¿Qué porcentaje de nuestros clientes ha realizado más de una compra? Queremos identificar a nuestros "Heavy Users".
5. Análisis de Descuentos: ¿Cómo impactan los descuentos en el volumen de ventas? ¿Estamos sacrificando demasiado margen por vender más unidades?
6. Métodos de Pago: ¿Existe alguna preferencia regional por ciertos métodos de pago?
7. Eficiencia de Registro: ¿Cuál es el tiempo promedio que transcurre desde que un cliente se registra en la plataforma hasta que realiza su primera transacción?
*/


-- 1. Crecimiento Histórico: ¿Cuál ha sido la evolución de las ventas mensuales desde 2020? ¿Existen patrones de estacionalidad claros?
SELECT 
    YEAR(fecha) AS anio,
    MONTH(fecha) AS mes,
    SUM(total_venta) AS total_ventas,
    ROUND((SUM(total_venta) / COUNT(venta_id)),2) AS ticket_promedio
FROM fact_ventas
GROUP BY anio, mes
ORDER BY anio, mes;

-- ============================================================= -- 
-- 2. Rendimiento Geográfico: ¿Cuál es el país de Latinoamérica que más ingresos aporta y cuál tiene el ticket promedio (AOV) más alto?
SELECT 
     dm.pais,
     SUM(fv.total_venta) AS total_ventas,
     ROUND((SUM(total_venta) / COUNT(venta_id)),2) AS ticket_promedio
FROM fact_ventas AS fv
LEFT JOIN dim_clientes AS dm
	ON fv.cliente_id = dm.cliente_id
GROUP BY dm.pais
ORDER BY total_ventas DESC, ticket_promedio DESC;

-- ============================================================= -- 
-- 3. Rentabilidad por Producto: ¿Qué categorías de productos generan el mayor margen de beneficio neto y cuáles tienen costos demasiado elevados en relación con su precio de venta?
SELECT 
	dp.categoria,
    SUM(fv.total_venta) AS ingreso_bruto,
    (SUM(dp.costo * fv.cantidad)) AS costo_total,
    (SUM(fv.total_venta) -  (SUM(dp.costo * fv.cantidad))) AS beneficio_neto
FROM fact_ventas AS fv
LEFT JOIN dim_productos AS dp
	ON fv.producto_id = dp.producto_id
GROUP BY dp.categoria
ORDER BY beneficio_neto DESC;

-- ============================================================= -- 
-- 4. Fidelización y Recurrencia: ¿Qué porcentaje de nuestros clientes ha realizado más de una compra? Queremos identificar a nuestros "Heavy Users".
SELECT 
	fv.cliente_id,
    dc.nombre,
    dc.pais,
    SUM(fv.total_venta) AS total_ventas
FROM fact_ventas AS fv
LEFT JOIN dim_clientes AS dc
	ON fv.cliente_id = dc.cliente_id
GROUP BY fv.cliente_id, dc.nombre, dc.pais
HAVING COUNT(venta_id) > 1
ORDER BY total_ventas DESC;

-- ============================================================= -- 
-- 5. Análisis de Descuentos: ¿Cómo impactan los descuentos en el volumen de ventas? ¿Estamos sacrificando demasiado margen por vender más unidades?
# No contamos con una columna que haga mención a 'descuentos', utilizaremos un método para buscar si es que existe algún descuento.
SELECT 
	(fv.cantidad * dp.precio) AS venta_teorica,
    fv.total_venta,
    ((fv.cantidad * dp.precio) - fv.total_venta) AS descuento_aplicado
FROM fact_ventas AS fv
LEFT JOIN dim_productos AS dp
	ON fv.producto_id = dp.producto_id;

# No existen descuentos aplicados. Todos los productos se vendieron a su precio original.

-- ============================================================= -- 
-- 6. Métodos de Pago: ¿Existe alguna preferencia regional por ciertos métodos de pago?
SELECT 
	dc.pais,
    fv.metodo_pago,
    COUNT(fv.venta_id) AS cantidad_vendida,
    SUM(fv.total_venta) AS total_ventas
   
FROM fact_ventas AS fv
LEFT JOIN dim_clientes AS dc
	ON fv.cliente_id = dc.cliente_id
GROUP BY dc.pais, fv.metodo_pago
ORDER BY dc.pais, total_ventas DESC;

-- ============================================================= -- 
-- 7. Eficiencia de Registro: ¿Cuál es el tiempo promedio que transcurre desde que un cliente se registra en la plataforma hasta que realiza su primera transacción?
# Se identificó que existen inconsistencias en las fechas de registro de clientes y su primera transacción. Hay clientes que realizaron compras antes de estar ingresados.
# Cuando se creó la base de datos de manera aleatoria en Python, no hubo una restricción de que la fecha de su primera compra debe ser > a la fecha de registro.
# Solamente seleccionaremos a los clientes que su primera compra sea con una fecha > a la fecha de registro.

SELECT 
    dc.pais,
    ROUND(AVG(DATEDIFF(primera_compra, fecha_registro)),0) AS dias_prom_compra
FROM (
	SELECT
		cliente_id,
		MIN(fecha) AS primera_compra
	FROM fact_ventas AS fv
	GROUP BY cliente_id) AS sub_ventas
JOIN dim_clientes AS dc
	ON dc.cliente_id = sub_ventas.cliente_id
WHERE primera_compra >= fecha_registro
GROUP BY dc.pais
ORDER BY dias_prom_compra DESC;