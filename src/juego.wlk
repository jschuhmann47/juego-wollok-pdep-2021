import wollok.game.*
import personaje.*
import paredes.*
import enemigo.*
import puntosYVidas.*
import objetos.*


object juego {
	const enemigo = new EnemigoTerrestre( position = posAleatoria.calcularLibre() )
	const fantasma = new Fantasma ( position = posAleatoria.calcularLibre() )
	
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
		game.addVisual(vida)
		game.addVisual(puntos)
		game.addVisual(enemigo)
		game.addVisual(fantasma)
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
		game.onTick(4000, "movimiento fantasma", {fantasma.perseguir()})
		game.onTick(2000, "movimiento enemigo terrestre", {enemigo.perseguir()})
		
		game.onTick(10000, "aparece sorpresa", { self.spawnear(new Sorpresas( position = posAleatoria.calcularLibre() )) })
		game.onTick(10000, "aparece arma", { self.spawnear(new ArmasMelee(position = posAleatoria.calcularLibre() )) })
		game.onTick(4000, "aparece moneda", { self.spawnear(new Monedas(position = posAleatoria.calcularLibre() )) })
		
		game.onCollideDo(enemigo, { objeto => objeto.tocarEnemigo(enemigo) })
		game.onCollideDo(personaje, { objeto => objeto.tocarPersonaje(personaje) })
	}
	
	method spawnear(objeto){
		objeto.aparecer()
		
		game.schedule(7000, {objeto.desaparecer()})
	}
	
}