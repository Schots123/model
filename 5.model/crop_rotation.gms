Equations
  e_maxShares(curCropGroups,years)
  e_minShares(curCropGroups,years)
  e_oneCropPlot(curPlots,years)
  e_cropBreak2years(curPlots,cropsBreak2,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,years)
;

*
*  --- each crop cannot exceed the maximum allowed share specified by the users
*      crop rotational settings
*
e_maxShares(curCropGroups,years) $ p_cropData(curCropGroups,"maxShare")..
  sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) 
    AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) 
    AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    AND curCrops_curCropGroups(curCropGroups,curCrops)
  ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
  * p_plotData(curPlots,"size") * farmSizeVar)
  =L= 
  (p_totArabLand * p_cropData(curCropGroups,"maxShare") / 100)
  + v_devMaxShares(curCropGroups,years)
;

e_minShares(curCropGroups,years) $ p_cropData(curCropGroups,"minShare")..
  sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) 
    AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) 
    AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    AND curCrops_curCropGroups(curCropGroups,curCrops)
  ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
  * p_plotData(curPlots,"size") * farmSizeVar)
  =G= 
  (p_totArabLand * p_cropData(curCropGroups,"minShare") / 100)
  + v_devMinShares(curCropGroups,years)
;

*
*  --- ensure that one element in each set of v_binCropPlot is chosen for each plot by the model and not more
*
e_oneCropPlot(curPlots,years)..
  sum((curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    $ (
    curPlots_ktblSize(curPlots,KTBL_size) 
    AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) 
    AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years))
  + v_devOneCrop(curPlots,years)
  =L= 1
;

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

*
* --- Mechanization variation
*
