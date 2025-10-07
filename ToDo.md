# Tareas 

## Diagramas, documentacion y presentacion
- Realizar el diagrama de clases ✅ (Se ira actualizando en base a los cambios)
- Realizar el/los diagrama(s) de caso de uso. No todos, solo los más importantes. (Vanesa)
- Realizar el/los diagrama(s) de secuencia de los mensajes y métodos. (Vanesa)
- Hacer la presentación del tp. (Vicky)
- Explicar el repositorio de GitHub
- Documentar el código con comentarios

## Funcionamiento del juego
- Bajar la velocidad de los enemigos. (Hernán)
- Agregar diferetentes tipos de enemigos. (Hernán)
- Que los enemigos disparen. (Hernán)
- Que los enemigos no bajen vida al tocar el limite inferior. (Hernán)

## Estadisticas
- Guardar los resultados, máximo puntaje alcanzado en un archivo JSON o CSV. (Horacio)
- Agregar usuarios. (Horacio)
- Modulo estadistica. (Ara)

## Extras
- Agregar imágenes para que sea mas atractivo. No es obligatorio, pero si recomendable. Por ejemplo: Una vez hicieron el reemplazo de la nave con la cara de Donaldo.
- Agregar diferentes niveles de dificultad
- Agregar sonido al juego
- Agregar power ups
- Coleccionar monedas
- Agregar diferentes tipos de municiones
- Agregar diferentes tipos de naves
- Agregar diferentes tipos de enemigos
- Ganar vidas 
- 

# Comentarios profesor
- Analizar si es necesaria la clase Juego
- Municion puede ser interfaz
- 

# Casos de uso principales

| Caso de Uso          | Clases involucradas                         | Descripción breve                                                                 |
|-----------------------|---------------------------------------------|-----------------------------------------------------------------------------------|
| Mover nave            | Nave, Juego                                | El jugador presiona flechas → Juego detecta teclas → Nave actualiza su posición.  |
| Disparar              | Nave, Municion, Juego                      | El jugador presiona espacio → Nave.disparar() crea Municion → Juego la agrega a la lista de disparos. |
| Destruir enemigo      | Municion, Enemigo, Juego                   | Municion.colisionaCon(Enemigo) → Enemigo.destruir() → Juego aumenta la puntuación. |
| Perder vida (colisión)| Nave, Enemigo, Juego                       | Nave.colisionaCon(Enemigo) → Juego resta vidas → si llega a 0, cambia estado a Game Over. |
| Game Over             | Juego                                      | Juego detecta que las vidas = 0 → cambia estado y dibuja pantalla final.           |
| Generar enemigo       | Juego, Enemigo                             | Cada cierto tiempo (intervaloEnemigos) Juego crea un nuevo Enemigo y lo agrega a la lista. |
| Actualizar puntaje    | Juego, Enemigo, Municion                   | Al destruir un enemigo, Juego suma +10 puntos al marcador.                         |
| Ver estadísticas      | Juego, (futura clase Estadisticas o GestorDatos) | Al finalizar la partida, se muestran puntaje final, vidas restantes y otros datos; se pueden guardar en CSV/JSON. |
| Reiniciar partida     | Juego, Nave, Enemigo, Municion             | El jugador presiona R → Juego.inicializarJuego() crea nuevas instancias y resetea todo. |


