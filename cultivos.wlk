import wollok.game.*


object maiz {
    var property position = game.center()
    var property estado = "bebe"


    method image() = "maiz_"+estado+".png"

    method cambiarEstado() {
        estado = "adulto"
    }
}

object trigo {
    var property position = game.center()
    var property estado = "0"


    method image() = "trigo_"+estado+".png"

    method cambiarEstado() {
        estado = if (estado == "0"){
            "1"
            } else if (estado == "1"){
                    "2"
            }       else {"3"}
    }
}

object tomaco {
    var property position = game.center()
    var property estado = "_baby"


    method image() = "tomaco"+estado+".png"

    method cambiarEstado() {
        estado = ""
    }
}
