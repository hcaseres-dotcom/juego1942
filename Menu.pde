class Menu extends Pantalla{

    void dibujarPantalla(){
        fill(255);
        textAlign(CENTER);
        textSize(32);
        text("JUEGO 1942", width/2, height/2 - 50);
        textSize(16);
        text("Presiona ENTER para comenzar", width/2, height/2 + 50);
        text("Usa las flechas para moverte", width/2, height/2 + 80);
        text("Presiona ESPACIO para disparar", width/2, height/2 + 100);
        textSize(12);
        fill(150, 150, 150);
        text("Los datos se guardan en: " + sketchPath("datos_juego.json"), width/2, height - 30);
    }
}
