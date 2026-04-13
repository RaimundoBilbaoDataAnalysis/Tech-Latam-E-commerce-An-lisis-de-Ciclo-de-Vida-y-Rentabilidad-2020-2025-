import pandas as pd
from faker import Faker
import random
import numpy as np
from datetime import datetime, timedelta

# Inicializamos Faker con localización en español para nombres realistas
fake = Faker(['es_ES', 'es_MX', 'es_CO'])

# --- CONFIGURACIÓN DEL PROYECTO ---
FECHA_INICIO = datetime(2020, 1, 1)
FECHA_FIN = datetime(2025, 12, 31)
N_CLIENTES = 400     # 400 clientes base
N_VENTAS = 3000      # Aumentamos a 3000 para ver mejor los picos y recurrencia

# 1. GENERACIÓN DE PRODUCTOS
print("Generando catálogo de productos...")
productos_base = [
    {'id': 1, 'nombre': 'Smartphone Galaxy A', 'cat': 'Celulares', 'costo': 200},
    {'id': 2, 'nombre': 'iPhone Pro Max', 'cat': 'Celulares', 'costo': 800},
    {'id': 3, 'nombre': 'Laptop Workstation', 'cat': 'Computacion', 'costo': 1200},
    {'id': 4, 'nombre': 'Monitor 27" 4K', 'cat': 'Computacion', 'costo': 250},
    {'id': 5, 'nombre': 'Audifonos Bluetooth', 'cat': 'Audio', 'costo': 40},
    {'id': 6, 'nombre': 'Teclado Mecanico RGB', 'cat': 'Accesorios', 'costo': 35},
    {'id': 7, 'nombre': 'Tablet Pro 11', 'cat': 'Tablets', 'costo': 350},
    {'id': 8, 'nombre': 'Camara Seguridad Wi-Fi', 'cat': 'Hogar', 'costo': 45}
]

# Calculamos un precio de venta con un margen aleatorio entre 30% y 60%
for p in productos_base:
    p['precio'] = round(p['costo'] * random.uniform(1.3, 1.6), 2)

df_productos = pd.DataFrame(productos_base)

# 2. GENERACIÓN DE CLIENTES
print("Generando base de clientes de LATAM...")
paises_latam = ['Chile', 'Mexico', 'Colombia', 'Argentina', 'Peru', 'Ecuador', 'Uruguay']

clientes = []
for i in range(1, N_CLIENTES + 1):
    clientes.append({
        'cliente_id': i,
        'nombre': fake.name(),
        'email': fake.ascii_free_email(),
        'pais': random.choice(paises_latam),
        'fecha_registro': fake.date_between(start_date='-6y', end_date='-1y')
    })

df_clientes = pd.DataFrame(clientes)


print(df_productos.head())
print(df_clientes.head())

# Guardar con encoding 'utf-8-sig' para que Excel reconozca tildes y eñes
df_productos.to_csv('productos.csv', index=False, encoding='utf-8-sig')
df_clientes.to_csv('clientes.csv', index=False, encoding='utf-8-sig')

print("¡Archivos guardados correctamente con soporte para tildes!")


# 3. GENERACIÓN DE VENTAS (FACT_VENTAS)
print("Generando 3,000 ventas con estacionalidad y recurrencia...")

ventas = []
ids_clientes = df_clientes['cliente_id'].values
productos_lista = df_productos.to_dict('records')

for i in range(1, N_VENTAS + 1):
    # Seleccionamos una fecha aleatoria entre 2020 y 2025
    fecha_base = fake.date_between(start_date=FECHA_INICIO, end_date=FECHA_FIN)
    
    # Lógica de Picos: Si es Noviembre o Diciembre, hay un 70% de probabilidad 
    # de generar una segunda venta extra en el mismo ciclo para simular volumen.
    mes = fecha_base.month
    prob_extra = 0.7 if mes in [11, 12] else 0.1
    
    intentos = 2 if random.random() < prob_extra else 1
    
    for _ in range(intentos):
        prod = random.choice(productos_lista)
        cantidad = random.choices([1, 2, 3], weights=[80, 15, 5])[0]
        
        ventas.append({
            'venta_id': len(ventas) + 1,
            'fecha': fecha_base,
            'cliente_id': random.choice(ids_clientes), # Aquí se genera la recurrencia
            'producto_id': prod['id'],
            'cantidad': cantidad,
            'total_venta': round(prod['precio'] * cantidad, 2),
            'metodo_pago': random.choice(['Tarjeta de Crédito', 'Transferencia', 'Efectivo'])
        })

df_ventas = pd.DataFrame(ventas)

# Guardar la tabla de hechos
df_ventas.to_csv('ventas.csv', index=False, encoding='utf-8-sig')

print(f"¡Proceso terminado! Generadas {len(df_ventas)} transacciones.")