class MoreEstadisticasView extends View {
    Controller controller;

    MoreEstadisticasView(PApplet app, Controller controller) {
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
        app.text("MAS ESTADISTICAS", app.width / 2, 80);
        
        // Cargar datos desde JSON
        JSONObject data = null;
        try {
            data = app.loadJSONObject("datos_juego.json");
        } catch (Exception e) {
            data = null;
        }

        if (data == null) {
            app.textSize(16);
            app.fill(255, 100, 100);
            app.text("No se encontró src/datos_juego.json", app.width / 2, app.height / 2);
            return;
        }

        JSONArray jugadores = data.getJSONArray("jugadores");
        if (jugadores == null || jugadores.size() == 0) {
            app.textSize(16);
            app.fill(255, 200, 0);
            app.text("No hay jugadores para mostrar.", app.width / 2, app.height / 2);
            return;
        }

        int numJugadores = jugadores.size();
        String[] nombres = new String[numJugadores];
        float[] promedios = new float[numJugadores];

        for (int i = 0; i < numJugadores; i++) {
            JSONObject jugador = jugadores.getJSONObject(i);
            String nombre = jugador.hasKey("nombre") ? jugador.getString("nombre").trim() : ("Jugador " + (i+1));
            JSONArray partidas = jugador.hasKey("partidas") ? jugador.getJSONArray("partidas") : new JSONArray();

            float suma = 0;
            for (int j = 0; j < partidas.size(); j++) {
                JSONObject partida = partidas.getJSONObject(j);
                if (partida.hasKey("puntuacion")) {
                    suma += partida.getFloat("puntuacion");
                }
            }
            float promedio = partidas.size() > 0 ? suma / partidas.size() : 0;

            nombres[i] = nombre;
            promedios[i] = promedio;
        }

        // Dibujar gráfico (la clase GraficoBarras usa las variables globales de Processing)
        GraficoBarras grafico = new GraficoBarras(nombres, promedios);
        grafico.dibujar();
    }

    @Override
    void keyPressed(char key, int keyCode) {
        if (keyCode == BACKSPACE || keyCode == ESC) {
            controller.cambiarEstado("menu");
        }
        else if (key == '1' || keyCode == ENTER) {
            controller.cambiarEstado("estadisticas");
        }
    }
}