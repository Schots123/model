*-------------------------------
* Fruchtfolge
*
* A spatial crop rotation model
* serving as a base for the
* Fruchtfolge web application
* (c) Christoph Pahmeyer, 2019
*-------------------------------

*
*  --- initiate global parameters
*
scalar  p_totLand total land available to farm;
scalar  p_totArabLand total arable land farm endowment;
scalar  p_totGreenLand total green land farm endowment;
scalar  p_shareGreenLand share of green land relative to total land endowment of farm;
*scalar  p_grassLandExempt defines whether farm has more than seventyfive percent green land and arable land is below thirty hectares or not, value assignment follows subsequently;

*
*  --- include data for parameter variations
*
$include '4.cropProtectionData/AnalysisData.gms'

p_totLand = sum(curPlots, p_plotData(curPlots,"size")) * farmSizeVar;
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size")) * farmSizeVar;
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
*p_grassLandExempt $((p_shareGreenLand > 0.75) $(p_totArabLand < 30)) = 1;

*
*  --- linking of individual plot data with KTBL_data from file KTBL_data.gms
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

curPlots_ktblYield(curPlots,'niedrig, mittlerer Boden') $ (p_plotData(curPlots,'soilQual')  gt 20 AND p_plotData(curPlots,'soilQual') le 40 
  AND (p_plotData(curPlots,"soilType") eq lehmigerSand OR p_plotData(curPlots,"soilType") eq lehmigerSchluff OR p_plotData(curPlots,"soilType") eq sandigerLehm OR p_plotData(curPlots,"soilType") eq schluffigerLehm)) = yes;
  
curPlots_ktblYield(curPlots,'niedrig, leichter Boden') $ (p_plotData(curPlots,'soilQual')  gt 20 AND p_plotData(curPlots,'soilQual') le 40 
  AND (p_plotData(curPlots,"soilType") eq sandigerSchluff OR p_plotData(curPlots,"soilType") eq Sand OR p_plotData(curPlots,"soilType") eq starkSandigerLehm)) = yes;

curPlots_ktblYield(curPlots,'sehr niedrig, leichter Boden') $ (p_plotData(curPlots,'soilQual') le 20 
  AND (p_plotData(curPlots,"soilType") eq sandigerSchluff OR p_plotData(curPlots,"soilType") eq Sand OR p_plotData(curPlots,"soilType") eq starkSandigerLehm))= yes;


set curMechan(KTBL_mechanisation);
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*
*  --- load farm individual ktbl data (processed) into model
*
parameters 
  p_profitPerHaNoPesti(KTBL_Crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance)
;

$Gdxin '3.farmData/gdxFiles/ktblResults_%farmNumber%.gdx'
$load p_profitPerHaNoPesti=p_profitPerHaNoPesti
$gdxin

option 
    p_profitPerHaNoPesti:1:5:1
;
*display p_profitPerHaNoPesti;

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
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,years)
  v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
;

Positive Variables
* crop_rotation.gms
  v_devMaxShares(curCropGroups,years) area in hectare planted by farm for specific crops and year above maximum share allowed
  v_devMinShares(curCropGroups,years) area in hectare planted by farm for specific crops and year below minimum share allowed 
  v_devOneCrop(curPlots,years) number of main crops planted on field above one crop restriction each year
  v_devCropBreak2(years)
* gaec.gms
  v_devGaec7(years)
  v_devGaec7_1(years)
*  v_devGaec8(years)
;

Equations
  e_profit(years)
  e_obje
  e_totProfit
;

*
*  --- include model files restricting on-farm decisions
*
$include '5.model/crop_rotation.gms'
*$include '5.model/fertilizer_ordinance.gms'
$include '5.model/gaec.gms'
$include '5.model/labour.gms'
$include '5.model/crop_protection.gms'

*
*  --- calculation of profit for farm
*    
e_profit(years)..
  v_profit(years) =E=
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) 
      AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) 
      AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    ),    
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
      * p_plotData(curPlots,"size") * farmSizeVar
      * p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    )
*direct costs for plant protection products
    - v_dcPesti(years)
    - v_dcPesti(years) * (3/12) * 0.03
*variable and fix costs for pesticide application operations 
    - sum(scenSprayer, v_varCostsSprayer(scenSprayer,years))
    - sum(scenSprayer, v_fixCostsSprayer(scenSprayer,years))
*costs from manure exports (file: fertilizer_ordinance.gms)
*    - v_manExports(years) * manPrice
;      

e_totProfit..
  v_totProfit =E=
    sum(years, v_profit(years))
;    

e_obje..
  v_obje =E=
    v_totProfit
    - sum((curCropGroups,years), v_devMaxShares(curCropGroups,years) * M)
    - sum((curCropGroups,years), v_devMinShares(curCropGroups,years) * M)
    - sum((curPlots,years), v_devOneCrop(curPlots,years) * M * 10)
    - sum(years, v_devCropBreak2(years))
*    - sum(years,v_170Slack(years) * M)
    - sum(years,v_devGaec7(years) * M)
*    - sum(years,v_devGaec8(years) * M)
;


parameters 
  summary(allItems,*,*)
  summarySenAn(allItems,*,*,*)
  summaryVali(allItems,measures,technology,scenario)
;


*
*  --- define upper bounds for slack variables
*
v_devMaxShares.up(curCropGroups,years) = p_totArabLand;
v_devOneCrop.up(curPlots,years) = 1;


*
* --- Definition of model
*

model SprayerAdoption /
  e_profit
  e_totProfit
  e_obje
*crop_protection.gms
  e_cropTechnoPlot1
  e_cropTechnoPlot2
  e_dcPestiTechno
  e_SprayerTechno
  e_deprecTechnoTime
  e_deprecTechnoHa
  e_interestTechno
  e_otherCostsTechno
  e_fixCostsPestiTechno
  e_varCostsPestiTechno
*crop_rotation.gms
  e_maxShares
  e_minShares
  e_oneCropPlot
  e_cropBreak2years
*fertilizer_ordinance.gms
*  e_manureUse
*  e_man_balance
*  e_170_avg
*gaec.gms
  e_preCropSeq
  e_gaec7
*  e_gaec8
*labour.gms
  e_labReq
/;

*
* --- Specification of tolerance for solver to find optimal solution 
*
if (card(curPlots)<30,
    option optCR=0.005;
  elseif card(curPlots)<50, 
    option optCR=0.005;
  else 
    option optCR=0.01;
);
*option optCR specifies a relative termination tolerance for use in solving MIP problems 
*solver stops when proportional difference between solution found and best theoretical objective function
*is guaranteed to be smaller than optcr 

*ensuring that draws from uniform distribution are truly random and do not follow a recurring pattern
execseed = gmillisec(jnow);



*
* --- Solves for scenario comparison
*
p_technology_scenario("BA","Base") = 1;
p_scenario_scenSprayer("Base",BASprayer) = 1;
p_technology_scenario_scenSprayer("BA","Base",BASprayer) = 1;
$ontext
loop(farmSizeSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
*2.step: change level of parameter to desired level in loop step 
  farmSizeVar = p_farmSizeFactor(farmSizeSteps) / sum(curPlots, p_plotData(curPlots,"size"));
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report.gms' farmSizeSteps "'Base'" 
*  $$batinclude '6.Report/report_vali.gms'
);


*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
curMechan("45") $ (p_totLand lt 30) = yes;
curMechan("45") $ (p_totLand ge 30) = no;
curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
curMechan("230") $ (p_totLand ge 250) = yes;
curMechan("230") $ (p_totLand lt 250) = no;

p_technology_scenario("BA","Base") = 0;
p_scenario_scenSprayer("Base",BASprayer) = 0;
p_technology_scenario_scenSprayer("BA","Base",BASprayer) = 0;



p_technology_scenario("spot6m",scenarioFH) = 1;
p_scenario_scenSprayer("FH",spot6m_BASprayer) = 1;
p_scenario_scenSprayer("FH+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;

loop(farmSizeSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
*2.step: change level of parameter to desired level in loop step 
  farmSizeVar = p_farmSizeFactor(farmSizeSteps) / sum(curPlots, p_plotData(curPlots,"size"));
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report.gms' farmSizeSteps "'SST6m_FH'" 
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
curMechan("45") $ (p_totLand lt 30) = yes;
curMechan("45") $ (p_totLand ge 30) = no;
curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
curMechan("230") $ (p_totLand ge 250) = yes;
curMechan("230") $ (p_totLand lt 250) = no;

p_technology_scenario("spot6m",scenarioFH) = 0;
p_scenario_scenSprayer("FH",spot6m_BASprayer) = 0;
p_scenario_scenSprayer("FH+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;


p_technology_scenario("spot27m",scenarioFH) = 1;
p_scenario_scenSprayer("FH",spot27m_BASprayer) = 1;
p_scenario_scenSprayer("FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;

loop(farmSizeSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
*2.step: change level of parameter to desired level in loop step 
  farmSizeVar = p_farmSizeFactor(farmSizeSteps) / sum(curPlots, p_plotData(curPlots,"size"));
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report.gms' farmSizeSteps "'SST27m_FH'" 
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
curMechan("45") $ (p_totLand lt 30) = yes;
curMechan("45") $ (p_totLand ge 30) = no;
curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
curMechan("230") $ (p_totLand ge 250) = yes;
curMechan("230") $ (p_totLand lt 250) = no;

p_technology_scenario("spot27m",scenarioFH) = 0;
p_scenario_scenSprayer("FH",spot27m_BASprayer) = 0;
p_scenario_scenSprayer("FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;



p_technology_scenario("spot6m",scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",spot6m_BASprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;

loop(farmSizeSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
*2.step: change level of parameter to desired level in loop step 
  farmSizeVar = p_farmSizeFactor(farmSizeSteps) / sum(curPlots, p_plotData(curPlots,"size"));
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report.gms' farmSizeSteps "'SST6m_FHBonus'" 
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
curMechan("45") $ (p_totLand lt 30) = yes;
curMechan("45") $ (p_totLand ge 30) = no;
curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
curMechan("230") $ (p_totLand ge 250) = yes;
curMechan("230") $ (p_totLand lt 250) = no;

p_technology_scenario("spot6m",scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",spot6m_BASprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;



p_technology_scenario("spot27m",scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",spot27m_BASprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;

loop(farmSizeSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
*2.step: change level of parameter to desired level in loop step 
  farmSizeVar = p_farmSizeFactor(farmSizeSteps) / sum(curPlots, p_plotData(curPlots,"size"));
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report.gms' farmSizeSteps "'SST27m_FHBonus'" 
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
curMechan("45") $ (p_totLand lt 30) = yes;
curMechan("45") $ (p_totLand ge 30) = no;
curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
curMechan("230") $ (p_totLand ge 250) = yes;
curMechan("230") $ (p_totLand lt 250) = no;

p_technology_scenario("spot27m",scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",spot27m_BASprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
$offtext


*
* --- Solves for sensitivity analysis
*

*Adjustment of solver tolerance becuase of high amount of solves required for sensitivity analysis
option optCR=0.01;

*
* -- SST value variation
*
p_technology_scenario("BA","Base") = 1;
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("Base",BASprayer) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("BA","Base",BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to initial level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  technoValueVar(scenSprayer) = 1;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  technoValueRandom = uniform(50,200);
  technoValueVar(spotSprayer) = (technoValueRandom / 100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'ValueVar'" "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;


p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to initial level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  technoValueVar(scenSprayer) = 1;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  technoValueRandom = uniform(50,200);
  technoValueVar(spotSprayer) = (technoValueRandom / 100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations  
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'ValueVar'" "'Base|FHBonus'"
);

*reestablish data to initial level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
curMechan("45") $ (p_totLand lt 30) = yes;
curMechan("45") $ (p_totLand ge 30) = no;
curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
curMechan("230") $ (p_totLand ge 250) = yes;
curMechan("230") $ (p_totLand lt 250) = no;

technoValueVar(scenSprayer) = 1;
technoValueRandom = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;



*
* -- Fee on a per ha basis considered
*

*
* - 1.Case: 100 % investment costs, algorithm costs between 0 & 10 €/ha
*
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to initial level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  p_algorithmCostsPerHa(technology,scenario,scenSprayer,pestType) = 0;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  algoCostsPerHaRandom = uniform(0,10);
  p_algorithmCostsPerHa(SST,scenarioFH,spotSprayer,FH) = algoCostsPerHaRandom;
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'100%AlgoVar'" "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;

p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to initial level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  p_algorithmCostsPerHa(technology,scenario,scenSprayer,pestType) = 0;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  algoCostsPerHaRandom = uniform(0,10);
  p_algorithmCostsPerHa(SST,scenarioFHBonus,spotSprayer,FHBonus) = algoCostsPerHaRandom;
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations  
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'100%AlgoVar'" "'Base|FHBonus'"
);

*reestablish data to initial level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
curMechan("45") $ (p_totLand lt 30) = yes;
curMechan("45") $ (p_totLand ge 30) = no;
curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
curMechan("230") $ (p_totLand ge 250) = yes;
curMechan("230") $ (p_totLand lt 250) = no;

algoCostsPerHaRandom = 0;
p_algorithmCostsPerHa(technology,scenario,scenSprayer,pestType) = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;



*
* - 2.Case: 50 % investment costs, algorithm costs between 0 & 10 €/ha
*
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;

* setting SST investment costs at 50 % of initial value
technoValueVar(spotSprayer) = (50 / 100);

loop(sensiAnSteps,
*1.step: reestablish parameters to initial level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  p_algorithmCostsPerHa(technology,scenario,scenSprayer,pestType) = 0;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  algoCostsPerHaRandom = uniform(0,10);
  p_algorithmCostsPerHa(SST,scenarioFH,spotSprayer,FH) = algoCostsPerHaRandom;
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'50%AlgoVar'" "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;

p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to initial level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  p_algorithmCostsPerHa(technology,scenario,scenSprayer,pestType) = 0;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  algoCostsPerHaRandom = uniform(0,10);
  p_algorithmCostsPerHa(SST,scenarioFHBonus,spotSprayer,FHBonus) = algoCostsPerHaRandom;
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations  
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'50%AlgoVar'" "'Base|FHBonus'"
);

*reestablish data to initial level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
curMechan("45") $ (p_totLand lt 30) = yes;
curMechan("45") $ (p_totLand ge 30) = no;
curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
curMechan("230") $ (p_totLand ge 250) = yes;
curMechan("230") $ (p_totLand lt 250) = no;

technoValueVar(scenSprayer) = 1;

algoCostsPerHaRandom = 0;
p_algorithmCostsPerHa(technology,scenario,scenSprayer,pestType) = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;



*
* - 1.Case: 100 % investment costs, annual costs between 0 & 15.000 €/ha
*
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to initial level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  p_annualFeeSST(scenSprayer) = 0;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  annualFeeRandom = uniform(0,15000);
  p_annualFeeSST(spotSprayer) = annualFeeRandom;
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'100%AnFeeVar'" "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;

p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to initial level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  p_annualFeeSST(scenSprayer) = 0;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  annualFeeRandom = uniform(0,15000);
  p_annualFeeSST(spotSprayer) = annualFeeRandom;
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations  
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'100%AnFeeVar'" "'Base|FHBonus'"
);

*reestablish data to initial level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
curMechan("45") $ (p_totLand lt 30) = yes;
curMechan("45") $ (p_totLand ge 30) = no;
curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
curMechan("230") $ (p_totLand ge 250) = yes;
curMechan("230") $ (p_totLand lt 250) = no;

annualFeeRandom = 0;
p_annualFeeSST(scenSprayer) = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;



*
* - 2.Case: 50 % investment costs, annual costs between 0 & 10.000 €/ha
*
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;

* setting SST investment costs at 50 % of initial value
technoValueVar(spotSprayer) = (50 / 100);

loop(sensiAnSteps,
*1.step: reestablish parameters to initial level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  p_annualFeeSST(scenSprayer) = 0;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  annualFeeRandom = uniform(0,15000);
  p_annualFeeSST(spotSprayer) = annualFeeRandom;
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'50%AnFeeVar'" "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;

p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to initial level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  p_annualFeeSST(scenSprayer) = 0;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  annualFeeRandom = uniform(0,15000);
  p_annualFeeSST(spotSprayer) = annualFeeRandom;
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations  
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'50%AnFeeVar'" "'Base|FHBonus'"
);

*reestablish data to initial level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
curMechan("45") $ (p_totLand lt 30) = yes;
curMechan("45") $ (p_totLand ge 30) = no;
curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
curMechan("230") $ (p_totLand ge 250) = yes;
curMechan("230") $ (p_totLand lt 250) = no;

technoValueVar(scenSprayer) = 1;

annualFeeRandom = 0;
p_annualFeeSST(scenSprayer) = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;



*
* -- SST pesticide saving variation
*
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  p_technoPestEff(curCrops,technology,scenario,pestType) = 0;
  p_technoPestEff(curCrops,technology,scenario,pestType) = p_savePestEff(curCrops,technology,scenario,pestType);
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));
  technoPestEffRandom = uniform(-20,20);
*pesticide saving variation for the 1st scenario
  p_technoPestEff(curCrops,SST,scenarioFH,FH) =
    p_technoPestEff(curCrops,SST,scenarioFH,FH) + (technoPestEffRandom/100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'EffVar'" "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;

p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  p_technoPestEff(curCrops,technology,scenario,pestType) = 0;
  p_technoPestEff(curCrops,technology,scenario,pestType) = p_savePestEff(curCrops,technology,scenario,pestType);
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  technoPestEffRandom = uniform(-20,20);
*pesticide saving variation for the 2nd scenario
  p_technoPestEff(curCrops,SST,scenarioFHBonus,FHBonus) =
    p_technoPestEff(curCrops,SST,scenarioFHBonus,FHBonus) + (technoPestEffRandom/100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'EffVar'" "'Base|FHBonus'"
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
curMechan("45") $ (p_totLand lt 30) = yes;
curMechan("45") $ (p_totLand ge 30) = no;
curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
curMechan("230") $ (p_totLand ge 250) = yes;
curMechan("230") $ (p_totLand lt 250) = no;

p_technoPestEff(curCrops,technology,scenario,pestType) = 0;
p_technoPestEff(curCrops,technology,scenario,pestType) = p_savePestEff(curCrops,technology,scenario,pestType);
technoPestEffRandom = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;



*
* -- SST time requirement variation
*
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  technoTimeRandom = 1;
  timeReqVar(technology,scenario,scenSprayer,pestType) = 1;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  technoTimeRandom = uniform(50,200);
  timeReqVar(SST,scenarioFH,spotSprayer,FH) = (technoTimeRandom/100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'TimeVar'" "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;

p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  technoTimeRandom = 1;
  timeReqVar(technology,scenario,scenSprayer,pestType) = 1;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  technoTimeRandom = uniform(50,200);
  timeReqVar(SST,scenarioFHBonus,spotSprayer,FHBonus) = (technoTimeRandom/100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'TimeVar'" "'Base|FHBonus'"
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
curMechan("45") $ (p_totLand lt 30) = yes;
curMechan("45") $ (p_totLand ge 30) = no;
curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
curMechan("230") $ (p_totLand ge 250) = yes;
curMechan("230") $ (p_totLand lt 250) = no;

timeReqVar(technology,scenario,scenSprayer,pestType) = 1;
technoTimeRandom = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;



*
* -- SST fuel consumption variation
*
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  fuelConsVar(technology,scenario,scenSprayer,pestType) = 1;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  technoFuelRandom = uniform(50,200);
  fuelConsVar(SST,scenarioFH,spotSprayer,FH) = (technoFuelRandom/100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations  
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'FuelVar'" "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;

p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  fuelConsVar(technology,scenario,scenSprayer,pestType) = 1;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  technoFuelRandom = uniform(50,200);
  fuelConsVar(SST,scenarioFHBonus,spotSprayer,FHBonus) = (technoFuelRandom/100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'FuelVar'" "'Base|FHBonus'"
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
curMechan("45") $ (p_totLand lt 30) = yes;
curMechan("45") $ (p_totLand ge 30) = no;
curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
curMechan("230") $ (p_totLand ge 250) = yes;
curMechan("230") $ (p_totLand lt 250) = no;

fuelConsVar(technology,scenario,scenSprayer,pestType) = 1;
technoFuelRandom = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;



*
* -- SST repair costs variation
*
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  repairCostsVar(scenSprayer) = 1;
*2.step: change level of parameter to desired level in loop step
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  technoRepRandom = uniform(50,200);
  repairCostsVar(spotSprayer) = (technoRepRandom/100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'RepVar'" "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;

p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  repairCostsVar(scenSprayer) = 1;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  technoRepRandom = uniform(50,200);
  repairCostsVar(spotSprayer) = (technoRepRandom/100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("45") $ (p_totLand ge 30) = no;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
  curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
  curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
  curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
  curMechan("230") $ (p_totLand ge 250) = yes;
  curMechan("230") $ (p_totLand lt 250) = no;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn.gms' sensiAnSteps "'RepVar'" "'Base|FHBonus'"
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;
curMechan("45") $ (p_totLand lt 30) = yes;
curMechan("45") $ (p_totLand ge 30) = no;
curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
curMechan("67") $ (p_totLand lt 30 OR p_totLand ge 45) = no;
curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
curMechan("83") $ (p_totLand lt 45 OR p_totLand ge 65) = no;
curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 90) = yes;
curMechan("102") $ (p_totLand lt 65 OR p_totLand ge 90) = no;
curMechan("120") $ (p_totLand ge 90 AND p_totLand lt 135) = yes;
curMechan("120") $ (p_totLand lt 90 OR p_totLand ge 135) = no;
curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
curMechan("200") $ (p_totLand lt 135 OR p_totLand ge 250) = no;
curMechan("230") $ (p_totLand ge 250) = yes;
curMechan("230") $ (p_totLand lt 250) = no;

repairCostsVar(scenSprayer) = 1;
technoRepRandom = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;

option 
*  summary:2:2:1
  summarysenAn:2:1:3
*  summaryVali:2:3:1
;

*display 
*  summary
*  summarySenAn
*  summaryVali
*;
