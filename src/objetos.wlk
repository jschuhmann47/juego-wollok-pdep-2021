import wollok.game.*
import personaje.*
import enemigo.*
import sorpresasYVidas.*
import juego.*


class Objetos {
	var property position
	method esArma() = false
	method esPared() = false
	method esPersonaje() = false
	method esSorpresa() = false
	method esMoneda() = false
	method image()
	method position()=position
	
	method calcularPosicionAleatoria() {
		return calcularPosAleatoria.calcularPosAleatoriaLibre()
	}	
	//method esObjeto() = true
	
	method aparecer(obj){
		game.addVisual(obj)
	}
	method tocarPersonaje(param)
	method desaparecer(){
		game.removeVisual(self)
	}
	method tocarEnemigo(enem) {
		game.removeVisual(enem) //la mayoria hace esto, dps vemos
	}
	
}


class ArmasMelee inherits Objetos{
		
	override method image() = "Visuals/OBJECTS/items/sword.png"
	
	override method esArma() = true
	
	override method tocarPersonaje(pers){
		pers.usarArma(self)
	}
	
}

class Monedas inherits Objetos{
	var property image = "Visuals/OBJECTS/items/bronce.png"
	var property valor = 0
	override method esMoneda() = true
	
	
	override method tocarPersonaje(pers){
		puntos.aumentarPuntuacion(self.valor())
		game.removeVisual(self)
	}
	
	override method aparecer(obj){
		obj.calcularValorMoneda()
		game.addVisual(obj)
		
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
	
	override method esSorpresa() = true
	
	method efecto(){
		const nroSorpresa = (1 .. 4).anyOne()
		
		if (nroSorpresa == 0){
			game.say(personaje, "Ups! Game over :(")
			personaje.morir()}
		else if (nroSorpresa == 1){
			game.say(personaje, "Bien! El enemigo se queda quieto por 5 segundos :D")
			enemigo.quedarseQuieto()}
		else if (nroSorpresa == 2){
			game.say(personaje, "Ups! Perdiste una vida :(")
			personaje.perderVida()}
		else if (nroSorpresa == 3){
			game.say(personaje, "Bien! Ganaste una vida :D")
			personaje.ganarVida()}
		else
			game.say(personaje, "Bueno, esta sorpresa no hace nada :p")
		game.removeVisual(self)
	}
	
	override method tocarPersonaje(pers){
		pers.agarrarSorpresa(self)
	}
	
}

object colores {
	const property blanco = "FFFFFFFF"
	const property rojo = "FF0000FF"
	}
	
	

object calcularPosAleatoria{
	method calcularPosAleatoriaLibre(){
		const posicionAleatoria=self.calcularPosicionAleatoria()
		const esP = game.getObjectsIn( posicionAleatoria ).any({ o => o.esPared() || o.esArma() || o.esMoneda() })
		if(esP)
			self.calcularPosAleatoriaLibre()
		else
			return posicionAleatoria
	}
	method calcularPosicionAleatoria() {
		const x = (0 .. game.width()-1).anyOne()
		const y = (0 .. game.height()-1).anyOne()
		return game.at(x,y)
	}
}




	
	

