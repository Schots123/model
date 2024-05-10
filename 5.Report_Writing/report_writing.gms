parameters 
  crops_year_report(*,*,*,curCrops,years) model decision for crops grown as sum of hectares 
  totProfit(*,*,*) total profit farm
  totProfitDiff(*,*,*) profit difference between scenario and baseline
  annDeprec(*,*,*,years)
  annLabReq(*,*,*,years)
;

crops_year_report(%1,%2,%3,curCrops,years) = 
  sum((curPlots,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield (curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    ), 
  v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
  * p_plotData(curPlots,'size'))
;
annLabReq(%1,%2,%3,years) = v_labReq.l(years);
totProfit(%1,%2,%3) =v_totProfit.l;


display p_totArabLand, crops_year_report, totProfit;