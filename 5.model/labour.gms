

positive variables
  v_labReq(scenSprayer)
;

equations
  e_labReqSprayer(scenSprayer)
;

e_labReqSprayer(scenSprayer)..
  v_labReq(scenSprayer) =E=
  sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) 
      AND curPlots_ktblDistance(curPlots,KTBL_distance)
      AND curPlots_ktblYield(curPlots,KTBL_yield) 
      AND ktblCrops_KtblYield(curCrops,KTBL_yield)
      AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
    ), 
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
      * p_plotData(curPlots,"size") * farmSizeVar
      * sum((pestType,halfMonth),
        p_sprayerPassagesMonth(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType,halfMonth)
        * passageVar(technology,scenario,pestType)
        * p_technoTimeReq(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) 
        * timeReqVar(technology,scenario,scenSprayer,pestType)
      )
  )
;