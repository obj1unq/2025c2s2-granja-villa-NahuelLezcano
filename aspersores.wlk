import wollok.game.*
import cultivos.*
import personaje.*

class Aspersor {
    var property position 

    const plantasLimitrofes = []

    method image() { return "aspersor.png"}

    method activarRiegoAutomatico() {
        game.onTick(1000, "Riego automatico", {self.regarPlantas()})
    }

    method regarPlantas() {         
        self.actualizarPlantasLimitrofes()   
        plantasLimitrofes.forEach({planta => planta.recibirRiegoDelAspersor()})
        plantasLimitrofes.clear()   
    }
    
    method actualizarPlantasLimitrofes() {

        plantasLimitrofes.addAll(self.soloLasPlantas(self.objetosLimitrofes()))
    }

    method objetosLimitrofes() {
        const posicionesLimitrofes = [position.up(1), position.up(1).right(1), position.right(1), position.right(1).down(1), position.down(1), position.down(1).left(1), position.left(1), position.left(1).up(1)]
        const objetosLimitrofes = []
        posicionesLimitrofes.forEach({posicion => objetosLimitrofes.addAll(game.getObjectsIn(posicion))})

        return objetosLimitrofes
    }

    method soloLasPlantas(objetos) {
        return objetos.filter({objeto => objeto.esCultivo()})
    }

    method esCultivo() { return false } 
}