
$ontext
parameter p_ktbl_workingStepsBroadcast(KTBL_size,KTBL_mechanisation,KTBL_distance,workingStepsEle);

*load in ktbl Data for variable and fix machine costs of pesticide application operations with broadcast technology
$Gdxin 2.ktblData/gdxFiles/KTBL_WorkingStepsBroadcast.gdx
$load p_ktbl_workingStepsBroadcast=p_ktbl_workingStepsBroadcast
*option p_ktbl_workingStepsBroadcast:1:3:1 display p_ktbl_workingStepsBroadcast;

*$include '4.CropProtectionData/broadcastData.gms'
$offtext

Binary variable 
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,technology,scenario,scenSprayer,years)
;

equation
    e_CropTechnoPlot1(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,years)
    e_cropTechnoPlot2(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,technology,scenario,years)
    e_cropTechnoPlot3
;


*
* --- Linking binary variables for crop management decision with binary variable for technology allocation
*
e_cropTechnoPlot1(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size)
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
    )..
    sum((technology,scenario,scenSprayer) $ (p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)),
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    ) 
    =E=
    sum((manAmounts,KTBL_system)
    $ (
        ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
        AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
    )
*following part is required for scenarios, where pesticide treatments are split up between BA sprayer and SST
*left hand side of equation has to be equal 2 instead of 1 in that case 
    + sum((technology,scenario,scenSprayer)
    $ (
        p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
        AND (sameas(scenario,"FH"))
*following condition required because otherwise the sum over v_binPlotTechno for the respective scenarios would be 2 and the result
*of the right hand side would be 3
        AND (sameas(technology,scenSprayer))
    ),
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    )
;

*
* --- Following equation only for scenarios where not all pesticides are applied with SST or with BA sprayer
* -- ensures that the BA sprayer and the SST are used for their defined treatments
e_cropTechnoPlot2(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size)
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
        AND p_technology_scenario(technology,scenario)
        AND (sameas(scenario,"FH"))
    )..
    sum(scenSprayer 
    $ (
        p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
        AND (sameas(scenSprayer,"BA"))
    ),
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    )
    =E=
    sum(scenSprayer 
    $ (
        p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
        AND (not(sameas(scenSprayer,"BA")))
    ),
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    )
;

*
* --- Following equation required to ensure that on all plots the same scenario is used 
*
e_cropTechnoPlot3..
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size)
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
    ),
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    - (v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,"FH",scenSprayer,years) * (1/2)) $ (sameas(scenario,"FH"))
    )
    =E=
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size)
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
        AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
        AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
    )
;

*
* --- Assigning input costs for pesticides to each respective scenario
*
parameter p_pestiCostsScenarios(KTBL_crops,KTBL_yield,technology,scenario) input costs for pesticides for each scenario and crop per ha;

*pesticide input costs for baseline scenario are simply the costs defined through the spraying sequence
p_pestiCostsScenarios(curCrops,KTBL_yield,"BA","Base") 
    = sum(pestType,
        p_sprayInputCosts(curCrops,KTBL_yield,pestType))
;

*pesticide input costs for FH scenario are the reduced costs for foliar herbicides + the remaining pesticide input costs
p_pestiCostsScenarios(curCrops,KTBL_yield,technology,"FH") 
    $ (not(sameas(technology,"BA")))
    = p_sprayInputCosts(curCrops,KTBL_yield,"foliarHerb") * (1 - sum(curMechan, p_technoPestEff(technology,curMechan,"foliarHerb")))
    + sum(pestType $ (not(sameas(pestType,"foliarHerb"))),
        p_sprayInputCosts(curCrops,KTBL_yield,pestType))
;

*pesticide input costs  for FH+BA scenario are the same as in the FH scenario
p_pestiCostsScenarios(curCrops,KTBL_yield,technology,"FH+BA") $ (not(sameas(technology,"BA")))
    = sum(curMechan, 
        p_sprayInputCosts(curCrops,KTBL_yield,"foliarHerb") 
        * (1 - p_technoPestEff(technology,curMechan,"foliarHerb")))
    + sum(pestType $ (not(sameas(pestType,"foliarHerb"))),
        p_sprayInputCosts(curCrops,KTBL_yield,pestType))
;

*activate other scenarios later
$ontext
*pesticide input costs for FH+F+I scenario result from the reduced costs for foliar herbicides, insecticides (in row crops) and fungicides (in row crops)
*and the remaining costs for pesticides  
p_pestiCostsScenarios(curCrops,KTBL_yield,technology,"FH+F+I") $ (not(sameas(technology,"BA")))
    = sum(curMechan, 
        p_sprayInputCosts(curCrops,KTBL_yield,"foliarHerb") 
        * (1 - p_technoPestEff(technology,curMechan,"foliarHerb")))
*reduced spraying costs for insecticides and fungicides in row crops 
    + sum(curMechan, 
        p_sprayInputCosts(curRowCrops,KTBL_yield,"fung")
        * (1 - p_technoPestEff(technology,curMechan,"fung"))) 
    $ sameas(curCrops,curRowCrops)
    + sum(curMechan, 
        p_sprayInputCosts(curRowCrops,KTBL_yield,"insect")
        * (1 - p_technoPestEff(technology,curMechan,"insect"))) 
    $ sameas(curCrops,curRowCrops)
*spraying costs for insecticides and fungicides remain the same in non-row crops 
    + sum(curMechan, 
        p_sprayInputCosts(curRowCrops,KTBL_yield,"fung")
        * (1 - p_technoPestEff(technology,curMechan,"fung"))) 
    $ not(sameas(curCrops,curRowCrops))
    + sum(curMechan, 
        p_sprayInputCosts(curRowCrops,KTBL_yield,"insect")
        * (1 - p_technoPestEff(technology,curMechan,"insect"))) 
    $ not(sameas(curCrops,curRowCrops))
    + p_sprayInputCosts(curCrops,KTBL_yield,"growthReg")
    + p_sprayInputCosts(curCrops,KTBL_yield,"dessic")
;

*pesticide input costs  for FH+F+I+BA scenario are the same as in the FH+F+I scenario
p_pestiCostsScenarios(curCrops,KTBL_yield,technology,"FH+F+I+BA") $ not(sameas(technology,"BA"))
    = p_pestiCostsScenarios(curCrops,KTBL_yield,technology,"FH+F+I")
;
$offtext

option p_pestiCostsScenarios:1:3:1 display p_pestiCostsScenarios;

*
*  --- 2. Part: Technology Integration and equations to calulate associated direct costs and variable and 
*       fix machine costs for spot sprayers 

positive variable v_dcPesti(years);

equation e_dcPestiTechno(years);

*
*  --- Calculation of direct costs for plant protection products 
*

e_dcPestiTechno(years)..
*die Summe der Direktkosten für Pflanzenschutzmittel für die unterschiedlichen möglichen Technologien bei Berücksichtigung des
*Einsparpotenzials soll gleich sein mit den Kosten, die in der Baseline anfallen würden
*p_techPestType ist definiert, um einzelne Pflanzenschutzmittelanwendungen der Technologie hinzuzuschalten als Möglichkeit oder abzuschalten
    v_dcPesti(years)
    =E=
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
        AND p_numberSprayPassesScenarios(curCrops,KTBL_yield,technology,scenario,scenSprayer)
        AND sameas(technology,scenSprayer)
    ),    
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
        * p_plotData(curPlots,'size')
        * p_pestiCostsScenarios(curCrops,KTBL_yield,technology,scenario)
    )
;

*
*  --- Depreciation calculations of technologies 
*
scalar AnnualFieldDays / 52 /;

positive variables
    v_deprecSprayer(scenSprayer,years)
    v_interestSprayer(scenSprayer,years)
;

integer variables 
    v_numberSprayer(scenSprayer)
;

equations 
    e_SprayerTechno(scenSprayer)
    e_deprecTechnoTime(scenSprayer,years)
    e_deprecTechnoHa(scenSprayer,years)
    e_interestTechno(scenSprayer,years)
*    e_otherCostsTechno(scenSprayer,years)
;

e_sprayerTechno(scenSprayer)..
    sum(curMechan,
    v_numberSprayer(scenSprayer) * AnnualFieldDays * p_technoFieldDayHours(scenSprayer)) 
    =G=
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND p_technology_scenario(technology,scenario)
    ),      
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
        * p_plotData(curPlots,'size')
        * p_numberSprayPassesScenarios(curCrops,KTBL_yield,technology,scenario,scenSprayer)
        * p_technoTimeReq(scenSprayer,KTBL_size,curMechan,KTBL_distance)
    ) 
    / card(years)
;

*
* --- Depreciation calculations - either time or hectare based
*

e_deprecTechnoTime(scenSprayer,years)..
    v_deprecSprayer(scenSprayer,years) =G=
    sum(curMechan,
    v_numberSprayer(scenSprayer) 
    * (p_technoValue(scenSprayer,curMechan) - p_technoRemValue(scenSprayer,curMechan)) 
    / p_technoLifetime(scenSprayer)
    )
;

e_deprecTechnoHa(scenSprayer,years)..
    v_deprecSprayer(scenSprayer,years) =G=
    sum(curMechan,
    ((p_technoValue(scenSprayer,curMechan) - p_technoRemValue(scenSprayer,curMechan)) 
        / p_technoAreaCapac(scenSprayer,curMechan)))
    * sum((curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND p_technology_scenario(technology,scenario)
    ),       
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
        * p_plotData(curPlots,'size')
        * p_numberSprayPassesScenarios(curCrops,KTBL_yield,technology,scenario,scenSprayer)
    )
;

*
* --- interest for sprayers is calculated with remaining value technique (KTBL)
*

e_interestTechno(scenSprayer,years)..
    v_interestSprayer(scenSprayer,years) =E=
    sum(curMechan,
    ((p_technoValue(scenSprayer,curMechan) + p_technoRemValue(scenSprayer,curMechan))
    /2 * 0.03) 
    * v_numberSprayer(scenSprayer)
    )
;

*
* --- Overall fixed costs for all sprayers used combined (other costs not included anymore?!)
* 
positive variables
    v_varCostsSprayer(scenSprayer,years)
    v_fixCostsSprayer(years)
;

equations
    e_fixCostsPestiTechno(years)
    e_varCostsPestiTechno(scenSprayer,years)
;

e_fixCostsPestiTechno(years)..
    v_fixCostsSprayer(years) =E=
    sum(scenSprayer,
    v_deprecSprayer(scenSprayer,years) 
    + v_interestSprayer(scenSprayer,years)
    )
;

e_varCostsPestiTechno(scenSprayer,years)..
    v_varCostsSprayer(scenSprayer,years)  =E= 
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND p_technology_scenario(technology,scenario)
    ), 
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
        * p_plotData(curPlots,'size')
        * p_numberSprayPassesScenarios(curCrops,KTBL_yield,technology,scenario,scenSprayer)
        * p_technoFuelCons(scenSprayer,KTBL_size,curMechan,KTBL_distance) 
        * newFuelPrice
    + v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
        * p_plotData(curPlots,'size')
        * p_numberSprayPassesScenarios(curCrops,KTBL_yield,technology,scenario,scenSprayer)
        * p_technoMaintenance(scenSprayer,KTBL_size,curMechan,KTBL_distance)
    )
;