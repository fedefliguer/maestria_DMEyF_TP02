library(data.table)
library(readr)

myfile <- "https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/comparaci%C3%B3n/linea%20de%20muerte/csv_train201701a202001_test201811a201903.csv"

total = data.table(read.csv(myfile, header = TRUE, sep = ",", quote = "\"", dec = ".", fill = TRUE))
ganancias_lb_privado = list()

i = 1
for (i in 1:1000){
  total$azar = runif(nrow(total))
  
  setorderv( total, c("target", "azar" ))
  
  secuencias_cinco = nrow(total)/5
  resto_secuencias_cinco = nrow(total) %% 5
  total$lb = c(rep(c(1, 1, 1, 1, 0), secuencias_cinco), rep(1, resto_secuencias_cinco))
  
  public_20pc = total[lb==0]
  private_80pc = total[lb==1]
  
  public_20pc$estimulo = as.integer(public_20pc$probabilidad>0.15)
  
  ganancia_optima_lb_pub =0 
  corte_optimo = 0
  
  for( vprob_corte  in (15:35)/100 )  #de 0.15 a 0.35
  {
    ganancia_lb_pub <- sum((public_20pc$probabilidad > vprob_corte) * 
                             public_20pc[, ifelse( target==1,29250,-750)])
    
    if (ganancia_lb_pub > ganancia_optima_lb_pub){
      corte_optimo = vprob_corte
    }
  }
  
  ganancia_lb_priv  <- sum((private_80pc$probabilidad > vprob_corte) * 
                             private_80pc[, ifelse( target==1,29250,-750)])
  
  ganancias_lb_privado = append(ganancias_lb_privado, ganancia_lb_priv)
  i = i + 1
}

ganancias_lb_privado <- unlist(ganancias_lb_privado, use.names = FALSE)

hist(ganancias_lb_privado, xaxt="n")
axis(side=1, at=axTicks(1), 
     labels=formatC(axTicks(1), format="d", big.mark=','))
