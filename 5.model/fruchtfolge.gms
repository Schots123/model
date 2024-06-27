*-------------------------------
* Fruchtfolge
*
* A spatial crop rotation model
* serving as a base for the
* Fruchtfolge web application
* (c) Christoph Pahmeyer, 2019
*-------------------------------

*
*  --- initiate global parameters for gaec evaluation
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

curPlots_ktblYield(curPlots,'niedrig, mittlerer Boden') $ (p_plotData(curPlots,'soilQual')  gt 25 AND p_plotData(curPlots,'soilQual') le 40 
  AND (p_plotData(curPlots,"soilType") eq lehmigerSand OR p_plotData(curPlots,"soilType") eq lehmigerSchluff OR p_plotData(curPlots,"soilType") eq sandigerLehm OR p_plotData(curPlots,"soilType") eq schluffigerLehm)) = yes;
  
curPlots_ktblYield(curPlots,'niedrig, leichter Boden') $ (p_plotData(curPlots,'soilQual')  gt 25 AND p_plotData(curPlots,'soilQual') le 40 
  AND (p_plotData(curPlots,"soilType") eq sandigerSchluff OR p_plotData(curPlots,"soilType") eq Sand OR p_plotData(curPlots,"soilType") eq starkSandigerLehm)) = yes;

curPlots_ktblYield(curPlots,'sehr niedrig, leichter Boden') $ (p_plotData(curPlots,'soilQual') le 25 
  AND (p_plotData(curPlots,"soilType") eq sandigerSchluff OR p_plotData(curPlots,"soilType") eq Sand OR p_plotData(curPlots,"soilType") eq starkSandigerLehm))= yes;


set curMechan(KTBL_mechanisation);
curMechan("45") $ (p_totLand lt 30) = yes;
curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 85) = yes;
curMechan("120") $ (p_totLand ge 85 AND p_totLand lt 105) = yes;
curMechan("120") $ (p_totLand ge 105 AND p_totLand lt 135) = yes;
curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
curMechan("230") $ (p_totLand ge 250) = yes;
*
*  --- load farm individual ktbl data (processed) into model
*
parameters 
  p_profitPerHaNoPesti(KTBL_Crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
;

$Gdxin '3.farmData/gdxFiles/ktblResults_%farmNumber%.gdx'
$load p_profitPerHaNoPesti=p_profitPerHaNoPesti
$gdxin

option 
    p_profitPerHaNoPesti:1:6:1
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
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts,years)
;

Positive Variables
* crop_rotation.gms
  v_devShares(curCrops,years) area in hectare planted for each crop and year above maximum share allowed
  v_devOneCrop(curPlots,years) number of main crops planted on field above one crop restriction each year
* gaec.gms
  v_devGaec7_1(years)
  v_devGaec7_2(years)
  v_devGaec8(years)
;

Equations
  e_profit(years)
  e_obje
  e_totProfit
;

*
*  --- include data for the sensitivity analysis
*
$include '4.cropProtectionData/senAnalysisData.gms'

*
*  --- include model files restricting on-farm decisions
*
$include '5.model/crop_protection.gms'
$include '5.model/crop_rotation.gms'
$include '5.model/fertilizer_ordinance.gms'
$include '5.model/gaec.gms'
$include '5.model/labour.gms'

*
*  --- calculation of profit for farm
*    
e_profit(years)..
  v_profit(years) =E=
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) 
      AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) 
      AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),    
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
      * p_plotData(curPlots,"size") * farmSizeVar
      * p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    )
*direct costs for plant protection products
    - v_dcPesti(years)
*variable and fix costs for pesticide application operations 
    - sum(scenSprayer, v_varCostsSprayer(scenSprayer,years))
    - v_fixCostsSprayer(years)
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
    - sum((curPlots,years), v_devOneCrop(curPlots,years) * M * 10)
    - sum(years,v_170Slack(years) * M)
    - sum(years,v_devGaec7_1(years) * M)
    - sum(years,v_devGaec7_2(years) * M)
    - sum(years,v_devGaec8(years) * M)
;


*
* --- Restrictions to allow defined scenarios for each model separately 
* 
equations 
  e_scenBase
  e_scenSST_FH
  e_scenSST_FH_BA
  e_scenSST_FH_Bonus
  e_scenSST_FH_Bonus_BA
;

e_scenBase..
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size)
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
        AND (not(sameas(scenario,"Base")))
    ),
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    )
    =E=
    0
;

e_scenSST_FH..
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size)
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
        AND (not(sameas(scenario,"FH")))
    ),
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    )
    =E=
    0
;

e_scenSST_FH_BA..
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size)
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
        AND (not(sameas(scenario,"FH+BA")))
    ),
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    )
    =E=
    0
;

e_scenSST_FH_Bonus..
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size)
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
        AND ((sameas(scenario,"Base"))
          OR (sameas(scenario,"FH"))
          OR (sameas(scenario,"FH+BA")))
          OR (sameas(scenario,"FH+Bonus+BA"))
    ),
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    )
    =E=
    0
;

e_scenSST_FH_Bonus_BA..
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size)
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
        AND ((sameas(scenario,"Base"))
          OR (sameas(scenario,"FH"))
          OR (sameas(scenario,"FH+BA")))
          OR (sameas(scenario,"FH+Bonus"))
    ),
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    )
    =E=
    0
;

parameters 
  arabLandUsed(*,*,*,*) cultivated arable land to grow crops 
  crops_year_report(*,*,*,*,curCrops) model decision for crops grown as sum of hectares 
  annProfitAvg(*,*,*,*) average annual profit farm
*  totProfitDiff(*) profit difference between scenario and baseline
  numberSprayer(*,*,*,*,scenSprayer) number of sprayers required for the respective scenario
*  numberPassages(curCrops,*,scenSprayer,years) 
  labCostsSprayerAvg(*,*,*,*) average annual labor costs for pesticide applications 
  deprecSprayerAvg(*,*,*,*,scenSprayer) average annual depreciation of sprayer
  yearsSprayerUsedAvg(*,*,*,*,scenSprayer) average amount of years until sprayer repurchase
  dcPestiAvg(*,*,*,*) average annual direct costs for pesticides 
  varCostsSprayerAvg(*,*,*,*) average annual variable machine costs for sprayer utilizations
  fixCostsSprayerAvg(*,*,*,*) average annual fixed costs for the sprayer technology

*  dcPestiCrops(*,*,*,*,curCrops,KTBL_yield,pestType,years)
;


*
*  --- define upper bounds for slack variables
*
v_devShares.up(curCrops,years) = p_totArabLand;
v_devOneCrop.up(curPlots,years) = 1;

if (card(curPlots)<30,
    option optCR=0.05;
  elseif card(curPlots)<50, 
    option optCR=0.052;
  else 
    option optCR=0.04;
);
*option optCR specifies a relative termination tolerance for use in solving MIP problems 
*solver stops when proportional difference between solution found and best theoretical objective function
*is guaranteed to be smaller than optcr 

$ontext
model TechnoBase /
  e_profit
  e_totProfit
  e_obje
*crop_protection.gms
  e_cropTechnoPlot1
  e_cropTechnoPlot2
  e_cropTechnoPlot3
  e_scenBase
  e_dcPestiTechno
  e_SprayerTechno
  e_deprecTechnoTime
  e_deprecTechnoHa
  e_interestTechno
  e_fixCostsPestiTechno
  e_varCostsPestiTechno
*crop_rotation.gms
  e_maxShares
  e_oneCropPlot
*fertilizer_ordinance.gms
  e_manureUse
  e_man_balance
  e_170_avg
*gaec.gms
  e_preCropSeq_1
  e_preCropSeq_2
  e_gaec7_1
  e_gaec7_2
  e_gaec8
*labour.gms
  e_labReq
/;


loop(farmSizeStep,
  farmSizeVar = 1;
  farmSizeVar = p_farmSizeFactor(farmSizeStep);

*parameter reformulations required because of parameter variations
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;
  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 85) = yes;
  curMechan("120") $ (p_totLand ge 85 AND p_totLand lt 105) = yes;
  curMechan("120") $ (p_totLand ge 105 AND p_totLand lt 135) = yes;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("230") $ (p_totLand ge 250) = yes;

  solve TechnoBase using MIP maximizing v_obje;
  display farmSizeVar;
  display p_totArabLand;
  display p_totLand;
  $$batinclude '6.Report_Writing/report_writing.gms' "'Base'" farmSizeStep "'Base'" "'Base'"
);
$offtext

model TechnoSST_FH /
  e_profit
  e_totProfit
  e_obje
*crop_protection.gms
  e_cropTechnoPlot1
  e_cropTechnoPlot2
  e_scenSST_FH
  e_dcPestiTechno
  e_SprayerTechno
  e_deprecTechnoTime
  e_deprecTechnoHa
  e_interestTechno
  e_fixCostsPestiTechno
  e_varCostsPestiTechno
*crop_rotation.gms
  e_maxShares
  e_oneCropPlot
*fertilizer_ordinance.gms
  e_manureUse
  e_man_balance
  e_170_avg
*gaec.gms
  e_preCropSeq_1
  e_preCropSeq_2
  e_gaec7_1
  e_gaec7_2
  e_gaec8
*labour.gms
  e_labReq
/;


loop((SSTvalueStep,SSTeffStep,farmSizeStep),
* --- step 1 reestablish data to base level  
*1. reestablishing investment costs for SST
  p_technoValue(scenSprayerSST,KTBL_mechanisation) = p_saveTechnoValue(scenSprayerSST,KTBL_mechanisation);
  p_technoRemValue(scenSprayer,KTBL_mechanisation) 
    = p_technoValue(scenSprayer,KTBL_mechanisation) * 0.2;
*2. reestablishing pesticide savings with SST
  p_effStepVar = 0;
*3. reestablishing farm size
  farmSizeVar = 1;

* --- step 2 change data to new level  
*1. assigning new investment costs to SST and correcting remaining value 
  p_technoValue(scenSprayerSST,KTBL_mechanisation) = 
    p_technoValue(scenSprayerSST,KTBL_mechanisation) * p_SSTvalueStep(SSTvalueStep);
  p_technoRemValue(scenSprayerSST,KTBL_mechanisation) 
    = p_technoValue(scenSprayerSST,KTBL_mechanisation) * 0.2;
*2. assigning new pesticide saving value for SST
  p_effStepVar = p_SSTeffStep(SSTeffStep);
*3. assigning new farm size to individual farm
  farmSizeVar = p_farmSizeFactor(farmSizeStep);

* --- step 3 parameter reformulations required for parameter variations
  p_totLand = sum(curPlots, p_plotData(curPlots,"size") * farmSizeVar);
  p_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,"size") * farmSizeVar);
  p_totGreenLand = p_totLand - p_totArabLand;
  p_shareGreenLand = p_totGreenLand / p_totLand;

  curMechan("45") $ (p_totLand lt 30) = yes;
  curMechan("67") $ (p_totLand ge 30 AND p_totLand lt 45) = yes;
  curMechan("83") $ (p_totLand ge 45 AND p_totLand lt 65) = yes;
  curMechan("102") $ (p_totLand ge 65 AND p_totLand lt 85) = yes;
  curMechan("120") $ (p_totLand ge 85 AND p_totLand lt 105) = yes;
  curMechan("120") $ (p_totLand ge 105 AND p_totLand lt 135) = yes;
  curMechan("200") $ (p_totLand ge 135 AND p_totLand lt 250) = yes;
  curMechan("230") $ (p_totLand ge 250) = yes;
*step 4 solve model
  solve TechnoSST_FH using MIP maximizing v_obje;
  $$batinclude '6.Report_Writing/report_writing.gms' "'SST_FH'" farmSizeStep SSTvalueStep SSTeffStep
);


$ontext
model TechnoSST_FH_BA /
  e_profit
  e_totProfit
  e_obje
*crop_protection.gms
  e_cropTechnoPlot1
  e_cropTechnoPlot2
  e_cropTechnoPlot3
  e_scenSST_FH_BA
  e_dcPestiTechno
  e_SprayerTechno
  e_deprecTechnoTime
  e_deprecTechnoHa
  e_interestTechno
  e_fixCostsPestiTechno
  e_varCostsPestiTechno
*crop_rotation.gms
  e_maxShares
  e_oneCropPlot
*fertilizer_ordinance.gms
  e_manureUse
  e_man_balance
  e_170_avg
*gaec.gms
  e_preCropSeq_1
  e_preCropSeq_2
  e_gaec7_1
  e_gaec7_2
  e_gaec8
*labour.gms
  e_labReq
/;

solve TechnoSST_FH_BA using MIP maximizing v_obje;
  $$batinclude '6.Report_Writing/report_writing.gms' "'SST_FH+BA'"



model TechnoSST_FH_Bonus /
  e_profit
  e_totProfit
  e_obje
*crop_protection.gms
  e_cropTechnoPlot1
  e_cropTechnoPlot2
  e_scenSST_FH_Bonus
  e_dcPestiTechno
  e_SprayerTechno
  e_deprecTechnoTime
  e_deprecTechnoHa
  e_interestTechno
  e_fixCostsPestiTechno
  e_varCostsPestiTechno
*crop_rotation.gms
  e_maxShares
  e_oneCropPlot
*fertilizer_ordinance.gms
  e_manureUse
  e_man_balance
  e_170_avg
*gaec.gms
  e_preCropSeq_1
  e_preCropSeq_2
  e_gaec7_1
  e_gaec7_2
  e_gaec8
*labour.gms
  e_labReq
/;

solve TechnoSST_FH_Bonus using MIP maximizing v_obje;
  $$batinclude '6.Report_Writing/report_writing.gms' "'SST_FH+Bonus'"



model TechnoSST_FH_Bonus_BA /
  e_profit
  e_totProfit
  e_obje
*crop_protection.gms
  e_cropTechnoPlot1
  e_cropTechnoPlot2
  e_cropTechnoPlot3
  e_scenSST_FH_Bonus_BA
  e_dcPestiTechno
  e_SprayerTechno
  e_deprecTechnoTime
  e_deprecTechnoHa
  e_interestTechno
  e_fixCostsPestiTechno
  e_varCostsPestiTechno
*crop_rotation.gms
  e_maxShares
  e_oneCropPlot
*fertilizer_ordinance.gms
  e_manureUse
  e_man_balance
  e_170_avg
*gaec.gms
  e_preCropSeq_1
  e_preCropSeq_2
  e_gaec7_1
  e_gaec7_2
  e_gaec8
*labour.gms
  e_labReq
/;

solve TechnoSST_FH_Bonus_BA using MIP maximizing v_obje;
  $$batinclude '6.Report_Writing/report_writing.gms' "'SST_FH+Bonus+BA'"

$offtext

option
  arabLandUsed:1:3:1
  crops_year_report:1:4:1
  annProfitAvg:1:3:1
;

display p_totArabLand, arabLandUsed, crops_year_report, annProfitAvg;

option
 numberSprayer:1:4:1
 labCostsSprayerAvg:1:3:1
 deprecSprayerAvg:1:4:1
 yearsSprayerUsedAvg:1:4:1
 dcPestiAvg:1:3:1
 varCostsSprayerAvg:1:3:1
 fixCostsSprayerAvg:1:3:1
;

display numberSprayer, labCostsSprayerAvg, deprecSprayerAvg, yearsSprayerUsedAvg,
  dcPestiAvg, varCostsSprayerAvg, fixCostsSprayerAvg;