import wollok.game.*
import personaje.*
import paredes.*
import enemigo.*
import sorpresasYVidas.*
import monedas.*
import objetos.*


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
		keyboard.down().onPressDo { personaje.caminar(abajo) }
		keyboard.up().onPressDo { personaje.caminar(arriba) }
		keyboard.right().onPressDo { personaje.caminar(derecha) }
		keyboard.left().onPressDo { personaje.caminar(izquierda) }
		keyboard.s().onPressDo { personaje.soltarArma() }
	
		keyboard.q().onPressDo { game.say(personaje, "basta chicos") }
		keyboard.w().onPressDo { game.say(personaje, "mamaaa cortaste toda la loz") }
		keyboard.e().onPressDo { game.say(personaje, "miamiiii") }
		keyboard.r().onPressDo { game.say(personaje, "yo no manejo el rating, yo manejo un roll royce") }
	}
	
	method definirEventos() {
		game.onTick(2000, "movimiento", { enemigo.perseguir() })
		game.onTick(10000, "aparece sorpresa", { self.spawnear("Sorpresas") })
		game.onTick(10000, "aparece arma", { self.spawnear("ArmasMelee") })
		game.onTick(4000, "aparece moneda", { self.spawnear("Monedas")	})
		
		game.onCollideDo(enemigo, { objeto => objeto.tocarEnemigo(enemigo) })
		game.onCollideDo(personaje, { objeto => objeto.tocarPersonaje(personaje) })
	}
	
	method calcularPosicionAleatoria() {
		const x = (0 .. game.width()-1).anyOne()
		const y = (0 .. game.height()-1).anyOne()
		return game.at(x,y)
	}
	
	method spawnear(objeto){
		objeto.aparecer()
	}
}

//object aparecer{
//	method aparecerArma(posicionAleatoria)=game.addVisual( new ArmasMelee(position = posicionAleatoria) )
//	method aparecerSorpresa(posicionAleatoria)=game.addVisual( new Sorpresa(position = posicionAleatoria) )
//	method aparecerMoneda(posicionAleatoria){
//			const nuevaMoneda = new Moneda(position = posicionAleatoria)
//			nuevaMoneda.calcularValorMoneda()
//			game.addVisual(nuevaMoneda)
//	}
//}