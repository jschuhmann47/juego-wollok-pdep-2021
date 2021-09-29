import wollok.game.*
import personaje.*
import paredes.*
import enemigo.*

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
		const nroSorpresa = (0 .. 4).anyOne()
		
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