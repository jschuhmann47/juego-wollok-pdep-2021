import wollok.game.*
import personaje.*
import paredes.*
import enemigo.*
import sorpresasYVidas.*
import armas.*
import monedas.*


object juego {
	
	method jugar() {
		self.configurarPantalla()
		self.agregarPersonajes()
		self.definirControles()
		self.definirEventos()
		nivel1.cargar()
		game.start()
	}
	
	method configurarPantalla() {
		game.width(20)
		game.height(20)
		game.title("Juego")
		game.ground("Visuals/BACKGROUND/terrain.jpg")
	}
	
	method agregarPersonajes() {
		game.addVisual(personaje)
		game.addVisual(enemigo)
		game.addVisual(vida)
		game.addVisual(puntos)
	}
	
	method definirControles() {
		keyboard.down().onPressDo { personaje.abajo() }
		keyboard.up().onPressDo { personaje.arriba() }
		keyboard.right().onPressDo { personaje.derecha() }
		keyboard.left().onPressDo { personaje.izquierda() }
		keyboard.s().onPressDo { personaje.soltarArma() }
	
		keyboard.q().onPressDo { game.say(personaje, "basta chicos") }
		keyboard.w().onPressDo { game.say(personaje, "mamaaa cortaste toda la loz") }
		keyboard.e().onPressDo { game.say(personaje, "miamiiii") }
		keyboard.r().onPressDo { game.say(personaje, "yo no manejo el rating, yo manejo un roll royce") }
	}
	
	method definirEventos() {
		game.onTick(2000, "movimiento", { enemigo.perseguir() })
		game.onTick(10000, "aparece sorpresa", { self.aparecerSorpresa() })
		game.onTick(10000, "aparece arma", { self.aparecerArma() })
		game.onTick(4000, "aparece moneda", { self.aparecerMoneda()	})
		
		game.onCollideDo(enemigo, { objeto => objeto.tocarEnemigo(enemigo) })
		game.onCollideDo(personaje, { objeto => objeto.tocarPersonaje(personaje) })
	}
	
	method calcularPosicionAleatoria() {
		const x = (0 .. game.width()-1).anyOne()
		const y = (0 .. game.height()-1).anyOne()
		return game.at(x,y)
	}
	
	method aparecerSorpresa() {
		const posicionAleatoria = self.calcularPosicionAleatoria()
		const esP = game.getObjectsIn( posicionAleatoria ).any({ objeto => objeto.esPared() || objeto.esArma() || objeto.esMoneda() })
		if(esP)
			self.aparecerSorpresa()
		else
			game.addVisual( new Sorpresa(position = posicionAleatoria) )
	}
	
	method aparecerArma(){
		const posicionAleatoria = self.calcularPosicionAleatoria()
		const esP = game.getObjectsIn( posicionAleatoria ).any({ objeto => objeto.esPared() || objeto.esSorpresa() || objeto.esMoneda() })
		if(esP)
			self.aparecerArma()
		else
			game.addVisual( new Arma(position = posicionAleatoria) )
	}
	
	method aparecerMoneda(){
		const posicionAleatoria = self.calcularPosicionAleatoria()
		const esP = game.getObjectsIn( posicionAleatoria ).any({ objeto => objeto.esPared() || objeto.esMoneda() || objeto.esArma() || objeto.esSorpresa() })
		if(esP)
			self.aparecerMoneda()
		else{
			const nuevaMoneda = new Moneda(position = posicionAleatoria)
			nuevaMoneda.calcularValorMoneda()
			game.addVisual(nuevaMoneda)
		}
	}
	
}