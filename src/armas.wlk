import wollok.game.*
import personaje.*
import paredes.*
import enemigo.*

class Arma{
	var property position
	method image() = "Visuals/OBJECTS/items/sword.png"
	
	method esArma() = true
	method esPared() = false
	method esPersonaje() = false
	method esSorpresa() = false
	
	method tocarEnemigo(enem) {
		game.removeVisual(enem)
	}
	method tocarPersonaje(pers){
		pers.usarArma(self)
	}
	
}