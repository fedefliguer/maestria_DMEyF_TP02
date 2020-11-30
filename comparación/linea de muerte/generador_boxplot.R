library(data.table)
library(ggplot2)

suyo = fread("muertes_pasadas.txt")
suyo = suyo[mes_aplicacion>201902, ]
suyo$origen = "suyo"
nuestro = fread("work_muertes_pasadas_bo4.txt")
nuestro$origen = "nuestro"

data = rbind(nuestro, suyo)
data$mes_aplicacion = as.factor(data$mes_aplicacion)

ggplot(data, aes(x=mes_aplicacion, y=ganancia_private, fill=origen)) + 
  geom_boxplot()

options(scipen = 999)
