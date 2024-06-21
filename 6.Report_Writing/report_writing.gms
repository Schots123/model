*
*  --- Optimal crop allocation solution parameters for farm 
*
arabLandUsed(%1,years) =
  sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) 
    AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) 
    AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),    
    v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
      * p_plotData(curPlots,'size')
  )
;

crops_year_report(%1,curCrops,years) = 
  sum((curPlots,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) 
    AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) 
    ), 
  v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  * p_plotData(curPlots,'size'))
;

annProfitAvg(%1) = v_totProfit.l/card(years);


*
*  --- Sprayer technology parameters related to optimal solution of scenario 
*
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

numberSprayer(%1,scenSprayer) = v_numberSprayer.l(scenSprayer);

labCostsSprayerAvg(%1) = 
  sum(years, v_labReq.l(years)) 
  * labPrice
  / card(years)
;

deprecSprayerAvg(%1,scenSprayer) = sum(years,v_deprecSprayer.l(scenSprayer,years))/card(years);

dcPestiAvg(%1) = sum(years,v_dcPesti.l(years))/card(years);

varCostsSprayerAvg(%1) = 
  sum((scenSprayer,years), 
  v_varCostsSprayer.l(scenSprayer,years))
  / card(years)
;

fixCostsSprayerAvg(%1) = 
  sum(years, v_fixCostsSprayer.l(years))
  / card(years)
;

option 
  arabLandUsed:1:1:1
  crops_year_report:1:1:2
  numberSprayer:1:1:1
  deprecSprayerAvg:1:1:1
  numberPassages:1:1:3
;

display p_totArabLand, arabLandUsed, crops_year_report, annProfitAvg;
display numberSprayer, numberPassages, labCostsSprayerAvg, deprecSprayerAvg, dcPestiAvg, varCostsSprayerAvg, fixCostsSprayerAvg;

*
*  --- Space for post-model calculations to validate model
*

$ontext 
following parameter assignment is used to check gaec 7 requirement
cropOnPlot(curPlots,curCrops,years) =
  sum((KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts),
  v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  * p_plotData(curPlots,'size'))
;
$offtext