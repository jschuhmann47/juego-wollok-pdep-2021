import personaje.*
import enemigos.*
import wollok.game.*

const todasLasParedes = new List()

object tocarPared { 
	method aplicar(alguien){ 
		const posicion = alguien.position()
		alguien.position( alguien.direccion().retroceder(posicion) )
	}
}

class Pared {
	var property position
	method image()
	method esEnemigo() = false
	method esPared() = true
	method esPersonaje() = false
	method esObjeto() = false
	
	method tocarEnemigo(enem){
		tocarPared.aplicar(enem)
	}
	method tocarPersonaje(pers){
		tocarPared.aplicar(pers)
	}
	method tocarDisparo(disparo)
}

class ParedIndestructible inherits Pared{
	override method image() = "Visuals/OBJECTS/items/pared.png"
	override method tocarDisparo(disparo){
		game.removeVisual(disparo)
	}
}

class ParedDestructible inherits Pared{
	override method image() = "Visuals/OBJECTS/blocks/pared-rota.png"
	override method tocarDisparo(disparo){
		game.removeVisual(disparo)
		game.removeVisual(self)
	}
}
