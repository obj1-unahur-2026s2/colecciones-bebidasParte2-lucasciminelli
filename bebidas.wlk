object whisky {
  method rendimientoQueOtorga(dosisConsumida) = 0.9 ** dosisConsumida
}

object terere {
  method rendimientoQueOtorga(dosisConsumida) = 1.max(0.1 * dosisConsumida)
}

object cianuro {
  method rendimientoQueOtorga(dosisConsumida) = 0
}

object licuadoDeFrutas{
  const frutas = #{};

  method agregarFruta(_fruta){
    frutas.add(_fruta);
  }

 method rendimientoQueOtorga(dosisConsumida) {
    const nutrientesTotales = frutas.sum { fruta => fruta.obtenerNutrientesQueAporta() }
    
    return (dosisConsumida / 1000) * nutrientesTotales
  }
}

object aguaSaborizada {
  var bebidaBase = whisky // Ponemos una por defecto, pero se puede cambiar
  
  method saborizarCon(bebida) {
    bebidaBase = bebida
  }

  method rendimientoQueOtorga(dosisConsumida) {
    return 1 + bebidaBase.rendimientoQueOtorga(dosisConsumida / 4)
  }
}


object coctel {
  const ingredientes = [] // Usamos una lista por si queremos repetir el mismo ingrediente

  method agregarIngrediente(bebida) {
    ingredientes.add(bebida)
  }
  


  method rendimientoQueOtorga(dosisConsumida) {
    if (ingredientes.isEmpty()) {
        return 0 
    }
    const dosisPorIngrediente = dosisConsumida / ingredientes.size()
    
    return ingredientes.fold(1, { acum, bebida => acum * bebida.rendimientoQueOtorga(dosisPorIngrediente) })
  }
}