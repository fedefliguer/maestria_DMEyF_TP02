#Genera todas las lineas de muerte
#Necesita 64 GB de RAM
#limpio la memoria
rm( list=ls() )  #remove all objects
gc()             #garbage collection

# install.packages("primes")
require("data.table")
require("primes")
require("lightgbm")
require("DiceKriging")
require("mlrMBO")
library(devtools)
library(readr)

ksemilla_lgb  <-  102191

karchivo_salida <- "parametros_fijos_pasados.txt"

# Carga del ds 
setwd("/home/fjf_arg_gcloud/buckets/b1/datasets/")

kcampos_separador <-  "\t"
karchivo_entrada <-  "paquete_premium.txt.gz"
ds <- fread(karchivo_entrada, header=TRUE, sep=kcampos_separador)
ds[ , clase01 :=  ifelse( clase_ternaria=="BAJA+2", 1L, 0L)  ]
ds[ , clase_ternaria :=  NULL  ]

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

#------------------------------------------------------------------------------

restar_dos_meses  <- function( periodo )
{
  if( periodo %% 100  > 2 ) {
    res <- periodo - 2
  } else {
    res <- periodo - 100 + 10
  }
  
  return( res )
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
  
  tbl <- as.data.table( list( "prob"=probs, "gan"= ifelse( vlabels==1, 29250, -750 )))
  
  setorder( tbl, -prob )
  tbl[ , gan_acum :=  cumsum( gan ) ]
  gan <- max( tbl$gan_acum )
  
  return(  list( name= "ganancia", value=  gan, higher_better= TRUE ) )
}
#------------------------------------------------------------------------------


ganancia_public_pcorte  <- function(  x )
{
  gan <-  sum(  dataset_aplicacion[ Public==TRUE,   ( pred >= as.integer(x$pcorte_entero)/100 ) * ifelse( clase01==1, 29250, -750 ) ] )
  return( gan )
}
#------------------------------------------------------------------------------
#esta funcion calcula 100 valores de linea de muerte para un mes dado
#se debe cumplir  pmes_aplicacion <= 202003

modelo_fijo_en_periodo  <- function(  pmes_aplicacion, psemilla_undersampling )
{
  
  vmes_last  <- restar_dos_meses( pmes_aplicacion )
  vmes_test  <- restar_un_ano( pmes_aplicacion )
  
  #hago undersampling de los negativos
  #me quedo con TODOS los positivos, pero con solo el 5% de los negativos
  set.seed(psemilla_undersampling)
  dataset[ , azar:= runif( nrow(dataset) ) ]
  
  #defino el dataset donde voy a entrenar
  dataset[ ,  BO_train := 0L]
  dataset[ ( foto_mes>=201701 & foto_mes<=vmes_last & foto_mes!=vmes_test & ( clase01==1 | azar<=0.25) ),  BO_train := 1L]
  
  #dejo los datos en el formato que necesita LightGBM
  dBO_train  <<- lgb.Dataset( data  = data.matrix(  dataset[ BO_train==1, campos_buenos, with=FALSE]),
                              label = dataset[ BO_train==1, clase01],
                              free_raw_data = FALSE
  )
  
  
  #defino el dataset donde voy a testear
  dataset[ ,  BO_test1 := 0L]
  dataset[ foto_mes==vmes_test,  BO_test1 := 1L]
  
  dBO_test1  <<- lgb.Dataset( data  = data.matrix(  dataset[ BO_test1==1, campos_buenos, with=FALSE]),
                              label = dataset[ BO_test1==1, clase01],
                              free_raw_data = FALSE
  )
  
  #calculo el modelo final que usa el valor optimo de tamaño de hoja encontrado antes
  modelo_final <- lgb.train(data= dBO_train,
                            objective= "binary",
                            eval= fganancia_logistic_lightgbm,
                            valids= list( valid1= dBO_test1 ),
                            first_metric_only= TRUE,
                            metric= "custom",
                            num_iterations=  999999,
                            early_stopping_rounds=  200,
                            learning_rate = 0.08729865,
                            min_data_in_leaf= as.integer( 7317.16421 ),
                            feature_pre_filter= FALSE,
                            feature_fraction= 0.7547246,
                            lambda_l1= 0.8124524018,
                            lambda_l2= 68.419841,
                            verbose= -1,
                            seed= ksemilla_lgb
  )
  
  #este mes nunca se utilizo para entrenar
  dataset_aplicacion <<- copy( dataset[ foto_mes==pmes_aplicacion, ] )
  
  #Genero los archivos que voy a probar contra el Leaderboard Publico y quedarme con el mejor
  prediccion_final  <- predict( modelo_final,  data.matrix( dataset_aplicacion[ , campos_buenos, with=FALSE]))
  dataset_aplicacion[  , pred := prediccion_final ]
  
 #Genero 100 semillas a azar para dividir en Public/Private y calcular las ganancias
  ksemillas <- c(904147,976091,910661,242197,847519,226099,699493,275339,751423,844523,577531,955139,929311,923441,372847,778187,102913,923179,356929,488617,
                 579869,869299,702469,877367,737281,659473,370399,561529,813199,128969,242377,906823,461603,590963,366217,780631,902179,651029,511691,259387,
                 221071,538301,706913,212999,647321,167623,222163,920687,167213,325673,132233,284227,876181,978233,355457,641513,737969,838139,544759,617791,
                 577169,414241,415823,992917,433861,730421,586237,123701,221077,476167,794569,380909,631039,862541,260551,219983,217121,976957,432559,628861,
                 944297,236627,546613,493123,618841,289031,627091,990719,461921,216803,615101,482117,358243,981983,712883,213173,400249,953501,624203,656273)
  
  for( vsemilla in ksemillas )
  {
    #division por muestra estratificada en Public Private  20% 80%
    set.seed( vsemilla )
    dataset_aplicacion[ , azar_public:= runif( nrow(dataset_aplicacion) ) ]
    setorderv( dataset_aplicacion, c("clase01","azar_public") )  #ordeno primero por la clase
    dataset_aplicacion[  , Public :=   ( .I %% 5 )== 0 ]  # el operador  %% en R es el modulo
    
    vganancias <- c()
    for( i in 1:99 )   vganancias <-  c( vganancias,  ganancia_public_pcorte( list( "pcorte_entero"=i) ) )
    
    #uso una mini optimizacion bayesiana para encontrar la probabilidad de corte optima
    #digamos que es una pseudo busqueda binaria
    #lo corto en  valores del tipo  0.21, 0.22, 0.23   con dos decimales
    obj.pcorte <- makeSingleObjectiveFunction(
      name= "OptimBayesiana",  #un nombre que no tiene importancia
      fn=   ganancia_public_pcorte,  #aqui va la funcion que quiero optimizar
      minimize= FALSE,  #quiero maximizar la ganancia 
      par.set= makeParamSet( makeNumericParam("pcorte_entero",  lower=  1, upper=  99 ) ),
      has.simple.signature= FALSE,  #porque le pase los parametros con makeParamSet
      noisy= TRUE
    )
    
    ctrl_pcorte  <-  makeMBOControl( )
    ctrl_pcorte  <-  setMBOControlTermination( ctrl_pcorte, iters = 6 )  #apenas 6 iteraciones
    ctrl_pcorte  <-  setMBOControlInfill(ctrl_pcorte, crit = makeMBOInfillCritEI())
    
    surr.km  <-  makeLearner("regr.km", predict.type= "se", covtype= "matern3_2", control = list(trace = FALSE))
    
    BO_pcorte  <-  mbo(obj.pcorte, learner=surr.km, control=ctrl_pcorte)
    ganancia_public <-  BO_pcorte$y
    #en BO_pcorte$x$pcorte_entero  ha quedo la mejor probabilidad de corte
    
    #usando la mejor probabilidad de corte, calculo la ganancia en el leaderboard publico
    ganancia_private <-  sum(  dataset_aplicacion[ Public==FALSE,
                                                   ( pred >= as.integer(BO_pcorte$x$pcorte_entero)/100 ) * ifelse( clase01==1, 29250, -750 ) ] )
    
    #calculo la ganancia en TODO el mes, la union de Public y Private
    ganancia_completa <-  sum(  dataset_aplicacion[ , ( pred >= as.integer(BO_pcorte$x$pcorte_entero)/100 ) * ifelse( clase01==1, 29250, -750 ) ] )
    
    #escribo al archivo de salida
    cat( pmes_aplicacion,
         psemilla_undersampling,
         vsemilla,
         max( vganancias ) / 0.2,  #Ganancia maxima teorica alcanzable
         as.integer(BO_pcorte$x$pcorte_entero)/100,  #probabilidad de corte
         ganancia_public/0.2,  #ganancia normalizada en leaderboard Public
         ganancia_private/0.8, #ganancia normalizada en leaderboard Public
         ganancia_completa,   #ganancia en la union de Public y Private
         "\n",
         sep="\t",
         append= TRUE,
         file= karchivo_salida
    )
  }
  
  #libero espacio
  rm( dBO_train, dBO_test1, dataset_aplicacion )
  gc()
}
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

setwd("/home/fjf_arg_gcloud/buckets/b1/tp2-working/work")

#genero los titulos del archivo de salida
if(!file.exists(karchivo_salida))
{
  cat( "mes_aplicacion",
       "semilla_undersampling",
       "semilla_public",
       "ganancia_public_inalcanzable",
       "probabilidad_corte",
       "ganancia_public",
       "ganancia_private",
       "ganancia_completa",
       "\n",
       sep="\t",
       append= TRUE,
       file= karchivo_salida
  )
}

psemilla_undersampling <- 102191

meses_validos <-  c(202003, 202002, 202001, 201912, 201911, 201910, 201909, 201908, 201907 )

#calculo la linea de muerte para varios meses
for(  pmes_aplicacion in  meses_validos )
{
  modelo_fijo_en_periodo(  pmes_aplicacion, psemilla_undersampling )
}

############# AHORA APLICO A LA PREDICCIÓN

#hago undersampling de los negativos
set.seed(psemilla_undersampling)
dataset[ , azar:= runif( nrow(dataset) ) ]

dataset[ ,  BO_train := 0L]
dataset[ ( foto_mes>=201701 & foto_mes<=202003 & foto_mes!=201905 & ( clase01==1 | azar<=0.25) ),  BO_train := 1L] ##### ACÁ SE PUEDE TAMBIÉN EXCLUIR LOS MESES QUE DIJO EN EL ULTIMO MAIL

#dejo los datos en el formato que necesita LightGBM
dBO_train  <<- lgb.Dataset( data  = data.matrix(  dataset[ BO_train==1, campos_buenos, with=FALSE]),
                            label = dataset[ BO_train==1, clase01],
                            free_raw_data = FALSE
)


#defino el dataset donde voy a testear
dataset[ ,  BO_test1 := 0L]
dataset[ foto_mes==201905,  BO_test1 := 1L]

dBO_test1  <<- lgb.Dataset( data  = data.matrix(  dataset[ BO_test1==1, campos_buenos, with=FALSE]),
                            label = dataset[ BO_test1==1, clase01],
                            free_raw_data = FALSE
)

#calculo el modelo final que usa el valor optimo de tamaño de hoja encontrado antes
modelo_final <- lgb.train(data= dBO_train,
                          objective= "binary",
                          eval= fganancia_logistic_lightgbm,
                          valids= list( valid1= dBO_test1 ),
                          first_metric_only= TRUE,
                          metric= "custom",
                          num_iterations=  999999,
                          early_stopping_rounds=  200,
                          learning_rate = 0.08729865,
                          min_data_in_leaf= as.integer( 7317.16421 ),
                          feature_pre_filter= FALSE,
                          feature_fraction= 0.7547246,
                          lambda_l1= 0.8124524018,
                          lambda_l2= 68.419841,
                          verbose= -1,
                          seed= ksemilla_lgb
)

#este mes nunca se utilizo para entrenar
dataset_aplicacion <<- copy( dataset[ foto_mes==202005, ] )

#Genero los archivos que voy a probar contra el Leaderboard Publico y quedarme con el mejor
prediccion_final  <- predict( modelo_final,  data.matrix( dataset_aplicacion[ , campos_buenos, with=FALSE]))

entrega <-   as.data.table(cbind( "numero_de_cliente" = dataset_aplicacion[ foto_mes==202005, numero_de_cliente],  "prob" = prediccion_final) )
entrega = entrega[order(-prob)]

entrega[  ,  estimulo :=  c(rep(1, 6000),rep(0,nrow(entrega)-6000))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_6000.csv')
entrega[  ,  estimulo :=  c(rep(1, 6100),rep(0,nrow(entrega)-6100))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_6100.csv')
entrega[  ,  estimulo :=  c(rep(1, 6200),rep(0,nrow(entrega)-6200))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_6200.csv')
entrega[  ,  estimulo :=  c(rep(1, 6300),rep(0,nrow(entrega)-6300))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_6300.csv')
entrega[  ,  estimulo :=  c(rep(1, 6400),rep(0,nrow(entrega)-6400))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_6400.csv')
entrega[  ,  estimulo :=  c(rep(1, 6500),rep(0,nrow(entrega)-6500))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_6500.csv')
entrega[  ,  estimulo :=  c(rep(1, 6600),rep(0,nrow(entrega)-6600))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_6600.csv')
entrega[  ,  estimulo :=  c(rep(1, 6700),rep(0,nrow(entrega)-6700))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_6700.csv')
entrega[  ,  estimulo :=  c(rep(1, 6800),rep(0,nrow(entrega)-6800))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_6800.csv')
entrega[  ,  estimulo :=  c(rep(1, 6900),rep(0,nrow(entrega)-6900))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_6900.csv')
entrega[  ,  estimulo :=  c(rep(1, 7000),rep(0,nrow(entrega)-7000))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_7000.csv')
entrega[  ,  estimulo :=  c(rep(1, 7100),rep(0,nrow(entrega)-7100))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_7100.csv')
entrega[  ,  estimulo :=  c(rep(1, 7200),rep(0,nrow(entrega)-7200))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_7200.csv')
entrega[  ,  estimulo :=  c(rep(1, 7300),rep(0,nrow(entrega)-7300))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_7300.csv')
entrega[  ,  estimulo :=  c(rep(1, 7400),rep(0,nrow(entrega)-7400))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_7400.csv')
entrega[  ,  estimulo :=  c(rep(1, 7500),rep(0,nrow(entrega)-7500))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_7500.csv')
entrega[  ,  estimulo :=  c(rep(1, 7600),rep(0,nrow(entrega)-7600))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_7600.csv')
entrega[  ,  estimulo :=  c(rep(1, 7700),rep(0,nrow(entrega)-7700))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_7700.csv')
entrega[  ,  estimulo :=  c(rep(1, 7800),rep(0,nrow(entrega)-7800))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_7800.csv')
entrega[  ,  estimulo :=  c(rep(1, 7900),rep(0,nrow(entrega)-7900))]
fwrite( entrega[ ,  c('numero_de_cliente', 'estimulo'), with=FALSE], sep=',',  file='entrega_power_corta_7900.csv')
