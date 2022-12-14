import wollok.game.*
import personaje.*
import paredes.*
import enemigos.*
import objetos.*
import juego.*
import niveles.*

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
		tocarPared.aplicar(pers)
	}
	method tocarEnemigo(enem){
		tocarPared.aplicar(enem)
	}
	method esObjeto() = false
	method esPared() = true
	method tocarDisparo(_){}
}

object puntos{
	var property puntuacion = 0
	var nivelUno = true
	const property position = game.at(9,18)
	method text() = puntuacion.toString()
	method aumentarPuntuacion(puntos){
		puntuacion += puntos
		if(nivelUno && puntuacion >= 1000){
			nivelUno = false
			juego.cargarNivel(dos)
		}
		if(puntuacion >= PUNTOSPARAGANAR){
			game.say(personaje,"Ganamos!")
			game.schedule(2000, {game.stop()})
		}
	}
	method disminuirPuntuacion(puntos){
		puntuacion = (puntuacion-puntos).max(0)
	}
	method tocarPersonaje(pers){}
	method esPared() = true
	method esObjeto() = false
	method tocarEnemigo(_){}
	method tocarDisparo(_){}
	
	
}