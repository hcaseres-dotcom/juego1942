// Archivo: Enemigo.pde

class Enemigo {
  PApplet app;
  float x, y;
  float velocidad;
  int ancho, alto;
  boolean activo;
  int tipoEnemigo;
  PImage imgEnemigo;
  
  // Constructor
  Enemigo(PApplet app, float x, float y, int tipo) {
    this.app = app;
    this.x = x;
    this.y = y;
    this.velocidad = random(1, 3);
    this.ancho = 45;
    this.alto = 45;
    this.activo = true;
    this.tipoEnemigo = tipo;
    // this.imgEnemigo = app.loadImage("enemigo" + tipo + ".png"); // Cargar imagen según el tipo
    this.imgEnemigo = app.loadImage("enemigo.png"); // Cargar imagen según el tipo
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
          fill(255, 0, 0, 50); // Rojo
          break;
        case 1:
          fill(255, 0, 255, 50); // Magenta
          break;
        default:
          fill(150, 150, 150, 50); // Gris
      }
      
      // Dibujar hit box para depuración
      /*
      stroke(255, 0, 0, 50);
      rect(x, y, ancho, alto);
      */

      // Dibujar la imagen en el mismo lugar que el triángulo
      app.imageMode(CENTER);
      app.image(imgEnemigo, x + ancho/2, y + alto/2, ancho, alto);
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