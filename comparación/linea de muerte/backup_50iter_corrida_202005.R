# Script cálculo ganancia para cada mes
#limpio la memoria
rm( list=ls() )  #remove all objects
gc()             #garbage collection

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
library(DiceKriging)

kBO_iter      <-  50  #cantidad de iteraciones de la Optimizacion Bayesiana
ksemilla_lgb  <-  102191

#------------------------------------------------------------------------------

restar_dos_meses  <- function( periodo )
{
  if( as.integer(periodo-round(periodo/100,0)*100) %% 13  > 2 ) {
    res <- periodo - 2
    return(res)
  } else {
    res <- periodo - 100 + 10
    return(res)
  }
}
#------------------------------------------------------------------------------

restar_un_ano  <- function( periodo )
{
  return( periodo - 100 )
}
#------------------------------------------------------------------------------

#esta es la funcion de ganancia, que se busca optimizar
#se usa internamente a LightGBM
#se calcula internamente la mejor ganancia para todos los puntos de corte posibles

fganancia_logistic_lightgbm   <- function(probs, data) 
{
  vlabels <- getinfo(data, "label")
  
  tbl <- as.data.table( list( "prob"=probs, "gan"= ifelse( vlabels==1, 29250, -750 ) ) )
  
  setorder( tbl, -prob )
  tbl[ , gan_acum :=  cumsum( gan ) ]
  gan <- max( tbl$gan_acum )
  
  return(  list( name= "ganancia", value=  gan, higher_better= TRUE ) )
}
#------------------------------------------------------------------------------
#funcion que va a optimizar la Bayesian Optimization

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
                       learning_rate= x$plearning_rate,  #ATENCION, este es el valor que se cambia
                       min_data_in_leaf= as.integer(x$pmin_data_in_leaf ),
                       feature_pre_filter= FALSE,
                       feature_fraction= x$pfeature_fraction,
                       lambda_l1= x$plambda_l1,
                       lambda_l2= x$plambda_l2,
                       verbose= -1,
                       seed= ksemilla_lgb
  )
  
  ganancia1  <- unlist(modelo$record_evals$valid1$ganancia$eval)[ modelo$best_iter ] 
  
  #esta es la forma de devolver un parametro extra
  attr(ganancia1 ,"extras" ) <- list("pnum_iterations"= modelo$best_iter )
  
  return( ganancia1 )
}
#------------------------------------------------------------------------------
#esta funcion calcula 100 valores de linea de muerte para un mes dado
#se debe cumplir  pmes_aplicacion <= 202003

lineamuerte_en_periodo  <- function(  pmes_aplicacion, psemilla_undersampling )
{
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
      makeNumericParam("plearning_rate",    lower=  0.01 , upper=    0.1),
      makeNumericParam("plambda_l1",        lower=  0L  , upper=   10L),
      makeNumericParam("plambda_l2",        lower=  0L  , upper=  100L)
    ),
    has.simple.signature = FALSE,  #porque le pase los parametros con makeParamSet
    noisy= TRUE
  )
  
  vbayesiana <- paste0("/home/fjf_arg_gcloud/buckets/b1/tp2-working/work/backup_entrega_final.RDATA")
  
  ctrl  <-  makeMBOControl( save.on.disk.at.time = 600,  save.file.path = vbayesiana )
  ctrl  <-  setMBOControlTermination(ctrl, iters = kBO_iter )
  ctrl  <-  setMBOControlInfill(ctrl, crit = makeMBOInfillCritEI())
  
  surr.km  <-  makeLearner("regr.km", predict.type= "se", covtype= "matern3_2", control = list(trace = FALSE))
  
  if(!file.exists(vbayesiana))
  {
    #lanzo la busqueda bayesiana
    run  <-  mbo(obj.fun, learner = surr.km, control = ctrl)
  } else {
    #retoma el procesamiento en donde lo dejo
    run <- mboContinue( vbayesiana ) 
  }
  
  #En  run$x$pmin_data_in_leaf  ha quedo el optimo
  
  #calculo el modelo final que usa el valor optimo de tamaño de hoja encontrado antes
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
                            lambda_l1= run$x$plambda_l1,
                            lambda_l2= run$x$plambda_l2,
                            verbose= -1,
                            seed= ksemilla_lgb
  )
  
  #este mes nunca se utilizo para entrenar
  dataset_aplicacion <- copy( dataset[ foto_mes==pmes_aplicacion, ] )
  
  #Genero los archivos que voy a probar contra el Leaderboard Publico y quedarme con el mejor
  prediccion_final  == predict( modelo_final,  data.matrix( dataset_aplicacion[ , campos_buenos, with=FALSE]))
  
  #libero espacio
  rm( dBO_train, dBO_test1, dataset_aplicacion )
  gc()
}
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

#Aqui comienza el programa

# Carga del ds 
setwd(  "~/buckets/b1/datasets/" )

kcampos_separador <-  "\t"
karchivo_entrada <-  "paquete_premium.txt.gz"
ds <- fread(karchivo_entrada, header=TRUE, sep=kcampos_separador)
ds[ , clase01 :=  ifelse( clase_ternaria=="BAJA+2", 1L, 0L)  ]
ds[ , clase_ternaria :=  NULL  ]
ds = ds[foto_mes>201701 , ]

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

dataset = cbind(ds_150, ds_50)

rm(ds_150, ds_50)

#los campos que se van a utilizar, intencionalmente no uso  numero_de_cliente
campos_buenos  <- setdiff(  colnames(dataset) ,  c("clase_ternaria","clase01","numero_de_cliente") )

#dejo fija la semilla, pero la podria llegar a cambiar y hacer loops anidados
psemilla_undersampling <- 102191

#hago undersampling de los negativos
#me quedo con TODOS los positivos, pero con solo el 5% de los negativos
set.seed(psemilla_undersampling)
dataset[ , azar:= runif( nrow(dataset) ) ]

#defino el dataset donde voy a entrenar
dataset[ ,  BO_train := 0L]
dataset[ ( foto_mes>201701 & foto_mes<=202003 & foto_mes!=201905 & ( clase01==1 | azar<=0.05) ),  BO_train := 1L]

#dejo los datos en el formato que necesita LightGBM
dBO_train  <- lgb.Dataset( data  = data.matrix(  dataset[ BO_train==1, campos_buenos, with=FALSE]),
                           label = dataset[ BO_train==1, clase01],
                           free_raw_data = FALSE
)


#defino el dataset donde voy a testear
dataset[ ,  BO_test1 := 0L]
dataset[ foto_mes==201905,  BO_test1 := 1L]

dBO_test1  <- lgb.Dataset( data  = data.matrix(  dataset[ BO_test1==1, campos_buenos, with=FALSE]),
                           label = dataset[ BO_test1==1, clase01],
                           free_raw_data = FALSE
)

lineamuerte_en_periodo(  202005, psemilla_undersampling )

entrega <-   as.data.table(cbind( "numero_de_cliente" = dataset_aplicacion[ foto_mes==202005, numero_de_cliente],  "prob" = prediccion_final) )
entrega = entrega[order(-prob)]

entrega[  ,  estimulo :=  c(rep(1, 4000),rep(0,nrow(entrega)-4000))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_4000.csv")

entrega[  ,  estimulo :=  c(rep(1, 4200),rep(0,nrow(entrega)-4200))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_4200.csv")

entrega[  ,  estimulo :=  c(rep(1, 4400),rep(0,nrow(entrega)-4400))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_4400.csv")

entrega[  ,  estimulo :=  c(rep(1, 4600),rep(0,nrow(entrega)-4600))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_4600.csv")

entrega[  ,  estimulo :=  c(rep(1, 4800),rep(0,nrow(entrega)-4800))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_4800.csv")

entrega[  ,  estimulo :=  c(rep(1, 5000),rep(0,nrow(entrega)-5000))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_5000.csv")

entrega[  ,  estimulo :=  c(rep(1, 5200),rep(0,nrow(entrega)-5200))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_5200.csv")

entrega[  ,  estimulo :=  c(rep(1, 5400),rep(0,nrow(entrega)-5400))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_5400.csv")

entrega[  ,  estimulo :=  c(rep(1, 5600),rep(0,nrow(entrega)-5600))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_5600.csv")

entrega[  ,  estimulo :=  c(rep(1, 5800),rep(0,nrow(entrega)-5800))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_5800.csv")

entrega[  ,  estimulo :=  c(rep(1, 6000),rep(0,nrow(entrega)-6000))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_6000.csv")

entrega[  ,  estimulo :=  c(rep(1, 6200),rep(0,nrow(entrega)-6200))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_6200.csv")

entrega[  ,  estimulo :=  c(rep(1, 6400),rep(0,nrow(entrega)-6400))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_6400.csv")

entrega[  ,  estimulo :=  c(rep(1, 6600),rep(0,nrow(entrega)-6600))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_6600.csv")

entrega[  ,  estimulo :=  c(rep(1, 6800),rep(0,nrow(entrega)-6800))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_6800.csv")

entrega[  ,  estimulo :=  c(rep(1, 7000),rep(0,nrow(entrega)-7000))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_7000.csv")

entrega[  ,  estimulo :=  c(rep(1, 7200),rep(0,nrow(entrega)-7200))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_7200.csv")

entrega[  ,  estimulo :=  c(rep(1, 7400),rep(0,nrow(entrega)-7400))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_7400.csv")

entrega[  ,  estimulo :=  c(rep(1, 7600),rep(0,nrow(entrega)-7600))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_7600.csv")

entrega[  ,  estimulo :=  c(rep(1, 7800),rep(0,nrow(entrega)-7800))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_7800.csv")

entrega[  ,  estimulo :=  c(rep(1, 8000),rep(0,nrow(entrega)-8000))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_8000.csv")

entrega[  ,  estimulo :=  c(rep(1, 8200),rep(0,nrow(entrega)-8200))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_8200.csv")

entrega[  ,  estimulo :=  c(rep(1, 8400),rep(0,nrow(entrega)-8400))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_8400.csv")

entrega[  ,  estimulo :=  c(rep(1, 8600),rep(0,nrow(entrega)-8600))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_8600.csv")

entrega[  ,  estimulo :=  c(rep(1, 8800),rep(0,nrow(entrega)-8800))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_8800.csv")

entrega[  ,  estimulo :=  c(rep(1, 9000),rep(0,nrow(entrega)-9000))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_9000.csv")

entrega[  ,  estimulo :=  c(rep(1, 9200),rep(0,nrow(entrega)-9200))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_9200.csv")

entrega[  ,  estimulo :=  c(rep(1, 9400),rep(0,nrow(entrega)-9400))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_9400.csv")

entrega[  ,  estimulo :=  c(rep(1, 9600),rep(0,nrow(entrega)-9600))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_9600.csv")

entrega[  ,  estimulo :=  c(rep(1, 9800),rep(0,nrow(entrega)-9800))]
fwrite( entrega[ ,  c("numero_de_cliente", "estimulo"), with=FALSE], sep=",",  file="entrega_backup_9800.csv")
