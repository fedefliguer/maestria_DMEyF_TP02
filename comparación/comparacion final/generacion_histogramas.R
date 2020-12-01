library(data.table)
library(ggplot2)

options(scipen = 999)
meses = c(201905, 201908, 202001)

suyo = fread("comparacion/lm.txt")
suyo = suyo[mes_aplicacion %in% meses, ]
suyo$origen = "lm"

nuestro1 = fread("comparacion/nuestro_5pc_desde2017_10iter.txt")
nuestro1 = nuestro1[mes_aplicacion %in% meses, ]
nuestro1$origen = "5pc_desde2017_10iter"
names(nuestro1) = names(suyo)

nuestro2 = fread("comparacion/nuestro_5pc_desde2018_10iter.txt")
nuestro2 = nuestro2[mes_aplicacion %in% meses, ]
nuestro2$origen = "5pc_desde2018_10iter"

nuestro3 = fread("comparacion/nuestro_20pc_desde2018_10iter.txt")
nuestro3 = nuestro3[mes_aplicacion %in% meses, ]
nuestro3$origen = "20pc_desde2018_10iter"

nuestro4 = fread("comparacion/nuestro_20pc_desde2018_100iter.txt")
nuestro4 = nuestro4[mes_aplicacion %in% meses, ]
nuestro4$origen = "20pc_desde2018_100iter"

nuestro5 = fread("comparacion/nuestro_5pc_desde2017_50iter.txt")
nuestro5 = nuestro5[mes_aplicacion %in% meses, ]
nuestro5$origen = "5pc_desde2017_50iter"

data = do.call("rbind", list(suyo, nuestro1, nuestro2, nuestro3, nuestro4, nuestro5))
data$mes_aplicacion = as.factor(data$mes_aplicacion)

ggplot(data, aes(x=mes_aplicacion, y=ganancia_private, fill=origen)) + 
  geom_boxplot()
