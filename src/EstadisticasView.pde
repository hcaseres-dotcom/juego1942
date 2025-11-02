class EstadisticasView extends View {
    Controller controller;

    EstadisticasView(PApplet app, Controller controller) {
        super(app);
        this.controller = controller;
    }

    @Override
    void iniciar() {}

    @Override
    void actualizar() {}

    @Override
    void dibujar() {
        app.textAlign(CENTER);
        app.fill(255);
        app.textSize(40);
        app.text("ESTADISTICAS DEL JUEGO", app.width / 2, 80);
        app.textSize(20);
        String rutaDatos = sketchPath("datos_juego.json");
        app.text("Los datos se guardan en: " + rutaDatos, app.width / 2, app.height - 30);
        String estadisticas = GestorDatos.obtenerEstadisticas(app);
        app.text(estadisticas, app.width / 2, app.height / 4);
        app.textSize(16);
        app.text("Presiona BACKSPACE o ESC para volver al menú principal.", app.width / 2, app.height - 60);
    }

    @Override
    void keyPressed(char key, int keyCode) {
        if (keyCode == BACKSPACE || keyCode == ESC) {
            controller.cambiarEstado("menu");
        }
        else if (key == '1' || keyCode == ENTER) {
            controller.cambiarEstado("mas_estadisticas");
        }
    }
}