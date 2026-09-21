import wollok.game.*
import granja.*


object maiz {
    var property position = game.center()
    var property etapa = "bebe"


    method image() = "maiz_"+etapa+".png"

    method efectoPorRiego() {
        etapa = "adulto"
    }

    method efectoCosecha() {
        if(self.estaListoParaCosechar()){
            game.removeVisual(self)
        }
    }

    method estaListoParaCosechar() = etapa == "adulto"

    method valor() = 150
}

object trigo {
    var property position = game.center()
    var property etapa = "0"


    method image() = "trigo_"+etapa+".png"

    method efectoPorRiego() {
        etapa = if (etapa == "0"){
            "1"
            } else if (etapa == "1"){
                    "2"
            } else if (etapa == "2"){
                "3"
            } else {"0"}
    }

    method efectoCosecha() {
        //if(etapa.toNumber() == 2 || etapa.toNumber() == 3){
        if(self.estaListoParaCosechar()){
            game.removeVisual(self)
        }
    }

    method estaListoParaCosechar() = etapa == "2" or etapa == "3"

    method valor() = (etapa.toNumber() - 1) * 100
}

object tomaco {
    var property position = game.center()
    var property etapa = "_baby"


    method image() = "tomaco"+etapa+".png"

    method efectoPorRiego() {
        etapa = ""
        //self.validarMovimiento()
        self.mover()
    }

    method mover() {
        const nuevaPosition = if(position.y()==game.height()-1){
            game.at(position.x(), 0)
        } else{
            game.at(position.x(), position.y()+1)
        }
        if (not granja.hayCultivo(nuevaPosition)) {
            position = nuevaPosition
        }
    }

    method efectoCosecha() {
        if(self.estaListoParaCosechar()){
            game.removeVisual(self)
        }
    }

    method estaListoParaCosechar() = true

    method valor() = 80
}
