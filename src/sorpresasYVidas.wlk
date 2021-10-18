import wollok.game.*
import personaje.*
import paredes.*
import enemigo.*
import objetos.*

object vida{
	const property position = game.at(9, 19)
	method image() = "Visuals/OBJECTS/items/paredConCorazon.png"
	method text() = personaje.vidas().toString()
	method textColor() = colores.blanco()
	method tocarPersonaje(pers){
		pers.colisionPared()
	}
	method esSorpresa() = false
	method esArma() = false
	method esMoneda() = false
}

object puntos{
	var puntuacion = 0
	const property position = game.at(9,18)
	method text() = puntuacion.toString()
	method aumentarPuntuacion(puntos){
		puntuacion += puntos
	}
	method tocarPersonaje(pers){} //no hace nada, solo tiene que entender el mensaje
	
}