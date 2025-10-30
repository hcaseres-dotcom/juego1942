class MenuView extends View {
  Controller controller;

  MenuView(PApplet app, Controller controller) {
    super(app);
    this.controller = controller;
  }

  @Override
  void iniciar() {
  }

  @Override
  void actualizar() {
  }

  @Override
  void dibujar() {
    app.background(0, 0, 50);
    app.fill(255);
    app.textAlign(CENTER);
    app.textSize(32);
    app.text("JUEGO 1942", app.width / 2, app.height / 2 - 50);

    app.textSize(16);
    app.text("Presiona ENTER para comenzar", app.width / 2, app.height / 2 + 50);
    app.text("Usa las flechas para moverte", app.width / 2, app.height / 2 + 80);
    app.text("Presiona ESPACIO para disparar", app.width / 2, app.height / 2 + 100);

    app.textSize(12);
    app.fill(150, 150, 150);
    app.text(
      "Los datos se guardan en: " + app.sketchPath("datos_juego.json"),
      app.width / 2,
      app.height - 30
    );
  }

  @Override
  void keyPressed(char key, int keyCode) {
    if (keyCode == ENTER) {
      controller.cambiarEstado("nombre");
    }
  }
}
