// Archivo: GameView.pde

class GameView extends View {

  Nave nave;
  ArrayList<Municion> disparos;
  ArrayList<Enemigo> enemigos;

  GameData data;
  Controller controller;

  int tiempoUltimoEnemigo;
  int tiempoUltimoDisparo;

  int intervaloEnemigos = 1000;
  int intervaloDisparos = 200;

  GameView(PApplet app, Controller controller, GameData data) {
    super(app);
    this.controller = controller;
    this.data = data;
    disparos = new ArrayList<Municion>();
    enemigos = new ArrayList<Enemigo>();
  }

  @Override
  void iniciar() {
    nave = new Nave(app.width / 2, app.height - 100);
    data.tiempoInicio = app.millis();
    data.tiempoInicio = app.millis();
    data.vidas = 3;
    data.puntuacion = 0;
    data.disparosAcertados = 0;
    disparos.clear();
    enemigos.clear();
    tiempoUltimoEnemigo = 0;
    tiempoUltimoDisparo = 0;
  }

  @Override
  void actualizar() {
    nave.actualizar();

    // Generar enemigos periódicamente
    if (app.millis() - tiempoUltimoEnemigo > intervaloEnemigos) {
      enemigos.add(new Enemigo(app.random(50, app.width - 50), -30, int(app.random(2))));
      tiempoUltimoEnemigo = app.millis();
    }

    // Actualizar disparos
    for (int i = disparos.size() - 1; i >= 0; i--) {
      Municion disparo = disparos.get(i);
      disparo.actualizar();
      if (!disparo.estaActiva()) disparos.remove(i);
    }

    // Actualizar enemigos
    for (int i = enemigos.size() - 1; i >= 0; i--) {
      Enemigo enemigo = enemigos.get(i);
      enemigo.actualizar();

      if (!enemigo.estaActivo()) {
        enemigos.remove(i);
      } else if (enemigo.llegaAlFinal()) {
        enemigos.remove(i);
        if (data.vidas <= 0) {
          int duracionMs = app.millis() - data.tiempoInicio;
          int minutos = duracionMs / 60000;
          int segundos = (duracionMs % 60000) / 1000;
          data.duracionJuego = minutos + "m " + segundos + "s";
          controller.cambiarEstado("gameover");
        }
      }
    }

    verificarColisiones();
  }

  void verificarColisiones() {
    // Disparos vs enemigos
    for (int i = disparos.size() - 1; i >= 0; i--) {
      Municion disparo = disparos.get(i);
      for (int j = enemigos.size() - 1; j >= 0; j--) {
        Enemigo enemigo = enemigos.get(j);
        if (disparo.colisionaCon(enemigo)) {
          disparo.desactivar();
          enemigo.destruir();
          data.puntuacion += 10;
          data.disparosAcertados++;
          disparos.remove(i);
          enemigos.remove(j);
          break;
        }
      }
    }

    // Nave vs enemigos
    for (int i = enemigos.size() - 1; i >= 0; i--) {
      Enemigo enemigo = enemigos.get(i);
      if (nave.colisionaCon(enemigo)) {
        data.vidas--;
        enemigos.remove(i);
        if (data.vidas <= 0) {
          int duracionMs = app.millis() - data.tiempoInicio;
          int minutos = duracionMs / 60000;
          int segundos = (duracionMs % 60000) / 1000;
          data.duracionJuego = minutos + "m " + segundos + "s";
          controller.cambiarEstado("gameover");
        }
      }
    }
  }

  @Override
  void dibujar() {
    dibujarEstrellas();
    nave.dibujar();

    for (Municion disparo : disparos) disparo.dibujar();
    for (Enemigo enemigo : enemigos) enemigo.dibujar();

    dibujarHUD();
  }

  void dibujarEstrellas() {
    app.fill(255);
    for (int i = 0; i < 50; i++) {
      float x = (app.frameCount * 2 + i * 37) % app.width;
      float y = (app.frameCount * 1 + i * 23) % app.height;
      app.ellipse(x, y, 1, 1);
    }
  }

  void dibujarHUD() {
    app.fill(255);
    app.textAlign(LEFT);
    app.textSize(16);
    app.text("Jugador: " + data.nombreJugador, 10, 30);
    app.text("Puntuación: " + data.puntuacion, 10, 50);
    app.text("Vidas: " + data.vidas, 10, 70);
    app.text("Disparos acertados: " + data.disparosAcertados, 10, 90);

    int duracionMs = app.millis() - data.tiempoInicio;
    int minutos = duracionMs / 60000;
    int segundos = (duracionMs % 60000) / 1000;
    app.text("Tiempo: " + minutos + "m " + segundos + "s", 10, 110);
  }

  @Override
  void keyPressed(char key, int keyCode) {
    if (key == ' ' && app.millis() - tiempoUltimoDisparo > intervaloDisparos) {
      disparos.add(nave.disparar());
      tiempoUltimoDisparo = app.millis();
    } else {
      nave.establecerMovimiento(keyCode, true);
    }
  }

  @Override
  void keyReleased(char key, int keyCode) {
    nave.establecerMovimiento(keyCode, false);
  }
}
