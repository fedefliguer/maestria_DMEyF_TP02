# Modelo más power para probar
## 300 iteraciones
## 25% negativos
## Desde 2017

rm(list=ls())

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

rm(list=ls())

# Carga del ds 
setwd("/home/antonellaalopez/buckets/b1/datasetsOri/")

kcampos_separador               <-  "\t"
karchivo_entrada_full     <-  "paquete_premium.txt.gz"
ds <- fread(karchivo_entrada_full, header=TRUE, sep=kcampos_separador)


ds[ , clase01 :=  ifelse( clase_ternaria=="BAJA+2", 1L, 0L)  ]
ds[ , clase_ternaria :=  NULL  ]
ds = ds[foto_mes>=201701 , ]


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

############# UNDERSAMPLING Y LGB FORMAT

#hago undersampling de los negativos
#me quedo con TODOS los positivos, pero con solo el 5% de los negativos
set.seed(102191)
dataset[ , azar:= runif( nrow(dataset) ) ]

dataset[ ( foto_mes>=201701 & foto_mes<=201903 & ( clase01==1 | azar<=0.25) ),  BO_train := 1L]

#Testeo en 201902, el mismo mes pero un año antes
dataset[ foto_mes==201905,  BO_test1 := 1L]


start.time <- Sys.time()


#dejo los datos en el formato que necesita LightGBM
dBO_train  <- lgb.Dataset( data  = data.matrix(  dataset[ BO_train==1, campos_buenos, with=FALSE]),
                           label = dataset[ BO_train==1, clase01],
                           free_raw_data = TRUE
)

dBO_test1  <- lgb.Dataset( data  = data.matrix(  dataset[ BO_test1==1, campos_buenos, with=FALSE]),
                           label = dataset[ BO_test1==1, clase01],
                           free_raw_data = TRUE
)


rm(base, ds)

##################### SETUP

kBO_iter    <-  300  #cantidad de iteraciones de la Optimizacion Bayesiana
kbayesiana  <-  paste0("modelo_prefinal_power.RDATA" )

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
                       feature_fraction= x$pfeature_fraction,
                       learning_rate= x$plearning_rate,
                       feature_pre_filter= FALSE,
                       lambda_l1= x$plambda_l1,
                       lambda_l2= x$plambda_l2,
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
    makeNumericParam("plearning_rate",    lower=  0.01 , upper=    0.1),
    makeNumericParam("plambda_l1",        lower=  0L  , upper=   10L),
    makeNumericParam("plambda_l2",        lower=  0L  , upper=  100L)
  ),
  has.simple.signature = FALSE,  #porque le pase los parametros con makeParamSet
  noisy= TRUE
)

ctrl  <-  makeMBOControl( save.on.disk.at.time = 600,  save.file.path = kbayesiana )
ctrl  <-  setMBOControlTermination(ctrl, iters = kBO_iter )
ctrl  <-  setMBOControlInfill(ctrl, crit = makeMBOInfillCritEI())

surr.km  <-  makeLearner("regr.km", predict.type= "se", covtype= "matern3_2", control = list(trace = FALSE))

######## RUN

#setwd("/home/fjf_arg_gcloud/buckets/b1/tp2-working/work")
setwd("/home/antonellaalopez/buckets/b1/work/")

if(!file.exists(kbayesiana))
{
  #lanzo la busqueda bayesiana
  run  <-  mbo(obj.fun, learner = surr.km, control = ctrl)
} else {
  #retoma el procesamiento en donde lo dejo
  run <- mboContinue( kbayesiana ) 
}


end.time <- Sys.time()
tiempo_ejecucion = end.time - start.time
print(tiempo_ejecucion)


#Hiperparámetros
run$x$pfeature_fraction
run$x$plearning_rate
run$x$pmin_data_in_leaf
run$x$plambda_l1
run$x$plambda_l2
