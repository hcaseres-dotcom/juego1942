class MenuView extends View {
	Controller controller;
	PImage logoflecha;
	PImage logocruz;
	PFont fuenteRetro;

  	MenuView(PApplet app, Controller controller) {
		super(app);
		this.controller = controller;
		fuenteRetro = loadFont("PressStart2P-Regular-32.vlw");
		logoflecha = loadImage("flecha.png");
		logocruz = loadImage("cruz.png");
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
		app.textSize(55);
		app.fill(#74cc00);  
		app.text("1942", app.width/2, app.height/2 - 120);
		app.textSize(35);
		app.fill(#ffffff);
		app.text("1 JUGAR", app.width/2-30, app.height/2-50);
		if (logoflecha != null) {
			app.imageMode(CENTER);
			app.image(logoflecha, app.width/2+140, app.height/2 - 70, 120, 120);
		}
		app.text("2 SALIR", app.width/2-30, app.height/2+20);
			if (logocruz != null) {
			app.image(logocruz, app.width/2+135, app.height/2, 120, 120);
		}
		app.textSize(20);
		app.textAlign(RIGHT);
		app.text("3 INSTRUCCIONES", app.width/2-70, app.height/2+200);
		app.textAlign(LEFT);
		app.text("4 ESTADISTICAS", app.width/2+40, app.height/2+200);
		app.textSize(12);
		app.fill(150, 150, 150);
		app.text("Los datos se guardan en: " + sketchPath("datos_juego.json"), app.width/2, app.height - 30);
	}

	@Override
	void keyPressed(char key, int keyCode) {
		if (keyCode == ENTER) {
			controller.cambiarEstado("nombre");
		}
		else if (key == '1') {
			controller.cambiarEstado("nombre");
		}
		else if (key == '2') {
			app.exit();
		}
		else if (key == '3') {
			controller.cambiarEstado("instrucciones");
		}
		else if (key == '4') {
			//controller.cambiarEstado("estadisticas");
		}
	}
}
