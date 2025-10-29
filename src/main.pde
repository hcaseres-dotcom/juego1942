// Archivo principal: juego_1942.pde

Controller controller;

void setup() {
  size(800, 600);
  controller = new Controller(this);
}

void draw() {
  controller.actualizar();
  controller.dibujar();
}

// Captura de eventos del teclado
void keyPressed() {
  controller.manejarTeclaPresionada(key, keyCode);
}

void keyReleased() {
  controller.manejarTeclaSoltada(key, keyCode);
}
  
