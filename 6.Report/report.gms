

summary("landAv",%1,%2) = p_totLand;

summary("landUsedAvg",%1,%2) =
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) 
    AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) 
    AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    ),    
    v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
      * p_plotData(curPlots,'size') * farmSizeVar
  )
  / card(years)
;

summary(curCropGroups,%1,%2) =
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) 
    AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) 
    AND curCrops_curCropGroups(curCropGroups,curCrops)
    ), 
  v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
  * p_plotData(curPlots,'size') * farmSizeVar)
  /card(years)
;

*
* --- sprayer utilization parameter calculations
*
summary(scenSprayer,%1,%2) = v_numberSprayer.l(scenSprayer);

$ontext    
summary(scenSprayer,"repurchDur",%1,%2) $ (v_numberSprayer.l(scenSprayer) ge 1) 
  = v_numberSprayer.l(scenSprayer)
  * (p_technoValue(scenSprayer) - p_technoRemValue(scenSprayer)) 
  * card(years)
  / sum(years, v_deprecSprayer.l(scenSprayer,years)) 
;

summary(scenSprayer,"capUtiliz",%1,%2) $ (v_numberSprayer.l(scenSprayer) ge 1)
  = sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario(technology,scenario)
    ), 
    v_binPlotTechno.l(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
      * p_plotData(curPlots,"size") * farmSizeVar
*      * sum(pestType, p_numberSprayPassesScenarios(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType))
  )
  * (
      (v_numberSprayer.l(scenSprayer) * (p_technoValue(scenSprayer) - p_technoRemValue(scenSprayer)) 
      / (sum(years, v_deprecSprayer.l(scenSprayer,years)) / card(years)))
      / card(years)
  )
  / (p_technoAreaCapac(scenSprayer) * v_numberSprayer.l(scenSprayer))
;

summary(scenSprayer,halfMonth,%1,%2)
    =
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario(technology,scenario)
    ),      
        v_binPlotTechno.l(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
            * p_plotData(curPlots,"size") * farmSizeVar
            * sum(pestType,
              p_datePestOpTechno(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType,halfMonth)
              * p_technoTimeReq(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) * timeReqVar(scenSprayer)
            )
    ) 
    / card(years)
    / (fieldDays(halfMonth) * p_technoFieldDayHours(scenSprayer))  
;
$offtext


*
* --- Farm performance parameter calculations
*
summary("avgAnnFarmProf",%1,%2) = v_totProfit.l/card(years);

summary("diCostsPesti",%1,%2) = sum(years,v_dcPesti.l(years))/card(years);

summary("fuelCostsSprayer",%1,%2) = 
  sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario(technology,scenario)
    ), 
        v_binPlotTechno.l(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
            * p_plotData(curPlots,"size") * farmSizeVar
            * sum(pestType,
              p_numberSprayPasScenTimeFuel(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer,pestType)
              * p_technoFuelCons(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) 
              * fuelConsVar(technology,scenario,scenSprayer,pestType)
            )
            * newFuelPrice
  ) 
  / card(years)
;

summary("repCostsSprayer",%1,%2) = 
  sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario(technology,scenario)
    ), 
  v_binPlotTechno.l(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
            * p_plotData(curPlots,"size") * farmSizeVar
            * sum(pestType,
              p_numberSprayPasScenRepair(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer,pestType)
              * p_technoMaintenance(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) 
              * repairCostsVar(scenSprayer)
            )
  )         
  / card(years)
;

summary("labCostsSprayer",%1,%2) = 
    sum((scenSprayer,years), v_labReq.l(scenSprayer,years)) 
    * labPrice
    / card(years)
;

summary("deprecSprayer",%1,%2) = 
    sum((years,scenSprayer),
    v_deprecSprayer.l(scenSprayer,years)) / card(years)
;

summary("interestSprayer",%1,%2) = 
    sum((years,scenSprayer),
    v_interestSprayer.l(scenSprayer,years)) / card(years)
;

summary("otherCostsSprayer",%1,%2) = 
    sum((years,scenSprayer),
    v_otherCostsSprayer.l(scenSprayer,years)) / card(years)
;

summary("varCostsSprayer",%1,%2) =  
    sum((scenSprayer,years), 
    v_varCostsSprayer.l(scenSprayer,years))
    / card(years)
;

summary("fixCostsSprayer",%1,%2) = 
    sum((scenSprayer,years), 
    v_fixCostsSprayer.l(scenSprayer,years))
    / card(years)
;

