import wollok.game.*
import granja.*


object personaje {
	var property genero = femenino
	var property position = game.center()
	const propiedad = granja


	method  image() = genero.prefijo() + "-player-" + self.estado() + ".png"

    //method position() = game.center()

	method estado() = if (self.estaSobreAlgo())  "abajo" else "normal" 


	method estaSobreAlgo() = not game.colliders(self).isEmpty()


	method cambiarGenero() {
		genero = genero.otro()
	}

	method plantar(cultivo) {
		//propiedad.plantar(cultivo, self.position())
		propiedad.plantar(cultivo, position)
	} 
	
}

object femenino{
	method prefijo() {
		return "f"
	}
	method otro() {
		return masculino
	}
}
object masculino{
	method prefijo() {
		return "m"
	}
	method otro() {
		return femenino
	}
}

