# 🚀 Tech-Latam E-commerce: Análisis de Ciclo de Vida y Rentabilidad (2020-2025)

## 📌 Descripción del Proyecto
Este proyecto simula un ecosistema de datos completo para una empresa tecnológica de e-commerce en Latinoamérica. 
A diferencia de los proyectos que usan datasets estáticos, aquí se construyó una infraestructura desde cero: desde la **generación sintética de datos** hasta la **resolución de KPIs de negocio mediante SQL**.

## 🏗️ Arquitectura y Stack Técnico
Para demostrar un control total sobre la lógica de negocio, el flujo de trabajo se dividió en:

1.  **Generación de Datos (Python):** Uso de `Pandas` y `Faker` para crear un modelo relacional de **3,603 transacciones** con estacionalidad programada (Black Friday y Navidad).
2.  **Modelado de Datos (SQL):** Diseño de un esquema estrella (*Star Schema*) con integridad referencial (PK y FK).
3.  **Análisis de Negocio:** Resolución de preguntas críticas de stakeholders mediante consultas en SQL. (Subconsultas, Joins, etc.).
4.  **Inteligencia de Negocios (Power BI):** Creación de un dashboard interactivo con métricas DAX avanzadas para el storytelling de datos y soporte a la toma de decisiones.

## 📊 Modelo de Datos (Esquema Estrella)
El modelo se compone de las siguientes entidades:
- `fact_ventas`: Tabla de hechos con métricas de transacciones y métodos de pago.
- `dim_clientes`: Atributos demográficos y fechas de registro de usuarios en 7 países de LATAM.
- `dim_productos`: Catálogo técnico con costos, precios y categorías.

## 🛠️ Data Integrity & Cleaning (Hallazgos Críticos)
Como parte del rol de Analista, se realizaron auditorías de calidad sobre los datos generados, detectando y documentando:
- **Anacronismos de fecha:** Se identificaron clientes con compras previas a su registro. Se aplicaron filtros de saneamiento en SQL para asegurar la validez de los KPIs de conversión.
- **Análisis de Discrepancias:** Validación cruzada entre precio de lista y precio de venta para auditar la existencia de descuentos aplicados.
- **Ajuste de Escala de Precios:** Detección de anomalías en la relación costo/precio durante la carga en Power Query, normalizando los datos para reflejar márgenes realistas del sector tecnológico.

## 📈 Roadmap de Análisis (KPIs del Stakeholder)
El análisis responde a 7 pilares estratégicos:
1.  **Crecimiento Histórico:** Evolución mensual y patrones de estacionalidad.
2.  **Rendimiento Geográfico:** Identificación de mercados líderes e ingresos por país.
3.  **Rentabilidad:** Cálculo de beneficio neto y márgenes por categoría de producto.
4.  **Fidelización:** Identificación de *Heavy Users* y tasa de recurrencia.
5.  **Análisis de Descuentos:** Impacto de promociones en el margen operativo.
6.  **Métodos de Pago:** Preferencias regionales (Tarjeta vs. Transferencia).
7.  **Eficiencia de Conversión:** Tiempo promedio (*Lead-to-First-Purchase*).

## 📊 Visualización & Storytelling (Power BI)

El dashboard final transforma los datos crudos en insights accionables, permitiendo a los stakeholders explorar el rendimiento de la empresa.

### **Key Insights & Hallazgos**
* **Validación de Estacionalidad:** El gráfico de tendencias confirma picos masivos de ingresos en **noviembre y diciembre**, validando la estrategia de campañas de fin de año (podría ser para Navidad y Año nuevo).
* **Optimización de Márgenes:** Mediante lógica **DAX**, se aplicaron márgenes diferenciados por categoría. Se identificó que, aunque *Celulares* lidera en volumen, categorías como *Accesorios* presentan una rentabilidad porcentual superior.
* **Performance Regional:** Argentina y Ecuador se posicionan como los mercados con mayor beneficio neto, permitiendo priorizar esfuerzos de logística en estas zonas.

### **Componentes Técnicos del Reporte**
* **Modelo de Datos:** Relaciones 1:N sólidas entre tablas de Dimensiones (Clientes, Productos) y Hechos (Ventas).
* **Medidas DAX:** Tabla centralizada de medidas para KPIs como *Ingresos Totales*, *Beneficio Neto*, *Ticket Promedio (AOV)* y *Costos Totales*.
* **Interactividad:** Navegación dinámica mediante segmentadores de fecha, país y categoría de producto.

Dashboard Preview!
<img width="1412" height="794" alt="Print_dashboard" src="https://github.com/user-attachments/assets/1f49493f-e762-4121-bc82-07eab1f34080" />


---
**Desarrollado por Raimundo Bilbao**
