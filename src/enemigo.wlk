import wollok.game.*
import paredes.*
import personaje.*

class EnemigoTerrestre{
	var property position = game.at(1,1)
	var direccion = abajoEnemigo
	var property direccionChoque = abajoEnemigo
	
	method image() = "Visuals/CHARACTERS/player/hero-derecha.png"
	
	method mirarHacia(nuevaDireccion) {
		direccion = nuevaDireccion
	}
	
	method perseguir(){
		perseguir.accion(self)
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
		game.removeTickEvent ("movimiento enemigo terrestre")
		game.schedule (5000, { game.onTick(1000, "movimiento enemigo terrestre", { self.perseguir() }) })
	}
	
}

class Fantasma{
	var property position = game.at(1,1)
	method image() = "Visuals/CHARACTERS/npc/frog/frog1.png"
	
	method perseguir(){
		perseguir.accion(self)
	}
	method colisionPared(){}
	method tocarEnemigo(_){}
	
	method esEnemigo() = true	
	method esPared() = false
	method esPersonaje() = false
	method esSorpresa() = false
	method esArma() = false
	method esMoneda() = false
}

object perseguir{	
	method comparar(nroAux1, nroAux2){
		var nroA = nroAux1
		var nroB = nroAux2
		if (nroA > nroB){
			nroA--}
		else{
			nroA++}
		
		return game.at(nroA, nroB)
	}
	
	method accion(enemigo){
		const xPersonaje = personaje.position().x()
		const yPersonaje = personaje.position().y()
		var xEnemigo = enemigo.position().x()
		var yEnemigo = enemigo.position().y()
		var posicionTemporal
		
		/*if (xEnemigo != xPersonaje)
			posicionTemporal = self.comparar(xEnemigo, xPersonaje)
		else
			posicionTemporal = self.comparar(yEnemigo, yPersonaje)*/
			
		if(xEnemigo!=xPersonaje){
			if(xEnemigo>xPersonaje)
				xEnemigo --
			else 
				xEnemigo ++
		}
		else if(yEnemigo!=yPersonaje){
			if(yEnemigo>yPersonaje)
				yEnemigo --
			else 
				yEnemigo ++
		}
		posicionTemporal = game.at(xEnemigo, yEnemigo)
		
		const esP = game.getObjectsIn( posicionTemporal ).any({ pa => pa.esPared()})
		if (esP)
			enemigo.colisionPared()
		else
			enemigo.position(posicionTemporal)
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