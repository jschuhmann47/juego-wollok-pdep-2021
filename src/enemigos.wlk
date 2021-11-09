import wollok.game.*
import paredes.*
import personaje.*

class Enemigo{
	var property position = game.at(1,1)
	var property direccion = abajo
	var property image
	method image()
	method esEnemigo() = true
	method esPared() = false
	method esPersonaje() = false
	method esObjeto() = false
	
	
	method perseguir(){
		perseguir.accion(self)
		direccion.determinarImagen(self)
	}
	
	 method tocarPersonaje(pers){
		pers.perderVida()
	}
	method tocarEnemigo(_){}
	method tocarDisparo(_){}
	method imagenNueva(_){}
	
}

class EnemigoTerrestre inherits Enemigo(image="Visuals/CHARACTERS/enemigos/enemigo-derecha.png"){
	
	method quedarseQuieto(){
		game.removeTickEvent ("movimiento enemigo terrestre")
		game.schedule (5000, { game.onTick(3000, "movimiento enemigo terrestre", { self.perseguir() }) })
	}
	
	method aparecer(){
		game.addVisual(self)
	}
	
	method desaparecer(){}
	
	override method imagenNueva(palabra){
		image = "Visuals/CHARACTERS/enemigos/enemigo-" + palabra.toString() + ".png"
	}
}

object fantasma inherits Enemigo(image="Visuals/CHARACTERS/enemigos/fantasma-abajo.png"){
	override method imagenNueva(palabra){
		image = "Visuals/CHARACTERS/enemigos/fantasma-" + palabra.toString() + ".png"
	}
}

object perseguir{
	
	method accion(enemigo){
		const xPersonaje = personaje.position().x()
		const yPersonaje = personaje.position().y()
		var xEnemigo = enemigo.position().x()
		var yEnemigo = enemigo.position().y()
		var pos
			
		if(xEnemigo!=xPersonaje){
			if(xEnemigo>xPersonaje){
				xEnemigo --
				enemigo.direccion(izquierda)
			}
			else{
				xEnemigo ++
				enemigo.direccion(derecha)
			}
		}
		
		else if(yEnemigo!=yPersonaje){
			if(yEnemigo>yPersonaje){
				yEnemigo --
				enemigo.direccion(abajo)
			}
			else{
				yEnemigo ++
				enemigo.direccion(arriba)
			}
		}
		
		pos = game.at(xEnemigo, yEnemigo)
		enemigo.position(pos)
	}		
	
}