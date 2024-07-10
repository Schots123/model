

positive variables
  v_labReq(scenSprayer,years)
;

equations
  e_labReq(scenSprayer,years)
;

e_labReq(scenSprayer,years)..
  v_labReq(scenSprayer,years) =E=
  sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) 
      AND curPlots_ktblDistance(curPlots,KTBL_distance)
      AND curPlots_ktblYield(curPlots,KTBL_yield) 
      AND ktblCrops_KtblYield(curCrops,KTBL_yield)
      AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
    ), 
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
      * p_plotData(curPlots,"size") * farmSizeVar
      * sum(pestType,
        p_numberSprayPassesScenarios(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType)
        * p_technoTimeReq(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) 
        * timeReqVar(scenSprayer)
      )
  )
;