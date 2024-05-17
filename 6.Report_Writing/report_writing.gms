

crops_year_report(%1,%2,%3,curCrops,years) = 
  sum((curPlots,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield)
    ), 
  v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  * p_plotData(curPlots,'size'))
;

crops_year_report(%1,%2,%3,'Brache',years) = 
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

$ontext 
following parameter assignment is used to check gaec 7 requirement
cropOnPlot(curPlots,curCrops,years) =
  sum((KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts),
  v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  * p_plotData(curPlots,'size'))
;
$offtext

annProfitAvg(%1,%2,%3) = sum(years,v_profit.l(years))/card(years);

dcPestiAvg(%1,%2,%3) = sum(years,v_dcPesti.l(years))/card(years);

numberSprayer(%1,%2,%3) = v_numberSprayer.l;

*novel technology depreciation
deprecAvg(%1,%2,%3) = sum(years,v_deprecPesti.l(years))/card(years);

option 
  crops_year_report:1:4:1
  annProfitAvg:1:2:1
  dcPestiAvg:1:2:1
  numberSprayer:1:2:1
  deprecAvg:1:2:1
;

display p_totArabLand, crops_year_report, annProfitAvg, dcPestiAvg, numberSprayer, deprecAvg;