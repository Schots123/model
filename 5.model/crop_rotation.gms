Equations
  e_maxShares(curCrops,years)
  e_oneCropPlot(curPlots,years)
$iftheni.constraints defined constraints
*constraints is not defined for model 5 -> no activation of the following equations
  e_minimumShares(constraints,curCrops,curCrops1,years)
  e_maximumShares(constraints,curCrops,curCrops1,years) 
$endif.constraints
;

*
*  --- each crop cannot exceed the maximum allowed share specified by the users
*      crop rotational settings
*
e_maxShares(curCrops,years) $ p_cropData(curCrops,"maxShare")..
  sum((curPlots,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  * p_plotData(curPlots,"size"))
=L= 
  (p_totArabLand * p_cropData(curCrops,"maxShare") / 100)
  + v_devShares(curCrops,years)
;

*
*  --- ensure that one element in each set of v_binCropPlot is chosen for each plot by the model and not more
*
e_oneCropPlot(curPlots,years)..
  sum((curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
    (ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts))
    ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years))
  + v_devOneCrop(curPlots,years)
  =L= 1
;