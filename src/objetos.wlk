import wollok.game.*
import personaje.*
import enemigos.*
import puntosYVidas.*
import juego.*

object armaVacia{}

class Objetos {
	var property position
	method esPared() = false
	method esPersonaje() = false
	method esEnemigo() = false
	method esObjeto() = true
	method image()
	
	method aparecer(){
		game.addVisual(self)
	}
	
	method desaparecer(){
		if (game.hasVisual(self))
			game.removeVisual(self)
	}
	
	method tocarPersonaje(param)
	
	method tocarEnemigo(enem) {
		game.removeVisual(self)
	}
	
	method colisionPared(){
		game.removeVisual(self)
	}
	
}


class ArmasMelee inherits Objetos{
	override method image() = "Visuals/OBJECTS/items/sword.png"
	
	override method tocarPersonaje(pers){
		pers.usarArma(self)
	}
	override method tocarEnemigo(enem){
		game.removeVisual(enem)
	}
	override method desaparecer(){}
	
}

object armaDisparo{
	var property position = posAleatoria.calcularLibre()
	var property direccion = izquierda
	var property image = "Visuals/OBJECTS/items/pistola-derecha.png"
	method esObjeto() = true
	
	method siguientePosicion() = direccion.siguientePosicion(position)
	method tocarPersonaje(pers){
		pers.usarArma(self)
	}
	method tocarEnemigo(enem){}
	
	method colisionPared(){}
	method imagenNueva(palabra){
		image="Visuals/OBJECTS/items/pistola-" + palabra.toString() + ".png"
	}
}

object disparo{
	var property position
	var property direccion
	var property image = "Visuals/OBJECTS/items/bala-derecha.png"
	
	method avanzar(){
		position = direccion.siguientePosicion(position)
	}
	method colisionPared(){
		game.removeVisual(self)
	}
	method tocarEnemigo(enem){
		game.removeVisual(enem)
	}
	method imagenNueva(palabra){
		image="Visuals/OBJECTS/items/bala-" + palabra.toString() + ".png"
	}
	
}	

class Monedas inherits Objetos{
	var property image = "Visuals/OBJECTS/items/bronce.png"
	var property valor = 0
	
	override method aparecer(){
		self.calcularValorMoneda()
		super()
	}
	
	override method tocarPersonaje(pers){
		puntos.aumentarPuntuacion(self.valor())
		game.removeVisual(self)
	}
	
	method calcularValorMoneda(){
		const tipoMoneda = 0.randomUpTo(10)

		if(tipoMoneda < 6){
			self.valor(100)
			self.image("Visuals/OBJECTS/items/bronce.png")
		}
		else{
			if(tipoMoneda < 9){
				self.valor(200)
				self.image("Visuals/OBJECTS/items/plata.png")
			}
			else{
				self.valor(300)
				self.image("Visuals/OBJECTS/items/oro.png")
			}
		}
	}
	
}

class Sorpresas inherits Objetos{
	override method image() = "Visuals/OBJECTS/blocks/sorpresa.png"
	
	method efecto(){
		const nroSorpresa = (1 .. 6).anyOne()
		
		if (nroSorpresa == 1){
			sorpresa1.aplicar()
		}
		else if (nroSorpresa == 2){
			sorpresa2.aplicar()
		}
		else if (nroSorpresa == 3){
			sorpresa3.aplicar()
		}
		else if (nroSorpresa == 4){
			sorpresa4.aplicar()
		}
		else if (nroSorpresa == 5){
			sorpresa5.aplicar()
		}
		else
			sorpresa6.aplicar()
			
		game.removeVisual(self)
	}
	
	
	override method tocarPersonaje(pers){
		pers.agarrarSorpresa(self)
	}
	
}

object sorpresa1{
	method aplicar(){
		game.say(personaje, "Perdí 500 puntos :(")
		puntos.disminuirPuntuacion(500)
	}
}

object sorpresa2{
	method aplicar(){
		game.say(personaje, "Gané 500 puntos :D")
		puntos.aumentarPuntuacion(500)
	}
}

object sorpresa3{
	method aplicar(){
		game.say(personaje, "Los enemigos terrestres se quedan quietos por 5 segundos :D")
		if (!enemigosT.isEmpty())
			enemigosT.forEach { enemigo => enemigo.quedarseQuieto() }
	}
}

object sorpresa4{
	method aplicar(){
		game.say(personaje, "Perdí una vida :(")
		personaje.perderVida()
	}
}

object sorpresa5{
	method aplicar(){
		game.say(personaje, "Gané una vida :D")
		personaje.ganarVida()
	}
}

object sorpresa6{
	method aplicar(){
		game.say(personaje, "Bueno, esta sorpresa no hace nada :p")
	}
}


class Obstaculo inherits Objetos{
	const nroObstaculo = (1 .. 3).anyOne()
	override method image() = "Visuals/OBJECTS/blocks/obstaculo" + nroObstaculo.toString() + ".png"
	override method tocarPersonaje(param){}
}


object posAleatoria{
	method calcularLibre(){
		const posicionAleatoria = self.calcularPosicionAleatoria()
		const posOcupada = game.getObjectsIn( posicionAleatoria ).any({ o => o.esPared() || o.esObjeto() })
		if(posOcupada)
			self.calcularLibre()
		else
			return posicionAleatoria
	}
	
	method calcularPosicionAleatoria() {
		const x = (0 .. game.width()-1).anyOne()
		const y = (0 .. game.height()-1).anyOne()
		return game.at(x,y)
	}
	
}