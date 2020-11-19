# Nombre de archivo: solo_importantes
# Función: Toma las variables importantes de los modelos 1 a 5 y conserva aquellas que superen cierto nivel mínimo

solo_importantes = function(dataset, importance_min){
  myfile <- "https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/importances/importances_max_1_5.csv"
  importances <- data.table(read_csv2(myfile))
  importances = importances[max_gan>importance_min]
  variables = unique(importances$Feature)
  ds <<- dataset[, c("foto_mes", "numero_de_cliente", variables, "clase01"), with=FALSE]
  }
