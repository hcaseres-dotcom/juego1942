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
  
  static void guardarPartida(PApplet app, String nombreJugador, int puntuacion, String duracion, int disparosAcertados) {
    JSONObject datos = cargarDatos(app);
    JSONArray jugadores = datos.getJSONArray("jugadores");
    
    // Buscar jugador existente
    JSONObject jugador = null;
    int indiceJugador;
    
    indiceJugador = -1;
    for (int i = 0; i < jugadores.size(); i++) {
      JSONObject j = jugadores.getJSONObject(i);
      if (j.getString("nombre").equals(nombreJugador)) {
        jugador = j;
        indiceJugador = i;
        break;
      }
    }
    
    // Si no existe, crear nuevo jugador
    if (jugador == null) {
      jugador = new JSONObject();
      jugador.setString("nombre", nombreJugador);
      jugador.setJSONArray("partidas", new JSONArray());
      jugadores.append(jugador);
    }
    
    // Agregar nueva partida
    JSONObject partida = new JSONObject();
    
    // Obtener fecha y hora actual
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String fechaHora = sdf.format(new Date());
    
    partida.setString("fechaHora", fechaHora);
    partida.setInt("puntuacion", puntuacion);
    partida.setString("duracion", duracion);
    partida.setInt("disparosAcertados", disparosAcertados);
    
    JSONArray partidas = jugador.getJSONArray("partidas");
    partidas.append(partida);
    
    // Actualizar �ltimo jugador
    datos.setString("ultimoJugador", nombreJugador);
    
    // Guardar todo
    guardarDatos(app, datos);
    
    println("Partida guardada para: " + nombreJugador);
    println("Archivo guardado en: " + app.sketchPath("datos_juego.json"));
  }
  
  static void mostrarEstadisticas(PApplet app) {
    JSONObject datos = cargarDatos(app);
    JSONArray jugadores = datos.getJSONArray("jugadores");
    
    println("\n=== ESTAD�STICAS DEL JUEGO ===");
    println("Total de jugadores: " + jugadores.size());
    
    for (int i = 0; i < jugadores.size(); i++) {
      JSONObject jugador = jugadores.getJSONObject(i);
      String nombre = jugador.getString("nombre");
      JSONArray partidas = jugador.getJSONArray("partidas");
      
      int totalPartidas = partidas.size();
      int totalPuntos = 0;
      int totalDisparos = 0;
      
      for (int j = 0; j < partidas.size(); j++) {
        JSONObject partida = partidas.getJSONObject(j);
        totalPuntos += partida.getInt("puntuacion");
        totalDisparos += partida.getInt("disparosAcertados");
      }
      
      println("\nJugador: " + nombre);
      println("  Partidas jugadas: " + totalPartidas);
      println("  Puntos totales: " + totalPuntos);
      println("  Disparos acertados totales: " + totalDisparos);
      
      if (totalPartidas > 0) {
        println("  Promedio puntos: " + (totalPuntos / totalPartidas));
        println("  Promedio disparos: " + (totalDisparos / totalPartidas));
        
        // Mostrar �ltima partida
        JSONObject ultimaPartida = partidas.getJSONObject(partidas.size() - 1);
        println("  �ltima partida:");
        println("    Fecha: " + ultimaPartida.getString("fechaHora"));
        println("    Puntos: " + ultimaPartida.getInt("puntuacion"));
        println("    Duraci�n: " + ultimaPartida.getString("duracion"));
      }
    }
    println("\n=============================\n");
  }

  static String obtenerEstadisticas(PApplet app) {
    JSONObject datos = cargarDatos(app);
    JSONArray jugadores = datos.getJSONArray("jugadores");
    
    StringBuilder estadisticas = new StringBuilder();
    estadisticas.append("Total de jugadores: ").append(jugadores.size()).append("\n\n");
    
    for (int i = 0; i < jugadores.size(); i++) {
      JSONObject jugador = jugadores.getJSONObject(i);
      String nombre = jugador.getString("nombre");
      JSONArray partidas = jugador.getJSONArray("partidas");
      
      int totalPartidas = partidas.size();
      int totalPuntos = 0;
      int totalDisparos = 0;
      
      for (int j = 0; j < partidas.size(); j++) {
        JSONObject partida = partidas.getJSONObject(j);
        totalPuntos += partida.getInt("puntuacion");
        totalDisparos += partida.getInt("disparosAcertados");
      }
      
      estadisticas.append("Jugador: ").append(nombre).append("\n");
      estadisticas.append("  Partidas jugadas: ").append(totalPartidas).append("\n");
      estadisticas.append("  Puntos totales: ").append(totalPuntos).append("\n");
      estadisticas.append("  Disparos acertados totales: ").append(totalDisparos).append("\n");
      
      if (totalPartidas > 0) {
        estadisticas.append("  Promedio puntos: ").append(totalPuntos / totalPartidas).append("\n");
        estadisticas.append("  Promedio disparos: ").append(totalDisparos / totalPartidas).append("\n");
        
        // Mostrar �ltima partida
        JSONObject ultimaPartida = partidas.getJSONObject(partidas.size() - 1);
        estadisticas.append("  �ltima partida:\n");
        estadisticas.append("    Fecha: ").append(ultimaPartida.getString("fechaHora")).append("\n");
        estadisticas.append("    Puntos: ").append(ultimaPartida.getInt("puntuacion")).append("\n");
        estadisticas.append("    Duraci�n: ").append(ultimaPartida.getString("duracion")).append("\n");
      }
      estadisticas.append("\n");
    }
    
    return estadisticas.toString();
  }
}
