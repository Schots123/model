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
  AND (p_plotData(curPlots,"soilType") eq Lehm OR p_plotData(curPlots,"soilType") eq sandigerSchluff OR p_plotData(curPlots,"soilType") eq starkSandigerLehm OR p_plotData(curPlots,"soilType") eq lehmigerSand OR p_plotData(curPlots,"soilType") eq lehmigerSchluff OR p_plotData(curPlots,"soilType") eq sandigerLehm OR p_plotData(curPlots,"soilType") eq schluffigerLehm)) = yes;

curPlots_ktblYield(curPlots,'hoch, leichter Boden') $ (p_plotData(curPlots,'soilQual')  gt 70 AND p_plotData(curPlots,'soilQual') le 100 
  AND (p_plotData(curPlots,"soilType") eq Sand)) = yes;

curPlots_ktblYield(curPlots,'mittel, schwerer Boden') $ (p_plotData(curPlots,'soilQual')  gt 40 AND p_plotData(curPlots,'soilQual') le 70 
  AND (p_plotData(curPlots,"soilType") eq schluffigTonigerLehm OR p_plotData(curPlots,"soilType") eq Ton OR p_plotData(curPlots,"soilType") eq tonigerLehm)) = yes;

curPlots_ktblYield(curPlots,'mittel, mittlerer Boden') $ (p_plotData(curPlots,'soilQual')  gt 40 AND p_plotData(curPlots,'soilQual') le 70
  AND (p_plotData(curPlots,"soilType") eq Lehm OR p_plotData(curPlots,"soilType") eq sandigerSchluff OR p_plotData(curPlots,"soilType") eq starkSandigerLehm OR p_plotData(curPlots,"soilType") eq lehmigerSand OR p_plotData(curPlots,"soilType") eq lehmigerSchluff OR p_plotData(curPlots,"soilType") eq sandigerLehm OR p_plotData(curPlots,"soilType") eq schluffigerLehm)) = yes;

curPlots_ktblYield(curPlots,'mittel, leichter Boden') $ (p_plotData(curPlots,'soilQual')  gt 40 AND p_plotData(curPlots,'soilQual') le 70 
  AND (p_plotData(curPlots,"soilType") eq Sand)) = yes;

curPlots_ktblYield(curPlots,'niedrig, mittlerer Boden') $ (p_plotData(curPlots,'soilQual')  gt 20 AND p_plotData(curPlots,'soilQual') le 40 
  AND (p_plotData(curPlots,"soilType") eq Lehm OR p_plotData(curPlots,"soilType") eq sandigerSchluff OR p_plotData(curPlots,"soilType") eq starkSandigerLehm OR p_plotData(curPlots,"soilType") eq lehmigerSand OR p_plotData(curPlots,"soilType") eq lehmigerSchluff OR p_plotData(curPlots,"soilType") eq sandigerLehm OR p_plotData(curPlots,"soilType") eq schluffigerLehm)) = yes;
  
curPlots_ktblYield(curPlots,'niedrig, leichter Boden') $ (p_plotData(curPlots,'soilQual')  gt 20 AND p_plotData(curPlots,'soilQual') le 40 
  AND (p_plotData(curPlots,"soilType") eq Sand)) = yes;

curPlots_ktblYield(curPlots,'sehr niedrig, leichter Boden') $ (p_plotData(curPlots,'soilQual') le 20 
  AND (p_plotData(curPlots,"soilType") eq Sand)) = yes;


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

*
*  --- declare objective variable and equation
*
Variables
  v_profit
  v_obje
;

scalar M / 99999 /;

Binary Variable 
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance)
  v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
;

Positive Variables
* crop_rotation.gms
  v_devMaxShares(curCropGroups) area in hectare planted by farm for specific crops above maximum share allowed
  v_devMaxSharesYieldLev(curCropGroups,KTBL_yieldLev) area in ha of crop planted by farm on plots above the allowed share for specific yield levels
  v_devOneCrop(curPlots) number of main crops planted on field above one crop restriction
*  v_devCropBreak2
* gaec.gms
*  v_devGaec7
*  v_devGaec7_1
*  v_devGaec8
;

Equations
  e_profit
  e_obje
;

*
*  --- include model files restricting on-farm decisions
*
$include '5.model/crop_rotation.gms'
$include '5.model/labour.gms'
$include '5.model/crop_protection.gms'

*
*  --- calculation of profit for farm
*    
e_profit..
  v_profit =E=
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) 
      AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) 
      AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    ),    
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
      * p_plotData(curPlots,"size") * farmSizeVar
      * p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    )
*direct costs for plant protection products
    - v_dcPesti
    - v_dcPesti * (3/12) * 0.03
*variable and fix costs for pesticide application operations 
    - sum(scenSprayer, v_varCostsSprayer(scenSprayer))
    - sum(scenSprayer, v_fixCostsSprayer(scenSprayer))
;      

e_obje..
  v_obje =E=
    v_Profit
    - sum(curCropGroups, v_devMaxShares(curCropGroups) * M)
    - sum((curCropGroups,KTBL_yieldLev), v_devMaxSharesYieldLev(curCropGroups,KTBL_yieldLev) * M)
*    - sum(curCropGroups, v_devMinShares(curCropGroups) * M)
    - sum(curPlots, v_devOneCrop(curPlots) * M * 10)
*    - v_devCropBreak2
*    - v_170Slack * M
*    - v_devGaec7 * M
*    - v_devGaec8 * M
;


parameters 
  summary(allItems,*,*)
  summarySenAn(allItems,*,*,*)
  summarySenAn3D(allItems,*,*,*,*)
  summaryVali(allItems,measures,technology,scenario)
;


*
*  --- define upper bounds for slack variables
*
v_devMaxShares.up(curCropGroups) = p_totArabLand;
v_devOneCrop.up(curPlots) = 1;


*
* --- Definition of model
*

model SprayerAdoption /
  e_profit
  e_obje
*crop_protection.gms
  e_CropSprayerPlot
  e_SST_BA_AdoptionStrategy
  e_dcPestiSprayer
  e_sprayerFieldDays
  e_sprayerFieldDaysHalf
  e_deprecTimeSprayer
*  e_deprecHaSprayer
  e_interestSprayer
  e_otherCostsSprayer
  e_fixCostsPestiSprayer
  e_varCostsPestiSprayer
*crop_rotation.gms
  e_maxShares
  e_maxSharesFavLoc
  e_oneCropPlot
*labour.gms
  e_labReqSprayer
/;


*
* --- To allow BA sprayer decisions at plot-level for the SST technology runs but ensure the acquisition of the SST, 
* an additional equation has to be established, forcing the model to acquire at least one sprayer of the respective SST
* while allowing the acquisition of a BA sprayer
equation 
  e_SST6m
  e_SST27m;

e_SST6m..
  v_numberSprayer("spot6m") 
  =G= 1;

e_SST27m..
  v_numberSprayer("spot27m") 
  =G= 1;

model SprayerAdoptionSST6m /
  e_profit
  e_obje
*crop_protection.gms
  e_SST6m
  e_CropSprayerPlot
  e_SST_BA_AdoptionStrategy
  e_dcPestiSprayer
  e_sprayerFieldDays
  e_sprayerFieldDaysHalf
  e_deprecTimeSprayer
*  e_deprecHaSprayer
  e_interestSprayer
  e_otherCostsSprayer
  e_fixCostsPestiSprayer
  e_varCostsPestiSprayer
*crop_rotation.gms
  e_maxShares
  e_maxSharesFavLoc
  e_oneCropPlot
*labour.gms
  e_labReqSprayer
/;

model SprayerAdoptionSST27m /
  e_profit
  e_obje
*crop_protection.gms
  e_SST27m
  e_CropSprayerPlot
  e_SST_BA_AdoptionStrategy
  e_dcPestiSprayer
  e_sprayerFieldDays
  e_sprayerFieldDaysHalf
  e_deprecTimeSprayer
*  e_deprecHaSprayer
  e_interestSprayer
  e_otherCostsSprayer
  e_fixCostsPestiSprayer
  e_varCostsPestiSprayer
*crop_rotation.gms
  e_maxShares
  e_maxSharesFavLoc
  e_oneCropPlot
*labour.gms
  e_labReqSprayer
/;

*
* --- Specification of tolerance for solver to find optimal solution 
*
option optCR=0;
*option optCR specifies a relative termination tolerance for use in solving MIP problems 
*solver stops when proportional difference between solution found and best theoretical objective function
*is guaranteed to be smaller than optcr 

*ensuring that draws from uniform distribution are truly random and do not follow a recurring pattern
execseed = gmillisec(jnow);

*Dissolution of mechanisation switch because it has no effect on profitability comparison of technologies
  curMechan("45") = no;
  curMechan("67") = no;
  curMechan("83") = no;
  curMechan("102") = no;
  curMechan("120") = yes;
  curMechan("200") = no;
  curMechan("230") = no;


*
* --- Solves for scenario comparison
*
p_technology_scenario("baseline","Base") = 1;
p_scenario_scenSprayer("Base",BASprayer) = 1;
p_technology_scenario_scenSprayer("baseline","Base",BASprayer) = 1;

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



p_technology_scenario("spot6m",scenarioFH) = 1;
p_scenario_scenSprayer("FH",spot6m_BASprayer) = 1;
p_scenario_scenSprayer("FH+BA","spot6m") = 1;
p_scenario_scenSprayer("BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

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
*4.step: solve model and initiate post model calculations
  solve SprayerAdoptionSST6m using MIP maximizing v_obje;
  $$batinclude '6.Report/report.gms' farmSizeSteps "'SST6m_FH'" 
  $$batinclude '6.Report/report_vali.gms'
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;

p_technology_scenario("spot6m",scenarioFH) = 0;
p_scenario_scenSprayer("FH",spot6m_BASprayer) = 0;
p_scenario_scenSprayer("FH+BA","spot6m") = 0;
p_scenario_scenSprayer("BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;


p_technology_scenario("spot27m",scenarioFH) = 1;
p_scenario_scenSprayer("FH",spot27m_BASprayer) = 1;
p_scenario_scenSprayer("FH+BA","spot27m") = 1;
p_scenario_scenSprayer("BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;

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
*4.step: solve model and initiate post model calculations
  solve SprayerAdoptionSST27m using MIP maximizing v_obje;
  $$batinclude '6.Report/report.gms' farmSizeSteps "'SST27m_FH'" 
  $$batinclude '6.Report/report_vali.gms'
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;

p_technology_scenario("spot27m",scenarioFH) = 0;
p_scenario_scenSprayer("FH",spot27m_BASprayer) = 0;
p_scenario_scenSprayer("FH+BA","spot27m") = 0;
p_scenario_scenSprayer("BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;



p_technology_scenario("spot6m",scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",spot6m_BASprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA","spot6m") = 1;
p_scenario_scenSprayer("BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

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
*4.step: solve model and initiate post model calculations
  solve SprayerAdoptionSST6m using MIP maximizing v_obje;
  $$batinclude '6.Report/report.gms' farmSizeSteps "'SST6m_FHBonus'" 
  $$batinclude '6.Report/report_vali.gms'
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;

p_technology_scenario("spot6m",scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",spot6m_BASprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA","spot6m") = 0;
p_scenario_scenSprayer("BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;



p_technology_scenario("spot27m",scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",spot27m_BASprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA","spot27m") = 1;
p_scenario_scenSprayer("BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;

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
*4.step: solve model and initiate post model calculations
  solve SprayerAdoptionSST27m using MIP maximizing v_obje;
  $$batinclude '6.Report/report.gms' farmSizeSteps "'SST27m_FHBonus'" 
  $$batinclude '6.Report/report_vali.gms'
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;

p_technology_scenario("spot27m",scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",spot27m_BASprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA","spot27m") = 0;
p_scenario_scenSprayer("BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;



*
* --- Solves for sensitivity analysis
*

*
* -- SST pesticide saving variation
*
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_scenario_scenSprayer("BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

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
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn2D.gms' sensiAnSteps "'EffVar'" "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_scenario_scenSprayer("BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;

p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_scenario_scenSprayer("BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

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
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn2D.gms' sensiAnSteps "'EffVar'" "'Base|FHBonus'"
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;

p_technoPestEff(curCrops,technology,scenario,pestType) = 0;
p_technoPestEff(curCrops,technology,scenario,pestType) = p_savePestEff(curCrops,technology,scenario,pestType);
technoPestEffRandom = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_scenario_scenSprayer("BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;



*
* -- SST time requirement variation
*
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_scenario_scenSprayer("BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  technoTimeRandom = 0;
  timeReqVar(technology,scenario,scenSprayer,pestType) = 1;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  technoTimeRandom = uniform(50,200);
  timeReqVar(SST,scenarioFH,spotSprayer,FH) = (technoTimeRandom / 100);
  timeReqVar(SST,scenarioFH,spotSprayer,"dualSpraying") $ (technoTimeRandom gt 100) = (technoTimeRandom / 100);

*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn2D.gms' sensiAnSteps "'TimeVar'" "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_scenario_scenSprayer("BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;

p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_scenario_scenSprayer("BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  technoTimeRandom = 0;
  timeReqVar(technology,scenario,scenSprayer,pestType) = 1;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  technoTimeRandom = uniform(50,200);
  timeReqVar(SST,scenarioFHBonus,spotSprayer,FHBonus) = (technoTimeRandom/100);
  timeReqVar(SST,scenarioFHBonus,spotSprayer,"dualSpraying") $ (technoTimeRandom gt 100) = (technoTimeRandom/100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn2D.gms' sensiAnSteps "'TimeVar'" "'Base|FHBonus'"
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;

timeReqVar(technology,scenario,scenSprayer,pestType) = 1;
technoTimeRandom = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_scenario_scenSprayer("BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;



*
* -- SST fuel consumption variation
*
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_scenario_scenSprayer("BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  fuelConsVar(technology,scenario,scenSprayer,pestType) = 1;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  technoFuelRandom = uniform(50,200);
  fuelConsVar(SST,scenarioFH,spotSprayer,FH) = (technoFuelRandom/100);
  fuelConsVar(SST,scenarioFH,spotSprayer,"dualSpraying") $ (technoFuelRandom gt 100)= (technoFuelRandom/100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
*4.step: solve model and initiate post model calculations  
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn2D.gms' sensiAnSteps "'FuelVar'" "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_scenario_scenSprayer("BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;

p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_scenario_scenSprayer("BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  fuelConsVar(technology,scenario,scenSprayer,pestType) = 1;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  technoFuelRandom = uniform(50,200);
  fuelConsVar(SST,scenarioFHBonus,spotSprayer,FHBonus) = (technoFuelRandom/100);
  fuelConsVar(SST,scenarioFHBonus,spotSprayer,"dualSpraying") $ (technoFuelRandom gt 100)= (technoFuelRandom/100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn2D.gms' sensiAnSteps "'FuelVar'" "'Base|FHBonus'"
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;

fuelConsVar(technology,scenario,scenSprayer,pestType) = 1;
technoFuelRandom = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_scenario_scenSprayer("BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;



*
* -- SST repair costs variation
*
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_scenario_scenSprayer("BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

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
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn2D.gms' sensiAnSteps "'RepVar'" "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_scenario_scenSprayer("BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;

p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_scenario_scenSprayer("BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

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
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn2D.gms' sensiAnSteps "'RepVar'" "'Base|FHBonus'"
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;

repairCostsVar(scenSprayer) = 1;
technoRepRandom = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_scenario_scenSprayer("BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;


*
* -- Variation of number of passages
*
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_scenario_scenSprayer("BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  passageVar(technology,scenario,pestType) = 1;
*2.step: change level of parameter to desired level in loop step
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  passageRandom = uniform(50,200);
  passageVar(SST,scenarioFHSavings,FH) = (passageRandom/100);
  passageVar(SST,scenarioFHSavings,"dualSpraying") $ (passageRandom gt 100) = (passageRandom/100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn2D.gms' sensiAnSteps "'PasVar'" "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_scenario_scenSprayer("BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;

p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_scenario_scenSprayer("BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

loop(sensiAnSteps,
*1.step: reestablish parameters to base level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));

  passageVar(technology,scenario,pestType) = 1;
*2.step: change level of parameter to desired level in loop step 
  farmSizeRandom = uniform(50,400);
  farmSizeVar = farmSizeRandom / sum(curPlots, p_plotData(curPlots,"size"));

  passageRandom = uniform(50,200);
  passageVar(SST,scenarioFHBonusSavings,FHBonus) = (passageRandom/100);
  passageVar(SST,scenarioFHBonusSavings,"dualSpraying") $ (passageRandom gt 100) = (passageRandom/100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn2D.gms' sensiAnSteps "'PasVar'" "'Base|FHBonus'"
);

*reestablish data to base level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;

passageVar(technology,scenario,pestType) = 1;
passageRandom = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_scenario_scenSprayer("BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;




*
* --- 3 parameter variations simultaneously
*
*Parameter introduction for value output in post model output of report_senAn3D.gms
parameters
  p_report_valuePestPrice /0/
  p_report_valueAnnualFee /0/
  p_report_valueAlgoFee /0/;

*
* -- SST value and pesticide price variation
*
p_report_valuePestPrice = 1;
* -- Scenario 1:
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_scenario_scenSprayer("BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

loop((valueStep3D,pestCostStep3D,farmSizeStep3D)
  $ (loopComb3DpestCost(valueStep3D,pestCostStep3D,farmSizeStep3D)),
*1.step: reestablish parameters to initial level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
  technoValueVar(scenSprayer) = 1;
  pestPriceVar = 1;
*2.step: change level of parameter to desired level in loop step 
  farmSizeVar = p_farmSizeStep(farmSizeStep3D) / sum(curPlots, p_plotData(curPlots,"size"));

  technoValueRandom = p_valueStep(valueStep3D);
  technoValueVar(spotSprayer) = (technoValueRandom / 100);

  pestPriceRandom = p_pestCostStep(pestCostStep3D);
  pestPriceVar = (pestPriceRandom / 100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn3D.gms' valueStep3D pestCostStep3D farmSizeStep3D "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_scenario_scenSprayer("BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;

p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_scenario_scenSprayer("BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

loop((valueStep3D,pestCostStep3D,farmSizeStep3D)
  $ (loopComb3DpestCost(valueStep3D,pestCostStep3D,farmSizeStep3D)),
*1.step: reestablish parameters to initial level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
  technoValueVar(scenSprayer) = 1;
  pestPriceVar = 1;
*2.step: change level of parameter to desired level in loop step 
  farmSizeVar = p_farmSizeStep(farmSizeStep3D) / sum(curPlots, p_plotData(curPlots,"size"));

  technoValueRandom = p_valueStep(valueStep3D);
  technoValueVar(spotSprayer) = (technoValueRandom / 100);

  pestPriceRandom = p_pestCostStep(pestCostStep3D);
  pestPriceVar = (pestPriceRandom / 100);
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn3D.gms' valueStep3D pestCostStep3D farmSizeStep3D "'Base|FHBonus'"
);

*reestablish data to initial level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;

technoValueVar(scenSprayer) = 1;
pestPriceVar = 1;
technoValueRandom = 0;
pestPriceRandom = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_scenario_scenSprayer("BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;

p_report_valuePestPrice = 0;



*
* -- Fee on a per ha basis considered (0,2,4,6,8,10,12 €/ha)
*
p_report_valueAlgoFee = 1;

* -- Scenario 1:
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_scenario_scenSprayer("BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

loop((valueStep3D,algoCostStep3D,farmSizeStep3D)
  $ (loopComb3DalgoCost(valueStep3D,algoCostStep3D,farmSizeStep3D)),
*1.step: reestablish parameters to initial level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
  technoValueVar(scenSprayer) = 1;
  p_algorithmCostsPerHa(technology,scenario,scenSprayer,pestType) = 0;
*2.step: change level of parameter to desired level in loop step 
  farmSizeVar = p_farmSizeStep(farmSizeStep3D) / sum(curPlots, p_plotData(curPlots,"size"));

  technoValueRandom = p_valueStep(valueStep3D);
  technoValueVar(spotSprayer) = (technoValueRandom / 100);

  algoCostsPerHaRandom = p_algoCostStep(algoCostStep3D);
  p_algorithmCostsPerHa(SST,scenarioFH,spotSprayer,FHPassages) = algoCostsPerHaRandom;
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn3D.gms' valueStep3D algoCostStep3D farmSizeStep3D "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_scenario_scenSprayer("BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;

* -- Scenario 2:
p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_scenario_scenSprayer("BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

loop((valueStep3D,algoCostStep3D,farmSizeStep3D)
  $ (loopComb3DalgoCost(valueStep3D,algoCostStep3D,farmSizeStep3D)),
*1.step: reestablish parameters to initial level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
  technoValueVar(scenSprayer) = 1;
  p_algorithmCostsPerHa(technology,scenario,scenSprayer,pestType) = 0;
*2.step: change level of parameter to desired level in loop step 
  farmSizeVar = p_farmSizeStep(farmSizeStep3D) / sum(curPlots, p_plotData(curPlots,"size"));

  technoValueRandom = p_valueStep(valueStep3D);
  technoValueVar(spotSprayer) = (technoValueRandom / 100);

  algoCostsPerHaRandom = p_algoCostStep(algoCostStep3D);
  p_algorithmCostsPerHa(SST,scenarioFHBonus,spotSprayer,FHBonusPassages) = algoCostsPerHaRandom;
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
*4.step: solve model and initiate post model calculations  
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn3D.gms' valueStep3D algoCostStep3D farmSizeStep3D "'Base|FHBonus'"
);

*reestablish data to initial level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;

technoValueVar(scenSprayer) = 1;
pestPriceVar = 1;
p_algorithmCostsPerHa(technology,scenario,scenSprayer,pestType) = 0;
technoValueRandom = 0;
pestPriceRandom = 0;
algoCostsPerHaRandom = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_scenario_scenSprayer("BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;

p_report_valueAlgoFee = 0;



*
* Fee on a per year basis considered (0,2500,5000,7500,10000,12500,15000 €/year)
*
p_report_valueAnnualFee = 1;

* -- Scenario 1:
p_technology_scenario(SST,scenarioFH) = 1;
p_scenario_scenSprayer("FH",scenSprayer) = 1;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 1;
p_scenario_scenSprayer("BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

loop((valueStep3D,annFeeStep3D,farmSizeStep3D)
  $ (loopComb3DannFee(valueStep3D,annFeeStep3D,farmSizeStep3D)),
*1.step: reestablish parameters to initial level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
  technoValueVar(scenSprayer) = 1;
  p_annualFeeSST(scenSprayer) = 0;
*2.step: change level of parameter to desired level in loop step 
  farmSizeVar = p_farmSizeStep(farmSizeStep3D) / sum(curPlots, p_plotData(curPlots,"size"));

  technoValueRandom = p_valueStep(valueStep3D);
  technoValueVar(spotSprayer) = (technoValueRandom / 100);

  annualFeeRandom = p_annFeeStep(annFeeStep3D);
  p_annualFeeSST(spotSprayer) = annualFeeRandom;
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
*4.step: solve model and initiate post model calculations
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn3D.gms' valueStep3D annFeeStep3D farmSizeStep3D "'Base|FH'"
);

p_technology_scenario(SST,scenarioFH) = 0;
p_scenario_scenSprayer("FH",scenSprayer) = 0;
p_scenario_scenSprayer("FH+BA",spotSprayer) = 0;
p_scenario_scenSprayer("BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;

* -- Scenario 2:
p_technology_scenario(SST,scenarioFHBonus) = 1;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 1;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 1;
p_scenario_scenSprayer("BA",spotSprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 1;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 1;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 1;

loop((valueStep3D,annFeeStep3D,farmSizeStep3D)
  $ (loopComb3DannFee(valueStep3D,annFeeStep3D,farmSizeStep3D)),
*1.step: reestablish parameters to initial level for next loop step
  farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
  technoValueVar(scenSprayer) = 1;
  p_annualFeeSST(scenSprayer) = 0;
*2.step: change level of parameter to desired level in loop step 
  farmSizeVar = p_farmSizeStep(farmSizeStep3D) / sum(curPlots, p_plotData(curPlots,"size"));

  technoValueRandom = p_valueStep(valueStep3D);
  technoValueVar(spotSprayer) = (technoValueRandom / 100);

  annualFeeRandom = p_annFeeStep(annFeeStep3D);
  p_annualFeeSST(spotSprayer) = annualFeeRandom;
*3.step: parameter reformulations required because of parameter variations in loop
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
*4.step: solve model and initiate post model calculations  
  solve SprayerAdoption using MIP maximizing v_obje;
  $$batinclude '6.Report/report_SenAn3D.gms' valueStep3D annFeeStep3D farmSizeStep3D "'Base|FHBonus'"
);

*reestablish data to initial level for initiation of next loop
farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));
p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
p_totGreenLand = p_totLand - p_totArabLand;
p_shareGreenLand = p_totGreenLand / p_totLand;

technoValueVar(scenSprayer) = 1;
pestPriceVar = 1;
p_annualFeeSST(scenSprayer) = 0;
technoValueRandom = 0;
pestPriceRandom = 0;
annualFeeRandom = 0;

p_technology_scenario(SST,scenarioFHBonus) = 0;
p_scenario_scenSprayer("FH+Bonus",scenSprayer) = 0;
p_scenario_scenSprayer("FH+Bonus+BA",spotSprayer) = 0;
p_scenario_scenSprayer("BA",spotSprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus",spot27m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot27m","FH+Bonus+BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot27m","BA","spot27m") = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus",spot6m_BASprayer) = 0;
p_technology_scenario_scenSprayer("spot6m","FH+Bonus+BA","spot6m") = 0;
p_technology_scenario_scenSprayer("spot6m","BA","spot6m") = 0;

p_report_valueAnnualFee = 0;


*option 
*  summary:1:2:1
*  summarysenAn:2:1:3
*  summaryVali:2:2:2
*;

*display 
*  summary
*  summarySenAn
*  summaryVali
*;
