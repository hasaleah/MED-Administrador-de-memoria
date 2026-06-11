# Proyecto Final

**Universidad de El Salvador**  
**Asignatura:** Manejo de Estructura de Datos  
**Docente:** Ing./MEd. Luis Alberto Herrera Mejía  

## Integrantes
| Nombre | Carnet |
|--------|-------|
| Catherine Andrea Argumedo | AB25013 |
| Jefry Odir Brizuela Rivas | BR25004 |
| José Adalberto Díaz Lue | DL25004 |
| Edwin Eduardo Torres Pérez | TP21002|

---

## Contenido del repositorio

Este repositorio contiene dos casos de estudio independientes desarrollados como parte del proyecto final de la asignatura. Cada uno explora una estructura de datos distinta aplicada a un problema real de sistemas operativos.

```
/
├── caso1-administrador-memoria/
│   ├── simulador Best-Fit.psc
│   ├── simulador Worst-Fit.psc
│   └── README_caso1.md
├── caso2-sistema-archivos/
│   ├── MiniSistemaArchivosBPlus.psc
│   └── README_caso2.md
└── README.md
```

---

## Caso 1 — Administrador de Memoria con Particiones Variables

Simulación conceptual de cómo un sistema operativo gestiona la memoria RAM mediante una **lista enlazada de particiones variables**. Se implementan y comparan tres algoritmos de asignación y se analiza el proceso de compactación.

### Algoritmos implementados

| Algoritmo | Criterio de selección | Complejidad |
|---|---|---|
| **First-Fit** | Primer bloque suficiente | O(1) mejor / O(n) promedio |
| **Best-Fit** | Bloque más pequeño suficiente | O(n) siempre |
| **Worst-Fit** | Bloque más grande disponible | O(n) siempre |
| **Compactación** | Unificación de espacio libre | O(n + m) |

### Parámetros de la simulación

- Memoria total: **600 unidades**
- Procesos: P1 (100), P2 (150), P3 (80), P4 (120), P5 (50), P6 (70)
- Estructura base: lista enlazada de nodos `{inicio, tamaño, estado}`

### Resultados clave

- **First-Fit** es el más rápido por asignación pero acumula fragmentación externa más rápido.
- **Best-Fit** minimiza el desperdicio inmediato pero genera residuos muy pequeños e inutilizables.
- **Worst-Fit** preserva bloques de tamaño razonable para futuras asignaciones.
- Los tres algoritmos son equivalentes en complejidad teórica O(n); su diferencia real está en el comportamiento de la fragmentación a largo plazo.
- La compactación eliminó completamente la fragmentación externa (210 unidades dispersas → 1 bloque contiguo de 210), sin incrementar la memoria total disponible.

---
<br>

## Caso 2 — Mini Sistema de Archivos Conceptual con Árbol B+

Diseño e implementación conceptual de un mini sistema de archivos usando un **árbol B+ de orden 4** como estructura principal de indexación. Incluye simulación de inserción paso a paso, pseudocódigo de búsqueda, inserción y eliminación, y análisis de complejidad.

### Configuración del árbol

| Propiedad | Valor |
|---|---|
| Tipo | B+ |
| Orden | 4 |
| Máximo de claves por nodo | 3 |
| Mínimo de claves por nodo | 1 |
| Criterio de ordenamiento | Alfabético (lexicográfico) |
| Datos almacenados en | Hojas únicamente |
| Hojas enlazadas | Sí (recorrido secuencial) |

### Operaciones implementadas

- **Búsqueda** — descenso por nodos índice hasta la hoja correspondiente.
- **Inserción** — inserción ordenada con Split y promoción de clave al padre ante desbordamiento.
- **Eliminación** — extracción con manejo de underflow mediante redistribución (rotación) o fusión (Merge) de nodos hermanos.

### Complejidad

| Operación | Caso promedio | Peor caso |
|---|---|---|
| Búsqueda | O(log N) | O(log N) |
| Inserción | O(log N) | O(log N) |
| Eliminación | O(log N) | O(log N) |
| Recorrido / Listado | O(N) | O(N) |
| Búsqueda por rango | O(log N + k) | O(log N + k) |

### Simulación — estado final (10 inserciones)

```
Raíz (índice): [ Fotos.png | Música | Tarea.pdf ]
    │               │              │              │
 Hoja 1          Hoja 2         Hoja 3          Hoja 4
Backup.zip    Fotos.png      Música          Tarea.pdf
Documentos    Imágenes       Notas.txt       Video.mp4
                             Proyectos
```

Cadena secuencial de hojas:
`Backup.zip → Documentos → Fotos.png → Imágenes → Música → Notas.txt → Proyectos → Tarea.pdf → Video.mp4`

---

## Relación entre los casos

Ambos casos abordan el problema de la **gestión eficiente de recursos en sistemas operativos** desde ángulos complementarios:

- El **Caso 1** gestiona *dónde* se ubican los procesos en memoria (espacio físico contiguo), usando una lista enlazada lineal. Su desafío principal es la fragmentación.
- El **Caso 2** gestiona *cómo se indexan* los archivos en disco (espacio lógico jerárquico), usando un árbol B+. Su fortaleza es el acceso logarítmico con balance automático.

La lista enlazada del Caso 1 opera en O(n) con degradación por fragmentación acumulada; el árbol B+ del Caso 2 mantiene O(log N) estable independientemente del patrón de operaciones. Juntos ilustran que la elección de estructura de datos determina directamente el rendimiento y la confiabilidad de un sistema operativo.

---

---

*Universidad de El Salvador — Ciclo III 2025*
