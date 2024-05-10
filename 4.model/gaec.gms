Binary variable 
  v_binRepCropPlot1(curPlots,curCrops,years) each plot on which crops are grown in two consecutive years 
  v_binRepCropPlot2(curPlots,curCrops,years) each plot on which crops are grown in three consecutive years 
;

Equations
*  e_gaec6(years)
  e_preCropSeq1(curPlots,curCrops,years) 
  e_gaec7_1(curCrops,years)
  e_gaec7_2(curCrops,years)
  e_gaec8(years)
*  e_efa
*  e_75diversification(cropGroup)
*  e_95diversification(cropGroup,cropGroup1)
;
 
*
* --- gaec 6
* 
$ontext
e_gaec6(years)..
  sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  $ (curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield)
    ),
* cover crops to fulfil minimum coverage requirements 
  v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years)
    * p_plotData(curPlots,"size")
    * p_grossMarginData(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,'efaFactor')
* winter grains as minimum coverage requirement OR stubble fallow as minimum coverage requirement
  + (v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years)      
    * p_plotData(curPlots,"size")) $ curCrops_cropType(curCrops,'Wintergetreide')
* maize stubble fallow as minimum coverage requirement 
  + (v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years) 
    * p_plotData(curPlots,"size")) 
    $ (sameas(catchCrop,'false') AND curCrops_cropType(curCrops,'Mais'))   
* if summer grains should become possible to be grown, it would be necessary to add a conditional based on the next period       
  )
  =G= 0.8*p_totArabLand - v_devGaec6(years); 
$offtext

*
* --- gaec 7 STILL UNDER CONSTRUCTION!!!!!!!
*
e_preCropSeq1(curPlots,curCrops,years)
  $ (years.pos ne 1)..
  sum((KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield)
    AND sameas(curCrops,curCrops)
    ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years-1) 
  + v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years))
  -1
  =L=
  v_binRepCropPlot1(curPlots,curCrops,years) * M
;

e_gaec7_1(curCrops,years)..
  sum((curPlots,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield)
    ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  * p_plotData(curPlots,"size")) * 0.33
  =G= 
  sum(curPlots,
  v_binRepCropPlot(curPlots,curCrops,years) 
  * p_plotData(curPlots,"size")) - v_devGaec7(years) 
;

$ontext
e_preCropSeq2(curPlots,curCrops,years)
  $ (years.pos gt 2)..
  sum((KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield)
    AND sameas(curCrops,curCrops)
    ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years-2) 
  + v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years-1) 
  + v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years))
  -2
  =L=
  v_binRepCropPlot2(curPlots,curCrops,years) * M
;

e_gaec7_2(curCrops,years)..
  sum((curPlots,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield)
    ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  * p_plotData(curPlots,"size")) * 0.66
  =G=
  sum(curPlots,
  v_binRepCropPlot2(curPlots,curCrops,years) 
  * p_plotData(curPlots,"size")) - v_devGaec7_2(years) 
$offtext

*
* --- gaec 8
*
e_gaec8(years) $ ((p_totArabLand gt 10) $ (p_shareGreenLand le 0.75))..
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert),
  (v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years)
    * p_plotData(curPlots,"size")) $ sameas(curCrops,'fallow')
  )   
  =G= 0.04*p_totArabLand - v_devGaec8(years)
;  

$ontext the following equations are deprecated due to CAP reform 2023
* Only activate ecological focus area equation if arable land is greater than 15ha
e_efa $ ((p_totArabLand >= 15) $(not p_grassLandExempt))..
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert),
      v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years)
      * p_plotData(curPlots,"size")
      * p_grossMarginData(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,'efaFactor')
  )
  + v_devEfa5
  =G= 
  p_totArabLand * 0.05
;


* Only activate 75% diversifaction rule if arable land is greater than 10ha
e_75diversification(cropGroup) $ ((p_totArabLand >= 10) $(not p_grassLandExempt))..
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
    $ ((not plots_permPast(curPlots))
    $ crops_cropGroup(curCrops,cropGroup)),
      v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years)
      * p_plotData(curPlots,"size")
  )
  =L= 
  p_totArabLand * 0.75
  + v_devEfa75
  
;

* Only activate 95% diversifaction rule if arable land is greater than 30ha
e_95diversification(cropGroup,cropGroup1)
  $ ((p_totArabLand >= 30)
  $ (not p_grassLandExempt)
  $ (not sameas(cropGroup,cropGroup1)))..
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
    $ crops_cropGroup(curCrops,cropGroup),
    v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years)
    * p_plotData(curPlots,"size")
  )
  +
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
    $ crops_cropGroup(curCrops,cropGroup1),
    v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years)
    * p_plotData(curPlots,"size")
  )
  =L= 
  p_totArabLand * 0.95
  + v_devEfa95
;
$offtext  