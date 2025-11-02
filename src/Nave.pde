// Archivo: Nave.pde

class Nave {
  PApplet app;
  float x, y;
  float velocidad;
  int ancho, alto;
  boolean moverIzquierda, moverDerecha, moverArriba, moverAbajo;
  PImage imgNave;
  
  // Constructor
  Nave(PApplet app, float x, float y) {
    this.app = app;
    this.x = x;
    this.y = y;
    this.velocidad = 5;
    this.ancho = 60;
    this.alto = 45;
    this.moverIzquierda = false;
    this.moverDerecha = false;
    this.moverArriba = false;
    this.moverAbajo = false;
    this.imgNave = app.loadImage("nave.png"); // Cargar imagen de la nave
  }
  
  void actualizar() {
    // Movimiento basado en las teclas presionadas
    if (moverIzquierda && x > 0) {
      x -= velocidad;
    }
    if (moverDerecha && x < width - ancho) {
      x += velocidad;
    }
    if (moverArriba && y > 0) {
      y -= velocidad;
    }
    if (moverAbajo && y < height - alto) {
      y += velocidad;
    }
  }
  
  void dibujar() {
    // Dibujar hit triangle para depuración
    /*
    fill(0, 255, 0, 50);
    stroke(255, 0, 0);
    triangle(x + ancho/2, y + alto,           // punta superior
             x, y,              // esquina inferior izquierda
             x + ancho, y);     // esquina inferior derecha
    */

    // Dibujar la imagen en el mismo lugar que el triángulo
    app.imageMode(CENTER);
    app.image(imgNave, x + ancho/2, y + alto/2, ancho, alto);

  }
  
  // Métodos para controlar el movimiento
  void establecerMovimiento(int codigo, boolean estado) {
    if (codigo == LEFT) moverIzquierda = estado;
    if (codigo == RIGHT) moverDerecha = estado;
    if (codigo == UP) moverArriba = estado;
    if (codigo == DOWN) moverAbajo = estado;
  }
  
  // Método para disparar
  Municion disparar() {
    return new Municion(x + ancho/2, y, 0, -8, false); // Disparo hacia arriba
  }
  
  // Verificar colisión
  boolean colisionaCon(Enemigo enemigo) {
    return (x < enemigo.x + enemigo.ancho &&
            x + ancho > enemigo.x &&
            y < enemigo.y + enemigo.alto &&
            y + alto > enemigo.y);
  }
}
