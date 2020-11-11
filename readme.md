
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

# FE
# Corrección de columnas que a priori son malas
source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/correcciones.R")
correcciones(ds)

source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/fe_tester.R")
fe_tester(ds, "_correcciones")

# CONVIERTO A RESULTADOS PARA AGREGAR AL RESULTS.MD
kable(results, format = "html")
```
