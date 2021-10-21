import wollok.game.*
import paredes.*
import objetos.*

object desactivado{}
object activado{}

object personaje{
	const posicionInicial = game.center()
	var property position = posicionInicial
	var property direccion = abajo
	var property image = "Visuals/CHARACTERS/player/soldado-izquierda.png"
	var property vidas = 3
	var property armaActual = armaVacia
	var property estadoMatarEnem = desactivado

	method caminar(direcc){
		direccion = direcc
		position = self.siguientePosicion()
		/*if (armaActual != armaVacia){
			if (armaActual == armaDisparo)
				modificarDireccion.aplicar(self.direccion(), armaDisparo)
			self.usarArma(armaActual)}*/
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
	
	method tocarEnemigo(enem){
		if (estadoMatarEnem == desactivado){
			game.say(enem, "Perdiste una vida")
			self.perderVida()}
		else{
			game.say(self, "Te maté! :D")
			game.removeVisual(enem)
		}
	}
	
	method agarrarSorpresa(sorpresa){
		sorpresa.efecto()
	}
	
	method usarArma(arma){
		armaActual = arma
		game.removeVisual(arma)
		if(armaActual == armaDisparo)
			self.image("Visuals/CHARACTERS/player/soldado-izquierda-arma.png")
		else{
			estadoMatarEnem = activado
			self.image("Visuals/CHARACTERS/player/soldado-izquierda-espada.png")
		}
	}
	
	method disparar(){
		if (armaActual == armaDisparo){
			//modificarDireccion.aplicar(self.direccion(), armaDisparo)
			const nuevoDisparo = new Disparo()
			nuevoDisparo.position(self.siguientePosicion())
			modificarDireccion.aplicar(self.direccion(), nuevoDisparo)
			game.addVisual(nuevoDisparo)
			game.onTick(1000, "avanzar disparo", {nuevoDisparo.avanzar()})
		}
		else
			game.say(self, "No tenemos arma para disparar")
	}
		
	method soltarArma(){
		if (armaActual == armaDisparo){
			armaDisparo.position(self.siguientePosicion())
			game.addVisual(armaDisparo)
		}
		estadoMatarEnem = desactivado	
		armaActual = armaVacia
		self.image("Visuals/CHARACTERS/player/soldado-izquierda.png")
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