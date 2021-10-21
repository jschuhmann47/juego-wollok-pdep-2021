import wollok.game.*
import paredes.*
import personaje.*

class EnemigoTerrestre{
	var property position
	var direccion = abajoEnemigo
	
	method image() = "Visuals/CHARACTERS/player/hero-derecha.png"
	
	method mirarHacia(nuevaDireccion) {
		direccion = nuevaDireccion
	}
	
	method perseguir(){
		perseguir.accion(self)
	}
	
	method tocarPersonaje(pers){}
	
	/*method colisionPared() {
		direccionChoque = direccion

			if(direccionChoque == arribaEnemigo){
				self.mirarHacia(derechaEnemigo)
			}else if(direccionChoque == derechaEnemigo){
				self.mirarHacia(abajoEnemigo)
			}else if(direccionChoque == abajoEnemigo){
				self.mirarHacia(izquierdaEnemigo)
			}else if(direccionChoque == izquierdaEnemigo){
				self.mirarHacia(arribaEnemigo)
			}
			
	}*/
	
	method colisionPared(){
		position = direccion.retroceder(position)
		//self.mirarHacia(direccion.direcOpuesta())
	}
	
	method colisionParedDestructible(pared) {
		self.colisionPared()
	}
	
	method esEnemigo() = true	
	method esPared() = false
	method esPersonaje() = false
	method esObjeto() = false
	
	method quedarseQuieto(){
		game.removeTickEvent ("movimiento enemigo terrestre")
		game.schedule (5000, { game.onTick(3000, "movimiento enemigo terrestre", { self.perseguir() }) })
	}
	
	method aparecer(){
		game.addVisual(self)
	}
	method desaparecer(){}
	
	method tocarEnemigo(_){}
	method tocarDisparo(_){}
	
}

object fantasma{
	var property position
	method image() = "Visuals/CHARACTERS/enemigos/fantasma.png"
	
	method perseguir(){
		perseguir.accion(self)
	}
	method colisionPared(){}
	method tocarEnemigo(_){}
	method tocarPersonaje(pers){
		game.say(self, "Perdiste una vida")
		pers.perderVida()
	}
	method colisionParedDestructible(pared) {
		self.colisionPared()
	}
	
	method tocarDisparo(_){}
		
	method esPared() = false
	method esPersonaje() = false
	method esObjeto() = false
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
		var pos
		
		/*if (xEnemigo != xPersonaje)
			pos = self.comparar(xEnemigo, xPersonaje)
		else if (yEnemigo != yPersonaje)
			pos = self.comparar(yEnemigo, yPersonaje)*/
			
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
		pos = game.at(xEnemigo, yEnemigo)
		enemigo.position(pos)
	}		
	
}

object arribaEnemigo {
	method siguientePosicion(posicion) = posicion.up(1)
	method retroceder(posicion)	= posicion.down(1)
	method direcOpuesta() = abajoEnemigo
//	method imagen() = "Visuals/CHARACTERS/player/hero-arriba.png"
}
object izquierdaEnemigo {
	method siguientePosicion(posicion) = posicion.left(1)
	method retroceder(posicion) = posicion.right(1)
	method direcOpuesta() = derechaEnemigo
//	method imagen() = "Visuals/CHARACTERS/player/hero-izquierda.png"
}
object derechaEnemigo {
	method siguientePosicion(posicion) = posicion.right(1)
	method retroceder(posicion) = posicion.left(1)
	method direcOpuesta() = izquierdaEnemigo
//	method imagen() = "Visuals/CHARACTERS/player/hero-derecha.png"
}
object abajoEnemigo {
	method siguientePosicion(posicion) = posicion.down(1)
	method retroceder(posicion) = posicion.up(1)
	method direcOpuesta() = arribaEnemigo
//	method imagen() = "Visuals/CHARACTERS/player/hero-derecha.png"
}