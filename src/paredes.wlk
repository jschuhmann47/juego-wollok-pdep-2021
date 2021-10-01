import personaje.*
import enemigo.*
import wollok.game.*
import pared.*


object nivel1 {
	
	method cargar() {
		
//	PAREDES
		const ancho = game.width() - 1
		const largo = game.height() - 1
	
		var posParedes = []
		(0 .. ancho).forEach{ n => posParedes.add(new Position(x=n, y=0)) } // bordeAbajo
		(0 .. 8).forEach{ n => posParedes.add(new Position(x=n, y=largo)) } // bordeArriba 1
		(10 .. largo).forEach{ n => posParedes.add(new Position(x=n, y=largo)) } // bordeArriba 2
		(0 .. largo).forEach{ n => posParedes.add(new Position(x=0, y=n)) } // bordeIzq 
		(0 .. largo).forEach{ n => posParedes.add(new Position(x=ancho, y=n)) } // bordeDer
		
		// L
		posParedes.addAll([new Position(x=3,y=3), new Position(x=3,y=4), new Position(x=3,y=5),new Position(x=3,y=6),new Position(x=4,y=3)])
		posParedes.addAll([new Position(x=16,y=3), new Position(x=16,y=4), new Position(x=16,y=5),new Position(x=16,y=6),new Position(x=15,y=3)])
		// |
		posParedes.addAll([new Position(x=7,y=1), new Position(x=7,y=2),new Position(x=7,y=3), new Position(x=7,y=4)])
		posParedes.addAll([new Position(x=12,y=1), new Position(x=12,y=2),new Position(x=12,y=3), new Position(x=12,y=4)])
		// -
		posParedes.addAll([new Position(x=6,y=6), new Position(x=7,y=6)])
		posParedes.addAll([new Position(x=10,y=6), new Position(x=11,y=6)])
		// .
		posParedes.addAll([new Position(x=1,y=18), new Position(x=4,y=18), new Position(x=6,y=18)])
		posParedes.addAll([new Position(x=3,y=16), new Position(x=5,y=16)])
		posParedes.addAll([new Position(x=2,y=14), new Position(x=4,y=14), new Position(x=6,y=14)])
		// | (mas chico)
		posParedes.addAll([new Position(x=8,y=17), new Position(x=8,y=16),new Position(x=8,y=15)])
		// _ 
		posParedes.addAll([new Position(x=15,y=10), new Position(x=16,y=10),new Position(x=17,y=10)])
		// T (invertida)
		posParedes.addAll([new Position(x=12,y=17), new Position(x=12,y=16),new Position(x=12,y=15)])
		posParedes.addAll([new Position(x=11,y=14), new Position(x=12,y=14), new Position(x=13,y=14)])
		// esquinero
		posParedes.addAll([new Position(x=16,y=16), new Position(x=16,y=15),new Position(x=15,y=16)])
		// cuadrado del medio
//		posParedes.addAll([new Position(x=6,y=12), new Position(x=7,y=12), new Position(x=8,y=12)])		//techo der
//		posParedes.addAll([new Position(x=4,y=11), new Position(x=5,y=11), new Position(x=6,y=11)])		//techo der
//		posParedes.addAll([new Position(x=11,y=12), new Position(x=12,y=12), new Position(x=13,y=12)])  //techo izq
//		posParedes.addAll([new Position(x=4,y=10), new Position(x=4,y=9),new Position(x=4,y=8)])		//pared izq
//		posParedes.addAll([new Position(x=13,y=11), new Position(x=13,y=10),new Position(x=13,y=9), new Position(x=13,y=8)]) //pared der
//		posParedes.addAll([new Position(x=5,y=8), new Position(x=6,y=8),new Position(x=7,y=8), new Position(x=8,y=8), new Position(x=9,y=8), new Position(x=10,y=8), new Position(x=11,y=8), new Position(x=12,y=8), new Position(x=13,y=8)]) //piso
		posParedes.addAll([new Position(x=3,y=10)])
		posParedes.forEach { p => self.dibujar(new Pared(position = p)) }	
		
			
	}
	
	method dibujar(dibujo) {
		game.addVisual(dibujo)
	}
	
}