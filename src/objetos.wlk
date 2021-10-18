import wollok.game.*
import personaje.*
import enemigo.*
import sorpresasYVidas.*


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
	
	method aparecer()
	method tocarPersonaje(param)
	method desaparecer(){
		game.removeVisual(self)
	}
	method tocarEnemigo(enem) {
		game.removeVisual(enem) //la mayoria hace esto, dps vemos
	}
	
}


class ArmasMelee inherits Objetos{
	override method aparecer(){
		game.addVisual( new ArmasMelee(position = self.calcularPosicionAleatoria()) )
		
	}
	override method image() = "Visuals/OBJECTS/items/sword.png"
	
	override method esArma() = true
	
	override method tocarPersonaje(pers){
		pers.usarArma(self)
	}
	
}

class Monedas inherits Objetos{
	var image = "Visuals/OBJECTS/items/bronce.png"
	var valor = 0
	override method image() = "Visuals/OBJECTS/items/bronce.png"
	override method esMoneda() = true
	
	
	override method tocarPersonaje(_){
		puntos.aumentarPuntuacion(valor)
		game.removeVisual(self)
	}
	
	override method aparecer(){
		game.addVisual( new Monedas(position = self.calcularPosicionAleatoria()) )
		
	}
	
	
	method calcularValorMoneda(){
		const tipoMoneda = 0.randomUpTo(10)

		if(tipoMoneda < 6){
			valor = 100
			image = "Visuals/OBJECTS/items/bronce.png"
		}
		else{
			if(tipoMoneda < 9){
				valor = 200
				image = "Visuals/OBJECTS/items/plata.png"
			}
			else{
				valor = 300
				image = "Visuals/OBJECTS/items/oro.png"
			}
		}
	}
	
}

class Sorpresas inherits Objetos{
	override method image() = "Visuals/OBJECTS/blocks/sorpresa.png"
	
	override method aparecer(){
		game.addVisual( new Sorpresas(position = self.calcularPosicionAleatoria()) )
	}
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
		const posicionAleatoria
		const esP = game.getObjectsIn( posicionAleatoria ).any({ o => o.esPared() || o.esArma() || o.esMoneda() })
		if(esP)
			self.calcularPosAleatoriaLibre()
		else
			return posicionAleatoria
	}
}



	
	

