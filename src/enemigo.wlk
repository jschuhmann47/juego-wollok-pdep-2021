import wollok.game.*
import paredes.*
import personaje.*

object enemigo{
	const posicionInicial = game.at(1,1)
	var property position = posicionInicial
	var direccion = abajoEnemigo
	var property direccionChoque = abajoEnemigo
	
	var xEnemigo = self.position().x()
	var yEnemigo = self.position().y()
	
	method image() = "Visuals/CHARACTERS/player/hero-derecha.png"
	
	method perseguir() {
		xEnemigo = self.position().x()
		yEnemigo = self.position().y()
		
		const xPersonaje = personaje.position().x()
		const yPersonaje = personaje.position().y()
		if(xEnemigo != xPersonaje){
			if(xEnemigo > xPersonaje){
				xEnemigo --
				direccion = izquierdaEnemigo}
			else{
				xEnemigo ++
				direccion = derechaEnemigo}
		}
		else if(yEnemigo != yPersonaje){
			if(yEnemigo > yPersonaje){
				yEnemigo --
				direccion = abajoEnemigo}
			else{
				yEnemigo ++
				direccion = arribaEnemigo}
		}
		
		const posicionTemporal = game.at(xEnemigo, yEnemigo)
		
		const esP = game.getObjectsIn( posicionTemporal ).any({ pa => pa.esPared()})
		if (esP)
			self.colisionPared()
		else
			position = posicionTemporal
	}
	
	method mirarHacia(nuevaDireccion) {
		direccion = nuevaDireccion
	}

	method avanzar(direc) {
		const posicionTemporal = self.consultarSiguientePosicion(direc)
		
		const esP = game.getObjectsIn( posicionTemporal ).any({ pa => pa.esPared()})
		if (esP)
			self.colisionPared()
		else
			position = posicionTemporal
	}
	
	method tocarPersonaje(pers){
		game.say(self, "Perdiste una vida")
		pers.perderVida()
	}
	
	method siguientePosicion() = direccion.siguientePosicion(position)
	method consultarSiguientePosicion(direc) {
		const posicionTemporal = position
		return direc.siguientePosicion(posicionTemporal)
	}
	
	method colisionPared() {
			direccionChoque = direccion
			//position = direccion.direccionOpuesta(position)
			if(direccionChoque == arribaEnemigo){
				self.mirarHacia(derechaEnemigo)
			}else if(direccionChoque == derechaEnemigo){
				self.mirarHacia(abajoEnemigo)
			}else if(direccionChoque == abajoEnemigo){
				self.mirarHacia(izquierdaEnemigo)
			}else if(direccionChoque == izquierdaEnemigo){
				self.mirarHacia(arribaEnemigo)
			}
			
			self.avanzar(direccion)
			self.avanzar(direccionChoque)
	}
	
	method esEnemigo() = true	
	method esPared() = false
	method esPersonaje() = false
	method esSorpresa() = false
	method esArma() = false
	method esMoneda() = false
	
	method quedarseQuieto(){
		game.removeTickEvent ("movimiento")
		game.schedule (5000, { game.onTick(1000, "movimiento", { self.perseguir() }) })
	}
	
//	method avanzarEnemigo(){
//		xEnemigo = self.position().x()
//		yEnemigo = self.position().y()
//		xPersonaje = personaje.position().x()
//		yPersonaje = personaje.position().y()
//		
//		var distanciaInicial = vectores.obtenerDistancia(xEnemigo,yEnemigo,xPersonaje,yPersonaje)
//		//si lo muevo para arriba que calcule
//		if(vectores.obtenerDistancia(xEnemigo,yEnemigo + 1,xPersonaje,yPersonaje) < distanciaInicial){
//			self.arriba()
//		}else if(vectores.obtenerDistancia(xEnemigo,yEnemigo - 1,xPersonaje,yPersonaje) < distanciaInicial){ //abajo
//			self.abajo()
//		}else if(vectores.obtenerDistancia(xEnemigo + 1,yEnemigo,xPersonaje,yPersonaje) < distanciaInicial){ //derecha
//			self.derecha()
//		}else if(vectores.obtenerDistancia(xEnemigo - 1,yEnemigo,xPersonaje,yPersonaje) < distanciaInicial){ //abajo
//			self.izquierda()
//		} 
//	}
	
}

/*object vectores{
	method obtenerDistancia(xEnemigo,yEnemigo,xPersonaje,yPersonaje){
		var rX = 0
		var rY = 0
		rX = xEnemigo - xPersonaje
		rY = yEnemigo - yPersonaje
		
		return (rX ** 2 + rY ** 2)** 0.5 
	}
}*/

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