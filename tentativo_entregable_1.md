Perfecto. Reescribo **p1–p4** ajustados **exactamente** a la consigna y rúbrica del TPI (esto corresponde a la *Documentación de Análisis: p1–p4*). 

# p1. Objetivo y Alcance

**Objetivo.** Construir un videojuego 2D en Processing (Java), inspirado en *1942*, aplicando **POO** (herencia, interfaces, polimorfismo) y sumando un **módulo de análisis de datos** con persistencia y visualización simple. 

**Alcance (MVP de esta entrega).**

* **Juego principal:** 1 jugador controlable, ≥2 tipos de enemigos, colisiones, puntaje, vidas, condiciones de victoria/derrota, dificultad creciente por nivel/tiempo. 
* **Ciencia de datos:** registro por partida (tiempo, puntaje, precisión, enemigos derrotados, vidas perdidas, victoria, nivel alcanzado), persistencia (JSON/CSV) y una vista con métricas **(promedio, máx, mín, % victorias)** y **1 gráfico** (barras/línea) integrado al juego. 
* **POO y calidad:** diseño orientado a objetos y código que compile/ejecute correctamente. 

**Fuera de alcance ahora (posibles extensiones):** ajuste dinámico de dificultad avanzado, ranking histórico ampliado, métricas estadísticas avanzadas (varianza, desvío). 

---

# p2. Descripción de alto nivel del sistema

**Vista general (módulos):**

* **Core de juego:** `Juego` (loop y estados: Menú, Entrada, Jugando, Game Over), `Nave` (jugador), `Municion` (balas), `Enemigo` (clase base + subclases con IA simple), `LevelManager` (spawns/dificultad), `CollisionManager` (AABB).
* **Datos y análisis:** `DataCollector` (contadores durante la partida), `DataStore` (JSON/CSV: load/save), `StatsAnalyzer` (prom/máx/mín/precisión/winrate/duración), `StatsScreen` (tabla + gráfico).
* **Interfaz:** HUD (vidas, score, tiempo, aciertos), pantallas de Menú/Entrada/Game Over/Análisis.

**Flujo principal:**

1. Menú → 2) Entrada de nombre → 3) Juego (spawns, colisiones, score/vidas) → 4) Game Over (persistencia) → 5) Acceso a **Análisis** desde menú. 

**Modelo de datos por partida (mínimo):**
`jugador, fechaISO, puntuacion, disparosAcertados, disparosTotales, enemigosDerrotados, vidasPerdidas, victoria(bool), nivelAlcanzado, duracionSeg`. (Obligatorios para cumplir “Ciencia de datos”.) 

---

# p3. Requerimientos funcionales más relevantes

> Priorización **M**ust/**S**hould/**C**ould. Todos trazables a “Requerimientos principales”. 

**F-01 Estados y navegación (M).** El sistema gestiona `MENU`, `ENTRADA_NOMBRE`, `JUGANDO`, `GAME_OVER`.
**F-02 Entrada de nombre (M).** Permite tipear/confirmar nombre y reutilizar el último.
**F-03 Control y disparo (M).** Movimiento con teclado y disparo con cadencia limitada.
**F-04 Enemigos y niveles (M).** Spawns periódicos, ≥2 tipos con comportamiento distinto y **dificultad creciente**.
**F-05 Colisiones y puntaje (M).** Bala↔enemigo suma puntos y registra **acierto**; Nave↔enemigo resta **vida**; condiciones de victoria/derrota.
**F-06 HUD (M).** Muestra jugador, score, vidas, aciertos y tiempo.
**F-07 Persistencia (M).** Al finalizar, guarda la partida en JSON/CSV con los campos mínimos definidos.
**F-08 Métricas agregadas (M).** Se calculan y muestran: **promedio/máx/mín** de puntaje, **precisión** (aciertos/totales), **% victorias**, **promedio de duración**.
**F-09 Visualización (S).** Vista de **Análisis** con una **tabla** y **un gráfico** (barras o línea) dentro del juego.
**F-10 Dificultad dinámica (C).** Ajuste por rendimiento del jugador (opcional/extension).
**F-11 Exportación CSV (C).** Opción de exportar histórico para análisis externo.

Estas funciones cumplen **Juego principal**, **Módulo de Ciencia de Datos** y **POO/calidad** de la consigna. 

---

# p4. Requerimientos no funcionales

**NF-01 Extensibilidad (M).** Diseño modular (subclases de `Enemigo`, `Strategy` de dificultad) que permita agregar tipos de enemigos, niveles y métricas sin romper interfaces. 
**NF-02 Mantenibilidad (M).** Separación de responsabilidades (render vs lógica vs datos), nombres claros, evitar duplicación, comentarios/Javadoc básicos. 
**NF-03 Gestión de errores (M).** Manejo de IO robusto: si el archivo de datos no existe/corrupto, se recrea estructura mínima; nunca crashea el juego. Jerarquía simple de excepciones si usan Java puro. 
**NF-04 Rendimiento (S).** Objetivo ≥ **50 FPS** con cantidad razonable de sprites; reciclar listas/objetos ligeros para munición; colisiones AABB.
**NF-05 Portabilidad (M).** Compila y ejecuta en **Processing 4.x** sin dependencias externas. 
**NF-06 Presentación/Organización (S).** README de ejecución, diagrama de clases y breve guía de análisis para la defensa. (Alinea con rúbrica de organización/presentación.) 

---

Si querés, te lo paso **en .DOCX** con formato (títulos numerados + tabla de trazabilidad RF↔consigna) y lo sumamos al repo.
