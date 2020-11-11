correcciones = function(dataset){
  setnames(dataset, "mrentabilidad_annual", "mrentabilidad_anual")

  dataset[ foto_mes==201701,  ccajas_consultas   := NA ]
  dataset[ foto_mes==201702,  ccajas_consultas   := NA ]

  dataset[ foto_mes==201801,  internet   := NA ]
  dataset[ foto_mes==201801,  thomebanking   := NA ]
  dataset[ foto_mes==201801,  chomebanking_transacciones   := NA ]
  dataset[ foto_mes==201801,  tcallcenter   := NA ]
  dataset[ foto_mes==201801,  ccallcenter_transacciones   := NA ]
  dataset[ foto_mes==201801,  cprestamos_personales   := NA ]
  dataset[ foto_mes==201801,  mprestamos_personales   := NA ]
  dataset[ foto_mes==201801,  mprestamos_hipotecarios  := NA ]
  dataset[ foto_mes==201801,  ccajas_transacciones   := NA ]
  dataset[ foto_mes==201801,  ccajas_consultas   := NA ]
  dataset[ foto_mes==201801,  ccajas_depositos   := NA ]
  dataset[ foto_mes==201801,  ccajas_extracciones   := NA ]
  dataset[ foto_mes==201801,  ccajas_otras   := NA ]

  dataset[ foto_mes==201806,  tcallcenter   :=  NA ]
  dataset[ foto_mes==201806,  ccallcenter_transacciones   :=  NA ]

  dataset[ foto_mes==201904,  ctarjeta_visa_debitos_automaticos  :=  NA ]
  dataset[ foto_mes==201904,  mttarjeta_visa_debitos_automaticos  := NA ]

  dataset[ foto_mes==201905,  mrentabilidad     := NA ]
  dataset[ foto_mes==201905,  mrentabilidad_anual     := NA ]
  dataset[ foto_mes==201905,  mcomisiones       := NA ]
  dataset[ foto_mes==201905,  mpasivos_margen  := NA ]
  dataset[ foto_mes==201905,  mactivos_margen  := NA ]
  dataset[ foto_mes==201905,  ctarjeta_visa_debitos_automaticos  := NA ]
  dataset[ foto_mes==201905,  ccomisiones_otras := NA ]
  dataset[ foto_mes==201905,  mcomisiones_otras := NA ]

  dataset[ foto_mes==201910,  mpasivos_margen  := NA ]
  dataset[ foto_mes==201910,  mactivos_margen  := NA ]
  dataset[ foto_mes==201910,  ccomisiones_otras := NA ]
  dataset[ foto_mes==201910,  mcomisiones_otras := NA ]
  dataset[ foto_mes==201910,  mcomisiones       := NA ]
  dataset[ foto_mes==201910,  mrentabilidad     := NA ]
  dataset[ foto_mes==201910,  mrentabilidad_anual     := NA ]
  dataset[ foto_mes==201910,  chomebanking_transacciones   := NA ]
  dataset[ foto_mes==201910,  ctarjeta_visa_descuentos   := NA ]
  dataset[ foto_mes==201910,  ctarjeta_master_descuentos   := NA ]
  dataset[ foto_mes==201910,  mtarjeta_visa_descuentos   := NA ]
  dataset[ foto_mes==201910,  mtarjeta_master_descuentos    := NA ]
  dataset[ foto_mes==201910,  ccajeros_propios_descuentos   := NA ]
  dataset[ foto_mes==201910,  mcajeros_propios_descuentos   := NA ]

  dataset[ foto_mes==202001,  cliente_vip   := NA ]
}
