parameter crops_year_report(curCrops,years);

crops_year_report(curCrops,years) = 
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert), 
      v_binCropPlot.l(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years)
      * p_plotData(curPlots,'size'))
;
display crops_year_report;