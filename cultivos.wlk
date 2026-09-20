import wollok.game.*
import granja.*


object maiz {
    var property position = game.center()
    var property estado = "bebe"


    method image() = "maiz_"+estado+".png"

    method efectoPorRiego() {
        estado = "adulto"
    }

    method efectoCosecha() {
        if(estado == "adulto"){
            game.removeVisual(self)
        }
    }

    method estaListoParaCosechar() = estado == "adulto"
}

object trigo {
    var property position = game.center()
    var property estado = "0"


    method image() = "trigo_"+estado+".png"

    method efectoPorRiego() {
        estado = if (estado == "0"){
            "1"
            } else if (estado == "1"){
                    "2"
            } else if (estado == "2"){
                "3"
            } else {"0"}
    }

    method efectoCosecha() {
        if(estado == "2" || estado == "3"){
            game.removeVisual(self)
        }
    }

    method estaListoParaCosechar() = estado == "2" or estado == "3"
}

object tomaco {
    var property position = game.center()
    var property estado = "_baby"


    method image() = "tomaco"+estado+".png"

    method efectoPorRiego() {
        estado = ""
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
        self.validarCosecha()
        game.removeVisual(self)
    }

    method estaListoParaCosechar() = true

    method validarCosecha() {
        
    }
}
