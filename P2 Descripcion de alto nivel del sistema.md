# p2. Descripción de alto nivel del sistema

# **Vista general (módulos):**

## 🧱 **Core de juego (Clases principales del juego):** 

- `Juego`: gestiona el loop principal y los estados (`Menú`, `Entrada`, `Jugando`, `Game Over`)
- `Nave`: representa al jugador
- `Municion`: proyectiles disparados por el jugador
- `Enemigo`: clase base con subclases que incorporan IA simple
- `LevelManager`: controla aparición de enemigos y dificultad progresiva
- `CollisionManager`: gestiona colisiones usando AABB (Axis-Aligned Bounding Box)


## 📊 **Datos y análisis:** 

- `DataCollector` (registra contadores durante la partida)
- `GestorDatos` (carga y guarda datos en formato JSON)
- `StatsAnalyzer` (calcula métricas como promedio, máximo, mínimo, precisión, puntaje y duración)
`StatsScreen` (muestra una tabla de estadísticas y un gráfico integrado).

## 🖥️ Interfaz

- HUD (Heads-Up Display) con indicadores de:
  - Vidas
  - Puntaje
  - Tiempo
  - Aciertos
- Pantallas:
  - Menú principal
  - Entrada de nombre
  - Juego
  - Game Over
  - Análisis de estadísticas

---

## 🔄 Flujo principal del juego

1. **Menú principal**  
2. **Entrada de nombre del jugador**  
3. **Juego activo**  
   - Spawns de enemigos/Aparición de enemigos  
   - Colisiones  
   - Puntaje y vidas  
4. **Game Over**  
   - Registro de datos y persistencia  
5. **Acceso al módulo de análisis** desde el menú



## 🧾 Modelo de datos por partida (mínimo)

Estos campos son obligatorios para cumplir con el módulo de **Ciencia de Datos**:

- `jugador`: nombre ingresado por el jugador
- `fechaISO`: fecha y hora 
- `puntuacion`: puntaje total obtenido
- `disparosAcertados`: cantidad de disparos que impactaron
- `disparosTotales`: cantidad total de disparos realizados
- `enemigosDerrotados`: número de enemigos eliminados
- `vidasPerdidas`: cantidad de vidas perdidas
- `victoria`: `true` si ganó la partida, `false` si no
- `nivelAlcanzado`: último nivel jugado
- `duracionSeg`: duración total de la partida en segundos

---