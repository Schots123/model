

summarySenAn("landAv",%1,%2,%3) = p_totLand;

summarySenAn("landUsedAvg",%1,%2,%3) = 
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

summarySenAn(curCropGroups,%1,%2,%3) = 
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
summarySenAn(scenSprayer,%1,%2,%3) = v_numberSprayer.l(scenSprayer);

$ontext
summarySenAn(scenSprayer,"repurchDur",%1,%2,%3) $ (v_numberSprayer.l(scenSprayer) ge 1) 
  = v_numberSprayer.l(scenSprayer)
  * (p_technoValue(scenSprayer) - p_technoRemValue(scenSprayer)) 
  * card(years)
  / sum(years, v_deprecSprayer.l(scenSprayer,years)) 
;

summarySenAn(scenSprayer,"capUtiliz",%1,%2,%3) 
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
  * (p_technoLifetime(scenSprayer) / card(years)) 
  / p_technoAreaCapac(scenSprayer)
;
$offtext

*following parameters calculated only for SST investment costs sensitivity analysis
summarySenAn('%SSTvalue',%1,%2,%3) $ (technoValueRandom ne 0) = technoValueRandom;
summarySenAn('%algCosts',%1,%2,%3) $ (algoCostsPerHaRandom ne 0) = algoCostsPerHaRandom;
summarySenAn('%anFee',%1,%2,%3) $ (annualFeeRandom ne 0) = annualFeeRandom;
summarySenAn('%pestiSav',%1,%2,%3) $ (technoPestEffRandom ne 0) = technoPestEffRandom;
summarySenAn('%timeReq',%1,%2,%3) $ (technoTimeRandom ne 0) = technoTimeRandom;
summarySenAn('%fuelCons',%1,%2,%3) $ (technoFuelRandom ne 0) = technoFuelRandom;
summarySenAn('%repCosts',%1,%2,%3) $ (technoRepRandom ne 0) = technoRepRandom;





*
* --- Farm performance parameter calculations
*
summarySenAn("avgAnnFarmProf",%1,%2,%3) = v_totProfit.l/card(years);

summarySenAn("diCostsPesti",%1,%2,%3) = sum(years,v_dcPesti.l(years) + v_dcPesti.l(years) * 0.03 * (3/12)) / card(years);

summarySenAn("fuelCostsSprayer",%1,%2,%3) = 
  sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
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

summarySenAn("repCostsSprayer",%1,%2,%3) = 
  sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
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

summarySenAn("labCostsSprayer",%1,%2,%3) = 
    sum((scenSprayer,years), v_labReq.l(scenSprayer,years)) 
    * labPrice
    / card(years)
;

summarySenAn("deprecSprayer",%1,%2,%3) = 
    sum((scenSprayer,years),
    v_deprecSprayer.l(scenSprayer,years)) / card(years)
;

summarySenAn("interestSprayer",%1,%2,%3) = 
    sum((scenSprayer,years),
    v_interestSprayer.l(scenSprayer,years)) / card(years)
;

summarySenAn("otherCostsSprayer",%1,%2,%3) = 
    sum((scenSprayer,years),
    v_otherCostsSprayer.l(scenSprayer,years)) / card(years)
;

summarySenAn("varCostsSprayer",%1,%2,%3) =  
    sum((scenSprayer,years), 
    v_varCostsSprayer.l(scenSprayer,years))
    / card(years)
;

summarySenAn("fixCostsSprayer",%1,%2,%3) = 
    sum((scenSprayer,years), 
    v_fixCostsSprayer.l(scenSprayer,years))
    / card(years)
;

