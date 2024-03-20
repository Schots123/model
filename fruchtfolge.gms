*-------------------------------
* Fruchtfolge
*
* A spatial crop rotation model
* serving as a base for the
* Fruchtfolge web application
* (c) Christoph Pahmeyer, 2019
*-------------------------------
*
*  --- initiate global parameters for Greening evaluation
*
scalar  p_totLand total land available to farm;
scalar  p_totArabLand total arable land farm endowment;
scalar  p_totGreenLand total green land farm endowment;
scalar  p_shareGreenLand share of green land relative to total land endowment of farm;
scalar  p_grassLandExempt defines whether farm has more than seventyfive percent green land and arable land is below thirty hectares or not, value assignment follows subsequently;

p_totLand = sum(curPlots, p_plotData(curPlots,"size"));
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size"));
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
p_grassLandExempt $((p_shareGreenLand > 0.75) $(p_totArabLand < 30)) = 1;
*p_gaec7Exempt $ ....xxx.... = 1

* 
*  --- initiate a cross set of all allowed combinations, might speed up generation time
*
$offOrder
*$offOrder removes the requirement, that set operations over leads and lags require the subject set to be ordered

set p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert);
p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
  $ p_grossMarginData(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,'grossMarginHa')
  = YES;
*all possibilities with a gross margin from the decision space enter this set (each valid possibility included once) 
alias (cropGroup,cropGroup1);
alias (curCrops,curCrops1);

scalar M / 99999 /;
*
*  --- declare objective variable and equation
*
Variables
  v_obje
  v_totGM
;

Positive Variables
  v_devShares(curCrops) area in hectare for crop planted above maximum share allowed specified by user in model5
  v_devOneCrop(curPlots) number of main crops planted on field above one crop requirement as specified in model5
*I think I have to alter the following 3 variables, because they are part of the old CAP
  v_devEfa5
  v_devEfa75 area in hectare of main crop planted above seventyfive diversification rule greening
  v_devEfa95
  v_devGaec6
  v_devGaec8
 
$iftheni.constraints defined constraints
  v_devUserShares(constraints,curCrops,curCrops) 
*constraints is currently not defined for farm5 (only for farm1 for the specific code in folder include)
$endif.constraints
$iftheni.labour defined p_availLabour
*p_availLabour is defined in file farm5, hence the following equation is currently activated
  v_devLabour(months) in hours per month
$endif.labour
;

Binary Variables
  v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
;

Equations
  e_obje
  e_totGM
;

*
*  --- include model
*
$include '%WORKDIR%model/crop_rotation.gms'
$include '%WORKDIR%model/fertilizer_ordinance.gms'
$include '%WORKDIR%model/storage.gms'
$include '%WORKDIR%model/gaec.gms'
$include '%WORKDIR%model/labour.gms'

*
*  --- calculate overall gross margin for the planning year
*
e_totGM..
  v_totGM =E=
    sum(p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert), 
      v_binCropPlot(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
      * p_grossMarginData(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,'grossMarginHa')
      * p_plotData(curPlots,'size')
    )
    - sum((manType,months), v_manExports(manType,months) * p_priceFertExport(manType,months));

e_obje..
  v_obje =E=
    v_totGM
    - sum(curCrops, v_devShares(curCrops) * M)
    - (v_devEfa5 * M)
    - (v_devEfa75 * M)
    - (v_devEfa95 * M)
    - sum(curPlots, v_devOneCrop(curPlots) * M * 10)
    - (sum((manType,months), v_manSlack(manType,months) * M))
    - (v_170Slack * M)
    - ((sum((manType,curPlots), v_170PlotSlack(curPlots))) * M)
    - (v_20RedSlack * M)
    - (v_devGaec6 * M)
    - (v_devGaec8 * M)
$iftheni.constraints defined constraints
    - sum((constraints,curCrops,curCrops1),
      v_devUserShares(constraints,curCrops,curCrops1) * M)
$endif.constraints
$iftheni.labour defined p_availLabour
    - sum(months, v_devLabour(months) * 1000)
$endif.labour
;

*
*  --- define upper bounds for slack variables
*
v_devShares.up(curCrops) = p_totArabLand;
v_devEfa5.up = p_totArabLand * 0.05;
v_devEfa75.up = p_totArabLand * 0.25;
v_devEfa95.up = p_totArabLand;
v_devOneCrop.up(curPlots) = 1;
$iftheni.constraints defined constraints
  v_devUserShares.up(constraints,curCrops,curCrops1) = p_totArabLand;
$endif.constraints
$iftheni.labour defined p_availLabour
  v_devLabour.up(months) = 15000;
$endif.labour

if (card(curPlots)<30,
    option optCR=0.0;
  elseif card(curPlots)<50, 
    option optCR=0.02;
  else 
    option optCR=0.04;
);
*option optCR specifies a relative termination tolerance for use in solving MIP problems 
*solver stops when proportional difference between solution found and best theoretical objective function
*is guaranteed to be smaller than optcr 


model Fruchtfolge /
  e_obje
  e_totGM
  e_maxShares
  e_oneCropPlot
*  e_man_balance
  e_170_avg
  $$ifi "%duev2020%"=="true" e_170_plots
  $$ifi "%duev2020%"=="true" e_20_red_plots
*e_170_plots and e_20_red_plots are activated for farm5 because it is set as true in farm5  
  e_storageBal
  e_manureSpring
  e_manureAutumn
  e_solidAutumn
  e_maxStorageCap
*I might have to change the following three equations due to outdated greening requirement
  e_efa
  e_75diversification
  e_95diversification
  e_gaec6
  e_gaec8

$iftheni.constraints defined constraints
*constraints is currently not defined - equation specification in file crop_rotation
  e_minimumShares
*e_minimumShares does enable the user to specify minimum shares of a crop to grow in a specific year (e.g. because of feed requirements)
  e_maximumShares
*e_maximumShares would allow user to define own maximum shares for crops (e.g. because of storage restrictions)
$endif.constraints

$iftheni.labour defined p_availLabour
*labour is defined in file farm5 - equation specification in file labour 
  e_maxLabour
$endif.labour
/;

display p_totArabLand
solve Fruchtfolge using MIP maximizing v_obje;

$include '%WORKDIR%exploiter/createJson.gms'
