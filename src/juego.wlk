import wollok.game.*
import personaje.*
import paredes.*
import enemigo.*

object juego {
	method jugar(){
		
		game.width(20)
		game.height(20)
		game.title("Juego")
		game.ground("Visuals/BACKGROUND/terrain.jpg")
		
		game.addVisual(personaje)
		game.addVisual(enemigo)
		game.addVisual(vida)
		
		keyboard.down().onPressDo { personaje.abajo() }
		keyboard.up().onPressDo { personaje.arriba() }
		keyboard.right().onPressDo { personaje.derecha() }
		keyboard.left().onPressDo { personaje.izquierda() }
		//keyboard.space().onPressDo { personaje.saltar() }	
	
		keyboard.q().onPressDo { game.say(personaje, "basta chicos") }
		keyboard.w().onPressDo { game.say(personaje, "mamaaa cortaste toda la loz") }
		keyboard.e().onPressDo { game.say(personaje, "miamiiii") }
		keyboard.r().onPressDo { game.say(personaje, "yo no manejo el rating, yo manejo un roll royce") }
		
		game.onTick(1000, "movimiento", { enemigo.perseguir() })
		//game.onTick(600, "matar personaje", { enemigo.chequearJugador() })
		game.onTick(2000, "aparece sorpresa", { self.aparecerSorpresa() })
		//game.onTick(5000, "aparece arma", { self.aparecerArma() })
		
		game.onCollideDo(enemigo, { objeto => objeto.tocarEnemigo(enemigo) })
		game.onCollideDo(personaje, { objeto => objeto.tocarPersonaje(personaje) })

		nivel1.cargar()
		
		game.start()
	}
	
	method calcularPosicionAleatoria() {
		const x = (0 .. game.width()-1).anyOne()
		const y = (0 .. game.height()-1).anyOne()
		return game.at(x,y)
	}
	
	method aparecerSorpresa() {
		const posicionAleatoria = self.calcularPosicionAleatoria()
		
		const esP = game.getObjectsIn( posicionAleatoria ).any({ p => p.esPared() || p.esArma()})
		if(esP)
			self.aparecerSorpresa()
		else
			game.addVisual( new Sorpresa(position = posicionAleatoria) )
	}
	
	method aparecerArma(){
		const posicionAleatoria = self.calcularPosicionAleatoria()
		
		const esP = game.getObjectsIn( posicionAleatoria ).any({ p => p.esPared() || p.esSorpresa()})
		if(esP)
			self.aparecerSorpresa()
		else
			game.addVisual( new Arma(position = posicionAleatoria) )
		
	}
	
}

object colores {
	const property blanco = "FFFFFFFF"
	const property rojo = "FF0000FF"
}

object vida{
	var property position = game.at(9, 19)
	method image() = "Visuals/OBJECTS/blocks/pared.png"
	method text() = personaje.vidas().toString() + " VIDA/S"
	method textColor() = colores.blanco()
	method tocarPersonaje(pers){
		pers.colisionPared()
	}
}

class Sorpresa {
	var property position
	method image() = "Visuals/OBJECTS/blocks/sorpresa.png"
	
	method esSorpresa() = true
	method esPared() = false
	method esPersonaje() = false
	method esArma() = false
	
	method tocarEnemigo(enem) {
		game.removeVisual(self)
	}
	
	method efecto(){
		const nroSorpresa = (1 .. 4).anyOne()
		
		if (nroSorpresa == 0){
			game.say(personaje, "Ups! Game over :(")
			personaje.morir()}
		else if (nroSorpresa == 1){
			game.say(personaje, "Bien! El enemigo se queda quieto por 5 segundos :D")
			enemigo.quedarseQuieto()}
		else if (nroSorpresa == 2){
			game.say(personaje, "Ups! Perdiste una vida :(")
			personaje.perderVida()}
		else if (nroSorpresa == 3){
			game.say(personaje, "Bien! Ganaste una vida :D")
			personaje.ganarVida()}
		else
			game.say(personaje, "Bueno, esta sorpresa no hace nada :p")
		game.removeVisual(self)
	}
	
	method tocarPersonaje(pers){
		pers.agarrarSorpresa(self)
	}
	
}

class Arma{
	var property position
	method image() = "Visuals/OBJECTS/items/sword.png"
	
	method esArma() = true
	method esPared() = false
	method esPersonaje() = false
	
	method tocarEnemigo(enem) {
		game.removeVisual(enem)
	}
	method tocarPersonaje(pers){
		pers.usarArma(self)
	}
	
}