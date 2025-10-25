import wollok.game.*
import personaje.*
import aspersores.*


class Maiz {
	var property position = game.at(0, 0)
	var property estado = babyCorn  
	
	method image() = estado.imagen()

	method recibirRiegoDelAspersor() { self.regar() }

	method regar() { estado = adultCorn }

	method estaListoParaCosechar() { return estado.listoParaCosecha() }

	method precio() = 150 

	method esCultivo() { return true }
}

object babyCorn {
	method imagen() { return "corn_baby.png" }

	method listoParaCosecha() { return false }
}

object adultCorn {
	method imagen() { return "corn_adult.png" }

	method listoParaCosecha() { return true }
}


class Trigo {
  	var property position = game.at(0, 0)
	var property etapa = 0  //Convertir los estado en objetos
	
	method image() = "wheat_" + etapa + ".png"

	method recibirRiegoDelAspersor() {
		self.regar()
	}

	method regar() {
		if(etapa < 3) { etapa += 1} else { etapa = 0 }
	}

	method estaListoParaCosechar() = etapa >= 2

	method precio() = (etapa - 1) * 100   


	method esCultivo() { return true }
}


class Tomaco {
  	var property position = game.at(0, 0)
	var property image = "tomaco.png"

	method recibirRiegoDelAspersor() { /*Nada*/ }

	method regar() {
		if(self.enLimite(personaje)) {
			const newPosition = self.posEjeYOrigen()
			personaje.position(newPosition)
		} else {
			const newPosition = personaje.position().up(1)
			personaje.position(newPosition)
		}
	}

	method enLimite(personaje) { return personaje.position().y() == game.width()-1 }

	method posEjeYOrigen() { return game.at(personaje.position().x(), 0) }

	method estaListoParaCosechar() { return true } 

	method precio() = 80 // Monedas

	method esCultivo() { return true }
}
