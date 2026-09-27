import wollok.game.*
import personaje.*
import cultivos.*
import mercado.*



object granja {
	const property cultivos = #{}
	const property plantasCosechadas = #{}
	var property encargado = personaje

	method cultivoPlantado() = if (cultivos.isEmpty()){null} else {cultivos.anyOne()}

	method plantar(cultivo, position) {
		self.validarPlantar(cultivo, position)
		cultivo.position(position)
		cultivos.clear()
		cultivos.add(cultivo)
		game.addVisual(cultivo)
	}

	method validarPlantar(cultivo, position) {
		if (cultivos.contains(cultivo) or self.hayCultivo(position)){self.error("No se puede plantar acá...")}
	}

	method hayCultivo(position) {
		return cultivos.any({ cultivo => cultivo.position() == position })
	}

	method regar() {
		self.validarRiego()
		self.cultivoPlantado().efectoPorRiego()
	}

	method validarRiego() {
		if (self.cultivoPlantado() == null){self.error("No tengo nada para regar")}
	}

	method cosechar() {
		self.validarCosecha()
		const cultivo = self.cultivoPlantado()
		plantasCosechadas.add(cultivo)
		cultivo.efectoCosecha()
		cultivos.remove(cultivo)
	}

	method validarCosecha() {
		if (!self.elCultivoAcaEstaParaCosechar()){self.error("No es posible hacer la cosecha...")}
	}

	method elCultivoAcaEstaParaCosechar() = self.cultivoPlantado() != null and self.cultivoPlantado().estaListoParaCosechar()

	method vender() {
		self.validarVender()
		self.encargado().vender(self.totalAObtenerPorVenta())
		plantasCosechadas.clear()
	}

	method validarVender() {
		if (!self.hayMercadoAca()){self.error("No hay un mercado cerca...")}
	}

	method hayMercadoAca() = game.getObjectsIn(self.encargado().position()).contains(mercado)

	method totalAObtenerPorVenta() = (plantasCosechadas.map{ p => p.valor() }).sum()
}