library(data.table)
library(ggplot2)
library(devtools)
library(Rcpp)
library(lightgbm)
library(methods)
library(ROCR)
library(knitr)
library(mlrMBO)

setwd(  "~/buckets/b1/datasets/" )

kcampos_separador <-  "\t"
karchivo_entrada <-  "paquete_premium.txt.gz"
ds <- fread(karchivo_entrada, header=TRUE, sep=kcampos_separador)
ds[ , clase01 :=  ifelse( clase_ternaria=="BAJA+2", 1L, 0L)  ]
ds[ , clase_ternaria :=  NULL  ]

############ FE

source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/correcciones.R")
correcciones(ds)

source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/nuevas_columnas_fede.R")
nuevas_columnas_fede(ds)

source_url("https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/scripts/nuevas_columnas_catedra.R")
nuevas_columnas_catedra(ds)

dataset = ds

campos_lags  <- setdiff(  colnames(dataset) ,  c("clase_ternaria","clase01", "numero_de_cliente","foto_mes") )

setorderv( dataset, c("numero_de_cliente","foto_mes") )
dataset[,  paste0( campos_lags, "_lag1") :=shift(.SD, 1, NA, "lag"), by=numero_de_cliente, .SDcols= campos_lags]

#agrego los deltas de los lags, de una forma nada elegante
for( vcol in campos_lags )
{
  dataset[,  paste0(vcol, "_delta1") := get( vcol)  - get(paste0( vcol, "_lag1"))]
}

#los campos que se van a utilizar, intencionalmente no uso  numero_de_cliente
campos_buenos  <- setdiff(  colnames(dataset) ,  c("clase_ternaria","clase01","numero_de_cliente") )


############# UNDERSAMPLING Y LGB FORMAT

#hago undersampling de los negativos
#me quedo con TODOS los positivos, pero con solo el 5% de los negativos
set.seed(102191)
dataset[ , azar:= runif( nrow(dataset) ) ]

dataset[ ( foto_mes>=201701 & foto_mes<=202003 & foto_mes!=201905 & ( clase01==1 | azar<=0.05) ),  BO_train := 1L]

#Testeo en 201902, el mismo mes pero un año antes
dataset[ foto_mes==201905,  BO_test1 := 1L]

#dejo los datos en el formato que necesita LightGBM
dBO_train  <- lgb.Dataset( data  = data.matrix(  dataset[ BO_train==1, campos_buenos, with=FALSE]),
                           label = dataset[ BO_train==1, clase01],
                           free_raw_data = TRUE
)

dBO_test1  <- lgb.Dataset( data  = data.matrix(  dataset[ BO_test1==1, campos_buenos, with=FALSE]),
                           label = dataset[ BO_test1==1, clase01],
                           free_raw_data = TRUE
)

dataset_aplicacion <- copy( dataset[ foto_mes==202005, ] )


##################### SETUP

kBO_iter    <-  10  #cantidad de iteraciones de la Optimizacion Bayesiana
kbayesiana  <-  paste0("linea_de_muerte_05.RDATA" )

fganancia_logistic_lightgbm   <- function(probs, data) 
{
  vlabels <- getinfo(data, "label")
  
  tbl <- as.data.table( list( "prob"=probs, "gan"= ifelse( vlabels==1, 29250, -750 ) ) )
  
  setorder( tbl, -prob )
  tbl[ , gan_acum :=  cumsum( gan ) ]
  gan <- max( tbl$gan_acum )
  
  return(  list( name= "ganancia", value=  gan, higher_better= TRUE ) )
}

estimar_lightgbm <- function( x )
{
  modelo <-  lgb.train(data= dBO_train,
                       objective= "binary",  #la clase es binaria
                       eval= fganancia_logistic_lightgbm,  #esta es la fuciona optimizar
                       valids= list( valid1= dBO_test1 ),
                       first_metric_only= TRUE,
                       metric= "custom",  #ATENCION   tremendamente importante
                       num_iterations=  999999,  #un numero muy grande
                       early_stopping_rounds=  200,
                       min_data_in_leaf= as.integer( x$pmin_data_in_leaf ),
                       feature_fraction= 0.25,
                       learning_rate= 0.02,
                       feature_pre_filter= FALSE,
                       verbose= -1,
                       seed= 102191
  )
  
  ganancia1  <- unlist(modelo$record_evals$valid1$ganancia$eval)[ modelo$best_iter ] 
  
  #esta es la forma de devolver un parametro extra
  attr(ganancia1 ,"extras" ) <- list("pnum_iterations"= modelo$best_iter )
  
  cat( modelo$best_iter, ganancia1, "\n" )
  
  return( ganancia1 )
}

#libero la memoria borrando el dataset
rm(dataset)
gc()

#Aqui comienza la configuracion de la Bayesian Optimization
configureMlr(show.learner.output = FALSE)

#configuro la busqueda bayesiana,  los hiperparametros que se van a optimizar
#por favor, no desesperarse por lo complejo
obj.fun <- makeSingleObjectiveFunction(
  name = "OptimBayesiana",  #un nombre que no tiene importancia
  fn   = estimar_lightgbm,  #aqui va la funcion que quiero optimizar
  minimize= FALSE,  #quiero maximizar la ganancia 
  par.set = makeParamSet(
    makeNumericParam("pmin_data_in_leaf",  lower=  10, upper=  30000 ),
    makeNumericParam("pfeature_fraction", lower=  0.10 , upper=    1.0),
    makeNumericParam("plearning_rate",    lower=  0.01 , upper=    0.1)
  ),
  has.simple.signature = FALSE,  #porque le pase los parametros con makeParamSet
  noisy= TRUE
)

ctrl  <-  makeMBOControl( save.on.disk.at.time = 600,  save.file.path = kbayesiana )
ctrl  <-  setMBOControlTermination(ctrl, iters = kBO_iter )
ctrl  <-  setMBOControlInfill(ctrl, crit = makeMBOInfillCritEI())

surr.km  <-  makeLearner("regr.km", predict.type= "se", covtype= "matern3_2", control = list(trace = FALSE))

######## RUN

setwd("/home/fjf_arg_gcloud/buckets/b1/tp2-working/work")

if(!file.exists(kbayesiana))
{
  #lanzo la busqueda bayesiana
  run  <-  mbo(obj.fun, learner = surr.km, control = ctrl)
} else {
  #retoma el procesamiento en donde lo dejo
  run <- mboContinue( kbayesiana ) 
}

#calculo el modelo final
modelo_final <- lgb.train(data= dBO_train,
                          objective= "binary",
                          eval= fganancia_logistic_lightgbm,
                          valids= list( valid1= dBO_test1 ),
                          first_metric_only= TRUE,
                          metric= "custom",
                          num_iterations=  999999,
                          early_stopping_rounds=  200,
                          learning_rate= run$x$plearning_rate,  #ATENCION, este es el valor que se cambia
                          min_data_in_leaf= as.integer( run$x$pmin_data_in_leaf ),
                          feature_pre_filter= FALSE,
                          feature_fraction= run$x$pfeature_fraction,
                          verbose= -1,
                          seed= 102191
)

campos_lags_ok = setdiff(  colnames(dataset_aplicacion) ,  c("azar","BO_train", "BO_test1", "clase01", "numero_de_cliente") )

dataset_aplicacion <- copy( ds[ foto_mes==202001, ] )
prediccion_202001  <- predict( modelo_final,  data.matrix( dataset_aplicacion[  , campos_lags_ok, with=FALSE]))
analisis_202001 = data.table(dataset_aplicacion[, clase01], prediccion_202001)
analisis_202001 = analisis_202001[order(-prediccion_202001)]
analisis_202001[, ganancia := cumsum( 
  ifelse( analisis_202001[, get("V1")] == 1, 29250, -750 ))]

analisis_202001[2000] # prob 0.4066892, ganancia 11550000
analisis_202001[3000] # prob 0.3095625, ganancia 12600000
analisis_202001[4000] # prob 0.2466736, ganancia 13110000
analisis_202001[5000] # prob 0.203573, ganancia 13290000
analisis_202001[6000] # prob 0.1731201, ganancia 13320000
analisis_202001[7000] # prob 0.1731201, ganancia 13320000

dataset_aplicacion <- copy( ds[ foto_mes==202002, ] )
prediccion_202002  <- predict( modelo_final,  data.matrix( dataset_aplicacion[  , campos_lags_ok, with=FALSE]))
analisis_202002 = data.table(dataset_aplicacion[, clase01], prediccion_202002)
analisis_202002 = analisis_202002[order(-prediccion_202002)]
analisis_202002[, ganancia := cumsum( 
  ifelse( analisis_202002[, get("V1")] == 1, 29250, -750 ))]

analisis_202002[2000] # prob 0.3001102, ganancia 8280000
analisis_202002[3000] # prob 0.2272159, ganancia 8790000
analisis_202002[4000] # prob 0.1811168, ganancia 9180000
analisis_202002[5000] # prob 0.1504497, ganancia 8880000
analisis_202002[6000] # prob 0.1291652, ganancia 8850000

# AHORA LO ARMO PARA EL TARGET CON 7000

entrega <- copy( ds[ foto_mes==202005, ] )
prediccion_202005  <- predict( modelo_final,  data.matrix( entrega[  , campos_lags_ok, with=FALSE]), type = "prob")
entrega <-   as.data.table(cbind( "numero_de_cliente" = ds[ foto_mes==202005, numero_de_cliente],  "prob" = prediccion_202005) )
entrega = entrega[order(-prob)]
entrega[  ,  estimulo :=  c(rep(1, 7000),rep(0,nrow(entrega)-7000))]

fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="lgb_bo_conFE_8000.csv")

lgb.save(modelo_final, "modelo_borradorDL_BO_conFE.txt")
