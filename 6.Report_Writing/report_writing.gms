
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

$ontext
crops_year_report(%1,'Brache',years) = 
  p_totArabLand
  - sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ), 
  v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  * p_plotData(curPlots,'size'))
;
$offtext

$ontext 
following parameter assignment is used to check gaec 7 requirement
cropOnPlot(curPlots,curCrops,years) =
  sum((KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts),
  v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  * p_plotData(curPlots,'size'))
;
$offtext

annProfitAvg(%1) = v_totProfit.l/card(years);

dcPestiAvg(%1) = sum(years,v_dcPesti.l(years))/card(years);

numberSprayer(%1,scenSprayer) = v_numberSprayer.l(scenSprayer);

deprecAvg(%1,scenSprayer) = sum(years,v_deprecSprayer.l(scenSprayer,years))/card(years);

numberPassages(curCrops,%1,scenSprayer,years) = 
  sum((curPlots,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario),
  v_binPlotTechno.l(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
        * p_numberSprayPassesScenarios(curCrops,KTBL_yield,technology,scenario,scenSprayer)
  )
;

option 
  arabLandUsed:1:1:1
  crops_year_report:1:1:2
  numberSprayer:1:1:1
  deprecAvg:1:1:1
  numberPassages:1:1:3
;

display p_totArabLand, arabLandUsed, crops_year_report, annProfitAvg;
display dcPestiAvg, numberSprayer, deprecAvg, numberPassages;