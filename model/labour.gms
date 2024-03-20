$ontext
This file can remain as it is first. Might become important later when I plan to incorporate field working days and 
labour costs. 
$offtext

*
*  --- Only account for labour constraints when parameter is defined
*
$iftheni.labour defined p_availLabour
Equations
  e_maxLabour(months)
*  e_maxFieldWorkDays(months)
;

e_maxLabour(months)..
*in hours per month
  sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert),
  v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,years)
  * p_grossMarginData(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,months)
  )
  =L= 
  p_availLabour(months)
  + v_devLabour(months)
;

*
*  --- we assume a maximum of 14h of work per day
*
$ontext
e_maxFieldWorkDays(months)..
  sum((curPlots,curCrops,halfMonths) $ months_halfMonths(months,halfMonths),
  v_binCropPlot(curCrops,curPlots)
  * p_tractorReq(crops,halfMonths)
  =L= p_availFieldWorkDays(months) * p_availTractHours(month)
;
$offtext

$endif.labour
