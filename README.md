# Tech-Latam-Ecommerce-Analisis-Ciclo-de-Vida-y-Rentabilidad-2020-2025
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
