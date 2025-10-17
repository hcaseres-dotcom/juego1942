// Archivo principal: juego_1942.pde

Controller juego;

void setup() {
  size(800, 600);
  juego = new Controller(this);
}

void draw() {
  juego.actualizar();
  juego.dibujar();
}

// Captura de eventos del teclado
void keyPressed() {
  juego.manejarTeclaPresionada(key, keyCode);
}

void keyReleased() {
  juego.manejarTeclaSoltada(key, keyCode);
}
  
