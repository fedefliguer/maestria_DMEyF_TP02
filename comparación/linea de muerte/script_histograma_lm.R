library(data.table)
library(readr)

myfile <- "https://raw.githubusercontent.com/fedefliguer/maestria_DMEyF_TP02/main/comparaci%C3%B3n/linea%20de%20muerte/csv_train201701a202001_test201811a201903.csv"

total = data.table(read.csv(myfile, header = TRUE, sep = ",", quote = "\"", dec = ".", fill = TRUE))
ganancias_lb_privado = list()

i = 1
for (i in 1:1000){       # 1000 ITERACIONES PARA COMPLETAR EL HISTOGRAMA
  total$azar = runif(nrow(total))  
  setorderv( total, c("target", "azar" )) # En cada iteración genero una columna al azar y ordeno (después de por el target) por esa para que la distribución publico-privado cambie.
  
  secuencias_cinco = nrow(total)/5
  resto_secuencias_cinco = nrow(total) %% 5
  total$lb = c(rep(c(1, 1, 1, 1, 0), secuencias_cinco), rep(1, resto_secuencias_cinco)) # Esto es para que se repartan 80-20
  
  public_20pc = total[lb==0]
  private_80pc = total[lb==1]
  
  ganancia_optima_lb_pub =0 
  corte_optimo = 0
  
  for( vprob_corte  in (15:35)/100 )  # de 0.15 a 0.35
  {
    ganancia_lb_pub <- sum((public_20pc$probabilidad > vprob_corte) * 
                             public_20pc[, ifelse( target==1,29250,-750)]) # Calculo la ganancia en el público si la linea de corte fuera esa
    
    if (ganancia_lb_pub > ganancia_optima_lb_pub){
      corte_optimo = vprob_corte  # El corte que de una máxima ganancia va a ser mi corte para el privado
    }
  }
  
  ganancia_lb_priv  <- sum((private_80pc$probabilidad > corte_optimo) * 
                             private_80pc[, ifelse( target==1,29250,-750)])   # Calculo ganancia en el privado
  
  ganancias_lb_privado = append(ganancias_lb_privado, ganancia_lb_priv) # Agrego a la lista de ganancias en el privado
  print (i) # Para saber por dónde va
  i = i + 1
}

ganancias_lb_privado <- unlist(ganancias_lb_privado, use.names = FALSE)

hist(ganancias_lb_privado, xaxt="n")
axis(side=1, at=axTicks(1), 
     labels=formatC(axTicks(1), format="d", big.mark=',')) # Genero histograma
