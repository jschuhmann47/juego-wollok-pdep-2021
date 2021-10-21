import wollok.game.*
import personaje.*
import paredes.*
import enemigos.*
import puntosYVidas.*
import objetos.*

const enemigosT = new List()

object juego {
	
	method configurarPantalla() {
		game.width(20)
		game.height(20)
		game.title("Juego")
		game.ground("Visuals/BACKGROUND/terrain.jpg")
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
		
		nivel1.cargar()
		game.addVisual(armaDisparo)
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
		game.onCollideDo(nuevoObstaculo, { objeto => objeto.colisionPared() })
	}
	
	method spawnear(objeto){
		objeto.aparecer()
		game.schedule(7000, {objeto.desaparecer()})
	}
	
}