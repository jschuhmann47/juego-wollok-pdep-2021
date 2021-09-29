import wollok.game.*
import paredes.*

object personaje{
	const posicionInicial = game.center()
	var property position = posicionInicial
	var direccion = abajo
	var property image = "Visuals/CHARACTERS/player/hero-arriba.png"
	
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

	method abajo() {
		self.mirarHacia(abajo)
		self.avanzar()
	}
	method izquierda() {
		self.mirarHacia(izquierda)
		self.avanzar()
	}
	method derecha() {
		self.mirarHacia(derecha)
		self.avanzar()
	}
	method arriba() {
		self.mirarHacia(arriba)
		self.avanzar()
	}
	method mirarHacia(nuevaDireccion) {
		direccion = nuevaDireccion
	}

	method avanzar() {
		position = self.siguientePosicion()
		var pp = game.getObjectsIn(self.position()).any({ p => p.esPared()})
		if(pp){
			self.colisionPared(pp)
		}
	}

	method siguientePosicion() = direccion.siguientePosicion(position)
	
	method colisionPared(_) {
		position = direccion.direccionOpuesta(position)	
	}
	
	method esEnemigo() = false
	method esPared() = false
	method esPersonaje() = true
	
	method colisionEnemigo(){ //no se por que no se ejecuta, deberia andar ni idea
		game.say(self, "Perdiste")
		game.removeVisual(self)
	}
	
	method agarrarSorpresa(sorpresa){
		game.say(self, "agarré una sorpresa!")
		game.removeVisual(sorpresa)
	}
	
	method usarArma(arma){
		game.say(self, "agarré un arma!")
		arma.position(self.siguientePosicion())
	}
	
/* El personaje salta
	method saltar(){
		self.subir()
		game.schedule(500, {self.caer()})
	}
	
	method subir(){
		position = position.up(2)
	}

	method caer(){
		position = position.down(2)
	}
*/
}


object arriba {
	method siguientePosicion(posicion) = posicion.up(1)	
	method direccionOpuesta(posicion) = posicion.down(1)	
//	method imagen() = "Visuals/CHARACTERS/player/hero-arriba.png"
}
object izquierda {
	method siguientePosicion(posicion) = posicion.left(1)
	method direccionOpuesta(posicion) = posicion.right(1)
//	method imagen() = "Visuals/CHARACTERS/player/hero-izquierda.png"
}
object derecha {
	method siguientePosicion(posicion) = posicion.right(1)
	method direccionOpuesta(posicion) = posicion.left(1)
//	method imagen() = "Visuals/CHARACTERS/player/hero-derecha.png"
}
object abajo {
	method siguientePosicion(posicion) = posicion.down(1)
	method direccionOpuesta(posicion) = posicion.up(1)
//	method imagen() = "Visuals/CHARACTERS/player/hero-abajo.png"
}