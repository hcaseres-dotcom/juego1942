// Archivo: Controller.pde

class Controller {
  // Estados del juego
  int MENU = 0;
  int ENTRADA_NOMBRE = 1;
  int JUGANDO = 2;
  int GAME_OVER = 3;
  int estadoActual;
  
  PApplet app;

  // Objetos del juego
  Nave nave;
  MenuView menuView;
  NombreInputView nombreInputView;
  GameView gameView;
  GameOverView gameOverView;

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
  Controller(PApplet app) {
    estadoActual = MENU;
    this.menuView = new MenuView();
    this.nombreInputView = new NombreInputView();
    this.gameView = new GameView();
    this.gameOverView = new GameOverView();

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
        menuView.dibujarView();
        break;
      case 1: // ENTRADA_NOMBRE
        nombreInputView.dibujarView(this.app, nombreJugador);
        break;
      case 2: // JUGANDO
        gameView.dibujarView(nave, disparos, enemigos, nombreJugador, puntuacion, vidas, disparosAcertados, tiempoInicio);
        break;
      case 3: // GAME_OVER
        gameOverView.dibujarView(nombreJugador, puntuacion, disparosAcertados, duracionJuego);
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
        // vidas--;
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
