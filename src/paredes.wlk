import personaje.*
import enemigos.*
import wollok.game.*

class Pared {
	var property position
	method image()
	method esEnemigo() = false
	method esPared() = true
	method esPersonaje() = false
	method esObjeto() = false
	
	method tocar(alguien){
		const posicion = alguien.position()
		alguien.position( alguien.direccion().retroceder(posicion) )
	}
	method tocarEnemigo(enem){
		self.tocar(enem)
	}
	method tocarPersonaje(pers){
		self.tocar(pers)
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
