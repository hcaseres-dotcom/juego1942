# Juego 1942

Juego 2D desarrollado en Processing (Java), inspirado en "1942". Incluye módulo básico de persistencia y estadísticas en JSON.

## Ejecutar
1. Abrir Processing 4.x.
2. Abrir el sketch situado en la carpeta `src` (archivo principal: [src/sketch.properties](src/sketch.properties) — `main=main.pde`).
3. Ejecutar (Play).

Alternativa CLI (si tiene processing-java instalado):
```sh
processing-java --sketch=`pwd`/src --run
```

## Cómo jugar
- Flechas: mover la nave.
- Espacio: disparar.
- ENTER en el menú: comenzar / confirmar nombre.
- R en Game Over: reiniciar.

## Estructura del repositorio (completa y con enlaces)
- Código fuente (sketch)
    - [src/main.pde](src/main.pde)
    - [src/Controller.pde](src/Controller.pde)
    - [src/Juego.pde](src/Juego.pde)
    - [src/Nave.pde](src/Nave.pde)
    - [src/Municion.pde](src/Municion.pde)
    - [src/Enemigo.pde](src/Enemigo.pde)
    - [src/Menu.pde](src/Menu.pde)
    - [src/GestorDatos.pde](src/GestorDatos.pde)
    - [src/datos_juego.json](src/datos_juego.json)
    - [src/sketch.properties](src/sketch.properties)

- Documentación
    - [Documentacion/P1 Objetivo y Alcance.md](Documentacion/P1%20Objetivo%20y%20Alcance.md)
    - [Documentacion/P2 Descripcion de alto nivel del sistema.md](Documentacion/P2%20Descripcion%20de%20alto%20nivel%20del%20sistema.md)
    - [Documentacion/P3 Requerimientos funcionales mas relevantes.md](Documentacion/P3%20Requerimientos%20funcionales%20mas%20relevantes.md)
    - [Documentacion/P4 Requerimientos no funcionales.md](Documentacion/P4%20Requerimientos%20no%20funcionales.md)
    - [Documentacion/tentativo_entregable_1.md](Documentacion/tentativo_entregable_1.md)

- Diagramas
    - [Diagramas/diagrama_casos_uso.drawio](Diagramas/diagrama_casos_uso.drawio)
    - [Diagramas/diagrama_clases.drawio](Diagramas/diagrama_clases.drawio)
    - [Diagramas/diagrama_secuencias_colision.drawio](Diagramas/diagrama_secuencias_colision.drawio)
    - [Diagramas/diagrama_secuencias_enemigo.drawio](Diagramas/diagrama_secuencias_enemigo.drawio)

- Organización interna
    - [Organizacion_interna/ToDo.md](Organizacion_interna/ToDo.md)

- Otros (si existen)
    - Añadir aquí enlaces a assets (imagenes/sonidos) u otros directorios cuando estén presentes.

## Clases y responsabilidades (vistas rápidas)
- [`Controller`](src/Controller.pde) — orquesta estados y pantallas.
- [`Juego`](src/Juego.pde) — gestión del loop, colisiones y estados.
- [`Nave`](src/Nave.pde) — movimiento, disparo y colisión del jugador.
- [`Municion`](src/Municion.pde) — comportamiento de proyectiles.
- [`Enemigo`](src/Enemigo.pde) — IA simple y estado.
- [`GestorDatos`](src/GestorDatos.pde) — persistencia JSON y estadísticas.

## Persistencia y estadísticas
- El sistema guarda partidas en `src/datos_juego.json` mediante `GestorDatos.guardarPartida`.
- Funciones relevantes: `GestorDatos.cargarDatos` y `GestorDatos.mostrarEstadisticas` (ver [src/GestorDatos.pde](src/GestorDatos.pde)).

## Notas de desarrollo / próximos pasos
- Ver [Organizacion_interna/ToDo.md](Organizacion_interna/ToDo.md) para tareas pendientes.
- Recomendado: añadir imágenes/sprites en `data/` (Processing), sonido, y tests básicos de lógica (colisiones, guardado).
- Si falta algún archivo o carpeta, se puede actualizar este README agregando el enlace relativo.
