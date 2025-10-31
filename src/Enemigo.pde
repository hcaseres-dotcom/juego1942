// Archivo: Enemigo.pde

class Enemigo {
  float x, y;
  float velocidad;
  int ancho, alto;
  boolean activo;
  int tipoEnemigo;
  
  // Constructor
  Enemigo(float x, float y, int tipo) {
    this.x = x;
    this.y = y;
    this.velocidad = random(1, 3);
    this.ancho = 30;
    this.alto = 25;
    this.activo = true;
    this.tipoEnemigo = tipo;
  }
  
  void actualizar() {
    if (activo) {
      y += velocidad;
      
      // Movimiento lateral para algunos tipos de enemigos
      if (tipoEnemigo == 1) {
        x += sin(y * 0.02) * 2;
      }
      
      // Desactivar si sale de la pantalla
      if (y > height) {
        activo = false;
      }
    }
  }
  
  void dibujar() {
    if (activo) {
      // Color según el tipo de enemigo
      switch(tipoEnemigo) {
        case 0:
          fill(255, 0, 0); // Rojo
          break;
        case 1:
          fill(255, 0, 255); // Magenta
          break;
        default:
          fill(150, 150, 150); // Gris
      }
      
      stroke(255);
      rect(x, y, ancho, alto);
      
      // Dibujar detalles del enemigo
      fill(255);
      rect(x + 5, y + 5, 5, 5);
      rect(x + ancho - 10, y + 5, 5, 5);
    }
  }
  
  void destruir() {
    activo = false;
  }
  
  boolean estaActivo() {
    return activo;
  }
  
  // Verificar si llegó al final de la pantalla
  boolean llegaAlFinal() {
    return y > height - alto;
  }

  // Enemigo dispara
  Municion disparar() {
    return new Municion(x + ancho / 2, y + alto, 0, 5, true);
  }
}