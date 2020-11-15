* Baseline con todo tal cual está

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
* En este punto Denicolay subió el borrador de la linea de muerte trabajando sobre el dataset original (un 10% aleatorio de los no-baja), haciendo transformaciones de lags y con una BO de 10 iteraciones para el único parámetro pmin_data_in_leaf. Se analiza la ganancia en Kaggle (leaderbord público) de ambos con diferentes puntos de corte (de 0.2 a 0.25).

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

* Las modificaciones bajan el score para cualquier punto de corte.
* El más alto en ambos (0.19) tiene:
 1. Sin FE, ganancia 13.714.500 en enero y 8.973.750 en febrero
 2. Con FE, ganancia 13.380.750 en enero y 8.452.500 en febrero
* Sin tirar una nueva BO, pruebo los parámetros de Con FE haciendo ciertos FE:
 1. Solo columnas nuevas (sin correcciones) da 12.881.250 en enero y 8.288.250 en febrero.
 2. Correcciones y columnas nuevas de Denicolay (sin las mías) da 14.053.500 en enero y 9.042.000 en febrero. 
* **Se eliminan las variables nuevas mías y quedan las de él**.
