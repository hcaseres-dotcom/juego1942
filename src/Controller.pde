class Controller {

  PApplet app;
  GameData gameData;
  HashMap<String, View> vistas;
  View estadoActual;

  Controller(PApplet app) {
    this.app = app;
    this.gameData = new GameData();
    this.vistas = new HashMap<String, View>();

    vistas.put("menu", new MenuView(app, this));
    vistas.put("nombre", new NombreInputView(app, this, gameData));
    vistas.put("juego", new GameView(app, this, gameData));
    vistas.put("gameover", new GameOverView(app, this, gameData));
    vistas.put("instrucciones", new InstruccionesView(app, this));
    vistas.put("pausa", new PausaView(app, this));

    cambiarEstado("menu");
  }

  void cambiarEstado(String nuevoEstado) {
    estadoActual = vistas.get(nuevoEstado);
    estadoActual.iniciar();
    
  }

  void actualizar() {
    estadoActual.actualizar();
  }

  void dibujar() {
    app.background(0, 0, 50);
    estadoActual.dibujar();
  }

  void manejarTeclaPresionada(char key, int keyCode) {
    estadoActual.keyPressed(key, keyCode);
  }

  void manejarTeclaSoltada(char key, int keyCode) {
    estadoActual.keyReleased(key, keyCode);
  }
}
