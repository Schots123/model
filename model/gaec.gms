$ontext
Here, the old greening requirements are still formulated. I have to update the equations to force the farm to 
comply with new CAP since 2023
$offtext

Equations
  e_gaec6
*  e_gaec7
  e_gaec8
  e_efa
  e_75diversification(cropGroup)
  e_95diversification(cropGroup,cropGroup1)
;


*I want that the following equation work independent of whether duev20 or farm5 is loaded 
$iftheni.fo2020 defined fo2020
  e_gaec6..
    sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert), 
* cover crops to fulfil minimum coverage requirements 
   v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
        * p_plotData(curPlots,"size")
       * p_grossMarginData(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,'efaFactor')
* winter grains as minimum coverage requirement OR stubble fallow as minimum coverage requirement
   + (v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)      
        * p_plotData(curPlots,"size")) $ (sameas(curCrops,'Winterweizen - Brotweizen') 
       OR sameas(curCrops,'Wintergerste - Futtergerste') OR sameas(curCrops,'Winterroggen - Mahl- und Brotroggen'))
        $ sameas(catchCrop,'false')
* stubble fallow for grains (including mais) as minimum coverage requirement (currently only incorporated for maize)
   + (v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert) * p_plotData(curPlots,"size")) 
       $ (sameas(catchCrop,'false') AND sameas(curCrops,'Mais - Silomais'))
* if summer grains should become possible to the farm, it would be necessary to add a conditional based on the next period       
   ) 
  =G= 0.8*p_totArabLand - v_devGaec6;
$else.fo2020
  e_gaec6..
    sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert), 
   v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
        * p_plotData(curPlots,"size")
       * p_grossMarginData(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,'efaFactor')
   + (v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)      
        * p_plotData(curPlots,"size")) $ (sameas(curCrops,'224944c2-7586-47c0-9078-67edc7e5f57d') 
       OR sameas(curCrops,'c331411e-f9ce-4357-9ff9-8ff34a586a9e') OR sameas(curCrops,'f0c833fd-73da-431d-a0b3-bff21872dfe6'))
        $ sameas(catchCrop,'false')
   + (v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert) * p_plotData(curPlots,"size")) 
       $ (sameas(catchCrop,'false') AND sameas(curCrops,'0082be89-8cfb-4a63-b812-4d42099b1a02'))      
    )   
  =G= 0.8*p_totArabLand - v_devGaec6;
$endif.fo2020


$ontext still under construction
e_gaec7..
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert), 
$offtext  


e_gaec8
  $ ((p_totArabLand gt 10) $ (p_shareGreenLand le 0.75))..
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert),
  (v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
      * p_plotData(curPlots,"size")) $ sameas(curCrops,'NoCrop')
  )
  + v_devGaec8     
  =G= 0.04*p_totArabLand
;  


* Only activate ecological focus area equation if arable land is greater than 15ha
e_efa $ ((p_totArabLand >= 15) $(not p_grassLandExempt))..
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert),
      v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
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
      v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
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
    v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
    * p_plotData(curPlots,"size")
  )
  +
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
    $ crops_cropGroup(curCrops,cropGroup1),
    v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
    * p_plotData(curPlots,"size")
  )
  =L= 
  p_totArabLand * 0.95
  + v_devEfa95
;
