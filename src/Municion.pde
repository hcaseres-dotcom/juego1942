// Archivo: Municion.pde

class Municion {
  float x, y;
  float velocidadX, velocidadY;
  int ancho, alto;
  boolean activa;
  
  // Constructor
  Municion(float x, float y, float velX, float velY) {
    this.x = x;
    this.y = y;
    this.velocidadX = velX;
    this.velocidadY = velY;
    this.ancho = 4;
    this.alto = 8;
    this.activa = true;
  }
  
  void actualizar() {
    if (activa) {
      x += velocidadX;
      y += velocidadY;
      
      // Desactivar si sale de la pantalla
      if (x < 0 || x > width || y < 0 || y > height) {
        activa = false;
      }
    }
  }
  
  void dibujar() {
    if (activa) {
      fill(255, 255, 0); // Amarillo para los disparos
      noStroke();
      rect(x, y, ancho, alto);
    }
  }
  
  // Verificar colisión con enemigo
  boolean colisionaCon(Enemigo enemigo) {
    if (!activa) return false;
    
    return (x < enemigo.x + enemigo.ancho &&
            x + ancho > enemigo.x &&
            y < enemigo.y + enemigo.alto &&
            y + alto > enemigo.y);
  }

  // Verificar colisión con nave
  boolean colisionaCon(Nave nave) {
    if (!activa) return false;
    return (x < nave.x + nave.ancho &&
            x + ancho > nave.x &&
            y < nave.y + nave.alto &&
            y + alto > nave.y);
  }
  
  void desactivar() {
    activa = false;
  }
  
  boolean estaActiva() {
    return activa;
  }
}