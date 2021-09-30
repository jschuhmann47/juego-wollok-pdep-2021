import wollok.game.*
import sorpresasYVidas.*

class Moneda {
		var valor = 0
	var imagen = "Visuals/OBJECTS/items/bronce.png"
	var property position = game.origin()
	method image() = imagen
	method esMoneda() = true
	//override method toString() = 'moneda'
	method valor(){
		var i = 0.randomUpTo(10)
		
		if(i < 6){
			valor = 100
			imagen = "Visuals/OBJECTS/items/bronce.png"
		}
		else{
			if(i < 9){
				valor = 200
				imagen = "Visuals/OBJECTS/items/plata.png"
			}
			else{
				valor = 300
				imagen = "Visuals/OBJECTS/items/oro.png"
			}
		}
	}
	
	method getNewPosition(){
		const x = 0.randomUpTo(20)
		const y = 0.randomUpTo(20)
		const posAux = game.at(x, y)
		 if( (game.getObjectsIn(posAux)).any({objeto => objeto.esPared() || objeto.esMoneda() || objeto.esArma() || objeto.esSorpresa()}) ){
			self.getNewPosition()
		}
		else{
			position = posAux
		}
		 
	}

	method tocarPersonaje(visual){
		if(visual.toString() == 'personaje'){
			puntos.aumentarPuntuacion(valor)
			game.removeVisual(self)
		}
	}
	
	method tocarEnemigo(visual){}
	
}
