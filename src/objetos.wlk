import wollok.game.*
import personaje.*
import enemigos.*
import puntosYVidas.*
import juego.*
import paredes.*

class Objetos {
	var property position
	method image()
	method esPared() = false
	method esPersonaje() = false
	method esEnemigo() = false
	method esObjeto() = true
	
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
	method tocarDisparo(disparo){
		game.removeVisual(self)
	}
}

object estadoMatarEnem{
	var property activado
	
	method activar(){
		activado = true
	}
	method desactivar(){
		activado = false
	}
}

class Arma inherits Objetos{
	method estaSiendoUsada() = personaje.arma() == self
	
	override method tocarPersonaje(pers){
		if(armaVacia.estaSiendoUsada())
			pers.usarArma(self)
	}
	
	method matarA(enem, pers){
		if ( estadoMatarEnem.activado() ){
			game.say(pers, "Te maté! :D")
			game.removeVisual(enem)
		}
		else{
			game.say(pers, "Perdiste una vida")
			pers.perderVida()
		}
	}
	
	method usar(pers){
		game.removeVisual(self)
		if(armaDisparo.estaSiendoUsada())
			pers.image("Visuals/CHARACTERS/player/soldado-izquierda-arma.png")
		else{
			estadoMatarEnem.activar()
			pers.image("Visuals/CHARACTERS/player/soldado-izquierda-espada.png")
		}
	}
	
	method disparar(pers){}
	
	method soltar(pers){
		if (armaDisparo.estaSiendoUsada()){
			armaDisparo.position(pers.siguientePosicion())
			game.addVisual(armaDisparo)
		}
		estadoMatarEnem.desactivar()
	}
	
}

object armaVacia inherits Arma( position = game.at(1,1) ){
	override method image() = "Visuals/OBJECTS/blocks/imagen-nula.png"
	override method toString()=""
	
	override method matarA(_, pers){}
	override method usar(_){}
	override method soltar(_){}
}

class ArmasMelee inherits Arma{
	var property image = "Visuals/OBJECTS/items/sword.png"
	var property usos = 3
	override method toString()="-espada"
	
	override method matarA(enem, pers){
		super(enem, pers)
		const sonido=game.sound("Sounds/espada.mp3")
		sonido.play()
		usos -= 1
		if(usos == 0)
			pers.soltarArma()
	}
}

object armaDisparo inherits Arma( position = posAleatoria.calcularLibre() ){
	var property direccion = izquierda
	var property image = "Visuals/OBJECTS/items/pistola-derecha.png"
	override method toString()="-arma"
	
	override method tocarEnemigo(enem){}
	method siguientePosicion() = direccion.siguientePosicion(position)
	method imagenNueva(palabra){
		image = "Visuals/OBJECTS/items/pistola-" + palabra.toString() + ".png"
	}
	
	override method disparar(pers){
		const nuevoDisparo = new Disparo()
		nuevoDisparo.position(pers.siguientePosicion())
		modificarDireccion.aplicar(pers.direccion(), nuevoDisparo)
		game.addVisual(nuevoDisparo)
		game.onCollideDo(nuevoDisparo, { objeto => objeto.tocarDisparo(nuevoDisparo) })
		game.onTick(500, "avanzar disparo", {nuevoDisparo.avanzar()})
		const sonido=game.sound("Sounds/disparo.mp3")
		sonido.play()
	}
}

class Disparo{
	var property position = game.at(1,1)
	var property direccion = abajo
	var property image = "Visuals/OBJECTS/items/bala-derecha.png"
	
	method avanzar(){
		position = direccion.siguientePosicion(position)
	}
	method tocarEnemigo(enem){
		game.removeVisual(enem)
		game.removeVisual(self)
	}
	method imagenNueva(palabra){
		image = "Visuals/OBJECTS/items/bala-" + palabra.toString() + ".png"
	}
	method tocarPersonaje(pers){
		game.say(self, "Te chocaste con una bala! Perdiste una vida :(")
		pers.perderVida()
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
		const sorpresa = [sorp1, sorp2, sorp3, sorp4, sorp5, sorp6].anyOne()
		sorpresa.apply()
		game.removeVisual(self)
	}
	
	override method tocarPersonaje(pers){
		self.efecto()
	}
}

const sorp1 = {puntos.disminuirPuntuacion(500)}

const sorp2 = {puntos.aumentarPuntuacion(500)}

object sorp3 {
	method apply(){
		if (!enemigosT.isEmpty())
			enemigosT.forEach { enemigo => enemigo.quedarseQuieto() }
	}
}

const sorp4 = {personaje.perderVida()}

const sorp5 = {personaje.ganarVida()}

const sorp6 = {game.say(personaje, "Bueno, esta sorpresa no hace nada :p")}


class Obstaculo inherits Objetos{
	const nroObstaculo = (1 .. 3).anyOne()
	override method image() = "Visuals/OBJECTS/blocks/obstaculo" + nroObstaculo.toString() + ".png"

	override method tocarEnemigo(enem){
		tocarPared.aplicar(enem)
	}
	override method tocarPersonaje(pers){
		tocarPared.aplicar(pers)
	}
}


object posAleatoria{
	method calcularLibre(){
		const posicionAleatoria = self.calcularPosicionAleatoria()
		const posOcupada = game.getObjectsIn( posicionAleatoria ).any({ o => o.esPared() || o.esObjeto() })
		if(posOcupada)
			return self.calcularLibre()
		else
			return posicionAleatoria
	}
	
	method calcularPosicionAleatoria() {
		const x = (0 .. game.width()-1).anyOne()
		const y = (0 .. game.height()-1).anyOne()
		return game.at(x,y)
	}
	
}