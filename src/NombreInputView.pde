// Archivo: NombreInputView.pde

class NombreInputView extends View {
	Controller controller;
	GameData data;
	PImage logoflechaverde;
	PImage logoflechablanca;


	NombreInputView(PApplet app, Controller controller, GameData data) {
		super(app);
		this.controller = controller;
		this.data = data;
		logoflechaverde = loadImage("flecha.png");
    	logoflechablanca = loadImage("flechablanca.png");
	}

	@Override
	void dibujar() {
		String ultimoJugador = GestorDatos.obtenerUltimoJugador(app);
        if (ultimoJugador.length() > 0) {
			app.textSize(20);
			app.fill(255);
			app.textAlign(CENTER);
			app.text("0 REPETIR ULTIMO JUGADOR: " + ultimoJugador, app.width/2, app.height/2 - 160);
        }
        app.textSize(40);
        app.text("Ingresa tu nombre:", app.width/2, app.height/2 - 80);
        // Campo de texto simulado
        app.text(data.nombreJugador + "_", app.width/2, app.height/2);
        app.textSize(20);
        app.textAlign(LEFT);
        if (logoflechaverde != null) {
        	app.image(logoflechaverde, app.width/2+245, app.height/2 +90, 100, 100);
        }
        app.text("1 JUGAR", app.width/2+70, app.height/2 + 100);
        app.textAlign(RIGHT);
        if (logoflechablanca != null) {
       		app.image(logoflechablanca, app.width/2-30, app.height/2 +90, 100, 100);
        }
		app.text("2 VOLVER", app.width/2-70, app.height/2 + 100);
	}

	@Override
	void keyPressed(char key, int keyCode) {
		String ultimoJugador = GestorDatos.obtenerUltimoJugador(app);

		if (key == '1') {
			if (data.nombreJugador.length() > 0) {
				controller.cambiarEstado("juego");
			}
		} 
		else if (key == '2') {
			app.key = 0;
			controller.cambiarEstado("menu");
		}
		else if (keyCode == ENTER) {
			if (data.nombreJugador.length() > 0) {
				controller.cambiarEstado("juego");
			}
		} 
		else if (keyCode == ESC) {
			app.key = 0;
			if (ultimoJugador.length() > 0) {
				data.nombreJugador = ultimoJugador;
				controller.cambiarEstado("juego");
			}
		} 
		else if (keyCode == BACKSPACE) {
			if (data.nombreJugador.length() > 0) {
				data.nombreJugador = data.nombreJugador.substring(0, data.nombreJugador.length() - 1);
			}
		} 
		else if (key >= 32 && key <= 126 && data.nombreJugador.length() < 20) {
			data.nombreJugador += key;
		}
	}
}
