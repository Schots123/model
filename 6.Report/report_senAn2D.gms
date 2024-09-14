

summarySenAn("landAv",%1,%2,%3) = p_totLand;

summarySenAn("landUsedAvg",%1,%2,%3) = 
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) 
    AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) 
    AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    ),    
    v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
      * p_plotData(curPlots,'size') * farmSizeVar
  )
;

summarySenAn(curCropGroups,%1,%2,%3) = 
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) 
    AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) 
    AND curCrops_curCropGroups(curCropGroups,curCrops)
    ), 
  v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  * p_plotData(curPlots,'size') * farmSizeVar)
;

*
* --- sprayer utilization parameter calculations
*
summarySenAn(scenSprayer,%1,%2,%3) = v_numberSprayer.l(scenSprayer);

$ontext
summarySenAn(scenSprayer,"repurchDur",%1,%2,%3) $ (v_numberSprayer.l(scenSprayer) ge 1) 
  = v_numberSprayer.l(scenSprayer)
  * (p_technoValue(scenSprayer) - p_technoRemValue(scenSprayer)) 
  / sum(years, v_deprecSprayer.l(scenSprayer)) 
;

summarySenAn(scenSprayer,"capUtiliz",%1,%2,%3) 
  = sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario(technology,scenario)
    ), 
    v_binPlotTechno.l(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
      * p_plotData(curPlots,"size") * farmSizeVar
*      * sum(pestType, p_numberSprayPassesScenario(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType))
  )
  * p_technoLifetime(scenSprayer)
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
summarySenAn('%pestCosts',%1,%2,%3) $ (pestPriceRandom ne 0) = pestPriceRandom;
summarySenAn('%numPassages',%1,%2,%3) $ (passageRandom ne 0) = passageRandom;



*
* --- Farm performance parameter calculations
*
summarySenAn("avgAnnFarmProf",%1,%2,%3) = v_Profit.l;

summarySenAn("diCostsPesti",%1,%2,%3) = v_dcPesti.l + v_dcPesti.l * 0.03 * (3/12);

summarySenAn("fuelCostsSprayer",%1,%2,%3) = 
  sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
    ), 
        v_binPlotTechno.l(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
            * p_plotData(curPlots,"size") * farmSizeVar
            * sum((pestType,halfMonth),
              p_sprayerPassagesMonth(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType,halfMonth)
              * p_technoFuelCons(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) 
              * fuelConsVar(technology,scenario,scenSprayer,pestType)
            )
            * newFuelPrice
  ) 
;

summarySenAn("repCostsSprayer",%1,%2,%3) = 
  sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
    ), 
  v_binPlotTechno.l(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
            * p_plotData(curPlots,"size") * farmSizeVar
            * sum((pestType,halfMonth),
              p_sprayerPassagesMonth(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType,halfMonth)
              * p_technoMaintenance(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) 
              * repairCostsVar(scenSprayer)
            )
  )
;

summarySenAn("labCostsSprayer",%1,%2,%3) = 
    sum(scenSprayer, v_labReq.l(scenSprayer)) 
    * labPrice
;

summarySenAn("deprecSprayer",%1,%2,%3) = 
    sum(scenSprayer,
    v_deprecSprayer.l(scenSprayer))
;

summarySenAn("interestSprayer",%1,%2,%3) = 
    sum(scenSprayer,
    v_interestSprayer.l(scenSprayer))
;

summarySenAn("otherCostsSprayer",%1,%2,%3) = 
    sum(scenSprayer,
    v_otherCostsSprayer.l(scenSprayer))
;

summarySenAn("varCostsSprayer",%1,%2,%3) =  
    sum(scenSprayer, 
    v_varCostsSprayer.l(scenSprayer))
;

summarySenAn("fixCostsSprayer",%1,%2,%3) = 
    sum(scenSprayer, 
    v_fixCostsSprayer.l(scenSprayer))
;

