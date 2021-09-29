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
		
		keyboard.down().onPressDo { personaje.abajo() }
		keyboard.up().onPressDo { personaje.arriba() }
		keyboard.right().onPressDo { personaje.derecha() }
		keyboard.left().onPressDo { personaje.izquierda() }
		//keyboard.space().onPressDo { personaje.saltar() }	
	
		keyboard.q().onPressDo { game.say(personaje, "basta chicos") }
		keyboard.w().onPressDo { game.say(personaje, "mamaaa cortaste toda la loz") }
		keyboard.e().onPressDo { game.say(personaje, "miamiiii") }
		keyboard.r().onPressDo { game.say(personaje, "yo no manejo el rating, yo manejo un roll royce") }
		
		game.onTick(600, "movimiento", { enemigo.perseguir() })
		game.onTick(600, "matar personaje", { enemigo.chequearJugador() })
		game.onTick(5000, "aparece sorpresa", { self.aparecerSorpresa() })
		game.onTick(5000, "aparece arma", { self.aparecerArma() })
		
		game.onCollideDo(enemigo, { objeto => objeto.tocarEnemigo(enemigo) })

		nivel1.cargar()
		
		game.start()
	}
	
	method calcularPosicionAleatoria() {
		const x = (0..game.width()-1).anyOne()
		const y = (0..game.height()-1).anyOne()
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

class Sorpresa {
	var property position
	method esSorpresa() = true
	method esPared() = false
	method esPersonaje() = false
	method image() = "Visuals/OBJECTS/blocks/sorpresa.png"
}

class Arma{
	var property position
	method esArma() = true
	method esPared() = false
	method esPersonaje() = false
	method tocarEnemigo(enemigo) {
		game.removeVisual(enemigo)
	}
	method image() = "Visuals/OBJECTS/items/sword.png"
}