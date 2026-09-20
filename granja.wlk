import wollok.game.*
import personaje.*
import cultivos.*
import mercado.*



object granja {
	//const property cultivos = #{}
	var property cultivoPlantado = null
	const property plantasCosechadas = #{}
	//var encargado = personaje


	method plantar(cultivo, position) {
		self.validarPlantar(cultivo, position)
		cultivo.position(position)
		//cultivos.add(cultivo)
		cultivoPlantado = cultivo
		game.addVisual(cultivo)
	}

	method validarPlantar(cultivo, position) {
		//if (not self.puedePlantar(cultivo, position)) {
		//	self.error("No se puede plantar")
		//}
		//if(!self.hayCultivo(position)){
		if(self.hayCultivo(position) or cultivoPlantado == cultivo){
			self.error("No se puede plantar...")
		}
	}

	//method puedePlantar(cultivo, position) {
	//	return not cultivos.contains(cultivo) and not self.hayCultivo(position)
	//}

	method hayCultivo(position) {
		//return cultivos.any({cultivo => cultivo.position() == position})
		//return cultivoPlantado != null
		return cultivoPlantado != null and cultivoPlantado.position() == position
	}

	method regar() {
		self.validarRiego()
		//cultivos.forEach({c => c.efectoPorRiego()})
		cultivoPlantado.efectoPorRiego()
	}

	method validarRiego() {
		if(cultivoPlantado == null){
			self.error("No tengo nada para regar")
		}
	}

	method cosechar() {
		self.validarCosecha()
		//cultivos.forEach({c => c.efectoCosecha()})
		plantasCosechadas.add(cultivoPlantado)
		cultivoPlantado.efectoCosecha()
		cultivoPlantado = null
	}

	method validarCosecha() {
		//if(cultivoPlantado == null){
		if(cultivoPlantado == null or not cultivoPlantado.estaListoParaCosechar()){
			self.error("No es posible hacer la cosecha...")
		}
	}
}