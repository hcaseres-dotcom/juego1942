class NombreInputView extends View{

    void dibujarView(PApplet app, String nombreJugador){
        fill(255);
        textAlign(CENTER);
        textSize(24);
        text("Ingresa tu nombre:", width/2, height/2 - 80);
        
        // Mostrar último jugador
        String ultimoJugador = GestorDatos.obtenerUltimoJugador(app);
        if (ultimoJugador.length() > 0) {
        textSize(14);
        fill(200, 200, 200);
        text("Último jugador: " + ultimoJugador, width/2, height/2 - 50);
        }
        
        // Campo de texto simulado
        fill(255);
        textSize(32);
        text(nombreJugador + "_", width/2, height/2);
        
        textSize(14);
        fill(150, 150, 150);
        text("Presiona ENTER para continuar", width/2, height/2 + 50);
        if (ultimoJugador.length() > 0) {
        text("Presiona ESC para usar último jugador", width/2, height/2 + 70);
        }
  }
}
