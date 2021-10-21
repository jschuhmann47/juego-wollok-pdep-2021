import wollok.game.*
import personaje.*
import paredes.*
import enemigos.*
import objetos.*

object colores {
	const property blanco = "FFFFFFFF"
	const property rojo = "FF0000FF"
}

object vida{
	const property position = game.at(9, 19)
	method image() = "Visuals/OBJECTS/items/paredConCorazon.png"
	method text() = personaje.vidas().toString()
	method textColor() = colores.blanco()
	method tocarPersonaje(pers){
		pers.colisionPared()
	}
	method esObjeto() = false
	method esPared() = true
	method tocarDisparo(_){}
}

object puntos{
	var puntuacion = 0
	const property position = game.at(9,18)
	method text() = puntuacion.toString()
	method aumentarPuntuacion(puntos){
		puntuacion += puntos
	}
	method disminuirPuntuacion(puntos){
		puntuacion = (puntuacion-puntos).max(0)
	}
	method tocarPersonaje(pers){} //no hace nada, solo tiene que entender el mensaje
	method esPared() = true
	method esObjeto() = false
	method tocarEnemigo(_){}
	method tocarDisparo(_){}
	
}