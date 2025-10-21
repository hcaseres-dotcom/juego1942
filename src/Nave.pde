// Archivo: Nave.pde

class Nave {
  float x, y;
  float velocidad;
  int ancho, alto;
  boolean moverIzquierda, moverDerecha, moverArriba, moverAbajo;
  
  // Constructor
  Nave(float x, float y) {
    this.x = x;
    this.y = y;
    this.velocidad = 5;
    this.ancho = 40;
    this.alto = 30;
    this.moverIzquierda = false;
    this.moverDerecha = false;
    this.moverArriba = false;
    this.moverAbajo = false;
  }
  
  void actualizar() {
    // Movimiento basado en las teclas presionadas
    if (moverIzquierda && x > 0) {
      x -= velocidad;
    }
    if (moverDerecha && x < width - ancho) {
      x += velocidad;
    }
    if (moverArriba && y > height/2) {  // Limitar movimiento hacia arriba
      y -= velocidad;
    }
    if (moverAbajo && y < height - alto) {
      y += velocidad;
    }
  }
  
  void dibujar() {
    // Dibujar la nave como un triángulo
    fill(0, 255, 0);
    stroke(255);
    triangle(x + ancho/2, y,           // punta superior
             x, y + alto,              // esquina inferior izquierda
             x + ancho, y + alto);     // esquina inferior derecha
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
    return new Municion(x + ancho/2, y, 0, -8); // Disparo hacia arriba
  }
  
  // Verificar colisión
  boolean colisionaCon(Enemigo enemigo) {
    return (x < enemigo.x + enemigo.ancho &&
            x + ancho > enemigo.x &&
            y < enemigo.y + enemigo.alto &&
            y + alto > enemigo.y);
  }
}
