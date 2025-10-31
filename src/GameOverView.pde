// Archivo: GameOverView.pde

class GameOverView extends View {

  Controller controller;
  GameData data;

  GameOverView(PApplet app, Controller controller, GameData data) {
    super(app);
    this.controller = controller;
    this.data = data;
  }

  @Override
  void iniciar() {
      GestorDatos.guardarPartida(app, data.nombreJugador, data.puntuacion, data.duracionJuego, data.disparosAcertados);
      GestorDatos.mostrarEstadisticas(app);
  }

  @Override
  void actualizar() {
  }

  @Override
  void dibujar() {
    app.fill(255, 0, 0);
    app.textAlign(CENTER);
    app.textSize(32);
    app.text("GAME OVER", app.width / 2, app.height / 2 - 120);

    app.fill(255);
    app.textSize(18);
    app.text("Jugador: " + data.nombreJugador, app.width / 2, app.height / 2 - 70);
    app.text("Puntuación Final: " + data.puntuacion, app.width / 2, app.height / 2 - 40);
    app.text("Disparos acertados: " + data.disparosAcertados, app.width / 2, app.height / 2 - 10);
    app.text("Disparos totales: " + data.disparosTotales, app.width / 2, app.height / 2 + 20);
    app.text("Duración: " + data.duracionJuego, app.width / 2, app.height / 2 + 50);

    app.textSize(16);
    app.fill(0, 255, 0);
    app.text("✓ Datos guardados correctamente", app.width / 2, app.height / 2 + 80);

    app.textSize(14);
    app.fill(255);
    app.text("Presiona R para jugar de nuevo", app.width / 2, app.height / 2 + 110);

    app.textSize(12);
    app.fill(150, 150, 150);
    app.text("Archivo: " + app.sketchPath("datos_juego.json"), app.width / 2, app.height - 30);
  }

  @Override
  void keyPressed(char key, int keyCode) {
    if (key == 'r' || key == 'R') {
      data.reset();
      controller.cambiarEstado("nombre");
    }
  }
}
