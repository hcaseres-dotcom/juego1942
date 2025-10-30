class PausaView extends View {
    PFont fuenteRetro;
    Controller controller;

    PausaView(PApplet app, Controller controller) {
        super(app);
        this.controller = controller;
        fuenteRetro = loadFont("PressStart2P-Regular-32.vlw");
    }
    
    @Override
    void iniciar(){}
    
    @Override
    void actualizar(){}

    @Override
    void dibujar() {
        app.background(0, 150);
        app.textAlign(CENTER);
        app.fill(255);
        app.textSize(50);
        app.text("JUEGO EN PAUSA", app.width / 2, app.height / 2 - 50);
        
        app.textSize(25);
        app.text("Presiona (P) para reanudar", app.width / 2, app.height / 2 + 20);
        app.text("Presiona (BACKSPACE) para volver al menú principal", app.width / 2, app.height / 2 + 60);
    }
    
    @Override
    void keyPressed(char key, int keyCode) {
        if (key == 'p' || key == 'P' || keyCode == ENTER) {
            controller.cambiarEstado("juego");
        } else if (keyCode == BACKSPACE || keyCode == ESC) {
            controller.cambiarEstado("menu");
        }
    }
}
