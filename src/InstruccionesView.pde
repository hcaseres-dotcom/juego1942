class InstruccionesView extends View {
    PFont fuenteRetro;
    Controller controller;
    
    InstruccionesView(PApplet app, Controller controller) {
        super(app);
        this.controller = controller;
        fuenteRetro = loadFont("PressStart2P-Regular-32.vlw");
    }
    
    @Override
    void iniciar(){}
    
    @Override
    void actualizar(){}
    
    @Override
    void dibujar(){
        app.background(#020c45);
        app.textFont(fuenteRetro);
        app.textAlign(CENTER);
        app.textSize(30);
        app.fill(#ffffff);
        app.text("INSTRUCCIONES", app.width/2, 80);
        app.textSize(16);
        String instrucciones = "Bienvenido a 1942!\n\n" +
                               "Controles:\n" +
                               "- Mover la nave: Flechas de direccion\n" +
                               "- Disparar: Barra espaciadora\n\n\n" +
                               "Objetivo:\n" +
                               "Sobrevive el mayor tiempo posible y \ndestruye tantos enemigos como puedas.\n\n\n\n\n\n\n" +
                               "Presiona BACKSPACE para volver al\nmenu principal.";
        app.text(instrucciones, app.width/2, app.height/4);
    }
    
    @Override
    void keyPressed(char key, int keyCode) {
        if (keyCode == BACKSPACE) {
            controller.cambiarEstado("menu");
        }
    }
}