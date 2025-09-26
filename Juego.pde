// Archivo: Juego.pde

class Juego {
  // Estados del juego
  final int MENU = 0;
  final int JUGANDO = 1;
  final int GAME_OVER = 2;
  int estadoActual;
  
  // Objetos del juego
  Nave nave;
  ArrayList<Municion> disparos;
  ArrayList<Enemigo> enemigos;
  
  // Variables del juego
  int puntuacion;
  int vidas;
  int tiempoUltimoEnemigo;
  int tiempoUltimoDisparo;
  int intervaloEnemigos = 1000; // milisegundos
  int intervaloDisparos = 200;  // milisegundos
  
  // Constructor
  Juego() {
    estadoActual = MENU;
    inicializarJuego();
  }
  
  void inicializarJuego() {
    nave = new Nave(width/2, height - 100);
    disparos = new ArrayList<Municion>();
    enemigos = new ArrayList<Enemigo>();
    puntuacion = 0;
    vidas = 3;
    tiempoUltimoEnemigo = 0;
    tiempoUltimoDisparo = 0;
  }
  
  void actualizar() {
    switch(estadoActual) {
      case MENU:
        actualizarMenu();
        break;
      case JUGANDO:
        actualizarJuego();
        break;
      case GAME_OVER:
        actualizarGameOver();
        break;
    }
  }
  
  void dibujar() {
    background(0, 0, 50); // Fondo azul oscuro
    
    switch(estadoActual) {
      case MENU:
        dibujarMenu();
        break;
      case JUGANDO:
        dibujarJuego();
        break;
      case GAME_OVER:
        dibujarGameOver();
        break;
    }
  }
  
  void actualizarMenu() {
    // Lógica del menú
  }
  
  void actualizarJuego() {
    // Actualizar nave
    nave.actualizar();
    
    // Generar enemigos
    if (millis() - tiempoUltimoEnemigo > intervaloEnemigos) {
      enemigos.add(new Enemigo(random(50, width-50), -30, int(random(2))));
      tiempoUltimoEnemigo = millis();
    }
    
    // Actualizar disparos
    for (int i = disparos.size()-1; i >= 0; i--) {
      Municion disparo = disparos.get(i);
      disparo.actualizar();
      
      if (!disparo.estaActiva()) {
        disparos.remove(i);
      }
    }
    
    // Actualizar enemigos
    for (int i = enemigos.size()-1; i >= 0; i--) {
      Enemigo enemigo = enemigos.get(i);
      enemigo.actualizar();
      
      if (!enemigo.estaActivo()) {
        enemigos.remove(i);
      } else if (enemigo.llegaAlFinal()) {
        vidas--;
        enemigos.remove(i);
        if (vidas <= 0) {
          estadoActual = GAME_OVER;
        }
      }
    }
    
    // Verificar colisiones disparos-enemigos
    verificarColisionesDisparosEnemigos();
    
    // Verificar colisiones nave-enemigos
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
          estadoActual = GAME_OVER;
        }
      }
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
    text("Presiona ESPACIO para comenzar", width/2, height/2 + 50);
    text("Usa las flechas para moverte", width/2, height/2 + 80);
    text("Presiona ESPACIO para disparar", width/2, height/2 + 100);
  }
  
  void dibujarJuego() {
    // Dibujar estrellas de fondo
    dibujarEstrellas();
    
    // Dibujar objetos del juego
    nave.dibujar();
    
    for (Municion disparo : disparos) {
      disparo.dibujar();
    }
    
    for (Enemigo enemigo : enemigos) {
      enemigo.dibujar();
    }
    
    // Dibujar HUD
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
    text("Puntuación: " + puntuacion, 10, 30);
    text("Vidas: " + vidas, 10, 50);
  }
  
  void dibujarGameOver() {
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(32);
    text("GAME OVER", width/2, height/2 - 50);
    fill(255);
    textSize(16);
    text("Puntuación Final: " + puntuacion, width/2, height/2);
    text("Presiona R para reiniciar", width/2, height/2 + 50);
  }
  
  void manejarTeclaPresionada(char tecla, int codigo) {
    if (estadoActual == MENU) {
      if (tecla == ' ') {
        estadoActual = JUGANDO;
      }
    } else if (estadoActual == JUGANDO) {
      // Movimiento de la nave
      nave.establecerMovimiento(codigo, true);
      
      // Disparo
      if (tecla == ' ' && millis() - tiempoUltimoDisparo > intervaloDisparos) {
        disparos.add(nave.disparar());
        tiempoUltimoDisparo = millis();
      }
    } else if (estadoActual == GAME_OVER) {
      if (tecla == 'r' || tecla == 'R') {
        inicializarJuego();
        estadoActual = MENU;
      }
    }
  }
  
  void manejarTeclaSoltada(char tecla, int codigo) {
    if (estadoActual == JUGANDO) {
      nave.establecerMovimiento(codigo, false);
    }
  }
}
