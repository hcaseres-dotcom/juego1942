// Archivo: GestorDatos.pde

import java.util.Date;
import java.text.SimpleDateFormat;

static class GestorDatos {
  
  static JSONObject cargarDatos(PApplet app) {
    File archivo = new File(app.sketchPath("datos_juego.json"));
    
    if (archivo.exists()) {
      JSONObject datos = app.loadJSONObject("datos_juego.json");
      return datos;
    } else {
      JSONObject nuevosDatos = new JSONObject();
      nuevosDatos.setJSONArray("jugadores", new JSONArray());
      nuevosDatos.setString("ultimoJugador", "");
      return nuevosDatos;
    }
  }
  
  static void guardarDatos(PApplet app, JSONObject datos) {
    app.saveJSONObject(datos, "datos_juego.json");
  }
  
  static String obtenerUltimoJugador(PApplet app) {
    JSONObject datos = cargarDatos(app);
    return datos.getString("ultimoJugador", "");
  }

static void guardarPartida(PApplet app, GameData data) {
  JSONObject datos = cargarDatos(app);
  JSONArray jugadores = datos.getJSONArray("jugadores");

  // Buscar jugador existente
  JSONObject jugador = null;
  int indiceJugador = -1;
  for (int i = 0; i < jugadores.size(); i++) {
    JSONObject j = jugadores.getJSONObject(i);
    if (j.getString("nombre").equals(data.nombreJugador)) {
      jugador = j;
      indiceJugador = i;
      break;
    }
  }

  // Si no existe, crear nuevo jugador
  if (jugador == null) {
    jugador = new JSONObject();
    jugador.setString("nombre", data.nombreJugador);
    jugador.setJSONArray("partidas", new JSONArray());
    jugadores.append(jugador);
  }

  JSONObject partida = new JSONObject();

  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
  String fechaHora = sdf.format(new Date());
  partida.setString("fechaHora", fechaHora);

  partida.setString("nombreJugador", data.nombreJugador);
  partida.setInt("puntuacion", data.puntuacion);
  partida.setInt("disparosAcertados", data.disparosAcertados);
  partida.setInt("disparosTotales", data.disparosTotales);
  partida.setInt("duracionJuego", data.duracionJuego);
  partida.setInt("vidas", data.vidas);
  partida.setInt("tiempoInicio", data.tiempoInicio);

  JSONArray partidas = jugador.getJSONArray("partidas");
  partidas.append(partida);

  datos.setString("ultimoJugador", data.nombreJugador);

  guardarDatos(app, datos);

  println("Partida guardada para: " + data.nombreJugador);
  println("Archivo guardado en: " + app.sketchPath("datos_juego.json"));
}

  
  static String obtenerEstadisticas(PApplet app) {
  JSONObject datos = cargarDatos(app);
  JSONArray jugadores = datos.getJSONArray("jugadores");

  if (jugadores == null || jugadores.size() == 0) {
    return "No hay datos de partidas registradas.";
  }

  int totalPartidas = 0;
  float sumaDuracion = 0;
  float sumaDisparosTotales = 0;
  float sumaDisparosAcertados = 0;

  // Para mejor partida
  JSONObject mejorPartida = null;
  String mejorJugador = "";
  int mejorPuntaje = -1;

  // Recorrer todos los jugadores y sus partidas
  for (int i = 0; i < jugadores.size(); i++) {
    JSONObject jugador = jugadores.getJSONObject(i);
    JSONArray partidas = jugador.getJSONArray("partidas");
    String nombreJugador = jugador.getString("nombre");

    for (int j = 0; j < partidas.size(); j++) {
      JSONObject partida = partidas.getJSONObject(j);
      totalPartidas++;

      int puntuacion = partida.getInt("puntuacion");
      int disparosAcertados = partida.hasKey("disparosAcertados") ? partida.getInt("disparosAcertados") : 0;
      int disparosTotales = partida.hasKey("disparosTotales") ? partida.getInt("disparosTotales") : 0;
      int duracion = partida.hasKey("duracionJuego") ? partida.getInt("duracionJuego") : 0;

      sumaDuracion += duracion;
      sumaDisparosTotales += disparosTotales;
      sumaDisparosAcertados += disparosAcertados;

      if (puntuacion > mejorPuntaje) {
        mejorPuntaje = puntuacion;
        mejorPartida = partida;
        mejorJugador = nombreJugador;
      }
    }
  }

  if (totalPartidas == 0) {
    return "No hay partidas registradas.";
  }

  // Calcular promedios
  float duracionPromedio = sumaDuracion / totalPartidas;
  float disparosPromedio = sumaDisparosTotales / totalPartidas;
  float disparosAcertadosPromedio = sumaDisparosAcertados / totalPartidas;

  // Calcular precisión de la mejor partida
  float porcentajeAcierto = 0;
  if (mejorPartida != null && mejorPartida.hasKey("disparosTotales")) {
    int dt = mejorPartida.getInt("disparosTotales");
    int da = mejorPartida.getInt("disparosAcertados");
    if (dt > 0) porcentajeAcierto = (da * 100.0f) / dt;
  }

  StringBuilder sb = new StringBuilder();

  sb.append("=== MEJOR PARTIDA ===\n");
  sb.append("Hecha por: ").append(mejorJugador).append("\n");
  sb.append("Puntaje: ").append(mejorPuntaje).append("\n");
  sb.append("Duración: ").append(mejorPartida != null ? mejorPartida.getInt("duracionJuego") + " s" : "N/A").append("\n");
  sb.append("Porcentaje de disparos acertados: ").append(String.format("%.2f", porcentajeAcierto)).append("%\n\n");

  sb.append("=== ESTADÍSTICAS ===\n");
  sb.append("Partidas jugadas totales: ").append(totalPartidas).append("\n");
  sb.append("Duración promedio por partida: ").append(String.format("%.2f", duracionPromedio)).append(" s\n");
  sb.append("Promedio de disparos por partida: ").append(String.format("%.2f", disparosPromedio)).append("\n");
  sb.append("Promedio de disparos acertados por partida: ").append(String.format("%.2f", disparosAcertadosPromedio)).append("\n");

  return sb.toString();
}


}
