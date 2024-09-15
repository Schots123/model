Equations
  e_maxShares(curCropGroups)
  e_maxSharesFavLoc(curCropGroups,KTBL_yieldLev)
  e_oneCropPlot(curPlots)
*  e_cropBreak2years(curPlots,cropsBreak2,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance)
;

*
*  --- each crop cannot exceed the maximum allowed share specified by the users
*      crop rotational settings
*
e_maxShares(curCropGroups) $ p_cropData(curCropGroups,"maxShare")..
  sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) 
    AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) 
    AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    AND curCrops_curCropGroups(curCropGroups,curCrops)
  ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  * p_plotData(curPlots,"size") * farmSizeVar)
  =L= 
  (p_totArabLand * p_cropData(curCropGroups,"maxShare") / 100)
  + v_devMaxShares(curCropGroups)
;

*
* --- Reduce overspecialization of most profitable crops on plots with high yields to better reflect average year of farm
*
parameter p_plotYieldGroup(KTBL_yieldLev);
p_plotYieldGroup(KTBL_yieldLev) = 
  sum((curPlots,KTBL_yield) 
  $ ( 
    curPlots_ktblYield(curPlots,KTBL_yield)
    AND KTBL_yieldGroup(KTBL_yield,KTBL_yieldLev)
  ), 
  p_plotData(curPlots,"size")
    * p_yieldGroup(KTBL_yield,KTBL_yieldLev)
  )
;
display p_plotYieldGroup;



e_maxSharesFavLoc(curCropGroups,KTBL_yieldLev) $ p_cropData(curCropGroups,"maxShareYieldLev")..
  sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) 
    AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) 
    AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    AND curCrops_curCropGroups(curCropGroups,curCrops)
    AND KTBL_yieldGroup(KTBL_yield,KTBL_yieldLev)
  ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  * p_plotData(curPlots,"size") * farmSizeVar
  )
  =L=
  p_plotYieldGroup(KTBL_yieldLev) * farmSizeVar
  * (p_cropData(curCropGroups,"maxShareYieldLev") / 100)
;


*
*  --- ensure that one element in each set of v_binCropPlot is chosen for each plot by the model and not more
*
e_oneCropPlot(curPlots)..
  sum((curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    $ (
    curPlots_ktblSize(curPlots,KTBL_size) 
    AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) 
    AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance))
  + v_devOneCrop(curPlots)
  =L= 1
;

$ontext
*
*  --- Crop break restriction
*
e_cropBreak2years(curPlots,cropsBreak2,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) 
    AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield)
  )..
  sum((KTBL_system,curCrops) 
  $ (
    ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    AND curCrops_curCropGroups(cropsBreak2,curCrops) 
  ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
  + v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years-1)
  + v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years-2)
  )
  =L=
  1
;
$offtext