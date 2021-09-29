class Pared {
	var property position
	
	method movete(direccion) {
		throw new Exception(message = "No puedes mover las paredes.")
	}
	
	method puedePisarte(_) = false
	method image() = "Visuals/OBJECTS/items/pared.png"
	method esEnemigo() = false
	method esPared() = true
	method esPersonaje() = false
	
	method tocarEnemigo(enem){
		enem.colisionPared()
	}
	method tocarPersonaje(pers){
		pers.colisionPared()
	}
	
}