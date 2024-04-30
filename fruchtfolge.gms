*-------------------------------
* Fruchtfolge
*
* A spatial crop rotation model
* serving as a base for the
* Fruchtfolge web application
* (c) Christoph Pahmeyer, 2019
*-------------------------------

set years / 2024 /;
*
*  --- initiate global parameters for Greening evaluation
*
scalar  p_totLand total land available to farm;
scalar  p_totArabLand total arable land farm endowment;
scalar  p_totGreenLand total green land farm endowment;
scalar  p_shareGreenLand share of green land relative to total land endowment of farm;
scalar p_newFuelPrice allows variation of fuel price;
*scalar  p_grassLandExempt defines whether farm has more than seventyfive percent green land and arable land is below thirty hectares or not, value assignment follows subsequently;

p_totLand = sum(curPlots, p_plotData(curPlots,"size"));
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size"));
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
p_newFuelPrice = 1;
*p_grassLandExempt $((p_shareGreenLand > 0.75) $(p_totArabLand < 30)) = 1;



*
*  --- linking individual plot data with KTBL_data from file KTBL_data.gms
*
set curPlots_ktblSize(curPlots,KTBL_size);
curPlots_ktblSize(curPlots,'1') $ (p_plotData(curPlots,'size') lt 1.5) = yes;
curPlots_ktblSize(curPlots,'2') $ (p_plotData(curPlots,'size') ge 1.5 AND  p_plotData(curPlots,'size') lt 3.5) = yes;
curPlots_ktblSize(curPlots,'5') $ (p_plotData(curPlots,'size') ge 3.5 AND  p_plotData(curPlots,'size') lt 7.5) = yes;
curPlots_ktblSize(curPlots,'10') $ (p_plotData(curPlots,'size') ge 7.5 AND  p_plotData(curPlots,'size') lt 15) = yes;
curPlots_ktblSize(curPlots,'20') $ (p_plotData(curPlots,'size') ge 15 AND  p_plotData(curPlots,'size') lt 30) = yes;
curPlots_ktblSize(curPlots,'40') $ (p_plotData(curPlots,'size') ge 30 AND  p_plotData(curPlots,'size') lt 60) = yes;
curPlots_ktblSize(curPlots,'80') $ (p_plotData(curPlots,'size') ge 60) = yes;


set curPlots_ktblDistance(curPlots,KTBL_distance);
curPlots_ktblDistance(curPlots,'1') $ (p_plotData(curPlots,'distance') lt 1.5) = yes;
curPlots_ktblDistance(curPlots,'2') $ (p_plotData(curPlots,'distance') ge 1.5 AND p_plotData(curPlots,'distance') lt 2.5) = yes;
curPlots_ktblDistance(curPlots,'3') $ (p_plotData(curPlots,'distance') ge 2.5 AND p_plotData(curPlots,'distance') lt 3.5) = yes;
curPlots_ktblDistance(curPlots,'4') $ (p_plotData(curPlots,'distance') ge 3.5 AND p_plotData(curPlots,'distance') lt 4.5) = yes;
curPlots_ktblDistance(curPlots,'5') $ (p_plotData(curPlots,'distance') ge 4.5 AND p_plotData(curPlots,'distance') lt 7.5) = yes;
curPlots_ktblDistance(curPlots,'10') $ (p_plotData(curPlots,'distance') ge 7.5 AND p_plotData(curPlots,'distance') lt 12.5) = yes;
curPlots_ktblDistance(curPlots,'15') $ (p_plotData(curPlots,'distance') ge 12.5) = yes;


set curPlots_ktblYield(curPlots,KTBL_yield);
curPlots_ktblYield(curPlots,'hoch, mittlerer Boden') $ (p_plotData(curPlots,'soilQual') gt 70 AND p_plotData(curPlots,'soilQual') le 100 
  AND (p_plotData(curPlots,"soilType") eq lehmigerSand OR p_plotData(curPlots,"soilType") eq lehmigerSchluff OR p_plotData(curPlots,"soilType") eq sandigerLehm OR p_plotData(curPlots,"soilType") eq schluffigerLehm)) = yes;

curPlots_ktblYield(curPlots,'hoch, leichter Boden') $ (p_plotData(curPlots,'soilQual')  gt 70 AND p_plotData(curPlots,'soilQual') le 100 
  AND (p_plotData(curPlots,"soilType") eq sandigerSchluff OR p_plotData(curPlots,"soilType") eq Sand OR p_plotData(curPlots,"soilType") eq starkSandigerLehm)) = yes;

curPlots_ktblYield(curPlots,'mittel, schwerer Boden') $ (p_plotData(curPlots,'soilQual')  gt 40 AND p_plotData(curPlots,'soilQual') le 70 
  AND (p_plotData(curPlots,"soilType") eq Lehm OR p_plotData(curPlots,"soilType") eq schluffigTonigerLehm OR p_plotData(curPlots,"soilType") eq Ton OR p_plotData(curPlots,"soilType") eq tonigerLehm)) = yes;

curPlots_ktblYield(curPlots,'mittel, mittlerer Boden') $ (p_plotData(curPlots,'soilQual')  gt 40 AND p_plotData(curPlots,'soilQual') le 70
  AND (p_plotData(curPlots,"soilType") eq lehmigerSand OR p_plotData(curPlots,"soilType") eq lehmigerSchluff OR p_plotData(curPlots,"soilType") eq sandigerLehm OR p_plotData(curPlots,"soilType") eq schluffigerLehm)) = yes;

curPlots_ktblYield(curPlots,'mittel, leichter Boden') $ (p_plotData(curPlots,'soilQual')  gt 40 AND p_plotData(curPlots,'soilQual') le 70 
  AND (p_plotData(curPlots,"soilType") eq sandigerSchluff OR p_plotData(curPlots,"soilType") eq Sand OR p_plotData(curPlots,"soilType") eq starkSandigerLehm)) = yes;

curPlots_ktblYield(curPlots,'niedrig, mittlerer Boden') $ (p_plotData(curPlots,'soilQual')  gt 25 AND p_plotData(curPlots,'soilQual') le 40 
  AND (p_plotData(curPlots,"soilType") eq lehmigerSand OR p_plotData(curPlots,"soilType") eq lehmigerSchluff OR p_plotData(curPlots,"soilType") eq sandigerLehm OR p_plotData(curPlots,"soilType") eq schluffigerLehm)) = yes;
  
curPlots_ktblYield(curPlots,'niedrig, leichter Boden') $ (p_plotData(curPlots,'soilQual')  gt 25 AND p_plotData(curPlots,'soilQual') le 40 
  AND (p_plotData(curPlots,"soilType") eq sandigerSchluff OR p_plotData(curPlots,"soilType") eq Sand OR p_plotData(curPlots,"soilType") eq starkSandigerLehm)) = yes;

curPlots_ktblYield(curPlots,'sehr niedrig, leichter Boden') $ (p_plotData(curPlots,'soilQual') le 25 
  AND (p_plotData(curPlots,"soilType") eq sandigerSchluff OR p_plotData(curPlots,"soilType") eq Sand OR p_plotData(curPlots,"soilType") eq starkSandigerLehm))= yes;

$ontext
* 
*  --- initiate a cross set of all allowed combinations, might speed up generation time -> that was the old approach of Christoph Pahmeyer, I could do the same think with the 
* conditionals used at each point where v_binCropPlot occurs in my version 
$offOrder
*$offOrder removes the requirement, for set operations to be ordered for lead and lag considerations 
set p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert);
p_c_m_s_n_z_a(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert)
  $ p_grossMarginData(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,'grossMarginHa')
  = YES;
*all possibilities with a gross margin from the decision space enter this set (each valid possibility included once) 
$OnOrder  
$offtext


*alias (cropGroup,cropGroup1);
alias (curCrops,curCrops1);

scalar M / 99999 /;

*
*  --- Calculation of profit per ha (no common costs) with KTBL_data
*
parameters
  p_ktbl_revenue(curCrops,KTBL_system,KTBL_yield)
  p_ktbl_directCosts(curCrops, KTBL_system, KTBL_yield) direct costs
  p_ktbl_directCostsInt(curCrops, KTBL_system, KTBL_yield) interest costs for inputs
  p_ktbl_vfMachCosts(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance) variable and fix machine costs 
  p_ktbl_fuelCons(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance) overall fuel consumption field operations
  p_ktbl_vfMachCostsNewFuel(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance) variable and fix machine costs with adapted fuel price
  p_ktbl_varMachCostsNewFuelInt(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance) interest costs for machine maintenenance and lubricant inputs
  p_ktbl_profitPerHa(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance) Profit per ha
;

p_ktbl_revenue(curCrops,KTBL_system,KTBL_yield)
  $ (ktblCrops_ktblSystem(curCrops,KTBL_system))
  = sum(KTBL_figure,
      p_ktbl_cropYields(curCrops,KTBL_system,KTBL_yield,KTBL_figure) * p_ktbl_cropPrice(curCrops,KTBL_system,KTBL_yield,KTBL_figure))
;

p_ktbl_directCosts(curCrops, KTBL_system, KTBL_yield)
  $ (ktblCrops_ktblSystem(curCrops,KTBL_system))
  = sum(fertType, 
        p_ktbl_fertAmount(curCrops, KTBL_system, KTBL_yield, fertType) *p_ktbl_fertPrice(fertType))
    + sum(pestType,
        p_ktbl_dcPesti(curCrops, KTBL_system, KTBL_yield, pestType))
    + p_ktbl_dirCostRest(curCrops, KTBL_system, KTBL_yield) 
;

p_ktbl_directCostsInt(curCrops, KTBL_system, KTBL_yield)
  $ (ktblCrops_ktblSystem(curCrops,KTBL_system))
  = p_ktbl_directCosts(curCrops,KTBL_system,KTBL_yield) * (3/12) * 0.03
;

p_ktbl_vfMachCosts(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance) 
  $ (ktblCrops_ktblSystem(curCrops,KTBL_system))
  =sum (vfCosts,
        p_ktbl_vfCostsUnedited(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,vfCosts))
;

p_ktbl_fuelCons(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  $ (ktblCrops_ktblSystem(curCrops,KTBL_system))
  = sum(pestType,
        p_ktbl_fuelConsPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,pestType))
      
    + sum(vfCostEle,
        p_ktbl_fuelConsNoPest(curCrops, KTBL_system, KTBL_size, KTBL_yield, curMechan,KTBL_distance,vfCostEle))
;    

p_ktbl_vfMachCostsNewFuel(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  $ (ktblCrops_ktblSystem(curCrops,KTBL_system))
  = p_ktbl_vfMachCosts(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance) 
    - p_ktbl_fuelCons(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance) * 0.8
    + p_ktbl_fuelCons(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance) * p_newFuelPrice
;

p_ktbl_varMachCostsNewFuelInt(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
  $ (ktblCrops_ktblSystem(curCrops,KTBL_system))
  = (p_ktbl_vfCostsUnedited(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,'varCosts')
    - p_ktbl_fuelCons(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance) * 0.8
    + p_ktbl_fuelCons(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance) * p_newFuelPrice)
  * (3/12) * 0.03
;

p_ktbl_profitPerHa(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance) 
  $ (ktblCrops_ktblSystem(curCrops,KTBL_system))
  = p_ktbl_revenue(curCrops,KTBL_system,KTBL_yield)
    - p_ktbl_directCosts(curCrops, KTBL_system, KTBL_yield)
    - p_ktbl_directCostsInt(curCrops, KTBL_system, KTBL_yield)
    - p_ktbl_vfMachCostsNewFuel(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    - p_ktbl_varMachCostsNewFuelInt(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    - p_ktbl_costsServices(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
;

*
*  --- declare objective variable and equation
*
Variables
  v_profit(years)
  v_totProfit
  v_obje
;

Positive Variables
*
*  --- crop_rotation.gms
*
  v_devShares(curCrops,years) area in hectare planted for each crop and year above maximum share allowed
  v_devOneCrop(curPlots,years) number of main crops planted on field above one crop restriction each year
*constraints is currently not defined for farm5 (only for farm1 for the specific code in folder include)  
*$iftheni.constraints defined constraints 
*    v_devUserShares(constraints,curCrops,curCrops1,years)  
*$endif.constraints

*
*  --- gaec.gms (serving as updated greening module file)
*
*  v_devEfa5
*  v_devEfa75 area in hectare of main crop planted above seventyfive diversification rule greening
*  v_devEfa95
*  v_devGaec6(years)
*  v_devGaec7(years)
*  v_devGaec8(years)

*
*  --- labour.gms
*
*$iftheni.labour defined p_availLabour
*p_availLabour is defined in file farm5, hence the following equation is currently activated
*  v_devLabour(months) in hours per month
*$endif.labour
;

Binary Variables
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
*  v_binRepCropPlot(curPlots,curCrops,years)
*v_binRepCropPlot is used in gaec.gms for gaec7 constraint (not completely finished yet)
;

Equations
  e_profit(years)
  e_obje
  e_totProfit
;

*
*  --- include model files constraining on-farm decision making
*
$include '%WORKDIR%model/crop_rotation.gms'
*$include '%WORKDIR%model/fertilizer_ordinance.gms'
*$include '%WORKDIR%model/storage.gms'
*$include '%WORKDIR%model/gaec.gms'
*$include '%WORKDIR%model/labour.gms'

*
*  --- calculation of profit for farm
*    
e_profit(years)..
  v_profit(years) =E=
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    $ (curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_ktblSystem(curCrops,KTBL_system)),    
      v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years) * p_plotData(curPlots,'size')
      * p_ktbl_profitPerHa(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance))
*costs from manure exports 
*  - sum((manType,months), v_manExports(manType,months) * p_priceFertExport(manType,months))
;      

e_totProfit..
  v_totProfit =E=
    sum(years, v_profit(years))
;    
e_obje..
  v_obje =E=
    v_totProfit
    - sum((curCrops,years), v_devShares(curCrops,years) * M)
*    - (v_devEfa5 * M)
*    - (v_devEfa75 * M)
*    - (v_devEfa95 * M)
    - sum((curPlots,years), v_devOneCrop(curPlots,years) * M * 10)
*    - (sum((manType,months), v_manSlack(manType,months) * M))
*    - (v_170Slack * M)
*    - (sum((manType,curPlots), v_170PlotSlack(curPlots) * M))
*    - (v_20RedSlack * M)
*    - sum(years,v_devGaec6(years) * M)
*    - sum(years,v_devGaec7(years) * M)
*    - sum(years,v_devGaec8(years) * M)
$iftheni.constraints defined constraints
    - sum((constraints,curCrops,curCrops1),
      v_devUserShares(constraints,curCrops,curCrops1,years) * M)
$endif.constraints
*$iftheni.labour defined p_availLabour
*    - sum(months, v_devLabour(months) * 1000)
*$endif.labour
;

*
*  --- define upper bounds for slack variables
*
v_devShares.up(curCrops,years) = p_totArabLand;
*v_devEfa5.up = p_totArabLand * 0.05;
*v_devEfa75.up = p_totArabLand * 0.25;
*v_devEfa95.up = p_totArabLand;
v_devOneCrop.up(curPlots,years) = 1;
*$iftheni.constraints defined constraints
*  v_devUserShares.up(constraints,curCrops,curCrops1,years) = p_totArabLand;
*$endif.constraints
*$iftheni.labour defined p_availLabour
*  v_devLabour.up(months) = 15000;
*$endif.labour

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
  e_profit
  e_totProfit
  e_obje
  e_maxShares
  e_oneCropPlot
*  e_man_balance
*  e_170_avg
*  $$ifi "%duev2020%"=="true" e_170_plots
*  $$ifi "%duev2020%"=="true" e_20_red_plots
*e_170_plots and e_20_red_plots are activated for farm5 because it is set as true in farm5  
*  e_storageBal
*  e_manureSpring
*  e_manureAutumn
*  e_solidAutumn
*  e_maxStorageCap
*I might have to change the following three equations due to outdated greening requirement
*  e_efa
*  e_75diversification
*  e_95diversification
*  e_gaec6
*  e_preCropSeq
*  e_gaec7
*  e_gaec8
*$iftheni.constraints defined constraints
*constraints is currently not defined - equation specification in file crop_rotation
*  e_minimumShares
*e_minimumShares(years) does enable the user to specify minimum shares of a crop to grow in a specific year (e.g. because of feed requirements)
*  e_maximumShares
*e_maximumShares(years) would allow user to define own maximum shares for crops (e.g. because of storage restrictions)
*$endif.constraints
*$iftheni.labour defined p_availLabour
*labour is defined in file farm5 - equation specification in file labour 
*  e_maxLabour
*$endif.labour
/;

solve Fruchtfolge using MIP maximizing v_obje;
$batinclude '%WORKDIR%test/include/report_writing.gms' "'base'" "'base'" "'base'"
*$include '%WORKDIR%exploiter/createJson.gms'