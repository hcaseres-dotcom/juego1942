abstract class View {
  PApplet app;
  
  View(PApplet app) {
    this.app = app;
  }
  
  void iniciar() {}

  void actualizar() {}

  void dibujar() {}

  void keyPressed(char key, int keyCode) {}

  void keyReleased(char key, int keyCode) {}

}

