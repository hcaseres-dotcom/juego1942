class GameData {
  String nombreJugador = "";
  int puntuacion = 0;
  int disparosAcertados = 0;
  int disparosTotales = 0;
  int duracionJuego = 0;
  int vidas = 3;
  int tiempoInicio = 0;

  void reset() {
    puntuacion = 0;
    disparosAcertados = 0;
    disparosTotales = 0;
    duracionJuego = 0;
    vidas = 3;
    tiempoInicio = 0;
  }
}
