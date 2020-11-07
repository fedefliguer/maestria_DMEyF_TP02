# GENERA RÁPIDAMENTE EL RESULTADO DE UN FE, PARA ANALIZAR IMPACTOS MARGINALES. DEVUELVE PARA DOS CONJUNTOS DE PARÁMETROS EL RESULTADO EN 202001 Y 202002, Y EL AUC DE 202001+202002.

fe_tester = function(dataset, transformations){
  results <- data.table(dataset=character(),
                        periods=character(),
                        parameters=numeric(),
                        gan_202001=numeric(),
                        gan_202002=numeric(),
                        auc=numeric()
  )
  
  ds_3 = dataset[ foto_mes>=201910 & foto_mes<=201912 , ]
  ds_12 = dataset[ foto_mes>=201901 & foto_mes<=201912 , ]
  periods <- list(ds_3, ds_12)
  
  val = dataset[ foto_mes>=202001 & foto_mes<=202002 , ]
  
  par_1  <- list( num_iterations= 1265,learning_rate=  0.01020333,feature_fraction=  0.2333709,min_gain_to_split= 0.003569764,num_leaves=  417,lambda_l1= 4.553854,lambda_l2=  7.115316)
  par_2  <- list( num_iterations= 1468, learning_rate= 0.01503084, feature_fraction= 0.2575957, min_gain_to_split= 0.01428075, num_leaves= 94, lambda_l1= 3.758696, lambda_l2= 0.341236)
  parameters <- list(par_1, par_2)
  
  for (i in c(1, 2)){
    for (j in c(1,2)){
      campos_buenos  <- setdiff(colnames(periods[[j]]), c("numero_de_cliente","foto_mes","clase01"))
      dgeneracion  <- lgb.Dataset(data= data.matrix(periods[[j]][ , campos_buenos, with=FALSE]), label= periods[[j]]$clase01, free_raw_data= FALSE )
      modelo  <- lgb.train( data= dgeneracion,
                            objective= "binary",
                            boost_from_average= TRUE,
                            max_bin= 31,
                            num_iterations=    parameters[[i]]$num_iterations,
                            learning_rate=     parameters[[i]]$learning_rate,
                            feature_fraction=  parameters[[i]]$feature_fraction,
                            min_gain_to_split= parameters[[i]]$min_gain_to_split,
                            num_leaves=        parameters[[i]]$num_leaves,
                            lambda_l1=         parameters[[i]]$lambda_l1,
                            lambda_l2=         parameters[[i]]$lambda_l2
      )
      
      if(j==1){
        p = "3m"
      }
      else if (j==2){
        p = "12m"
      }  
      
      assign(paste("m_", p, "_", i, sep=""), modelo, envir = .GlobalEnv)
      
      val_p  <- predict(modelo, data.matrix( val[, campos_buenos, with=FALSE ]))
      val_pr  <- prediction( val_p, val$clase01)
      AUC  <- performance( val_pr,"auc")@y.values[[1]]
      
      val_202001 = val[foto_mes==202001, ]
      val_202001_p  <- predict(modelo, data.matrix( val_202001[, campos_buenos, with=FALSE ]))
      val_202001_g  <- sum((val_202001_p > 0.025) * val_202001[, ifelse( clase01==1,29250,-750)])
      
      val_202002 = val[foto_mes==202002, ]
      val_202002_p  <- predict(modelo, data.matrix( val_202002[, campos_buenos, with=FALSE ]))
      val_202002_g  <- sum((val_202002_p > 0.025) * val_202002[, ifelse( clase01==1,29250,-750)])
      
      result = list(transformations, p, i, val_202001_g, val_202002_g, AUC)
      results = rbind(results, result)
      assign("results", results, envir = .GlobalEnv)
    }
  }
  remove(dgeneracion, modelo, result, val_p, val_202001_g, val_202001_p, val_202002_g, val_202002_p, periods, parameters, p, par_1, par_2, ds_12, ds_3, val, val_202001, val_202002, val_pr, AUC, campos_buenos, i, j)
}
