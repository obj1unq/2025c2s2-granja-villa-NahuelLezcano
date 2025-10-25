import wollok.game.*
import cultivos.* 
import personaje.* 


class Mercado {
    var property position 

    method image() = "market.png"

    const property mercaderias = []

    var property monedas = 500.randomUpTo(2000).roundUp(0)

    method quitar(cantMonedas) {
        monedas -= cantMonedas
    }

    method agregar(nuevasMercaderias) {
        mercaderias.addAll(nuevasMercaderias)
    }
}

object mercadosEnElJuego {
    const property losMercados = [new Mercado(position = game.at(0,9)), 
                                   new Mercado(position = game.at(9,5)), 
                                   new Mercado(position = game.at(9,0))]

    method agregarVisualDeLosMercados() {
        losMercados.forEach({mercado => game.addVisual(mercado)})
    }
}