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

    method regarPlantas() {         //Antes de cada riego se fija que cultivos tiene a su alrededor
        plantasLimitrofes.clear()   
        self.actualizarPlantas()   
        plantasLimitrofes.forEach({planta => planta.recibirRiego()})
    }
    
    method actualizarPlantas() {
        self.añadirSiHayPlantaEnLaCelda(self.objetoEnLaPosicion(position.up(1))) 
        self.añadirSiHayPlantaEnLaCelda(self.objetoEnLaPosicion(position.up(1).right(1)))
        self.añadirSiHayPlantaEnLaCelda(self.objetoEnLaPosicion(position.right(1)))
        self.añadirSiHayPlantaEnLaCelda(self.objetoEnLaPosicion(position.right(1).down(1))) 
        self.añadirSiHayPlantaEnLaCelda(self.objetoEnLaPosicion(position.down(1))) 
        self.añadirSiHayPlantaEnLaCelda(self.objetoEnLaPosicion(position.down(1).left(1))) 
        self.añadirSiHayPlantaEnLaCelda(self.objetoEnLaPosicion(position.left(1))) 
        self.añadirSiHayPlantaEnLaCelda(self.objetoEnLaPosicion(position.left(1).up(1)))
    }

    method añadirSiHayPlantaEnLaCelda(celda) {
        if (self.noEsCeldaVacia(celda) && self.hayUnaPlantaEnLaCelda(celda)) {
            plantasLimitrofes.add(self.plantaDeLaCelda(celda))
        }
    }

    method noEsCeldaVacia(celda) {return not celda.isEmpty() }

    method hayUnaPlantaEnLaCelda(celda) { return celda.get(0).esCultivo() }

    method plantaDeLaCelda(celda) {return celda.get(0) }

    method objetoEnLaPosicion(pos) { return game.getObjectsIn(pos) }

    method esCultivo() { return false } 
}