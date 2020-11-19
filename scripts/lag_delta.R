# Nombre de archivo: lag_delta.R
# Función: Sobre el dataset original, genera un lag y un delta

lag_delta = function(dataset){
  campos_lags  <- setdiff(  colnames(dataset) ,  c("clase_ternaria","clase01", "numero_de_cliente","foto_mes") )

  setorderv( dataset, c("numero_de_cliente","foto_mes") )
  dataset[,  paste0( campos_lags, "_lag1") :=shift(.SD, 1, NA, "lag"), by=numero_de_cliente, .SDcols= campos_lags]

  #agrego los deltas de los lags, de una forma nada elegante
  for( vcol in campos_lags )
  {
    dataset[,  paste0(vcol, "_delta1") := get( vcol)  - get(paste0( vcol, "_lag1"))]
  }
}
