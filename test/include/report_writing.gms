parameters 
  crops_year_report(curCrops,years) model decision for crops grown as sum of hectares 
  annGM(years) annual gross margin model results
;

crops_year_report(curCrops,years) = 
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert), 
      v_binCropPlot.l(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years)
      * p_plotData(curPlots,'size'))
;

annGM(years) = v_annGM.l(years);
  
display crops_year_report, annGM;