class GraficoBarras {
  String[] nombres;
  float[] valores;
  float maxValor;

  GraficoBarras(String[] nombres, float[] valores) {
    this.nombres = nombres;
    this.valores = valores;
    
    // Buscar valor máximo
    maxValor = 0;
    for (float v : valores) {
      if (v > maxValor) maxValor = v;
    }
  }

  void dibujar() {
    int num = valores.length;
    float anchoBarra = width / (num + 1);
    
    textAlign(CENTER);
    textSize(14);
    fill(255);
    text("Promedio de puntuaciones por jugador", width/2, 130);

    for (int i = 0; i < num; i++) {
      float altura = map(valores[i], 0, maxValor, 0, height - 250);
      float x = (i + 1) * anchoBarra;
      float y = height - altura - 50;
      
      // Color según valor
      fill(map(valores[i], 0, maxValor, 100, 0),
           map(valores[i], 0, maxValor, 150, 255),
           255);
      rectMode(CORNER);
      rect(x - anchoBarra / 4, y, anchoBarra / 2, altura);
      
      // Etiquetas
      fill(255);
      textSize(10);
      text(nombres[i], x, height - 20);
      text(nf(valores[i], 1, 1), x, y - 5);
    }
  }
}

/*
JSONObject data;
JSONArray jugadores;
GraficoBarras grafico;

void setup() {
  size(900, 500);
  data = loadJSONObject("datos_juego.json");
  jugadores = data.getJSONArray("jugadores");

  int numJugadores = jugadores.size();
  float[] promedios = new float[numJugadores];
  String[] nombres = new String[numJugadores];

  for (int i = 0; i < numJugadores; i++) {
    JSONObject jugador = jugadores.getJSONObject(i);
    String nombre = jugador.getString("nombre").trim();
    JSONArray partidas = jugador.getJSONArray("partidas");

    float suma = 0;
    for (int j = 0; j < partidas.size(); j++) {
      JSONObject partida = partidas.getJSONObject(j);
      suma += partida.getFloat("puntuacion");
    }
    float promedio = partidas.size() > 0 ? suma / partidas.size() : 0;

    nombres[i] = nombre;
    promedios[i] = promedio;
  }

  grafico = new GraficoBarras(nombres, promedios, "Jugadores", "Promedio de Puntos");
  grafico.setTitulo("Promedio de puntuaciones por jugador");

  noLoop();
}

void draw() {
  grafico.dibujar();
}
*/