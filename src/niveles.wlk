import wollok.game.*
import paredes.*

class AgregarParedes{
	const posic = new List()
	const paredes = new Set()
		
	method agregarImagen(){
		paredes.forEach { pared => game.addVisual(pared) }
		todasLasParedes.addAll(paredes)
	}
	method agregar(posiciones)
}

object paredesIndestructibles inherits AgregarParedes{
	override method agregar(posiciones){
		posic.addAll(posiciones)
		posic.forEach { pos => paredes.add(new ParedIndestructible(position = pos)) }
	}
}

object paredesDestructibles inherits AgregarParedes{
	override method agregar (posiciones){
		posic.addAll(posiciones)
		posic.forEach { pos => paredes.add(new ParedIndestructible(position = pos)) }
	}
}

class Niveles {
	
	method quitarNivel(){
		todasLasParedes.forEach { pared=> game.removeVisual(pared) }
	}
	
	method agregarBordes(){
		const ancho = game.width() - 1
		const largo = game.height() - 1
	
		paredesIndestructibles.agregar((0 .. ancho).map{nro => new Position(x = nro, y = 0)})
		paredesIndestructibles.agregar((0 .. 8).map{nro => new Position(x = nro, y = largo)})
		paredesIndestructibles.agregar((10 .. largo).map{nro => new Position(x = nro, y = largo)})
		paredesIndestructibles.agregar((0 .. largo).map{nro => new Position(x = 0, y = nro)})
		paredesIndestructibles.agregar((0 .. largo).map{nro => new Position(x = ancho, y = nro)})
	}
	
	method cargar()
	method fondo()
	
}

object uno inherits Niveles{
	override method cargar() {
		// Bordes
		self.agregarBordes()
		// L
		const paredesL = [new Position(x=3,y=3), new Position(x=3,y=4), new Position(x=3,y=5),new Position(x=3,y=6),new Position(x=4,y=3),
			new Position(x=16,y=3), new Position(x=16,y=4), new Position(x=16,y=5),new Position(x=16,y=6),new Position(x=15,y=3)]
		paredesIndestructibles.agregar(paredesL)
		// Paredes intermedias
		const intermedias = [new Position(x=12,y=1), new Position(x=12,y=2),new Position(x=12,y=3), new Position(x=12,y=4), new Position(x=6,y=6),
			new Position(x=7,y=6), new Position(x=10,y=6), new Position(x=11,y=6), new Position(x=1,y=18), new Position(x=4,y=18), new Position(x=6,y=18),
			new Position(x=3,y=16), new Position(x=5,y=16), new Position(x=15,y=10), new Position(x=16,y=10), new Position(x=17,y=10)]
		paredesIndestructibles.agregar(intermedias)
		// T (invertida)
		const tInvertida = [new Position(x=12,y=17), new Position(x=12,y=16),new Position(x=12,y=15),
			new Position(x=11,y=14), new Position(x=12,y=14), new Position(x=13,y=14)]
		paredesIndestructibles.agregar(tInvertida)
		// Esquinero
		const esquinero =  [new Position(x=16,y=16), new Position(x=16,y=15),new Position(x=15,y=16)]
		paredesIndestructibles.agregar(esquinero)
		
		const paredesRotas1 = [new Position(x=7,y=1), new Position(x=7,y=2),new Position(x=7,y=3), new Position(x=7,y=4)]
		paredesDestructibles.agregar(paredesRotas1)
		const paredesRotas2 = [new Position(x=2,y=14), new Position(x=4,y=14), new Position(x=6,y=14), new Position(x=8,y=17), new Position(x=8,y=16),new Position(x=8,y=15)]
		paredesDestructibles.agregar(paredesRotas2)
		
		paredesIndestructibles.agregarImagen()
		paredesDestructibles.agregarImagen()
	}
	
	override method fondo(){
		game.ground("Visuals/BACKGROUND/terrain.jpg")
	}
	
}

object dos inherits Niveles{
	override method cargar(){
		self.agregarBordes()
		// L
		const paredesL = [new Position(x=3,y=3), new Position(x=3,y=4), new Position(x=3,y=5),new Position(x=3,y=6),new Position(x=4,y=3),
			new Position(x=16,y=3), new Position(x=16,y=4), new Position(x=16,y=5),new Position(x=16,y=6),new Position(x=15,y=3)]
		paredesIndestructibles.agregar(paredesL)
	}
	
	override method fondo(){
		game.ground("Visuals/BACKGROUND/lava.jpg")
	}
	
}