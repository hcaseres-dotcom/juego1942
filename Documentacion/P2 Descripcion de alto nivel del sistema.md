# P2. Descripción de alto nivel del sistema

Orientamos la solución de software siguiendo el modelo **MVC (Modelo-Vista-Controlador)** para separar las responsabilidades y facilitar el mantenimiento y la escalabilidad del código.

# **Vista general (módulos):**

## 🧱 **Core de juego (Clases principales del juego):** 

- `Controller`: gestiona el loop principal y los estados del juego:
  - Menú principal
  - Entrada de nombre
  - Juego activo
  - Game Over
  - Instrucciones
  - Análisis de estadísticas
- `View`: clase abstracta para las vistas del juego:
  - `GameView`: renderiza el juego, HUD y elementos visuales.
  - `MenuView`: muestra el menú principal y opciones.
  - `NombreInputView`: gestiona la entrada del nombre del jugador.
  - `PausaView`: muestra la pantalla de pausa.
  - `GameOverView`: muestra la pantalla de Game Over.
  - `InstructionsView`: muestra las instrucciones del juego.
  - `EstadisticasView`: muestra las estadísticas del jugador.
  - `MoreEstadisticasView`: muestra estadísticas adicionales.
- Clases Modelo: contiene la lógica de cada elemento del juego:
  - `Nave`: clase base para la nave del jugador.
  - `Enemigo`: clase base para los enemigos.
  - `Municion`: clase base para los proyectiles disparados por la nave y enemigos.

## 📊 **Datos y análisis:** 
  - `GestorDatos`: maneja la carga y guardado de datos en formato JSON.
  - `GraficoBarras`: genera gráficos de barras para visualización de estadísticas.

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
  - Pausa
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
- `tiempoInicio` (timestamp de inicio del juego)
- `duracionJuego` (en segundos)
- `vidas` (vidas restantes al finalizar)
- `puntuacion` (puntaje final)
- `fechaHora` (fecha y hora de la partida)
- `nombreJugador` (nombre ingresado por el jugador)
- `disparosAcertados` (cantidad de disparos que impactaron)
- `disparosTotales` (cantidad total de disparos realizados)

---