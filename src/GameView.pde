class GameView extends View{

    void dibujarView(Nave nave, ArrayList<Municion> disparos, ArrayList<Enemigo> enemigos, String nombreJugador, int puntuacion, int vidas, int disparosAcertados, int tiempoInicio){
        dibujarEstrellas();
        
        nave.dibujar();
        
        for (Municion disparo : disparos) {
        disparo.dibujar();
        }
        
        for (Enemigo enemigo : enemigos) {
        enemigo.dibujar();
        }
        
        dibujarHUD(nombreJugador, puntuacion, vidas, disparosAcertados, tiempoInicio);
    }
    
    void dibujarEstrellas() {
        fill(255);
        for (int i = 0; i < 50; i++) {
        float x = (frameCount * 2 + i * 37) % width;
        float y = (frameCount * 1 + i * 23) % height;
        ellipse(x, y, 1, 1);
        }
    }
    
    void dibujarHUD(String nombreJugador, int puntuacion, int vidas, int disparosAcertados, int tiempoInicio) {
        fill(255);
        textAlign(LEFT);
        textSize(16);
        text("Jugador: " + nombreJugador, 10, 30);
        text("Puntuación: " + puntuacion, 10, 50);
        text("Vidas: " + vidas, 10, 70);
        text("Disparos acertados: " + disparosAcertados, 10, 90);
        
        // Tiempo transcurrido
        int duracionMs = millis() - tiempoInicio;
        int minutos = duracionMs / 60000;
        int segundos = (duracionMs % 60000) / 1000;
        text("Tiempo: " + minutos + "m " + segundos + "s", 10, 110);
    }
}
