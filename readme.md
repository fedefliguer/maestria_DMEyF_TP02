
``` r
library(data.table)
library(ggplot2)
library(devtools)
library(Rcpp)
library(lightgbm)
library(methods)
library(xgboost)
library(ROCR)
library(knitr)

set.seed(1)

setwd(  "~/buckets/b1/datasets/" )

kcampos_separador <-  "\t"
karchivo_entrada <-  "paquete_premium_201901_202005.txt.gz"
ds <- fread(karchivo_entrada, header=TRUE, sep=kcampos_separador)

ds[ , clase01 :=  ifelse( clase_ternaria=="BAJA+2", 1L, 0L)  ]
ds[ , clase_ternaria :=  NULL  ]
#ds = ds[sample(.N,10000)]

#setwd(  "~/buckets/b1/tp2-working/" )

# FEATURE ENGINEERING

# Ensayo 1: Corrección de columnas que a priori son malas
source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/correcciones.R")
correcciones(ds)

# Ensayo 2: Nuevas columnas armadas por Fede
source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/nuevas_columnas_fede.R")
nuevas_columnas_fede(ds)

# Ensayo 3: Nuevas columnas armadas por cátedra
source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/nuevas_columnas_catedra.R")
nuevas_columnas_catedra(ds)

source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/fe_tester.R")
fe_tester(ds, "_correcciones_nuevas_columnas_fede_catedra")

# CONVIERTO A RESULTADOS PARA AGREGAR AL RESULTS.MD
kable(results, format = "html")
```
