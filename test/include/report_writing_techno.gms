crops_year_report(%1,%2,%3,curCrops,years) = sum((curPlots,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  $ (curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) AND curPlots_ktblYield (curPlots,KTBL_yield) AND ktblCrops_ktblSystem(curCrops,KTBL_system)), 
      v_binCropPlot.l(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
      * p_plotData(curPlots,'size'));
crops_year_report(%1,%2,%3,curCrops,years) $ (v_totProfitTechno.l lt p_totProfitLevelBase) = 0;

annDeprec(%1,%2,%3,years) = v_deprecTechno.l(years);
annDeprec(%1,%2,%3,years) $ (v_totProfitTechno.l lt p_totProfitLevelBase) = 0;

totProfit(%1,%2,%3) = v_totProfitTechno.l;
totProfit(%1,%2,%3) $ (v_totProfitTechno.l lt p_totProfitLevelBase) = 0;

totProfitDiff(%1,%2,%3) = v_totProfitTechno.l - p_totProfitLevelBase;
totProfitDiff(%1,%2,%3) $ (v_totProfitTechno.l lt p_totProfitLevelBase) = 0;

option
  crops_year_report:1:3:2
  annDeprec:1:2:2
  totProfit:1:1:2
  totProfitDiff:1:1:2
;

option dispwidth = 20;
display crops_year_report, annDeprec, totProfit;
display totProfitDiff;