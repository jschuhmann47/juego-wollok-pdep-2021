import wollok.game.*

object personaje {
	const posicionInicial = game.at(0,0)
	var posicion = posicionInicial
	var direccion = abajo
	method position() = posicion
	method image() = direccion.imagen()
	method volveAlPrincipio() {
		posicion = posicionInicial
	}
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
		posicion = self.siguientePosicion()
	}

	method siguientePosicion() = direccion.siguientePosicion(posicion)

	method colisionasteConEnemigo(enemigo) {
		self.volveAlPrincipio()
	}
}
	

object arriba {
	method siguientePosicion(posicion) {
		return posicion.up(1)	
	}
	method imagen() = "Visuals/CHARACTERS/player/hero-arriba.png"
}
object izquierda {
	method siguientePosicion(posicion) = posicion.left(1)
	method imagen() = "Visuals/CHARACTERS/player/hero-izquierda.png"
}
object derecha {
	method siguientePosicion(posicion) = posicion.right(1)
	method imagen() = "Visuals/CHARACTERS/player/hero-derecha.png"
}
object abajo {
	method siguientePosicion(posicion) = posicion.down(1)
	method imagen() = "Visuals/CHARACTERS/player/hero-abajo.png"
}