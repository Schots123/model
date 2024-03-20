$ontext
I have to make some changes here to integrate duev2020 as a fixed part into the model
$offtext
set manType / manure,solid /;
parameter p_excr(manType,man_attr);
p_excr("manure",man_attr) = p_manure(man_attr);
p_excr("solid",man_attr) = p_solid(man_attr);

positive variables
  v_manExports(manType,months)
  v_170Slack
  v_170PlotSlack(curPlots)
  v_20RedSlack
;
Equations
  e_man_balance ensures that manure produced on the farm has either to be applied or sold 
  e_170_avg 
*duev2020 shall be a fixed part of my model -> remove if condition  
  $$ifi "%duev2020%"=="true" e_170_plots(curPlots)
  $$ifi "%duev2020%"=="true" e_20_red_plots
;


Parameter p_manValue(manType,manAmounts,solidAmounts) /
*this parameter assigns a value to the type of manure, since solid manure has 
*higher dry content values -> set.xx enables that value assignment for the threedimensional
*set has only made once like in a twodimensional set (for all solid amount possibilities the 
* manValue for 5m3 of manure is the same)
  'manure'.'0'.set.solidAmounts 0
  'manure'.'10'.set.solidAmounts 10
  'manure'.'15'.set.solidAmounts 15
  'manure'.'20'.set.solidAmounts 20
  'manure'.'25'.set.solidAmounts 25
  'manure'.'30'.set.solidAmounts 30
  'manure'.'40'.set.solidAmounts 40
  'manure'.'50'.set.solidAmounts 50
  'manure'.'60'.set.solidAmounts 60
  'solid'.set.manAmounts.'0' 0
  'solid'.set.manAmounts.'5' 5
  'solid'.set.manAmounts.'10' 10
  'solid'.set.manAmounts.'12' 15
  'solid'.set.manAmounts.'15' 20
  'solid'.set.manAmounts.'20' 25
/;


e_man_balance(manType)..
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert),
    v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
    * p_plotData(curPlots,"size")
    * p_manValue(manType,manAmounts,solidAmounts))
    + sum(months, v_manExports(manType,months))
    =E= p_excr(manType,"amount")
;

$iftheni.duev2020 "%duev2020%"=="true"
  parameter p_notEndangeredLand field area of farm in hectare currently not in red area;

  p_notEndangeredLand = sum((curPlots) $ (not plots_duevEndangered(curPlots)), 
  p_plotData(curPlots,"size"));
      
*according to duev2020, for all fields in the red area the average rule of 170 kg application
*is still relevant
  e_170_avg $ p_notEndangeredLand..
    sum((p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert),manType)
      $ (not plots_duevEndangered(curPlots)),
    v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
     * p_plotData(curPlots,"size")
     * p_manValue(manType,manAmounts,solidAmounts)
     * p_manure("n")
     * 80 / 100
     ) /p_notEndangeredLand =L= 170 + v_170Slack
 ;
* In "red areas", the 170kg N maximum rule is active for every single field,
* instead of the average of all fields
$ontext
Maybe it is unnecessary to make such a complicated conditional formulation - it might have been
sufficient to write $ plots_duevEnadangered(curPlots)
$offtext
  e_170_plots(curPlots) $ (plots_duevEndangered(curPlots) )..
   sum((p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert),manType),
   v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
    * p_manValue(manType,manAmounts,solidAmounts)
    * p_manure("n")
    * 80 / 100
    )  =L= 170 + v_170PlotSlack(curPlots)
  ;
* In addition to this, nitrogen fertilizer needs to be reduced by a minimum average of 
* 20% on all fields in a "red area "of the farm
  e_20_red_plots $ sum(curPlots $ plots_duevEndangered(curPlots), 1)..
    sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
      $ plots_duevEndangered(curPlots),
     v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
      * p_plotData(curPlots,"size")
      * (ord(nReduction) - 1) * 10
*in the case that the model chooses o for a specific field, the calculation of the previous line would be
*(1-1)*10 = 0 and for 0.3 (4-1)*10 = 30
    ) 
    / sum(curPlots $ plots_duevEndangered(curPlots), p_plotData(curPlots,"size"))     
    =G= 20 - v_20RedSlack
  ;
$else.duev2020
  e_170_avg..
    sum((p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert),manType), 
    v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
     * p_plotData(curPlots,"size")
     * p_manValue(manType,manAmounts,solidAmounts)
     * p_manure("n")
     * 80 / 100
     )/p_totLand =L= 170 + v_170Slack

$endif.duev2020


