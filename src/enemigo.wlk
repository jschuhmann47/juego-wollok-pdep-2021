import wollok.game.*
import paredes.*
import personaje.*

object enemigo{
	const posicionInicial = game.at(1,1)
	var property position = posicionInicial

	var direccion = abajoEnemigo
	var property direccionChoque = abajoEnemigo
	
	var xEnemigo = self.position().x()
	var yEnemigo = self.position().x()
	var xPersonaje = personaje.position().x()
	var yPersonaje = personaje.position().x()
	
	method position() = position
	method image() = "Visuals/CHARACTERS/player/hero-derecha.png"

	method abajo() {
		self.mirarHacia(arribaEnemigo)
		self.avanzar()
	}
	method izquierda() {
		self.mirarHacia(izquierdaEnemigo)
		self.avanzar()
	}
	method derecha() {
		self.mirarHacia(derechaEnemigo)
		self.avanzar()
	}
	method arriba() {
		self.mirarHacia(arribaEnemigo)
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
		direccionChoque = direccion
		position = direccion.direccionOpuesta(position)
		if(self.direccionChoque() == arribaEnemigo){
			self.mirarHacia(derechaEnemigo)
		}else if(self.direccionChoque() == derechaEnemigo){
			self.mirarHacia(abajoEnemigo)
		}else if(self.direccionChoque() == abajoEnemigo){
			self.mirarHacia(izquierdaEnemigo)
		}else if(self.direccionChoque() == izquierdaEnemigo){
			self.mirarHacia(arribaEnemigo)
		}
		
		self.avanzar()
//		game.say(self, "hi")
	}
	
	method avanzarEnemigo(){
		xEnemigo = self.position().x()
		yEnemigo = self.position().y()
		xPersonaje = personaje.position().x()
		yPersonaje = personaje.position().y()
		
		var distanciaInicial = vectores.obtenerDistancia(xEnemigo,yEnemigo,xPersonaje,yPersonaje)
		//si lo muevo para arriba que calcule
		if(vectores.obtenerDistancia(xEnemigo,yEnemigo + 1,xPersonaje,yPersonaje) < distanciaInicial){
			self.arriba()
		}else if(vectores.obtenerDistancia(xEnemigo,yEnemigo - 1,xPersonaje,yPersonaje) < distanciaInicial){ //abajo
			self.abajo()
		}else if(vectores.obtenerDistancia(xEnemigo + 1,yEnemigo,xPersonaje,yPersonaje) < distanciaInicial){ //derecha
			self.derecha()
		}else if(vectores.obtenerDistancia(xEnemigo - 1,yEnemigo,xPersonaje,yPersonaje) < distanciaInicial){ //abajo
			self.izquierda()
		} 
	}
	
}

object vectores{
	method obtenerDistancia(xEnemigo,yEnemigo,xPersonaje,yPersonaje){
		var rX = 0
		var rY = 0
		rX = xEnemigo - xPersonaje
		rY = yEnemigo - yPersonaje
		
		return (rX ** 2 + rY ** 2)** 0.5 
	}
}

object arribaEnemigo {
	method siguientePosicion(posicion) = posicion.up(1)	
	method direccionOpuesta(posicion) = posicion.down(1)	
//	method imagen() = "Visuals/CHARACTERS/player/hero-arriba.png"
}
object izquierdaEnemigo {
	method siguientePosicion(posicion) = posicion.left(1)
	method direccionOpuesta(posicion) = posicion.right(1)
//	method imagen() = "Visuals/CHARACTERS/player/hero-izquierda.png"
}
object derechaEnemigo {
	method siguientePosicion(posicion) = posicion.right(1)
	method direccionOpuesta(posicion) = posicion.left(1)
//	method imagen() = "Visuals/CHARACTERS/player/hero-derecha.png"
}
object abajoEnemigo {
	method siguientePosicion(posicion) = posicion.down(1)
	method direccionOpuesta(posicion) = posicion.up(1)
	}