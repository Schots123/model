summarySenAn3D("landAv",%1,%2,%3,%4) = p_totLand;

summarySenAn3D("landUsedAvg",%1,%2,%3,%4) = 
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

summarySenAn3D(curCropGroups,%1,%2,%3,%4) = 
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
summarySenAn3D(scenSprayer,%1,%2,%3,%4) = v_numberSprayer.l(scenSprayer);


summarySenAn3D('%SSTvalue',%1,%2,%3,%4) = technoValueRandom;
summarySenAn3D('%algCosts',%1,%2,%3,%4) $ (p_report_valueAlgoFee > 0) = algoCostsPerHaRandom;
summarySenAn3D('%anFee',%1,%2,%3,%4) $ (p_report_valueAnnualFee > 0) = annualFeeRandom;
summarySenAn3D('%pestCosts',%1,%2,%3,%4) $ (p_report_valuePestPrice > 0) = pestPriceRandom;

*
* --- Farm performance parameter calculations
*
summarySenAn3D("avgAnnFarmProf",%1,%2,%3,%4) = v_Profit.l;

summarySenAn3D("diCostsPesti",%1,%2,%3,%4) = v_dcPesti.l + v_dcPesti.l * 0.03 * (3/12);

summarySenAn3D("fuelCostsSprayer",%1,%2,%3,%4) = 
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

summarySenAn3D("repCostsSprayer",%1,%2,%3,%4) = 
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

summarySenAn3D("labCostsSprayer",%1,%2,%3,%4) = 
    sum(scenSprayer, v_labReq.l(scenSprayer)) 
    * labPrice
;

summarySenAn3D("deprecSprayer",%1,%2,%3,%4) = 
    sum(scenSprayer,
    v_deprecSprayer.l(scenSprayer))
;

summarySenAn3D("interestSprayer",%1,%2,%3,%4) = 
    sum(scenSprayer,
    v_interestSprayer.l(scenSprayer))
;

summarySenAn3D("otherCostsSprayer",%1,%2,%3,%4) = 
    sum(scenSprayer,
    v_otherCostsSprayer.l(scenSprayer))
;

summarySenAn3D("varCostsSprayer",%1,%2,%3,%4) =  
    sum(scenSprayer, 
    v_varCostsSprayer.l(scenSprayer))
;

summarySenAn3D("fixCostsSprayer",%1,%2,%3,%4) = 
    sum(scenSprayer, 
    v_fixCostsSprayer.l(scenSprayer))
;

