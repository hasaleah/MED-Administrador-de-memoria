# Simuladores de Administración de Memoria con Particiones Variables

Proyecto académico que implementa y documenta tres algoritmos clásicos de administración de memoria con particiones variables: **First-Fit**, **Best-Fit** y **Worst-Fit**. Incluye simuladores interactivos en PSeInt y documentación teórica con análisis y diagramas de lista enlazada.


## Simuladores (PSeInt)

Cada simulador es un programa **interactivo y genérico**: el usuario puede definir sus propios procesos con cualquier nombre e ID y tamaño, asignarlos y liberarlos libremente sobre una memoria configurable. No están limitados a ningún conjunto fijo de procesos.

### Funcionalidades comunes


| Opción | Descripción |
|--------|-------------|
| 1 | Muestra la tabla de bloques con inicio, tamaño, estado y proceso asignado |
| 2 | Solicita ID y tamaño del proceso, aplica el algoritmo correspondiente |
| 3 | Libera un proceso por ID y fusiona automáticamente bloques libres adyacentes |
| 4 | Compacta la memoria moviendo todos los bloques ocupados al inicio |
| 5 | Sale del simulador |

### Cómo se representa la memoria

La memoria se modela como una **lista enlazada** de bloques. Cada bloque almacena:

- `inicio` — dirección de inicio del bloque
- `tamaño` — cantidad de unidades que ocupa
- `estado` — `0 = Libre` / `1 = Ocupado`
- `id_proceso` — identificador del proceso asignado (0 si está libre)


---

## Descripción de los algoritmos

### ✿ First-Fit
Recorre la lista desde el inicio y asigna el proceso al **primer bloque libre** que sea suficientemente grande. Es el más rápido porque detiene la búsqueda en cuanto encuentra un espacio adecuado.

### ✿ Best-Fit
Recorre **toda la lista** y asigna el proceso al bloque libre **más pequeño que sea suficiente**. Minimiza el desperdicio inmediato por asignación, pero puede generar residuos muy pequeños difíciles de reutilizar.

### ✿ Worst-Fit
Recorre **toda la lista** y asigna el proceso al bloque libre **más grande disponible**. Busca que el residuo resultante sea lo suficientemente grande para alojar procesos futuros.

### Comparativa

| Aspecto | First-Fit | Best-Fit | Worst-Fit |
|---|---|---|---|
| Criterio | Primer bloque suficiente | Bloque más pequeño suficiente | Bloque más grande disponible |
| Velocidad de búsqueda | Rápida | Lenta | Lenta |
| Fragmentación generada | Bloques medianos residuales | Residuos muy pequeños | Residuos más grandes |
| Principal ventaja | Velocidad | Menor desperdicio inmediato | Residuos más reutilizables |
| Principal desventaja | Puede saltarse bloques óptimos | Residuos inutilizables | Agota bloques grandes rápido |

---


## Conceptos clave

**✿ Particiones variables:** la memoria se divide dinámicamente según el tamaño real de cada proceso  
**✿ Fragmentación externa:** espacios libres dispersos entre bloques ocupados que no pueden utilizarse de forma contigua  
**✿ Coalescencia:** fusión automática de bloques libres adyacentes al liberar un proceso  
**✿ Compactación:** reorganización de los bloques ocupados al inicio de la memoria para consolidar el espacio libre en un único bloque contiguo


## Contexto académico

Proyecto desarrollado para la materia de **Estructura de Datos**, el objetivo es comprender la gestión dinámica de memoria mediante listas enlazadas y analizar las ventajas y limitaciones de cada política de asignación.
