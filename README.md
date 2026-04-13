[# Tech-Latam-Ecommerce-Analisis-Ciclo-de-Vida-y-Rentabilidad-2020-2025
Este proyecto simula un ecosistema de datos para una empresa de e-commerce tecnológica con operaciones en Latinoamérica. El objetivo es demostrar habilidades de Ingeniería de Datos (generación sintética y carga masiva), Arquitectura de Bases de Datos (diseño relacional) y Análisis de Negocio (SQL). 

- Base de datos ficticia creada en Python (con ayuda de IA-Gemini).

## Arquitectura de datos:
Para este proyecto, decidí no utilizar un dataset estático de internet, sino construir uno propio para tener control total sobre la lógica de negocio.

Generación de Datos con Python
Utilicé un script de Python con las librerías Pandas y Faker para crear:
- Volumen: 3,603 transacciones distribuidas en 6 años.
- Integridad: Modelo relacional con 3 tablas vinculadas por llaves primarias y foráneas.


### Lógica de Negocio:
- Estacionalidad: Programé picos de ventas en Noviembre (Black Friday) y Diciembre (Navidad).
- Geografía: Localización enfocada en 7 países de LATAM.
- Recurrencia: Lógica de asignación aleatoria ponderada para simular clientes leales.


## Lista de Preguntas del Stakeholder (Roadmap del Proyecto)
1. Crecimiento Histórico: ¿Cuál ha sido la evolución de las ventas mensuales desde 2020? ¿Existen patrones de estacionalidad claros?
2. Rendimiento Geográfico: ¿Cuál es el país de Latinoamérica que más ingresos aporta y cuál tiene el ticket promedio (AOV) más alto?
3. Rentabilidad por Producto: ¿Qué categorías de productos generan el mayor margen de beneficio neto y cuáles tienen costos demasiado elevados en relación con su precio de venta?
4. Fidelización y Recurrencia: ¿Qué porcentaje de nuestros clientes ha realizado más de una compra? Queremos identificar a nuestros "Heavy Users".
5. Análisis de Descuentos: ¿Cómo impactan los descuentos en el volumen de ventas? ¿Estamos sacrificando demasiado margen por vender más unidades?
6. Métodos de Pago: ¿Existe alguna preferencia regional por ciertos métodos de pago? (Ej: ¿Se usa más tarjeta en Chile que en México?).
7. Eficiencia de Registro: ¿Cuál es el tiempo promedio que transcurre desde que un cliente se registra en la plataforma hasta que realiza su primera transacción?
](https://img.shields.io/badge/SQL-MySQL-blue)
