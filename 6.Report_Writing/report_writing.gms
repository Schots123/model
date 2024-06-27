*
*  --- Optimal crop allocation solution parameters for farm 
*
arabLandUsed(%1,%2,%3,%4) =
  sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) 
    AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) 
    AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),    
    v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
      * p_plotData(curPlots,'size') * farmSizeVar
  )
  / card(years)
;

crops_year_report(%1,%2,%3,%4,curCrops) = 
  sum((curPlots,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) 
    AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) 
    ), 
  v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  * p_plotData(curPlots,'size') * farmSizeVar)
  /card(years)
;

annProfitAvg(%1,%2,%3,%4) = v_totProfit.l/card(years);


*
*  --- Sprayer technology parameters related to optimal solution of scenario 
*

$ontext
numberPassages(curCrops,%1,scenSprayer,years) = 
  sum((curPlots,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) 
    AND curPlots_ktblDistance(curPlots,KTBL_distance)
    AND curPlots_ktblYield(curPlots,KTBL_yield) 
    AND p_technology_scenario(technology,scenario)
    ),
  v_binPlotTechno.l(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    * p_numberSprayPassesScenarios(curCrops,KTBL_yield,technology,scenario,scenSprayer)
  )
;
$offtext

numberSprayer(%1,%2,%3,%4,scenSprayer) = v_numberSprayer.l(scenSprayer);

labCostsSprayerAvg(%1,%2,%3,%4) = 
  sum(years, v_labReq.l(years)) 
  * labPrice
  / card(years)
;

deprecSprayerAvg(%1,%2,%3,%4,scenSprayer) = sum(years,v_deprecSprayer.l(scenSprayer,years))/card(years);

yearsSprayerUsedAvg(%1,%2,%3,%4,scenSprayer) =
  sum(curMechan,
  v_numberSprayer.l(scenSprayer) 
    * (p_technoValue(scenSprayer,curMechan) - p_technoRemValue(scenSprayer,curMechan)))
  * (1/(sum(years, v_deprecSprayer.l(scenSprayer,years)) / card(years))) 
  $ (sum(years, v_deprecSprayer.l(scenSprayer,years)) gt 0)
;

dcPestiAvg(%1,%2,%3,%4) = sum(years,v_dcPesti.l(years))/card(years);

varCostsSprayerAvg(%1,%2,%3,%4) = 
  sum((scenSprayer,years), 
  v_varCostsSprayer.l(scenSprayer,years))
  / card(years)
;

fixCostsSprayerAvg(%1,%2,%3,%4) = 
  sum(years, v_fixCostsSprayer.l(years))
  / card(years)
;

*
*  --- Space for post-model calculations to validate model
*

$ontext 
following parameter assignment is used to check gaec 7 requirement
cropOnPlot(curPlots,curCrops,years) =
  sum((KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts),
  v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  * p_plotData(curPlots,'size') * farmSizeVar)
;
$offtext

$ontext
dcPestiCrops(%1,curCrops,KTBL_yield,pestType,years) =
  sum((curPlots,KTBL_size,curMechan,KTBL_distance,technology,scenario,scenSprayer)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
        AND sameas(technology,scenSprayer)
    ),    
        v_binPlotTechno.l(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
            * p_plotData(curPlots,'size') * farmSizeVar
            * p_sprayInputCosts(curCrops,KTBL_yield,pestType) 
            * (1 - p_technoPestEff(curCrops,technology,scenario,pestType))
    )
;
option dcPestiCrops:1:4:1 display dcPestiCrops;
$offtext

Execute_Unload '6.Report_Writing/Results_%farmNumber%.gdx',  
  arabLandUsed, crops_year_report, annProfitAvg, numberSprayer, labCostsSprayerAvg, deprecSprayerAvg, 
  yearsSprayerUsedAvg, dcPestiAvg, varCostsSprayerAvg, fixCostsSprayerAvg;