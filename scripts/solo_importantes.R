myfile <- "https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/importances/importances_max_1_5.csv"
importances <- data.table(read_csv2(myfile))
importances = importances[max_gan>importance_min]
variables = unique(importances$Feature)
dataset = dataset[, c("foto_mes", "numero_de_cliente", variables, "clase01"), with=FALSE]
