import wollok.game.*
import sorpresasYVidas.*

class Moneda {
	var property position = game.origin()
	var valor = 0
	var property image = "Visuals/OBJECTS/items/bronce.png"
	method esMoneda() = true
	method esPared() = false
	method esArma() = false
	method esSorpresa() = false
	//override method toString() = 'moneda'
	
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

	method tocarPersonaje(pers){
		puntos.aumentarPuntuacion(valor)
		game.removeVisual(self)
	}
	
	method tocarEnemigo(enem){
		game.removeVisual(self)
	}
	
}
