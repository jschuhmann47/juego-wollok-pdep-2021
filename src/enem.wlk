import wollok.game.*
import paredes.*
import personaje.*


class Enemigo{
	const posicionInicial = game.center()
	var property position = posicionInicial

	var direccion = abajo
	
	method position() = position
	method image() = "Visuals/CHARACTERS/player/hero-arriba.png"
	
//	method abajo(){
//		position = position.down(1)
//		opuesto = position.up(1)
//	}
//	
//	method arriba(){
//		position = position.up(1)
//		opuesto = position.down(1)
//	}
//	
//	method derecha(){
//		position = position.right(1)
//		opuesto = position.left(1)
//	}
//	
//	method izquierda(){
//		position = position.left(1)
//		opuesto = position.right(1)
//	}

	method abajoE() {
		self.mirarHacia(abajo)
		self.avanzar()
	}
	method izquierdaE() {
		self.mirarHacia(izquierda)
		self.avanzar()
	}
	method derechaE() {
		self.mirarHacia(derecha)
		self.avanzar()
	}
	method arribaE() {
		self.mirarHacia(arriba)
		self.avanzar()
	}
	method mirarHacia(nuevaDireccion) {
		direccion = nuevaDireccion
	}

	method avanzar() {
		position = self.siguientePosicion()
	}

	method siguientePosicion() = direccion.siguientePosicion(position)
	
	method colisionPared(_) {
		position = direccion.direccionOpuesta(position)
//		game.say(self, "hi")
	}
	
}