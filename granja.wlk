import wollok.game.*
import personaje.*
import cultivos.*
import mercado.*





object granja {
	const property cultivos = #{}
	//var encargado = personaje


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