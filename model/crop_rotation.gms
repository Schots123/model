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
  sum((curPlots,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  $ (curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) AND curPlots_ktblYield (curPlots,KTBL_yield)
  AND ktblCrops_ktblSystem(curCrops,KTBL_system) AND (not plots_permPast(curPlots))),
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
    * p_plotData(curPlots,"size"))
  =L= 
    (p_totArabLand * p_cropData(curCrops,"maxShare") / 100)
    + v_devShares(curCrops,years)
;

*
*  --- ensure that one element in the set crops (also fallow) is chosen for each plot by the model and not more
*
e_oneCropPlot(curPlots,years)..
  sum((curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  $ (curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) AND curPlots_ktblYield (curPlots,KTBL_yield)
  AND ktblCrops_ktblSystem(curCrops,KTBL_system)),
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years))
  + v_devOneCrop(curPlots,years)
  =E= 1
;


$ontext
*
*  --- prohibit growing a crop on a plot when there is no gross margin present
*
v_binCropPlot.up(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years) $ ((not
  p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert))
  $ (not plots_permPast(curPlots))) = 0;
$offtext

*
*  --- Enter user specified constraints into the model, 
*


$ontext
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
$offtext
