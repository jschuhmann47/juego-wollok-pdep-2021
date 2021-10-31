import wollok.game.*
import paredes.*
import personaje.*

class Enemigo{
	var property position = game.at(1,1)
	var direccion = abajo
	method image()
	method esEnemigo() = true
	method esPared() = false
	method esPersonaje() = false
	method esObjeto() = false
	
	method mirarHacia(nuevaDireccion) {
		direccion = nuevaDireccion
	}
	
	method perseguir(){
		perseguir.accion(self)
	}
	
	method tocarPersonaje(_){}
	method tocarEnemigo(_){}
	method tocarDisparo(_){}
	
	method colisionPared(){}
	method colisionParedDestructible(pared) {
		self.colisionPared()
	}
	
}

class EnemigoTerrestre inherits Enemigo{
	var property image = "Visuals/CHARACTERS/player/hero-derecha.png"

	override method colisionPared(){
		position = direccion.retroceder(position)
		//self.mirarHacia(direccion.direcOpuesta())
	}
	
	method quedarseQuieto(){
		game.removeTickEvent ("movimiento enemigo terrestre")
		game.schedule (5000, { game.onTick(3000, "movimiento enemigo terrestre", { self.perseguir() }) })
	}
	
	method aparecer(){
		game.addVisual(self)
	}
	
	method desaparecer(){}
	
	method imagenNueva(palabra){
		image = "Visuals/CHARACTERS/player/hero-" + palabra.toString() + ".png"
	}
}

object fantasma inherits Enemigo{
	override method image() = "Visuals/CHARACTERS/enemigos/fantasma.png"
	
	override method tocarPersonaje(pers){
		game.say(self, "Perdiste una vida")
		pers.perderVida()
	}
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