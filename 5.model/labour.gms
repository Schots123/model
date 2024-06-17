

positive variables
  v_labReq(years)
;

equations
  e_labReq(years)
;

e_labReq(years)..
  v_labReq(years) =E=
  sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) 
      AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) 
      AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
      * p_plotData(curPlots,'size')
      * p_timeReq(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  )
*time for spraying operation  
  + sum((curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) 
      AND curPlots_ktblDistance(curPlots,KTBL_distance)
      AND curPlots_ktblYield(curPlots,KTBL_yield) 
      AND p_technology_scenario(technology,scenario)
    ), 
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
      * p_plotData(curPlots,'size')
      * p_numberSprayPassesScenarios(curCrops,KTBL_yield,technology,scenario,scenSprayer)
      * p_technoTimeReq(scenSprayer,KTBL_size,curMechan,KTBL_distance)
  )
;