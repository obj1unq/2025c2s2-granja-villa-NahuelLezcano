import mercados.*
import aspersores.*
import wollok.game.*
import cultivos.*


object personaje {
	var property position = game.center()
	const property image = "mplayer.png"
	const property cosecha = [] 
	var property oroAcumulado = 0

	method sembrar(cultivo) {
		self.validarSembrar()
		cultivo.position(self.position())
		game.addVisual(cultivo)
	}

	method validarSembrar() {
		if (self.hayAlgoEnLaPosicionActual()) {
			self.error("No se puede sembrar en este espacio que se encuentra ocupado por otro cultivo")
		}
	}

	method validarColocacionDeAspersor() {
		if (self.hayAlgoEnLaPosicionActual()) {
			self.error("No se puede colocar un aspersor por que el lugar ya está ocupado")
		}
	}

	method hayAlgoEnLaPosicionActual() = not (game.colliders(self).isEmpty())

	method regarCultivo() {
		const cultivoActual = game.uniqueCollider(self) //El cultivo que se encuentra en la misma posicion
		cultivoActual.regar()
	}

	method cosecharCultivo() {
		const cultivoActual = game.uniqueCollider(self) //El cultivo que se encuentra en la misma posicion

		if (cultivoActual.estaListoParaCosechar()) { 
			self.agregarACosecha(cultivoActual)
			game.removeVisual(cultivoActual) 
		}
	}

	method agregarACosecha(cultivo) {
		cosecha.add(cultivo)
	}

	method venderCosecha() {
		self.validarVenta()
		const mercado = self.mercadoActual()
		self.elMercadoPuedePagar(mercado)
		const precioOro = self.precioCosecha() 
		oroAcumulado += precioOro
		mercado.quitar(precioOro)
		mercado.agregar(cosecha)
		cosecha.clear() 
	}

	method validarVenta() {
		if (not self.estaEnElMercado()) {
			self.error("No se puede vender la cosecha si no se encuentra en un mercado")
		}
	}

	method estaEnElMercado() {
		return mercadosEnElJuego.losMercados().any({mercadoAct => mercadoAct.position() == self.position()})
	}

	method elMercadoPuedePagar(mercado) {
		if (mercado.monedas() < self.precioCosecha()) {
			self.error("El mercado actual no tiene suficiente monedas para comprar la cosecha")
		}
	}

	method mercadoActual() = mercadosEnElJuego.losMercados().find({mercadoAct => mercadoAct.position() == self.position()})

	method precioCosecha() = cosecha.sum({cultivo => cultivo.precio()})
	
	method informeDeVenta() {
		game.say(self, "Tengo " + oroAcumulado + " monedas, y " + cosecha.size()  + " plantas para vender")
	}

	method colocarAspersor() {
		self.validarColocacionDeAspersor()
	
		const nuevoAspersor = new Aspersor(position = self.position())
		nuevoAspersor.activarRiegoAutomatico()
		game.addVisual(nuevoAspersor)
	}

	method apagarAspersores() { game.removeTickEvent("Riego automatico") }

	method esCultivo() { return false }
}