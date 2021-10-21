import wollok.game.*
import paredes.*
import objetos.*

object personaje{
	const posicionInicial = game.center()
	var property position = posicionInicial
	var property direccion = abajo
	var property image = "Visuals/CHARACTERS/player/soldado-izquierda.png"
	var property vidas = 3
	var property armaActual = armaVacia

	method caminar(direcc){
		direccion = direcc
		position = self.siguientePosicion()
		if (armaActual != armaVacia){
			if (armaActual == armaDisparo)
				modificarDireccion.aplicar(self.direccion(), armaDisparo)
			self.usarArma(armaActual)
		}
	}

	method siguientePosicion() = direccion.siguientePosicion(position)
	
	method colisionPared() {
		position = direccion.retroceder(position)	
	}
	method colisionParedDestructible(pared) {
		self.colisionPared()
	}
	
	method esEnemigo() = false
	method esPared() = false
	method esPersonaje() = true
	method esArma() = false
	method esMoneda() = false
	method esSorpresa() = false
	
	method tocarEnemigo(enem){} //solo tiene que entender el mensaje
	
	method agarrarSorpresa(sorpresa){
		sorpresa.efecto()
	}
	
	method usarArma(arma){
		armaActual = arma
		armaActual.position(self.siguientePosicion())
	}
	
	method disparar(){
		if (armaActual == armaDisparo){
			modificarDireccion.aplicar(self.direccion(), armaDisparo)
			modificarDireccion.aplicar(self.direccion(), disparo)
			disparo.position(armaActual.siguientePosicion())
			if(!game.hasVisual(disparo))
				game.addVisual(disparo)
			game.onTick(1000, "avanzar disparo", {disparo.avanzar()})
		}
		else
			game.say(self, "No tenemos arma para disparar")
	}
		
	method soltarArma(){
		if (armaActual != armaDisparo)
			game.removeVisual(armaActual)
			
		armaActual = armaVacia
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
		image="Visuals/CHARACTERS/player/hero-" + palabra.toString() + ".png"
	}
	

}

object modificarDireccion{
	method aplicar(direccion, elemento){
		elemento.direccion(direccion)
		direccion.determinarImagen(elemento)
	}
}

object arriba {
	method siguientePosicion(posicion) = posicion.up(1)	
	method retroceder(posicion) = posicion.down(1)
	
	method determinarImagen(elemento){
		elemento.imagenNueva(self)
	}
}

object izquierda {
	method siguientePosicion(posicion) = posicion.left(1)
	method retroceder(posicion) = posicion.right(1)
	
	method determinarImagen(elemento){
		elemento.imagenNueva(self)
	}
}

object derecha {
	method siguientePosicion(posicion) = posicion.right(1)
	method retroceder(posicion) = posicion.left(1)
	
	method determinarImagen(elemento){
		elemento.imagenNueva(self)
	}
}

object abajo {
	method siguientePosicion(posicion) = posicion.down(1)
	method retroceder(posicion) = posicion.up(1)

	method determinarImagen(elemento){
		elemento.imagenNueva(self)
	}
}