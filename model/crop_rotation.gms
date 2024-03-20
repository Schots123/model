$ontext
This file can remain first like it is. Changes would be necessary if I incorporate multiple year
consideration
$offtext

Equations
  e_maxShares(curCrops,years)
  e_oneCropPlot(curPlots,years)
$iftheni.constraints defined constraints
*constraints is not defined for model 5 -> no activation of the following equations
  e_minimumShares(constraints,curCrops,curCrops1,years)
  e_maximumShares(constraints,curCrops,curCrops1,years) 
$endif.constraints
;

*
*  --- each crop cannot exceed the maximum allowed share specified by the users
*      crop rotational settings
*
e_maxShares(curCrops,years) $ p_cropData(curCrops,"maxShare")..
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
    $ (not plots_permPast(curPlots)),
    v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years)
    * p_plotData(curPlots,"size")
  )
  =L= 
    (p_totArabLand * p_cropData(curCrops,"maxShare") / 100)
    + v_devShares(curCrops,years)
;

*
*  --- ensure that one element in the set crops (also fallow) is chosen for each plot by the model and not more
*
e_oneCropPlot(curPlots,years)..
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert),
    v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years))
  + v_devOneCrop(curPlots,years)
  =E= 1
;

*
*  --- prohibit growing a crop on a plot when there is no gross margin present
*
v_binCropPlot.up(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years) $ ((not
  p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert))
  $ (not plots_permPast(curPlots))) = 0;
  
*
*  --- Enter user specified constraints into the model, 
*
$iftheni.constraints defined constraints
*constraints is currently not defined for farm5, only for farm1 in farm1_time_crop_constraints
e_minimumShares(constraints,curCrops,curCrops1,years) 
  $ (p_constraint(constraints,curCrops,curCrops1) 
  $ (not (constraints_lt(constraints,'lt'))))..
    sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert), 
      v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years) 
      * p_plotData(curPlots,'size'))
      + v_devUserShares(constraints,curCrops,curCrops1,years)
  =G= p_constraint(constraints,curCrops,curCrops1) 
;  

e_maximumShares(constraints,curCrops,curCrops1,years) 
*constraints is currently not defined for farm5
  $ (p_constraint(constraints,curCrops,curCrops1) 
  $ (constraints_lt(constraints,'lt')))..
    sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert),
      v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years) 
      * p_plotData(curPlots,'size'))
  + sum(p_c_m_s_n_z_a(curPlots,curCrops1,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert),
      v_binCropPlot(curPlots,curCrops1,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years) 
      * p_plotData(curPlots,'size'))
  =L= 
    p_constraint(constraints,curCrops,curCrops1)
  + v_devUserShares(constraints,curCrops,curCrops1,years)
;  
$endif.constraints
