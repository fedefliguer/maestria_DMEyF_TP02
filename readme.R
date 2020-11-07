library(data.table)
library(ggplot2)
library(devtools)
library(Rcpp)
library(lightgbm)
library(methods)
library(xgboost)
library(ROCR)

set.seed(1)

#limpio la memoria
rm( list=ls() )
gc()

kcampos_separador <-  "\t"
karchivo_entrada <-  "datasets_paquete_premium_201906_202005.txt.gz"
ds <- fread(karchivo_entrada, header=TRUE, sep=kcampos_separador)
ds[ , clase01 :=  ifelse( clase_ternaria=="BAJA+2", 1L, 0L)  ]
ds[ , clase_ternaria :=  NULL  ]
#ds = ds[sample(.N,10000)]

# ESPACIO PARA CUALQUIER FE

source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/fe_tester.R")
fe_tester(ds, "baseline")
