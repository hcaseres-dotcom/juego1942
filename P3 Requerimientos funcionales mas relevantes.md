# p3. Requerimientos funcionales más relevantes

## ✅ Priorización de funcionalidades

Clasificación según **Must / Should / Could**, todas trazables a los **Requerimientos principales** del proyecto.

### 🟩 Obligatorias  (Must)

- **F-01 Estados y navegación**  
  El sistema gestiona los estados: `MENU`, `CIENCIA_DE_DATOS`,`ENTRADA_NOMBRE`, `JUGANDO`, `GAME_OVER`

- **F-02 Entrada de nombre**  
  Es obligatorio la confirmación del nombre del jugador. También se puede reutilizar el último ingresado.

- **F-03 Control y disparo**  
  Movimiento en 4 sentidos con teclado. Disparo con cadencia limitada.

- **F-04 Enemigos y niveles**  
  Aparición periódica de enemigos (≥2 tipos) con comportamientos distintos y dificultad creciente.

- **F-05 Colisiones y puntaje**  
  - Bala ↔ Enemigo: suma puntos y registra aciertos  
  - Nave ↔ Enemigo: resta vidas  
  - Condiciones de victoria/derrota

- **F-06 HUD(Heads-Up Display)**  
  Muestra jugador, puntaje, vidas, aciertos y tiempo.

- **F-07 Persistencia**  
  Al finalizar la partida, guarda los datos en formato JSON con los campos mínimos definidos.

- **F-08 Métricas agregadas**  
  Se calculan y muestran:  
  - Promedio / Máximo / Mínimo de puntaje  
  - Precisión (aciertos / totales)  
  - % de victorias  
  - Promedio de duración

### 🟨 Recomendadas (Should)

- **F-09 Visualización**  
  Vista de **Análisis** con una **tabla** y **un gráfico** (barras o líneas) integrado al juego.

### 🟦 Opcionales / Extensiones (Could)

- **F-10 Dificultad dinámica**  
  Ajuste automático según el rendimiento del jugador.

- **F-11 Exportación JSON**  
  Opción para exportar el histórico completo para análisis externo.

---

Estas funcionalidades cubren los tres pilares del proyecto del juego 1942:  
**Juego principal**, **Módulo de Ciencia de Datos** y **POO / calidad técnica**.
