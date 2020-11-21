* Bajas+2 por mes: **no es parejo**. De 201901 a 201912 tiene entre 850 y 1100, mientras que en 202001 tiene 799, 202002 562, 202003 411.
* En el mes de target, Mayo, hay 859 bajas. Por lo que se puede interpretar así

	300	350	400	450	500	550	600	650	700	750	800	850	859
4000	6.00	7.50	9.00	10.50	12.00	13.50	15.00	16.50	18.00	19.50	21.00	22.50	22.77
4500	5.63	7.13	8.63	10.13	11.63	13.13	14.63	16.13	17.63	19.13	20.63	22.13	22.40
5000	5.25	6.75	8.25	9.75	11.25	12.75	14.25	15.75	17.25	18.75	20.25	21.75	22.02
5500	4.88	6.38	7.88	9.38	10.88	12.38	13.88	15.38	16.88	18.38	19.88	21.38	21.65
6000	4.50	6.00	7.50	9.00	10.50	12.00	13.50	15.00	16.50	18.00	19.50	21.00	21.27
6500	4.13	5.63	7.13	8.63	10.13	11.63	13.13	14.63	16.13	17.63	19.13	20.63	20.90
7000	3.75	5.25	6.75	8.25	9.75	11.25	12.75	14.25	15.75	17.25	18.75	20.25	20.52
7500	3.38	4.88	6.38	7.88	9.38	10.88	12.38	13.88	15.38	16.88	18.38	19.88	20.15
8000	3.00	4.50	6.00	7.50	9.00	10.50	12.00	13.50	15.00	16.50	18.00	19.50	19.77
8500	2.63	4.13	5.63	7.13	8.63	10.13	11.63	13.13	14.63	16.13	17.63	19.13	19.40
9000	2.25	3.75	5.25	6.75	8.25	9.75	11.25	12.75	14.25	15.75	17.25	18.75	19.02
9500	1.88	3.38	4.88	6.38	7.88	9.38	10.88	12.38	13.88	15.38	16.88	18.38	18.65
10000	1.50	3.00	4.50	6.00	7.50	9.00	10.50	12.00	13.50	15.00	16.50	18.00	18.27
10500	1.13	2.63	4.13	5.63	7.13	8.63	10.13	11.63	13.13	14.63	16.13	17.63	17.90
11000	0.75	2.25	3.75	5.25	6.75	8.25	9.75	11.25	12.75	14.25	15.75	17.25	17.52
11500	0.38	1.88	3.38	4.88	6.38	7.88	9.38	10.88	12.38	13.88	15.38	16.88	17.15
12000	0.00	1.50	3.00	4.50	6.00	7.50	9.00	10.50	12.00	13.50	15.00	16.50	16.77
12500	-0.38	1.13	2.63	4.13	5.63	7.13	8.63	10.13	11.63	13.13	14.63	16.13	16.40
13000	-0.75	0.75	2.25	3.75	5.25	6.75	8.25	9.75	11.25	12.75	14.25	15.75	16.02
13500	-1.13	0.38	1.88	3.38	4.88	6.38	7.88	9.38	10.88	12.38	13.88	15.38	15.65
14000	-1.50	0.00	1.50	3.00	4.50	6.00	7.50	9.00	10.50	12.00	13.50	15.00	15.27
14500	-1.88	-0.38	1.13	2.63	4.13	5.63	7.13	8.63	10.13	11.63	13.13	14.63	14.90
15000	-2.25	-0.75	0.75	2.25	3.75	5.25	6.75	8.25	9.75	11.25	12.75	14.25	14.52
15500	-2.63	-1.13	0.38	1.88	3.38	4.88	6.38	7.88	9.38	10.88	12.38	13.88	14.15
16000	-3.00	-1.50	0.00	1.50	3.00	4.50	6.00	7.50	9.00	10.50	12.00	13.50	13.77
16500	-3.38	-1.88	-0.38	1.13	2.63	4.13	5.63	7.13	8.63	10.13	11.63	13.13	13.40
17000	-3.75	-2.25	-0.75	0.75	2.25	3.75	5.25	6.75	8.25	9.75	11.25	12.75	13.02
17500	-4.13	-2.63	-1.13	0.38	1.88	3.38	4.88	6.38	7.88	9.38	10.88	12.38	12.65
18000	-4.50	-3.00	-1.50	0.00	1.50	3.00	4.50	6.00	7.50	9.00	10.50	12.00	12.27
18500	-4.88	-3.38	-1.88	-0.38	1.13	2.63	4.13	5.63	7.13	8.63	10.13	11.63	11.90
19000	-5.25	-3.75	-2.25	-0.75	0.75	2.25	3.75	5.25	6.75	8.25	9.75	11.25	11.52
19500	-5.63	-4.13	-2.63	-1.13	0.38	1.88	3.38	4.88	6.38	7.88	9.38	10.88	11.15
20000	-6.00	-4.50	-3.00	-1.50	0.00	1.50	3.00	4.50	6.00	7.50	9.00	10.50	10.77


* Empiezo a trabajar con el método del fe_tester: cambio que hago en el dataset le aplico esa función, que me genera cuatro modelos: dos períodos (3meses -201910 a 201912- y 12meses -201901 a 201912-) X dos conjuntos de parámetros (C1 = num_iterations= 1265,learning_rate=  0.01020333,feature_fraction=  0.2333709,min_gain_to_split= 0.003569764,num_leaves=  417,lambda_l1= 4.553854,lambda_l2=  7.115316 y C2 = num_iterations= 1468, learning_rate= 0.01503084, feature_fraction= 0.2575957, min_gain_to_split= 0.01428075, num_leaves= 94, lambda_l1= 3.758696, lambda_l2= 0.341236). Evalúa la ganancia de ese modelo en enero y en febrero, y AUC y KS en enero + febrero.

* Primer experimento: baseline con todo tal cual está:

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

* Primera prueba: le agrego las correcciones a la base del dropbox

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

* Le gana en AUC a todos, así que parece que vamos bien.
* Ahora pruebo con las columnas que armó Denicolay (las mismas que habíamos usado en el tp anterior).

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

* Bajan todas las ganancias, aunque dos veces sube el AUC. ¿Las incluimos o no? Por ahora no sé.
* Las mejores son mv_status01, mv_mpagospesos, mv_Finiciomora, mv_status05, mvr_mpagominimo.

* En este punto Denicolay subió el borrador de la linea de muerte trabajando sobre el dataset original (un 5% aleatorio de los no-baja), haciendo sólamente transformaciones de lags y con una BO de 10 iteraciones para el único parámetro pmin_data_in_leaf. Para analizar cómo vamos con estas transformaciones, pruebo esa optimización que mandó (bo_borrador_sin_FE.RDATA), y pruebo una igual pero con nuestras transformaciones (bo_borrador_con_FE_1par.RDATA). Se analiza la ganancia en Kaggle (leaderbord público) de ambos con diferentes puntos de corte (de 0.2 a 0.25). **POSTERIOR**: Lo que mandó él entrenaba con muchos períodos, yo me olvidé de cambiar el dataset así que entrenó desde 201901.

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

* El punto de corte más alto en ambos (0.19) tiene:
 1. Sin FE, ganancia 13.714.500 en enero y 8.973.750 en febrero **Guarda que se usó para entrenar**
 2. Con FE, ganancia 13.380.750 en enero y 8.452.500 en febrero **Guarda que se usó para entrenar**
* Sin tirar una nueva BO, pruebo un nuevo modelo con esos parámetros:
 1. Solo columnas nuevas (sin correcciones) da 12.881.250 en enero y 8.288.250 en febrero. **Guarda que se usó para entrenar**
 2. Correcciones y columnas nuevas de Denicolay (sin las mías) da 14.053.500 en enero y 9.042.000 en febrero. **Guarda que se usó para entrenar**
* Las modificaciones bajan el score para cualquier punto de corte. ¿Estamos haciendo todo mal y conviene no hacer ningun cambio de variable? La explicación me la dijeron en clase: esto pasa porque todos los otros parámetros (salvo pmin_data_in_leaf) que no se ajustaron por la BO estaban elegidos especificamente, es decir que Denicolay probó que anden bien. Yo, en cambio, para mi nuevo dataset asumí que valían también pero se ve que no. 

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

* Claramente no suma. Descartamos esto y volvemos a la creación de variables. Con las dos FE, ya tenemos nuestro conjunto de variables, por lo que podemos hacer el análisis marginal de incorporar históricas.
* Empezamos probando el FE de él (lags y deltas) sobre el dataset que tenemos nosotros, y viendo el impacto como lo venimos haciendo.

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

* Panorama claro: Hay ganancia con este método de LAG + DELTA. Es el candidato para hacer mi BO basada en eso. 
* Tiro mi BO (bo_borrador_con_FE_3par.RDATA) con este dataset. La optimización es igual a la que mandó Denicolay (10 iteraciones, 5% de los que no son baja, mismos períodos de prueba y test) pero optimizando 3 parámetros.
* Pruebo los puntos de corte pensando en cantidades:
1. Donde más gano en Enero es mandando los primeros 6000 (corte 0.1731, ganancia 13320000) **Guarda que se usó para entrenar**
2. Donde más gano en Febrero es mandando los primeros 4000 (corte 0.1811, ganancia 9180000) **Guarda que se usó para entrenar**
3. Donde más gano en el leaderbord público es mandando los primeros 7000 (corte 0.1311, ganancia 12.58)
* Primera conclusión: empezar a ampliar el espacio de búsqueda (de 1 a 3 parámetros en conjunto) genera mucha ganancia. Los pasos a seguir son ampliar las otras cuestiones:
1. Más de 5% de los 0
2. Más de 10 iteraciones
3. Más parámetros para buscar
4. Más espacio de búsqueda en cada parámetro.
* Con todo esto la ganancia tiene que crecer. 
* La última duda que me queda antes de tirarme con eso es si ya con este FE estamos bien, o si podemos probar algo que había quedado del TP anterior: quedarme con algunas (las mejores) variables y sacarle más jugo histórico.
* Probamos eso en marginal: la última tabla que subí (FE de él sobre el dataset que tenemos nosotros) es el punto de partida, y se compara contra el mismo FE pero conservando únicamente una proporción de las variables y agregando ventanas históricas. 

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
   <td style="text-align:left;"> VARS: 150, VENTANAS: 12 </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 11169000 </td>
   <td style="text-align:right;"> 7656000 </td>
   <td style="text-align:right;"> 0.9496133 </td>
   <td style="text-align:right;"> 0.7739492 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 150, VENTANAS: 12 </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 11907750 </td>
   <td style="text-align:right;"> 8154000 </td>
   <td style="text-align:right;"> 0.9548356 </td>
   <td style="text-align:right;"> 0.7888675 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 150, VENTANAS: 12 </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11125500 </td>
   <td style="text-align:right;"> 7740000 </td>
   <td style="text-align:right;"> 0.9503930 </td>
   <td style="text-align:right;"> 0.7773157 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 150, VENTANAS: 12 </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11985000 </td>
   <td style="text-align:right;"> 7859250 </td>
   <td style="text-align:right;"> 0.9554769 </td>
   <td style="text-align:right;"> 0.7923207 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 100, VENTANAS: 6, 12 </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 10764000 </td>
   <td style="text-align:right;"> 7453500 </td>
   <td style="text-align:right;"> 0.9501426 </td>
   <td style="text-align:right;"> 0.7770054 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 100, VENTANAS: 6, 12 </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 11961000 </td>
   <td style="text-align:right;"> 8022000 </td>
   <td style="text-align:right;"> 0.9540588 </td>
   <td style="text-align:right;"> 0.7859781 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 100, VENTANAS: 6, 12 </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11234250 </td>
   <td style="text-align:right;"> 7290000 </td>
   <td style="text-align:right;"> 0.9500523 </td>
   <td style="text-align:right;"> 0.7707255 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 100, VENTANAS: 6, 12 </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11831250 </td>
   <td style="text-align:right;"> 7446000 </td>
   <td style="text-align:right;"> 0.9540436 </td>
   <td style="text-align:right;"> 0.7801709 </td>
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

* Mepa que la mejor es 150 variables y la ventana de 12, obvio que si no nos molesta forzarla un poco más podrían ser las 238 con su ventana de 12 O (esto sería bastante más pesado) las 150 con 12 y 6 o 12 y 3.
* Una idea más antes de la BO. No se podrá combinar? Es decir, para las primeras 50 tirar las tres ventanas (3, 6, 12) y desde la 50 hasta la 150 tirar solo la 12. Hago la prueba: queda un dataset pesado (1138 variables) pero si ibamos a usar el método de las 150 con ventana de 12 teníamos más de 900, o sea solo se suman 200 que pintan para ser buenas.

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
   <td style="text-align:left;"> VARS: 150, VENTANAS 3,6,12 (para 1-50), 12 (para 51-150) </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 11133000 </td>
   <td style="text-align:right;"> 7835250 </td>
   <td style="text-align:right;"> 0.9507317 </td>
   <td style="text-align:right;"> 0.7780712 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 150, VENTANAS 3,6,12 (para 1-50), 12 (para 51-150) </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 1 - m6 </td>
   <td style="text-align:right;"> 12045000 </td>
   <td style="text-align:right;"> 8478750 </td>
   <td style="text-align:right;"> 0.9556689 </td>
   <td style="text-align:right;"> 0.7889728 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 150, VENTANAS 3,6,12 (para 1-50), 12 (para 51-150) </td>
   <td style="text-align:left;"> 3m </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11436750 </td>
   <td style="text-align:right;"> 7956750 </td>
   <td style="text-align:right;"> 0.9515071 </td>
   <td style="text-align:right;"> 0.7823749 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> VARS: 150, VENTANAS 3,6,12 (para 1-50), 12 (para 51-150) </td>
   <td style="text-align:left;"> 12m </td>
   <td style="text-align:right;"> 2 - m7 </td>
   <td style="text-align:right;"> 11955000 </td>
   <td style="text-align:right;"> 7946250 </td>
   <td style="text-align:right;"> 0.9558679 </td>
   <td style="text-align:right;"> 0.7924988 </td>
  </tr>
</tbody>
</table>

* Genial, hay buena ganancia. Este va a ser el dataset sobre el que voy a hacer mi BO.
* Me guardo las importancias de los modelos de 12 meses (importances_m6 y importances_m7) por si durante la BO en algún momento convenga que ajustar la cantidad de variables (no sería lo ideal).
* Pruebo con algunos puntos de corte sobre Kaggle, elijo el m7.
0. 4000 me da 12.08
1. 5000 me da 12.50
2. 5500 me da 12.73
3. 6000 me da 12.49
4. 7000 me da 12.15
5. 8000 me da 11.88

* Listo, ATR para nuestra BO? No! Recordemos la última BO que hicimos, bo_borrador_con_FE_3par.RDATA que dio 12.58 en el leaderbord público. Acá con una prueba de parámetros dio 12.73. Como quiero hacer un análisis siempre marginal, voy a tirar primero esa misma BO más chica (la llamo bo_borrador_con_FE_Historicas_3par.RDATA), igual a la que hicimos antes pero con este dataset enriquecido (y ya definitivo?). Sería nuestra baseline de la BO, y también nuestra baseline de los tiempos (tardó 2.30hs) para entender cuánto gano porque puede tardar un montón. Solo después de tener eso puedo extender el espacio de búsqueda.
0. 4000 me da 12.31
1. 5000 me da 12.16
2. 5500 me da 12.91
3. 6000 me da 12.87
4. 6500 me da 12.82
5. 7000 me da 12.92
6. 8000 me da 12.63

* Ahora sí. La BO que corramos tiene que crecer respecto de estos scores.
