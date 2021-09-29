import wollok.game.*
import paredes.*

object personaje{
	const posicionInicial = game.center()
	var property position = posicionInicial
	var direccion = abajo
	var property image = "Visuals/CHARACTERS/player/hero-arriba.png"
	var property vidas = 3
	var property armaActual = null

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
		if (armaActual != null)
			self.usarArma(armaActual)
	}

	method siguientePosicion() = direccion.siguientePosicion(position)
	
	method colisionPared() {
		position = direccion.direccionOpuesta(position)	
	}
	
	method esEnemigo() = false
	method esPared() = false
	method esPersonaje() = true
	method esArma() = false
	
	method tocarEnemigo(enem){} //el personaje no hace nada, porque ya lo hace el enemigo, solo tiene que entender el mensaje
	
	method agarrarSorpresa(sorpresa){
		sorpresa.efecto()
	}
	
	method usarArma(arma){
		armaActual = arma
		armaActual.position(self.siguientePosicion())
	}
	
	method soltarArma(){
		game.removeVisual(armaActual)
		armaActual = null
	}
	
	method morir(){
		game.removeVisual(self)
		game.stop()
	}
	
	method ganarVida(){
		vidas += 1
	}
	
	method perderVida(){
		vidas -= 1
		if (vidas == 0)
			self.morir()
		else
			self.volverAlInicio()
	}
	
	method volverAlInicio(){
		position = posicionInicial
	}

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