// Archivo: NombreInputView.pde

class NombreInputView extends View {
  Controller controller;
  GameData data;

  NombreInputView(PApplet app, Controller controller, GameData data) {
    super(app);
    this.controller = controller;
    this.data = data;
  }

  @Override
  void dibujar() {
    app.fill(255);
    app.textAlign(CENTER);
    app.textSize(24);
    app.text("Ingresa tu nombre:", app.width / 2, app.height / 2 - 80);

    String ultimoJugador = GestorDatos.obtenerUltimoJugador(app);
    if (ultimoJugador.length() > 0) {
      app.textSize(14);
      app.fill(200, 200, 200);
      app.text("Último jugador: " + ultimoJugador, app.width / 2, app.height / 2 - 50);
    }

    app.fill(255);
    app.textSize(32);
    app.text(data.nombreJugador + "_", app.width / 2, app.height / 2);

    app.textSize(14);
    app.fill(150, 150, 150);
    app.text("Presiona ENTER para continuar", app.width / 2, app.height / 2 + 50);
    if (ultimoJugador.length() > 0) {
      app.text("Presiona ESC para usar último jugador", app.width / 2, app.height / 2 + 70);
    }
  }

  @Override
  void keyPressed(char key, int keyCode) {
    String ultimoJugador = GestorDatos.obtenerUltimoJugador(app);

    if (keyCode == ENTER) {
      if (data.nombreJugador.length() > 0) {
        controller.cambiarEstado("juego");
      }
    } 
    else if (keyCode == ESC) {
      app.key = 0;
      if (ultimoJugador.length() > 0) {
        data.nombreJugador = ultimoJugador;
        controller.cambiarEstado("juego");
      }
    } 
    else if (keyCode == BACKSPACE) {
      if (data.nombreJugador.length() > 0) {
        data.nombreJugador = data.nombreJugador.substring(0, data.nombreJugador.length() - 1);
      }
    } 
    else if (key >= 32 && key <= 126 && data.nombreJugador.length() < 20) {
      data.nombreJugador += key;
    }
  }
}
