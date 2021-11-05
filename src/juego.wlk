import wollok.game.*
import personaje.*
import paredes.*
import enemigos.*
import puntosYVidas.*
import objetos.*
import niveles.*

const enemigosT = new List()

object juego {
	
	var property nivelActual = uno
	
	method configurarPantalla() {
		game.width(20)
		game.height(20)
		game.title("Juego")
		nivelActual.fondo()
	}
	
	method configurarFantasma(){
		fantasma.position( posAleatoria.calcularLibre() )
		game.addVisual(fantasma)
		game.onTick(4000, "movimiento fantasma", {fantasma.perseguir()})
	}
	
	method jugar() {
		self.configurarPantalla()
		
		game.addVisual(personaje)
		game.onCollideDo(personaje, { objeto => objeto.tocarPersonaje(personaje) })
		game.addVisual(vida)
		game.addVisual(puntos)
		
		keyboard.down().onPressDo { personaje.caminar(abajo) }
		keyboard.up().onPressDo { personaje.caminar(arriba) }
		keyboard.right().onPressDo { personaje.caminar(derecha) }
		keyboard.left().onPressDo { personaje.caminar(izquierda) }
		keyboard.s().onPressDo { personaje.soltarArma() }
		keyboard.d().onPressDo { personaje.disparar() }
		
		nivelActual.cargar()
		game.addVisual(armaDisparo)
		estadoMatarEnem.desactivar()
		self.configurarFantasma()
		
		game.onTick(10000, "aparece sorpresa", { self.spawnear(new Sorpresas( position = posAleatoria.calcularLibre() )) })
		game.onTick(10000, "aparece espada", { self.spawnear(new ArmasMelee(position = posAleatoria.calcularLibre() )) })
		game.onTick(4000, "aparece moneda", { self.spawnear(new Monedas(position = posAleatoria.calcularLibre() )) })
		game.onTick(10000, "aparece obstáculo", {self.nuevoObstaculo()})
		game.onTick(10000, "aparece enemigo", {self.nuevoEnemigoTerrestre()})
	
		game.start()
	}
	
	method nuevoEnemigoTerrestre(){
		const nuevoEnemigoTerrestre = new EnemigoTerrestre (position = posAleatoria.calcularLibre())
		enemigosT.add(nuevoEnemigoTerrestre)
		self.spawnear(nuevoEnemigoTerrestre)
		game.onCollideDo(nuevoEnemigoTerrestre, { objeto => objeto.tocarEnemigo(nuevoEnemigoTerrestre) })
		game.onTick(3000, "movimiento enemigo terrestre", {nuevoEnemigoTerrestre.perseguir()})
	}
	
	method nuevoObstaculo(){
		const nuevoObstaculo = new Obstaculo (position = posAleatoria.calcularLibre())
		self.spawnear(nuevoObstaculo)
	}
	
	method spawnear(objeto){
		objeto.aparecer()
		game.schedule(10000, {objeto.desaparecer()})
	}
	
	method cargarNivel(numero){
		game.say(personaje, "Pasé al nivel 2!")
		nivelActual.quitarNivel()
		nivelActual = numero
		nivelActual.cargar()
		//nivelActual.fondo()
	}
	
}