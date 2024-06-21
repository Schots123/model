

positive variables
  v_labReq(years)
;

equations
  e_labReq(years)
;

e_labReq(years)..
  v_labReq(years) =E=
  sum((curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) 
      AND curPlots_ktblDistance(curPlots,KTBL_distance)
      AND curPlots_ktblYield(curPlots,KTBL_yield) 
      AND p_technology_scenario(technology,scenario)
    ), 
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
      * p_plotData(curPlots,'size') * sizeFactor
      * p_numberSprayPassesScenarios(curCrops,KTBL_yield,technology,scenario,scenSprayer)
      * p_technoTimeReq(scenSprayer,KTBL_size,curMechan,KTBL_distance)
  )
;