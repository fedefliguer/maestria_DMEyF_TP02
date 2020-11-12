nuevas_columnas_fede = function(dataset){
  
  # Compartidas con el FE del profesor

  dataset[,mv_mlimitecompra := rowSums( cbind( Master_mlimitecompra, Visa_mlimitecompra) , na.rm=TRUE ) ]
  dataset[,mv_msaldototal:= rowSums( cbind( Master_msaldototal,Visa_msaldototal) , na.rm=TRUE ) ]

  # Propociones de las nuevas

  dataset[,pc_comisiones_limite := mcomisiones/mv_mlimitecompra]
  dataset[,pc_comisiones_productos := mcomisiones/cproductos]
  dataset[,pc_limite_saldo := mv_mlimitecompra/mcuentas_saldo]

  # Sobre los periodos

  dataset[,fl_enero := ifelse( foto_mes%%100 == 1 , 1, 0)]
  dataset[,fl_febrero := ifelse( foto_mes%%100 == 2 , 1, 0)]
  dataset[,fl_marzo := ifelse( foto_mes%%100 == 3 , 1, 0)]
  dataset[,fl_abril := ifelse( foto_mes%%100 == 4 , 1, 0)]
  dataset[,fl_mayo := ifelse( foto_mes%%100 == 5 , 1, 0)]
  dataset[,fl_junio := ifelse( foto_mes%%100 == 6 , 1, 0)]
  dataset[,fl_julio := ifelse( foto_mes%%100 == 7 , 1, 0)]
  dataset[,fl_agosto := ifelse( foto_mes%%100 == 8 , 1, 0)]
  dataset[,fl_septiembre := ifelse( foto_mes%%100 == 9 , 1, 0)]
  dataset[,fl_octubre := ifelse( foto_mes%%100 == 10 , 1, 0)]
  dataset[,fl_noviembre := ifelse( foto_mes%%100 == 11 , 1, 0)]
  dataset[,fl_diciembre := ifelse( foto_mes%%100 == 12 , 1, 0)]
  dataset[,fl_aguinaldo := ifelse( foto_mes%%100 %in% c(1, 7) , 1, 0)]
  dataset[,fl_post_paso := ifelse(foto_mes>201907, 1, 0)]
  dataset[,fl_cepo := ifelse(foto_mes>201910, 1, 0)]

  # Sobre los productos

  dataset[,nu_prestamos_totales := rowSums( cbind(cprestamos_hipotecarios,cprestamos_personales,cprestamos_prendarios) , na.rm=TRUE ) ]
  dataset[,vl_prestamos_totales := rowSums( cbind(mprestamos_hipotecarios,mprestamos_personales,mprestamos_prendarios) , na.rm=TRUE ) ]
  dataset[,fl_fidelizacion_tarjetas := ifelse(ctarjeta_debito + ctarjeta_visa + ctarjeta_master == 0 , 0, 1)  ]
  dataset[,fl_fidelizacion_descuentos := ifelse( ccajeros_propios_descuentos + ctarjeta_visa_descuentos + ctarjeta_master_descuentos == 0 , 0, 1)  ]
  dataset[,fl_fidelizacion_media := ifelse( ctarjeta_visa + ctarjeta_master + cprestamos_personales + cprestamos_prendarios + cpayroll_trx == 0 , 0, 1)  ]
  dataset[,fl_fidelizacion_alta := ifelse( ccaja_seguridad + cprestamos_hipotecarios == 0 , 0, 1)  ]
  dataset[,fl_invierte := ifelse( cplazo_fijo + cinversion1 + cinversion2 == 0 , 0, 1)  ]
  dataset[,vl_invierte := rowSums( cbind(mplazo_fijo_dolares,mplazo_fijo_pesos,minversion1_dolares,minversion1_pesos,minversion2) , na.rm=TRUE ) ]
  dataset[,vl_adeuda := rowSums( cbind(mv_msaldototal,mprestamos_personales,mprestamos_prendarios) , na.rm=TRUE ) ]
  dataset[,rt_invierte_adeuda := vl_invierte/vl_adeuda]
  dataset[,vl_egresos := rowSums( cbind( mautoservicio, mpagodeservicios, mforex_buy, mtransferencias_emitidas, mextraccion_autoservicio, mtarjeta_visa_consumo, mtarjeta_master_consumo, na.rm = TRUE))]
  dataset[,vl_egreso_principal := pmax( mautoservicio, mpagodeservicios, mforex_buy, mtransferencias_emitidas, mextraccion_autoservicio, mtarjeta_visa_consumo, mtarjeta_master_consumo, na.rm = TRUE)]
  dataset[,pc_egreso_principal := vl_egreso_principal/vl_egresos ]
  dataset[,fl_egreso_principal_compras_debito := ifelse(mautoservicio > pmax(mpagodeservicios, mforex_buy, mtransferencias_emitidas, mextraccion_autoservicio, mtarjeta_visa_consumo, mtarjeta_master_consumo, na.rm = TRUE), 1, 0)]
  dataset[,fl_egreso_principal_pago_servicios := ifelse(mpagodeservicios > pmax(mautoservicio, mforex_buy, mtransferencias_emitidas, mextraccion_autoservicio, mtarjeta_visa_consumo, mtarjeta_master_consumo, na.rm = TRUE), 1, 0)]
  dataset[,fl_egreso_principal_compra_me := ifelse(mforex_buy > pmax(mautoservicio, mpagodeservicios, mtransferencias_emitidas, mextraccion_autoservicio, mtarjeta_visa_consumo, mtarjeta_master_consumo, na.rm = TRUE), 1, 0)]
  dataset[,fl_egreso_principal_transferencias := ifelse(mtransferencias_emitidas > pmax(mautoservicio, mpagodeservicios, mforex_buy, mextraccion_autoservicio, mtarjeta_visa_consumo, mtarjeta_master_consumo, na.rm = TRUE), 1, 0)]
  dataset[,fl_egreso_principal_extracciones := ifelse(mextraccion_autoservicio > pmax(mautoservicio, mpagodeservicios, mforex_buy, mtransferencias_emitidas, mtarjeta_visa_consumo, mtarjeta_master_consumo, na.rm = TRUE), 1, 0)]
  dataset[,fl_egreso_principal_tc_visa := ifelse(mtarjeta_visa_consumo > pmax(mautoservicio, mpagodeservicios, mforex_buy, mtransferencias_emitidas, mextraccion_autoservicio, mtarjeta_master_consumo, na.rm = TRUE), 1, 0)]
  dataset[,fl_egreso_principal_tc_master := ifelse(mtarjeta_master_consumo > pmax(mautoservicio, mpagodeservicios, mforex_buy, mtransferencias_emitidas, mextraccion_autoservicio, fl_egreso_principal_tc_visa, na.rm = TRUE), 1, 0)]

  nuevo_orden <-  c( setdiff( colnames( dataset ) , "clase01" ) , "clase01" )
  setcolorder( dataset, nuevo_orden )

}

