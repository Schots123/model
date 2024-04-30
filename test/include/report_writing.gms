parameters 
  crops_year_report(*,*,*,curCrops,years) model decision for crops grown as sum of hectares 
  totProfit(*,*,*) total profit farm
  totProfitDiff(*,*,*) profit difference between scenario and baseline
  annDeprec(*,*,*,years)
;

crops_year_report(%1,%2,%3,curCrops,years) = 
  sum((curPlots,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  $ (curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) AND curPlots_ktblYield (curPlots,KTBL_yield) AND ktblCrops_ktblSystem(curCrops,KTBL_system)), 
      v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
      * p_plotData(curPlots,'size'))
;

totProfit(%1,%2,%3) =v_totProfit.l;

option 
  p_ktbl_revenue:1:2:1
  p_ktbl_directCosts:1:2:1
  p_ktbl_directCostsInt:1:2:1
  p_ktbl_vfMachCosts:1:2:4
  p_ktbl_fuelCons:1:2:4
  p_ktbl_vfMachCostsNewFuel:1:2:4
  p_ktbl_varMachCostsNewFuelInt:1:2:4
  p_ktbl_profitPerHa:1:2:4
;

display 
  p_ktbl_revenue, p_ktbl_directCosts, p_ktbl_directCostsInt, p_ktbl_vfMachCosts, p_ktbl_fuelCons, p_ktbl_vfMachCostsNewFuel, p_ktbl_varMachCostsNewFuelInt, p_ktbl_profitPerHa;

display p_totArabLand, crops_year_report, totProfit;