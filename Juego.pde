// Archivo: Juego.pde

class Juego {
  // Estados del juego
  int MENU = 0;
  int ENTRADA_NOMBRE = 1;
  int JUGANDO = 2;
  int GAME_OVER = 3;
  int estadoActual;
  
  PApplet app;

  
  // Objetos del juego
  Nave nave;
  ArrayList<Municion> disparos;
  ArrayList<Enemigo> enemigos;
  
  // Variables del juego
  int puntuacion;
  int vidas;
  int tiempoUltimoEnemigo;
  int tiempoUltimoDisparo;
  int intervaloEnemigos = 1000;
  int intervaloDisparos = 200;
  int disparosAcertados;
  
  // Variables de tiempo
  int tiempoInicio;
  String duracionJuego;
  
  // Variables de jugador
  String nombreJugador;
  boolean inputActivo;
  
  // Constructor
  Juego(PApplet app) {
    estadoActual = MENU;
    nombreJugador = "";
    inputActivo = false;
    inicializarJuego();
    this.app = app;    
  }
  
  void inicializarJuego() {
    nave = new Nave(width/2, height - 100);
    disparos = new ArrayList<Municion>();
    enemigos = new ArrayList<Enemigo>();
    puntuacion = 0;
    vidas = 3;
    tiempoUltimoEnemigo = 0;
    tiempoUltimoDisparo = 0;
    disparosAcertados = 0;
    tiempoInicio = 0;
    duracionJuego = "";
  }
  
  void actualizar() {
    switch(estadoActual) {
      case 0: // MENU
        actualizarMenu();
        break;
      case 1: // ENTRADA_NOMBRE
        actualizarEntradaNombre();
        break;
      case 2: // JUGANDO
        actualizarJuego();
        break;
      case 3: // GAME_OVER
        actualizarGameOver();
        break;
    }
  }
  
  void dibujar() {
    background(0, 0, 50);
    
    switch(estadoActual) {
      case 0: // MENU
        dibujarMenu();
        break;
      case 1: // ENTRADA_NOMBRE
        dibujarEntradaNombre();
        break;
      case 2: // JUGANDO
        dibujarJuego();
        break;
      case 3: // GAME_OVER
        dibujarGameOver();
        break;
    }
  }
  
  void actualizarMenu() {
    // Lógica del menú
  }
  
  void actualizarEntradaNombre() {
    // Lógica entrada de nombre
  }
  
  void actualizarJuego() {
    nave.actualizar();
    
    if (millis() - tiempoUltimoEnemigo > intervaloEnemigos) {
      enemigos.add(new Enemigo(random(50, width-50), -30, int(random(2))));
      tiempoUltimoEnemigo = millis();
    }
    
    for (int i = disparos.size()-1; i >= 0; i--) {
      Municion disparo = disparos.get(i);
      disparo.actualizar();
      
      if (!disparo.estaActiva()) {
        disparos.remove(i);
      }
    }
    
    for (int i = enemigos.size()-1; i >= 0; i--) {
      Enemigo enemigo = enemigos.get(i);
      enemigo.actualizar();
      
      if (!enemigo.estaActivo()) {
        enemigos.remove(i);
      } else if (enemigo.llegaAlFinal()) {
        vidas--;
        enemigos.remove(i);
        if (vidas <= 0) {
          finalizarJuego();
        }
      }
    }
    
    verificarColisionesDisparosEnemigos();
    verificarColisionesNaveEnemigos();
  }
  
  void verificarColisionesDisparosEnemigos() {
    for (int i = disparos.size()-1; i >= 0; i--) {
      Municion disparo = disparos.get(i);
      
      for (int j = enemigos.size()-1; j >= 0; j--) {
        Enemigo enemigo = enemigos.get(j);
        
        if (disparo.colisionaCon(enemigo)) {
          disparo.desactivar();
          enemigo.destruir();
          puntuacion += 10;
          disparosAcertados++;
          disparos.remove(i);
          enemigos.remove(j);
          break;
        }
      }
    }
  }
  
  void verificarColisionesNaveEnemigos() {
    for (int i = enemigos.size()-1; i >= 0; i--) {
      Enemigo enemigo = enemigos.get(i);
      
      if (nave.colisionaCon(enemigo)) {
        vidas--;
        enemigos.remove(i);
        
        if (vidas <= 0) {
          finalizarJuego();
        }
      }
    }
  }
  
  void finalizarJuego() {
    estadoActual = GAME_OVER;
    
    // Calcular duración
    int duracionMs = millis() - tiempoInicio;
    int minutos = duracionMs / 60000;
    int segundos = (duracionMs % 60000) / 1000;
    duracionJuego = minutos + "m " + segundos + "s";
    
    // Guardar partida
    if (nombreJugador.length() > 0) {
      GestorDatos.guardarPartida(this.app, nombreJugador, puntuacion, duracionJuego, disparosAcertados);
      
      // Mostrar estadísticas en consola
      GestorDatos.mostrarEstadisticas(this.app);
    }
  }
  
  void actualizarGameOver() {
    // Lógica del game over
  }
  
  void dibujarMenu() {
    fill(255);
    textAlign(CENTER);
    textSize(32);
    text("JUEGO 1942", width/2, height/2 - 50);
    textSize(16);
    text("Presiona ENTER para comenzar", width/2, height/2 + 50);
    text("Usa las flechas para moverte", width/2, height/2 + 80);
    text("Presiona ESPACIO para disparar", width/2, height/2 + 100);
    textSize(12);
    fill(150, 150, 150);
    text("Los datos se guardan en: " + sketchPath("datos_juego.json"), width/2, height - 30);
  }
  
  void dibujarEntradaNombre() {
    fill(255);
    textAlign(CENTER);
    textSize(24);
    text("Ingresa tu nombre:", width/2, height/2 - 80);
    
    // Mostrar último jugador
    String ultimoJugador = GestorDatos.obtenerUltimoJugador(this.app);
    if (ultimoJugador.length() > 0) {
      textSize(14);
      fill(200, 200, 200);
      text("Último jugador: " + ultimoJugador, width/2, height/2 - 50);
    }
    
    // Campo de texto simulado
    fill(255);
    textSize(32);
    text(nombreJugador + "_", width/2, height/2);
    
    textSize(14);
    fill(150, 150, 150);
    text("Presiona ENTER para continuar", width/2, height/2 + 50);
    if (ultimoJugador.length() > 0) {
      text("Presiona ESC para usar último jugador", width/2, height/2 + 70);
    }
  }
  
  void dibujarJuego() {
    dibujarEstrellas();
    
    nave.dibujar();
    
    for (Municion disparo : disparos) {
      disparo.dibujar();
    }
    
    for (Enemigo enemigo : enemigos) {
      enemigo.dibujar();
    }
    
    dibujarHUD();
  }
  
  void dibujarEstrellas() {
    fill(255);
    for (int i = 0; i < 50; i++) {
      float x = (frameCount * 2 + i * 37) % width;
      float y = (frameCount * 1 + i * 23) % height;
      ellipse(x, y, 1, 1);
    }
  }
  
  void dibujarHUD() {
    fill(255);
    textAlign(LEFT);
    textSize(16);
    text("Jugador: " + nombreJugador, 10, 30);
    text("Puntuación: " + puntuacion, 10, 50);
    text("Vidas: " + vidas, 10, 70);
    text("Disparos acertados: " + disparosAcertados, 10, 90);
    
    // Tiempo transcurrido
    int duracionMs = millis() - tiempoInicio;
    int minutos = duracionMs / 60000;
    int segundos = (duracionMs % 60000) / 1000;
    text("Tiempo: " + minutos + "m " + segundos + "s", 10, 110);
  }
  
  void dibujarGameOver() {
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(32);
    text("GAME OVER", width/2, height/2 - 120);
    
    fill(255);
    textSize(18);
    text("Jugador: " + nombreJugador, width/2, height/2 - 70);
    text("Puntuación Final: " + puntuacion, width/2, height/2 - 40);
    text("Disparos acertados: " + disparosAcertados, width/2, height/2 - 10);
    text("Duración: " + duracionJuego, width/2, height/2 + 20);
    
    textSize(16);
    fill(0, 255, 0);
    text("✓ Datos guardados correctamente", width/2, height/2 + 60);
    
    textSize(14);
    fill(255);
    text("Presiona R para jugar de nuevo", width/2, height/2 + 100);
    
    textSize(12);
    fill(150, 150, 150);
    text("Archivo: " + sketchPath("datos_juego.json"), width/2, height - 30);
  }
  
  void manejarTeclaPresionada(char tecla, int codigo) {
    if (estadoActual == MENU) {
      if (codigo == ENTER) {
        estadoActual = ENTRADA_NOMBRE;
        nombreJugador = GestorDatos.obtenerUltimoJugador(this.app);
      }
    } else if (estadoActual == ENTRADA_NOMBRE) {
      if (codigo == ENTER && nombreJugador.length() > 0) {
        estadoActual = JUGANDO;
        tiempoInicio = millis();
      } else if (codigo == ESC) {
        String ultimoJugador = GestorDatos.obtenerUltimoJugador(this.app);
        if (ultimoJugador.length() > 0) {
          nombreJugador = ultimoJugador;
          estadoActual = JUGANDO;
          tiempoInicio = millis();
        }
        // Evitar que ESC cierre la aplicación
        key = 0;
      } else if (codigo == BACKSPACE) {
        if (nombreJugador.length() > 0) {
          nombreJugador = nombreJugador.substring(0, nombreJugador.length() - 1);
        }
      } else if (tecla >= 32 && tecla <= 126 && nombreJugador.length() < 20) {
        // Caracteres imprimibles
        nombreJugador += tecla;
      }
    } else if (estadoActual == JUGANDO) {
      nave.establecerMovimiento(codigo, true);
      
      if (tecla == ' ' && millis() - tiempoUltimoDisparo > intervaloDisparos) {
        disparos.add(nave.disparar());
        tiempoUltimoDisparo = millis();
      }
    } else if (estadoActual == GAME_OVER) {
      if (tecla == 'r' || tecla == 'R') {
        inicializarJuego();
        estadoActual = ENTRADA_NOMBRE;
        nombreJugador = GestorDatos.obtenerUltimoJugador(this.app);
      }
    }
  }
  
  void manejarTeclaSoltada(char tecla, int codigo) {
    if (estadoActual == JUGANDO) {
      nave.establecerMovimiento(codigo, false);
    }
  }
}
