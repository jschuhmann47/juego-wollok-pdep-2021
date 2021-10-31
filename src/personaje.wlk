import wollok.game.*
import paredes.*
import objetos.*

object personaje{
	const posicionInicial = game.center()
	var property position = posicionInicial
	var property direccion = abajo
	var property image = "Visuals/CHARACTERS/player/soldado-izquierda.png"
	var property vidas = 3
	var property arma = armaVacia
	
	method esEnemigo() = false
	method esPared() = false
	method esPersonaje() = true
	method esObjeto() = false

	method caminar(direcc){
		direccion = direcc
		position = self.siguientePosicion()
	}

	method siguientePosicion() = direccion.siguientePosicion(position)
	
	method colisionPared() {
		position = direccion.retroceder(position)	
	}
	method colisionParedDestructible(pared) {
		self.colisionPared()
	}
	
	method tocarDisparo(_){}
	
	method tocarEnemigo(enem){
		arma.matarA(enem, self)
	}
	
	method agarrarSorpresa(sorpresa){
		sorpresa.efecto()
	}
	
	method usarArma(nuevaArma){
		arma = nuevaArma
		arma.usar(self)
	}
	
	method disparar(){
		validar.personajeTieneArmaDisparo(self)
		arma.disparar(self)
	}
		
	method soltarArma(){
		arma.soltar(self)
		arma = armaVacia
		self.imagenNueva(derecha)
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
		else{
			self.soltarArma()
			self.volverAlInicio()
		}
	}
	
	method volverAlInicio(){
		position = posicionInicial
	}
	
	method imagenNueva(palabra){
		image = "Visuals/CHARACTERS/player/soldado-" + palabra.toString() + ".png"
	}

}

object validar{
	method personajeTieneArmaDisparo(pers) {
		if( armaDisparo.estaSiendoUsada() )
			self.error("No tengo arma para disparar")
	}
}

object modificarDireccion{
	method aplicar(direccion, elemento){
		elemento.direccion(direccion)
		direccion.determinarImagen(elemento)
	}
}

class Direccion{
	method siguientePosicion(posicion)
	method retroceder(posicion)
	
	method determinarImagen(elemento){
		elemento.imagenNueva(self)
	}
}

object arriba inherits Direccion{
	override method siguientePosicion(posicion) = posicion.up(1)	
	override method retroceder(posicion) = posicion.down(1)
}

object izquierda inherits Direccion{
	override method siguientePosicion(posicion) = posicion.left(1)
	override method retroceder(posicion) = posicion.right(1)
}

object derecha inherits Direccion{
	override method siguientePosicion(posicion) = posicion.right(1)
	override method retroceder(posicion) = posicion.left(1)
}

object abajo inherits Direccion{
	override method siguientePosicion(posicion) = posicion.down(1)
	override method retroceder(posicion) = posicion.up(1)
}