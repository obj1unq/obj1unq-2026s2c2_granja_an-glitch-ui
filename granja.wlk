import wollok.game.*

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



object personaje {
	var property genero = femenino
	var property position = game.center()
	const propiedad = granja
	
	method  image() {
		return genero.prefijo() + "-player-" + self.estado() + ".png"
	} 
	method estado() {
		return if (self.estaSobreAlgo())  "abajo" else "normal" 
	}
	method estaSobreAlgo() {
		return not game.colliders(self).isEmpty()
	}
	method cambiarGenero() {
		genero = genero.otro()
	}

	method plantar(cultivo) {
		propiedad.plantar(cultivo, self.position())
	} 
	
}

object mercado {
	const property position = game.at(5,5)
	const property image = "mercado.png"
}

object granja {
	const property cultivos = #{}
	method plantar(cultivo, position) {
		self.validarPlantar(cultivo, position)
		cultivo.position(position)
		cultivos.add(cultivo)
		game.addVisual(cultivo)
	}
	method validarPlantar(cultivo, position) {
		if (not self.puedePlantar(cultivo, position)) {
			self.error("No se puede plantar")
		}
	}
	method puedePlantar(cultivo, position) {
		return not cultivos.contains(cultivo) and not self.hayCultivo(position)
	}
	method hayCultivo(position) {
		return cultivos.any({cultivo => cultivo.position() == position})
	}
}