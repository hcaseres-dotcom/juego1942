class GameData {
  String nombreJugador = "";
  int puntuacion = 0;
  int disparosAcertados = 0;
  String duracionJuego = "";
  int vidas = 3;
  int tiempoInicio = 0;

  void reset() {
    puntuacion = 0;
    disparosAcertados = 0;
    duracionJuego = "";
    vidas = 3;
    tiempoInicio = 0;
  }
}
