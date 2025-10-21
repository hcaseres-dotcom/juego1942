class GameOverView extends View{

    void dibujarView(String nombreJugador, int puntuacion, int disparosAcertados, String duracionJuego){
        fill(255, 0, 0);
        textAlign(CENTER);
        textSize(32);
        text("GAME OVER", width/2, height/2 - 120);
        
        fill(255);
        textSize(18);
        text("Jugador: " + nombreJugador, width/2, height/2 - 70);
        text("Puntuación Final: " + puntuacion, width/2, height/2 - 40);
        text("Disparos acertados: " + disparosAcertados, width/2, height/2 - 10);
        text("Duración: " + duracionJuego, width/2, height/2 + 20);
        
        textSize(16);
        fill(0, 255, 0);
        text("✓ Datos guardados correctamente", width/2, height/2 + 60);
        
        textSize(14);
        fill(255);
        text("Presiona R para jugar de nuevo", width/2, height/2 + 100);
        
        textSize(12);
        fill(150, 150, 150);
        text("Archivo: " + sketchPath("datos_juego.json"), width/2, height - 30);
    }
}
