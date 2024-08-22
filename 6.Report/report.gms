

summary("landAv",%1,%2) = p_totLand;

summary("landUsedAvg",%1,%2) =
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

summary(curCropGroups,%1,%2) =
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

summary(scenSprayer,%1,%2) = v_numberSprayer.l(scenSprayer);



*
* --- Farm performance parameter calculations
*
summary("farmProfNoPest",%1,%2) = 
  sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) 
      AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) 
      AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    ),
    v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
      * p_plotData(curPlots,"size") * farmSizeVar
      * p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  )
;

summary("avgAnnFarmProf",%1,%2) = v_Profit.l; 

summary("diCostsPesti",%1,%2) = (v_dcPesti.l + v_dcPesti.l * 0.03 * (3/12));

summary("fuelCostsSprayer",%1,%2) = 
  sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario(technology,scenario)
    ), 
        v_binPlotTechno.l(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
            * p_plotData(curPlots,"size") * farmSizeVar
            * sum(pestType,
              p_sprayerPassagesMonth(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType)
              * (
                p_technoFuelCons(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) 
                  * newFuelPrice 
                + p_technoFuelCons(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType)
                  * newFuelPrice 
                  * (3/12) * 0.03
              )
              * fuelConsVar(technology,scenario,scenSprayer,pestType)
            )
  )
;

summary("repCostsSprayer",%1,%2) = 
  sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario(technology,scenario)
    ), 
  v_binPlotTechno.l(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
            * p_plotData(curPlots,"size") * farmSizeVar
            * sum(pestType,
              p_sprayerPassagesMonth(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType)
              * (
                  p_technoMaintenance(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) 
                  + p_technoMaintenance(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) * (3/12) * 0.03
              )
              * repairCostsVar(scenSprayer)
            )
  )
;

summary("labCostsSprayer",%1,%2) = 
    sum(scenSprayer, v_labReq.l(scenSprayer)) 
    * labPrice
;

summary("deprecSprayer",%1,%2) = 
    sum(scenSprayer,
    v_deprecSprayer.l(scenSprayer)) 
;

summary("interestSprayer",%1,%2) = 
    sum(scenSprayer,
    v_interestSprayer.l(scenSprayer))
;

summary("otherCostsSprayer",%1,%2) = 
    sum(scenSprayer,
    v_otherCostsSprayer.l(scenSprayer))
;

summary("varCostsSprayer",%1,%2) =  
    sum(scenSprayer, 
    v_varCostsSprayer.l(scenSprayer))
;

summary("fixCostsSprayer",%1,%2) = 
    sum(scenSprayer, 
    v_fixCostsSprayer.l(scenSprayer) - v_labReq.l(scenSprayer) * labPrice)
;

$ontext
#Following parameter calculation used to check whether number of passages for crops are considered appropriately
summary(scenSprayer,%1,%2) 
  $ (
    sum ((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
    ),
    v_binPlotTechno.l(curPlots,"Winterweizen - Korn und Stroh (thermische Nutzung)",KTBL_size,'hoch, mittlerer Boden',KTBL_distance,technology,scenario,scenSprayer)
  ) > 0
  )
  =
  sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,pestType,halfMonth)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
    ),      
  v_binPlotTechno.l(curPlots,"Winterweizen - Korn und Stroh (thermische Nutzung)",KTBL_size,'hoch, mittlerer Boden',KTBL_distance,technology,scenario,scenSprayer)
  * p_datePestOpTechno("Winterweizen - Korn und Stroh (thermische Nutzung)",'hoch, mittlerer Boden',technology,scenario,scenSprayer,pestType,halfMonth)
  )
  / sum ((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
    ),
    v_binPlotTechno.l(curPlots,"Winterweizen - Korn und Stroh (thermische Nutzung)",KTBL_size,'hoch, mittlerer Boden',KTBL_distance,technology,scenario,scenSprayer)
  )
;
$offtext
