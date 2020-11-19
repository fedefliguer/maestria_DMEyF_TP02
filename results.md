* Targets por mes: **no es parejo**. De 201901 a 201912 tiene entre 850 y 1100, mientras que en 202001 tiene 799, 202002 562, 202003 411.
* Baseline con todo tal cual está:

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> dataset </th>
   <th style="text-align:left;"> periods </th>
   <th style="text-align:right;"> parameters </th>
   <th style="text-align:right;"> gan_202001 </th>
   <th style="text-align:right;"> gan_202002 </th>
   <th style="text-align:right;"> auc </th>
   <th style="text-align:right;"> ks </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> baseline </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 10632750 </td>
   <td style="text-align:right;"> 6666000 </td>
   <td style="text-align:right;"> 0.9456437 </td>
   <td style="text-align:right;"> 0.7615296 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> baseline </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 11025000 </td>
   <td style="text-align:right;"> 6902250 </td>
   <td style="text-align:right;"> 0.9506677 </td>
   <td style="text-align:right;"> 0.7767317 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> baseline </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 10175250 </td>
   <td style="text-align:right;"> 6845250 </td>
   <td style="text-align:right;"> 0.9452452 </td>
   <td style="text-align:right;"> 0.7621345 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> baseline </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11067750 </td>
   <td style="text-align:right;"> 6768000 </td>
   <td style="text-align:right;"> 0.9504831 </td>
   <td style="text-align:right;"> 0.7812051 </td>
  </tr>
 </tbody>
</table>

* Pruebo agregarle las correcciones a la base del dropbox

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> dataset </th>
   <th style="text-align:left;"> periods </th>
   <th style="text-align:right;"> parameters </th>
   <th style="text-align:right;"> gan_202001 </th>
   <th style="text-align:right;"> gan_202002 </th>
   <th style="text-align:right;"> auc </th>
   <th style="text-align:right;"> ks </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> _correcciones </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 10620000 </td>
   <td style="text-align:right;"> 6750750 </td>
   <td style="text-align:right;"> 0.9463774 </td>
   <td style="text-align:right;"> 0.7655640 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> _correcciones </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 11062500 </td>
   <td style="text-align:right;"> 6908250 </td>
   <td style="text-align:right;"> 0.9505114 </td>
   <td style="text-align:right;"> 0.7788874 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> _correcciones </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 10421250 </td>
   <td style="text-align:right;"> 6806250 </td>
   <td style="text-align:right;"> 0.9462242 </td>
   <td style="text-align:right;"> 0.7642716 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> _correcciones </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11178000 </td>
   <td style="text-align:right;"> 6701250 </td>
   <td style="text-align:right;"> 0.9504307 </td>
   <td style="text-align:right;"> 0.7762005 </td>
  </tr>
  </tbody>
</table>

* Pareciera que las correcciones no hacen ganar tanto.
* Pruebo las nuevas columnas mias

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> dataset </th>
   <th style="text-align:left;"> periods </th>
   <th style="text-align:right;"> parameters </th>
   <th style="text-align:right;"> gan_202001 </th>
   <th style="text-align:right;"> gan_202002 </th>
   <th style="text-align:right;"> auc </th>
   <th style="text-align:right;"> ks </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> _nuevas_columnas_fede </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 10759500 </td>
   <td style="text-align:right;"> 6951000 </td>
   <td style="text-align:right;"> 0.9463858 </td>
   <td style="text-align:right;"> 0.7589984 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> _nuevas_columnas_fede </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 11304000 </td>
   <td style="text-align:right;"> 6968250 </td>
   <td style="text-align:right;"> 0.9504804 </td>
   <td style="text-align:right;"> 0.7778025 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> _nuevas_columnas_fede </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 10647000 </td>
   <td style="text-align:right;"> 6848250 </td>
   <td style="text-align:right;"> 0.9455294 </td>
   <td style="text-align:right;"> 0.7617453 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> _nuevas_columnas_fede </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11001000 </td>
   <td style="text-align:right;"> 6943500 </td>
   <td style="text-align:right;"> 0.9502937 </td>
   <td style="text-align:right;"> 0.7785212 </td>
  </tr>
</tbody>
</table>

* Las nuevas variables ayudan. Incluso en gain llegan a quedar primeras (vl_egreso_principal) y terceras (vl_egresos). Otras importantes: fl_fidelizacion_media, vl_adeuda, vl_prestamos_totales, rt_invierte_adeuda, pc_comisiones_limite, nu_prestamos_totales, fl_egreso_principal_tc_visa
* El KS no aporta demasiado, se puede ganar en KS y perder en ganancia.
* Las nuevas columnas ayudan en las ganancias más bajas de febrero, menos en las más altas de enero donde ayudaban un poco las correcciones. Por eso vemos qué pasa con las dos cosas juntas:

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> dataset </th>
   <th style="text-align:left;"> periods </th>
   <th style="text-align:right;"> parameters </th>
   <th style="text-align:right;"> gan_202001 </th>
   <th style="text-align:right;"> gan_202002 </th>
   <th style="text-align:right;"> auc </th>
   <th style="text-align:right;"> ks </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> _correcciones_nuevas_columnas_fede </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 10670250 </td>
   <td style="text-align:right;"> 6806250 </td>
   <td style="text-align:right;"> 0.9469378 </td>
   <td style="text-align:right;"> 0.7637806 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> _correcciones_nuevas_columnas_fede </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 11236500 </td>
   <td style="text-align:right;"> 7033500 </td>
   <td style="text-align:right;"> 0.9508499 </td>
   <td style="text-align:right;"> 0.7773254 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> _correcciones_nuevas_columnas_fede </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 10712250 </td>
   <td style="text-align:right;"> 6965250 </td>
   <td style="text-align:right;"> 0.9465691 </td>
   <td style="text-align:right;"> 0.7644295 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> _correcciones_nuevas_columnas_fede </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11062500 </td>
   <td style="text-align:right;"> 7018500 </td>
   <td style="text-align:right;"> 0.9506184 </td>
   <td style="text-align:right;"> 0.7790350 </td>
  </tr>
</tbody>
</table>

* Le gana en AUC a todos, así que quedan.
* Pruebo las nuevas columnas que armó Denicolay.

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> dataset </th>
   <th style="text-align:left;"> periods </th>
   <th style="text-align:right;"> parameters </th>
   <th style="text-align:right;"> gan_202001 </th>
   <th style="text-align:right;"> gan_202002 </th>
   <th style="text-align:right;"> auc </th>
   <th style="text-align:right;"> ks </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> _correcciones_nuevas_columnas_fede_catedra </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 10559250 </td>
   <td style="text-align:right;"> 6757500 </td>
   <td style="text-align:right;"> 0.9468441 </td>
   <td style="text-align:right;"> 0.7589652 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> _correcciones_nuevas_columnas_fede_catedra </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 11013750 </td>
   <td style="text-align:right;"> 6888000 </td>
   <td style="text-align:right;"> 0.9506158 </td>
   <td style="text-align:right;"> 0.7766971 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> _correcciones_nuevas_columnas_fede_catedra </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 10537500 </td>
   <td style="text-align:right;"> 6873000 </td>
   <td style="text-align:right;"> 0.9469629 </td>
   <td style="text-align:right;"> 0.7586731 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> _correcciones_nuevas_columnas_fede_catedra </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11000250 </td>
   <td style="text-align:right;"> 6939000 </td>
   <td style="text-align:right;"> 0.9509203 </td>
   <td style="text-align:right;"> 0.7753216 </td>
  </tr>
</tbody>
</table>

* Bajan todas las ganancias, aunque dos veces sube el AUC.
* Las mejores son mv_status01, mv_mpagospesos, mv_Finiciomora, mv_status05, mvr_mpagominimo
* En este punto Denicolay subió el borrador de la linea de muerte trabajando sobre el dataset original (un 10% aleatorio de los no-baja), haciendo transformaciones de lags y con una BO de 10 iteraciones para el único parámetro pmin_data_in_leaf. Se genera una BO igual que la de Denicolay (bo_borrador_sin_FE.RDATA), y una ajustandola igual pero con nuestras transformaciones (bo_borrador_con_FE_1par.RDATA). Se analiza la ganancia en Kaggle (leaderbord público) de ambos con diferentes puntos de corte (de 0.2 a 0.25). También me olvidé de cambiar el dataset, y no entrenó con todos los períodos sino desde 201901.

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> punto de corte </th>
   <th style="text-align:left;"> kaggle - BO borrador punto de corte sin transformaciones </th>
   <th style="text-align:right;"> kaggle - BO borrador punto de corte con transformaciones </th>
  </tr>
 </thead>
<tbody>
   <tr>
   <th style="text-align:left;"> 0.17 </th>
   <th style="text-align:left;"> 12.13 </th>
   <th style="text-align:right;"> 11.80 </th>
  </tr>
   <tr>
   <th style="text-align:left;"> 0.18 </th>
   <th style="text-align:left;"> 12.31 </th>
   <th style="text-align:right;"> 12.22 </th>
  </tr>
   <tr>
   <th style="text-align:left;"> 0.19 </th>
   <th style="text-align:left;"> 12.55 </th>
   <th style="text-align:right;"> 12.47 </th>
  <tr>
   <th style="text-align:left;"> 0.20 </th>
   <th style="text-align:left;"> 12.34 </th>
   <th style="text-align:right;"> 12.15 </th>
  </tr>
  <tr>
   <th style="text-align:left;"> 0.21 </th>
   <th style="text-align:left;"> 12.21 </th>
   <th style="text-align:right;"> 11.85 </th>
  </tr>
   <tr>
   <th style="text-align:left;"> 0.22 </th>
   <th style="text-align:left;"> 12.36 </th>
   <th style="text-align:right;"> 11.67 </th>
  </tr>
   <tr>
   <th style="text-align:left;"> 0.23 </th>
   <th style="text-align:left;"> 12.21 </th>
   <th style="text-align:right;"> 11.77 </th>
  </tr>
   <tr>
   <th style="text-align:left;"> 0.24 </th>
   <th style="text-align:left;"> 12.09 </th>
   <th style="text-align:right;"> 11.64 </th>
  </tr>
   <tr>
   <th style="text-align:left;"> 0.25 </th>
   <th style="text-align:left;"> 11.70 </th>
   <th style="text-align:right;"> 11.39 </th>
  </tr>
   <tr>
   <th style="text-align:left;"> Top 5 variables </th>
   <th style="text-align:left;"> mcaja_ahorro, ctrx_quarter, mcuentas_saldo, mtarjeta_visa_consumo, ctarjeta_visa_transacciones </th>
   <th style="text-align:right;"> vl_egresos, mcaja_ahorro, vl_egreso_principal, pc_egreso_principal, mtarjeta_visa_consumo </th>
  </tr>
 </tbody>
</table>

* Las modificaciones bajan el score para cualquier punto de corte. La explicación me la dijeron en clase: esto pasa porque los otros parámetros que no se ajustaron por la BO estaban elegidos especificamente, y yo asumí que valían también pero se ve que no. 
* El más alto en ambos (0.19) tiene:
 1. Sin FE, ganancia 13.714.500 en enero y 8.973.750 en febrero
 2. Con FE, ganancia 13.380.750 en enero y 8.452.500 en febrero
* Sin tirar una nueva BO, pruebo los parámetros de Con FE haciendo ciertos FE:
 1. Solo columnas nuevas (sin correcciones) da 12.881.250 en enero y 8.288.250 en febrero.
 2. Correcciones y columnas nuevas de Denicolay (sin las mías) da 14.053.500 en enero y 9.042.000 en febrero. 
* Lo que dice él es que las variables nuevas siempre van a sumar, por lo que si bajaron es porque los parámetros que él dejó fijos (los dejó fijos pero ya había probado que eran buenos) con estas nuevas variables no son buenos. Tiene sentido en la medida que son variables nuevas, así que seguimos probando con ellas.
* Tenemos esto en cuenta, esperando que optimizando con más parámetros ayude. Hay que ampliar el espacio de búsqueda.
* Ahora escalo variables numéricas por mes (con el método del dropbox) y pruebo:

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> dataset </th>
   <th style="text-align:left;"> periods </th>
   <th style="text-align:right;"> parameters </th>
   <th style="text-align:right;"> gan_202001 </th>
   <th style="text-align:right;"> gan_202002 </th>
   <th style="text-align:right;"> auc </th>
   <th style="text-align:right;"> ks </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> escalo </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 10200000 </td>
   <td style="text-align:right;"> 6979500 </td>
   <td style="text-align:right;"> 0.9471565 </td>
   <td style="text-align:right;"> 0.7590729 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> escalo </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 10122000 </td>
   <td style="text-align:right;"> 7059750 </td>
   <td style="text-align:right;"> 0.9501952 </td>
   <td style="text-align:right;"> 0.7700053 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> escalo </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 9987000 </td>
   <td style="text-align:right;"> 6580500 </td>
   <td style="text-align:right;"> 0.9459770 </td>
   <td style="text-align:right;"> 0.7548883 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> escalo </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 9195750 </td>
   <td style="text-align:right;"> 5194500 </td>
   <td style="text-align:right;"> 0.9487536 </td>
   <td style="text-align:right;"> 0.7660306 </td>
  </tr>
</tbody>
</table>

* Claramente no suma. Sin esto, nos metemos a ver cómo mejorar las variables nuevas que tenemos a partir de lo que mandó en el borrador de la línea de muerte.
* Vamos con lo otro: ampliar el espacio de búsqueda y ver si mejora.
* Empezamos solo haciendole el FE de él (lags y deltas) al dataset que tenemos nosotros, y viendo el impacto como lo venimos haciendo.

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> dataset </th>
   <th style="text-align:left;"> periods </th>
   <th style="text-align:right;"> parameters </th>
   <th style="text-align:right;"> gan_202001 </th>
   <th style="text-align:right;"> gan_202002 </th>
   <th style="text-align:right;"> auc </th>
   <th style="text-align:right;"> ks </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> _fe_borrador </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 11226750 </td>
   <td style="text-align:right;"> 7687500 </td>
   <td style="text-align:right;"> 0.9494234 </td>
   <td style="text-align:right;"> 0.7693056 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> _fe_borrador </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 11848500 </td>
   <td style="text-align:right;"> 7562250 </td>
   <td style="text-align:right;"> 0.9542980 </td>
   <td style="text-align:right;"> 0.7859822 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> _fe_borrador </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11244750 </td>
   <td style="text-align:right;"> 7439250 </td>
   <td style="text-align:right;"> 0.9503816 </td>
   <td style="text-align:right;"> 0.7669653 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> _fe_borrador </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11575500 </td>
   <td style="text-align:right;"> 7478250 </td>
   <td style="text-align:right;"> 0.9544444 </td>
   <td style="text-align:right;"> 0.7870401 </td>
  </tr>
</tbody>
</table>

* Panorama claro: Hay ganancia con este método de LAG + DELTA. Por ahora es el candidato para hacer mi BO basada en eso. 
* La primera BO (bo_borrador_con_FE_3par.RDATA) la probamos con este dataset, igual a la que mandó Denicolay (mismos períodos de prueba y test) pero optimizando 3 parámetros, con 10 iteraciones, 5% de los 0 y probando puntos de corte basados en cantidades y no en probabilidades.
1. Donde más gano en Enero es mandando los primeros 6000 (corte 0.1731, ganancia 13320000)
2. Donde más gano en Febrero es mandando los primeros 4000 (corte 0.1811, ganancia 9180000)
3. Donde más gano en el leaderbord público es mandando los primeros 7000 (corte 0.1311, ganancia 12.58)
* Primera conclusión: empezar a ampliar el espacio de búsqueda (de 1 a 3 parámetros en conjunto) genera mucha ganancia.
* En este esquema, parece claro que lo que tenemos que hacer es ampliar el la BO (más de 5% de los 0, más de 10 iteraciones, más parámetros con más espacio de búsqueda) apuntando a que con esto la ganancia crezca. La última duda que me queda antes de tirarme con eso es si ya asegurar este FE o probar un caso de reducir variables y meter más históricas.
* Probamos eso: el FE Borrador va contra dos casos donde reduzco variables pero agrego lags

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> dataset </th>
   <th style="text-align:left;"> periods </th>
   <th style="text-align:right;"> parameters </th>
   <th style="text-align:right;"> gan_202001 </th>
   <th style="text-align:right;"> gan_202002 </th>
   <th style="text-align:right;"> auc </th>
   <th style="text-align:right;"> ks </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> VARS: 238, VENTANAS: Ninguna </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 11226750 </td>
   <td style="text-align:right;"> 7687500 </td>
   <td style="text-align:right;"> 0.9494234 </td>
   <td style="text-align:right;"> 0.7693056 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 238, VENTANAS: Ninguna </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 11848500 </td>
   <td style="text-align:right;"> 7562250 </td>
   <td style="text-align:right;"> 0.9542980 </td>
   <td style="text-align:right;"> 0.7859822 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 238, VENTANAS: Ninguna </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11244750 </td>
   <td style="text-align:right;"> 7439250 </td>
   <td style="text-align:right;"> 0.9503816 </td>
   <td style="text-align:right;"> 0.7669653 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 238, VENTANAS: Ninguna </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11575500 </td>
   <td style="text-align:right;"> 7478250 </td>
   <td style="text-align:right;"> 0.9544444 </td>
   <td style="text-align:right;"> 0.7870401 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 50, VENTANAS: 3, 6, 12 </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 11115750 </td>
   <td style="text-align:right;"> 7627500 </td>
   <td style="text-align:right;"> 0.9476855 </td>
   <td style="text-align:right;"> 0.7732366 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 50, VENTANAS: 3, 6, 12 </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 12045750 </td>
   <td style="text-align:right;"> 7792500 </td>
   <td style="text-align:right;"> 0.9511031 </td>
   <td style="text-align:right;"> 0.7820929 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 50, VENTANAS: 3, 6, 12 </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11265000 </td>
   <td style="text-align:right;"> 7439250 </td>
   <td style="text-align:right;"> 0.9468016 </td>
   <td style="text-align:right;"> 0.7705608 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 50, VENTANAS: 3, 6, 12 </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11766000 </td>
   <td style="text-align:right;"> 7642500 </td>
   <td style="text-align:right;"> 0.9513720 </td>
   <td style="text-align:right;"> 0.7807305 </td>
  </tr>
</tbody>
</table>
