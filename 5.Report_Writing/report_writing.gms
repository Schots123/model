parameters 
  crops_year_report(*,*,*,curCrops,years) model decision for crops grown as sum of hectares 
  cropOnPlot(curPlots,curCrops,years) shows which crop was grown on which plot in which year
  totProfit(*,*,*) total profit farm
  totProfitDiff(*,*,*) profit difference between scenario and baseline
  annDeprec(*,*,*,years)
;

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

cropOnPlot(curPlots,curCrops,years) =
  sum((KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts),
  v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  * p_plotData(curPlots,'size'))
;

totProfit(%1,%2,%3) =v_totProfit.l;

display p_totArabLand, crops_year_report, cropOnPlot, totProfit;