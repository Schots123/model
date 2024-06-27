
Binary variable 
  v_binRepCropPlot_1(curPlots,mainCropGroup,years) each plot on which crops are grown in two consecutive years 
  v_binRepCropPlot_2(curPlots,mainCropGroup,years) each plot on which crops are grown in three consecutive years 
;

Equations
*  e_gaec6(years)
  e_preCropSeq_1(curPlots,mainCropGroup,years)
  e_preCropSeq_2(curPlots,mainCropGroup,years)
  e_gaec7_1(mainCropGroup,years)
  e_gaec7_2(mainCropGroup,years)
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
* --- gaec 7 
*     the area on which the same crop was grown in two consecutive years has to be smaller than 66 %
e_preCropSeq_1(curPlots,mainCropGroup,years)
  $ (
    (years.pos ne 1) AND (p_totArabLand gt 10) AND (not(mainCropGroupExempt(mainCropGroup)))
    AND (not(p_shareGreenLand gt 0.75 AND p_totArabLand lt 50))
  )..
  sum((curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    AND cropCropGroup(curCrops,mainCropGroup) AND (not(mainCropGroupExempt(mainCropGroup)))
  ),
  (v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years-1) 
  + v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)))
  =L= 
  1 + v_binRepcropPlot_1(curPlots,mainCropGroup,years)
;
$ontext
  the left hand side of the equation equals 2 if the same crop was grown on the same plot in 2 consecutive years
  the right hand side can become either 1 or 2 and could be 2 without further conditions 
$offtext

*only on max 66 % of the arable land it is allowed to grow the same crop in two consecutive years 
e_gaec7_1(mainCropGroup,years)
  $ (
    (years.pos ne 1) AND (p_totArabLand gt 10) AND (not(mainCropGroupExempt(mainCropGroup)))
    AND (not(p_shareGreenLand gt 0.75 AND p_totArabLand lt 50))
  )..
  sum(curPlots,
    v_binRepcropPlot_1(curPlots,mainCropGroup,years) 
    * p_plotData(curPlots,"size") * farmSizeVar)
  + v_devGaec7_1(years)
  =L=
  sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    AND cropCropGroup(curCrops,mainCropGroup) AND (not(mainCropGroupExempt(mainCropGroup)))
  ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  * p_plotData(curPlots,"size") * farmSizeVar) * 0.66
;
$ontext
  the left hand side can't take lower values than the actual amount of hectare on which one crop was grown in 2 consective years 
  (but might even become higher than the available arable land of the farm because of the way e_preCropSeq_1 is formulated -> useless without proper restriction of value)
  The left hand side of the equation requires that the result on the left hand side of the equation for each crop is less than 66 % of the overall amount of the crop planted in the respective year
  -> the model will set the values for v_binRepcropPlot_1(curPlots,curCrops,years) equal 0 first which don't label the same crop decision on a plot in two consecutive years, because they dont negatively 
  influence the optimal solution of the model (not restricting)
  -> in the event that the farm always decides for the same crop on plots in consecutive years, this value adjustment of v_binRepcropPlot_1(curPlots,curCrops,years) without an impact on the optimal solution
  will take as long as the right hand side of the equation equals the overall amount of hectare on which the respective crop is grown
  -> since in this case the right hand side of the equation is only 2/3 of that value, the model would have to reduce the number of same crop decisions in two consecutive years accordingly, influencing the
  optimal solution
$offtext


e_preCropSeq_2(curPlots,mainCropGroup,years)
  $ (
    (years.pos gt 2) AND (p_totArabLand gt 10) AND (not(mainCropGroupExempt(mainCropGroup)))
    AND (not(p_shareGreenLand gt 0.75 AND p_totArabLand lt 50))
  )..
  sum((curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    AND cropCropGroup(curCrops,mainCropGroup) AND (not(mainCropGroupExempt(mainCropGroup)))
    ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years-2) 
  + v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years-1)
  + v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years))
  =L=
  2 + v_binRepCropPlot_2(curPlots,mainCropGroup,years)
;

*a change of the main crop for each plot is required in at least all three years  
e_gaec7_2(mainCropGroup,years)
  $ (
    (years.pos gt 2) AND (p_totArabLand gt 10) AND (not(mainCropGroupExempt(mainCropGroup)))
    AND (not(p_shareGreenLand gt 0.75 AND p_totArabLand lt 50))
  )..
  sum(curPlots,
    v_binRepCropPlot_2(curPlots,mainCropGroup,years) 
    * p_plotData(curPlots,"size") * farmSizeVar) 
  + v_devGaec7_2(years) 
  =L=
  0
$ontext  
  sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHa(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    AND cropCropGroup(curCrops,mainCropGroup)
    ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  * p_plotData(curPlots,"size")) * 0
$offtext
;


*
* --- gaec 8
*
e_gaec8(years) 
  $ (
    (p_totArabLand gt 10) AND (p_shareGreenLand lt 0.75)
  )..
  sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
    * p_plotData(curPlots,"size") * farmSizeVar)
  =L= 
  p_totArabLand - (0.04 * p_totArabLand) + v_devGaec8(years)
;  