
``` r
library(data.table)
library(ggplot2)
library(devtools)
library(Rcpp)
library(lightgbm)
library(methods)
library(ROCR)
library(knitr)
library(mlrMBO)
library(readr)

set.seed(1)

setwd(  "~/buckets/b1/datasets/" )

kcampos_separador <-  "\t"
karchivo_entrada <-  "paquete_premium_201901_202005.txt.gz"
ds <- fread(karchivo_entrada, header=TRUE, sep=kcampos_separador)

ds[ , clase01 :=  ifelse( clase_ternaria=="BAJA+2", 1L, 0L)  ]
ds[ , clase_ternaria :=  NULL  ]
#ds = ds[sample(.N,10000)]

#setwd(  "~/buckets/b1/tp2-working/" )

############ FE

source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/correcciones.R")
correcciones(ds)

source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/nuevas_columnas_fede.R")
nuevas_columnas_fede(ds)

source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/nuevas_columnas_catedra.R")
nuevas_columnas_catedra(ds)

# Si quiero quedarme únicamente con las n variables más importantes según los modelos 1 a 5
source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/solo_importantes.R")
nu_variables = 150
solo_importantes(ds, nu_variables)

# Ensayo 1: Corrección de columnas que a priori son malas
source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/correcciones.R")
correcciones(ds)

# Ensayo 2: Nuevas columnas armadas por Fede
source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/nuevas_columnas_fede.R")
nuevas_columnas_fede(ds)

# Ensayo 3: Nuevas columnas armadas por cátedra
source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/nuevas_columnas_catedra.R")
nuevas_columnas_catedra(ds)

base = ds

# Si quiero quedarme únicamente con las n variables más importantes según los modelos 1 a 5
source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/solo_importantes.R")
nu_variables = 150
solo_importantes(ds, nu_variables)

# Agrego el lag 1 y el delta 1 para todas las variables seleccionadas
source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/lag_delta.R")
lag_delta(ds)

# Agrego históricas (maximo, minimo, tendencia) para las ventanas que quiera
ventanas = c(12)
source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/variables_historicas.R")
variables_historicas(ds, ventanas)

ds_150 = ds

# SOLO PARA LAS 50 MEJORES
ds = base

source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/solo_importantes.R")
nu_variables = 50
solo_importantes(ds, nu_variables)

ventanas = c(3, 6)
source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/variables_historicas.R")
variables_historicas(ds, ventanas)

ds_50 = ds[ , grepl( "__" , names( ds ) ), with = FALSE ]

ds = cbind(ds_150, ds_50)

# Genero el testeo del impacto
source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/fe_tester.R")
fe_tester(ds, "VARS: 150, VENTANAS 3,6,12 (para 1-50), 12 (para 51-150)")

# CONVIERTO A RESULTADOS PARA AGREGAR AL RESULTS.MD
v150_ve3612_12 = kable(results, format = "html")
```
