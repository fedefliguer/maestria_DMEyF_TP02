# Nombre de archivo: solo_importantes
# Función: Toma las variables importantes de los modelos 1 a 5 y conserva aquellas que superen cierto nivel mínimo

solo_importantes = function(dataset, nro_variables){
  myfile <- "https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/importances/importances_max_1_5.csv"
  importances <- data.table(read_csv2(myfile))[order(-rank(max_gan))]
  importances = importances[1:nro_variables]
  variables = unique(importances$Feature)
  ds <<- dataset[, c("foto_mes", "numero_de_cliente", variables, "clase01"), with=FALSE]
  }
