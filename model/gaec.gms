Equations
  e_gaec6(years)
  e_preCropSeq(curPlots,curCrops,years)
  e_gaec7(curCrops,years)
  e_gaec8(years)
*  e_efa
*  e_75diversification(cropGroup)
*  e_95diversification(cropGroup,cropGroup1)
;
 
*
* --- gaec 6
* 
e_gaec6(years)..
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert), 
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


*
* --- gaec 7 STILL UNDER CONSTRUCTION!!!!!!!
*
e_preCropSeq(curPlots,curCrops,years)
  $ (years.pos ne 1)..
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
  $ (sameas(curCrops,curCrops)),
  v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years-1) 
  + v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years))
  -1
  =L=
  v_binRepCropPlot(curPlots,curCrops,years) * M
;

e_gaec7(curCrops,years)..
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert),
  v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years)
  * p_plotData(curPlots,"size") * 0.6)
  =G= 
  sum(curPlots,
  v_binRepCropPlot(curPlots,curCrops,years) 
  * p_plotData(curPlots,"size")) -v_devGaec7(years) 
;

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