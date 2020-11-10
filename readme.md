
``` r
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

#limpio la memoria
rm( list=ls() )
gc()

kcampos_separador <-  "\t"
karchivo_entrada <-  "paquete_premium_201901_202005.txt.gz"

setwd(  "~/buckets/b1/datasets/" )

ds <- fread(karchivo_entrada, header=TRUE, sep=kcampos_separador)
ds[ , clase01 :=  ifelse( clase_ternaria=="BAJA+2", 1L, 0L)  ]
ds[ , clase_ternaria :=  NULL  ]
#ds = ds[sample(.N,10000)]

#setwd(  "~/buckets/b1/tp2-working/" )

# ESPACIO PARA CUALQUIER FE

# # _correcciones
# 
# ds[ foto_mes==201701,  ccajas_consultas   := NA ]
# ds[ foto_mes==201702,  ccajas_consultas   := NA ]
# ds[ foto_mes==201801,  internet   := NA ]
# ds[ foto_mes==201801,  thomebanking   := NA ]
# ds[ foto_mes==201801,  chomebanking_transacciones   := NA ]
# ds[ foto_mes==201801,  tcallcenter   := NA ]
# ds[ foto_mes==201801,  ccallcenter_transacciones   := NA ]
# ds[ foto_mes==201801,  cprestamos_personales   := NA ]
# ds[ foto_mes==201801,  mprestamos_personales   := NA ]
# ds[ foto_mes==201801,  mprestamos_hipotecarios  := NA ]
# ds[ foto_mes==201801,  ccajas_transacciones   := NA ]
# ds[ foto_mes==201801,  ccajas_consultas   := NA ]
# ds[ foto_mes==201801,  ccajas_depositos   := NA ]
# ds[ foto_mes==201801,  ccajas_extracciones   := NA ]
# ds[ foto_mes==201801,  ccajas_otras   := NA ]
# ds[ foto_mes==201806,  tcallcenter   :=  NA ]
# ds[ foto_mes==201806,  ccallcenter_transacciones   :=  NA ]
# ds[ foto_mes==201904,  ctarjeta_visa_debitos_automaticos  :=  NA ]
# ds[ foto_mes==201904,  mttarjeta_visa_debitos_automaticos  := NA ]
# ds[ foto_mes==201905,  mrentabilidad     := NA ]
# ds[ foto_mes==201905,  mrentabilidad_annual     := NA ]
# ds[ foto_mes==201905,  mcomisiones       := NA ]
# ds[ foto_mes==201905,  mpasivos_margen  := NA ]
# ds[ foto_mes==201905,  mactivos_margen  := NA ]
# ds[ foto_mes==201905,  ctarjeta_visa_debitos_automaticos  := NA ]
# ds[ foto_mes==201905,  ccomisiones_otras := NA ]
# ds[ foto_mes==201905,  mcomisiones_otras := NA ]
# ds[ foto_mes==201910,  mpasivos_margen  := NA ]
# ds[ foto_mes==201910,  mactivos_margen  := NA ]
# ds[ foto_mes==201910,  ccomisiones_otras := NA ]
# ds[ foto_mes==201910,  mcomisiones_otras := NA ]
# ds[ foto_mes==201910,  mcomisiones       := NA ]
# ds[ foto_mes==201910,  mrentabilidad     := NA ]
# ds[ foto_mes==201910,  mrentabilidad_annual     := NA ]
# ds[ foto_mes==201910,  chomebanking_transacciones   := NA ]
# ds[ foto_mes==201910,  ctarjeta_visa_descuentos   := NA ]
# ds[ foto_mes==201910,  ctarjeta_master_descuentos   := NA ]
# ds[ foto_mes==201910,  mtarjeta_visa_descuentos   := NA ]
# ds[ foto_mes==201910,  mtarjeta_master_descuentos    := NA ]
# ds[ foto_mes==201910,  ccajeros_propios_descuentos   := NA ]
# ds[ foto_mes==201910,  mcajeros_propios_descuentos   := NA ]
# ds[ foto_mes==202001,  cliente_vip   := NA ]

source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/fe_tester.R")
fe_tester(ds, "_correcciones")

kable(results, format = "html")
```
