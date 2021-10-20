import wollok.game.*
import personaje.*
import paredes.*
import enemigo.*
import puntosYVidas.*
import objetos.*


object juego {
	
	method jugar() {
		self.configurarPantalla()
		nivel1.cargar()
		self.agregarPersonajes()
		self.definirControles()
		self.definirEventos()
		game.start()
	}
	
	method configurarPantalla() {
		game.width(20)
		game.height(20)
		game.title("Juego")
		game.ground("Visuals/BACKGROUND/terrain.jpg")
	}
	
	method agregarPersonajes() {
		const fantasma = new Fantasma ( position = posAleatoria.calcularLibre() )
		game.addVisual(personaje)
		game.addVisual(vida)
		game.addVisual(puntos)
		game.addVisual(fantasma)
		game.addVisual(armaDisparo)
		game.onTick(1000, "movimiento fantasma", {fantasma.perseguir()})
	}
	
	method definirControles() {
		keyboard.down().onPressDo { personaje.caminar(abajo) }
		keyboard.up().onPressDo { personaje.caminar(arriba) }
		keyboard.right().onPressDo { personaje.caminar(derecha) }
		keyboard.left().onPressDo { personaje.caminar(izquierda) }
		keyboard.s().onPressDo { personaje.soltarArma() }
		keyboard.d().onPressDo { personaje.disparar() }
	
		keyboard.q().onPressDo { game.say(personaje, "basta chicos") }
		keyboard.w().onPressDo { game.say(personaje, "mamaaa cortaste toda la loz") }
		keyboard.e().onPressDo { game.say(personaje, "miamiiii") }
		keyboard.r().onPressDo { game.say(personaje, "yo no manejo el rating, yo manejo un roll royce") }
	}
	
	method definirEventos() {
		game.onTick(10000, "aparece sorpresa", { self.spawnear(new Sorpresas( position = posAleatoria.calcularLibre() )) })
		game.onTick(10000, "aparece espada", { self.spawnear(new ArmasMelee(position = posAleatoria.calcularLibre() )) })
		game.onTick(4000, "aparece moneda", { self.spawnear(new Monedas(position = posAleatoria.calcularLibre() )) })
		game.onTick(10000, "aparece obstáculo", {self.nuevoObstaculo()})
		game.onTick(5000, "aparece enemigo", {self.nuevoEnemigoTerrestre()})
		
		game.onCollideDo(personaje, { objeto => objeto.tocarPersonaje(personaje) })
	}
	
	method nuevoEnemigoTerrestre(){
		const nuevoEnemigoTerrestre = new EnemigoTerrestre (position = posAleatoria.calcularLibre())
		self.spawnear(nuevoEnemigoTerrestre)
		game.onCollideDo(nuevoEnemigoTerrestre, { objeto => objeto.tocarEnemigo(nuevoEnemigoTerrestre) })
		game.onTick(3000, "movimiento enemigo terrestre", {nuevoEnemigoTerrestre.perseguir()})
	}
	
	method nuevoObstaculo(){
		const nuevoObstaculo = new Obstaculo (position = posAleatoria.calcularLibre())
		self.spawnear(nuevoObstaculo)
		game.onCollideDo(nuevoObstaculo, { objeto => objeto.colisionPared() })
	}
	
	method spawnear(objeto){
		objeto.aparecer()
		
		game.schedule(7000, {objeto.desaparecer()})
	}
	
}