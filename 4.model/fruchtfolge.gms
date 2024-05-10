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
*scalar  p_grassLandExempt defines whether farm has more than seventyfive percent green land and arable land is below thirty hectares or not, value assignment follows subsequently;

p_totLand = sum(curPlots, p_plotData(curPlots,"size"));
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size"));
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
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


*
*  --- load farm individual ktbl data (processed) into model
*
parameters 
  p_profitPerHa(KTBL_Crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
  p_timeReq(KTBL_Crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,CostsEle,manAmounts)
;

$Gdxin '3.farmData/gdxFiles/ktblResults_%farmNumber%.gdx'
$load p_profitPerHa=p_profitPerHa
$load p_timeReq=p_timeReq
$gdxin

option 
    p_profitPerHa:1:6:1
    p_timeReq:1:7:1
;

*display p_profitPerHa, p_timeReq;

*
*  --- declare objective variable and equation
*
Variables
  v_profit(years)
  v_totProfit
  v_obje
;

scalar M / 99999 /;

Binary Variable 
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
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
*  v_devGaec7_1(years)
*  v_devGaec7_2(years)
*  v_devGaec8(years)

Equations
  e_profit(years)
  e_obje
  e_totProfit
;

$ontext
*
*  --- Set and parameter introduction for later technology evaluation
*
set technoAttr / areaCapac, eff, fieldTime, varMachCostsPestiRedFactor /;
parameter p_technoData(technoAttr,pestType);
p_technoData("eff",pestType) = 0;
$offtext

*
*  --- include model files restricting on-farm decisions
*
$include '4.model/crop_rotation.gms'
$include '4.model/fertilizer_ordinance.gms'
*$include '4.model/gaec.gms'
$include '4.model/labour.gms'

*
*  --- calculation of profit for farm
*    
e_profit(years)..
  v_profit(years) =E=
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHa(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
      ),    
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years) * p_plotData(curPlots,'size')
    * p_profitPerHa(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    )
*direct costs for fertilization depending on amount of manure applied (file: fertilization.gms)  
*costs for labor (file: labour.gms)
    - v_labReq(years) * labPrice
*costs from manure exports (file: fertilizer_ordinance.gms)
    - v_manExports(years) * manPrice
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
    - sum(years,v_170Slack(years) * M)
*    - sum(years,v_devGaec6(years) * M)
*    - sum(years,v_devGaec7(years) * M)
*    - sum(years,v_devGaec8(years) * M)
$ontext
$iftheni.constraints defined constraints
    - sum((constraints,curCrops,curCrops1),
      v_devUserShares(constraints,curCrops,curCrops1,years) * M)
$endif.constraints
$iftheni.labour defined p_availLabour
    - sum(months, v_devLabour(months) * 1000)
$endif.labour
$offtext
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
*crop_rotation.gms
  e_maxShares
  e_oneCropPlot
*fertilizer_ordinance.gms
  e_manureUse
  e_man_balance
  e_170_avg
*gaec.gms
*  e_efa
*  e_75diversification
*  e_95diversification
*  e_gaec6
*  e_preCropSeq
*  e_gaec7
*  e_gaec8
*labour.gms
  e_labReq
/;

solve Fruchtfolge using MIP maximizing v_obje;
$batinclude '5.Report_Writing/report_writing.gms' "'base'" "'base'" "'base'"
*$include '%WORKDIR%exploiter/createJson.gms'