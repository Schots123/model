
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
    sum((technology,scenario,scenSprayer) 
    $ (p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)),
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
        AND ((sameas(scenario,"FH")) OR (sameas(scenario,"FH+Bonus")))
*following condition required because otherwise the sum over v_binPlotTechno for the respective scenarios would be 2 and the result
*of the right hand side would be 3
        AND (sameas(technology,scenSprayer))
    ),
        v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
    )
;

*
* --- Following equation only for scenarios where not all pesticides are applied with SST
* -- ensures that the BA sprayer and the SST are used for their defined treatments
e_cropTechnoPlot2(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size)
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
        AND p_technology_scenario(technology,scenario)
        AND ((sameas(scenario,"FH")) OR (sameas(scenario,"FH+Bonus")))
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
* --- Following equation required to ensure that on all plots the same scenario is assumed 
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
        - (v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,"FH",scenSprayer,years) * (1/2)) 
        $ ((sameas(scenario,"FH")) OR (sameas(scenario,"FH+Bonus")))
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
            * p_plotData(curPlots,'size') * sizeFactor
            * sum(pestType, 
                p_sprayInputCosts(curCrops,KTBL_yield,pestType) 
                * (1 - p_technoPestEff(curCrops,technology,scenario,pestType))
            )
    )
;

*
*  --- Depreciation calculations of technologies 
*

positive variables
    v_deprecSprayer(scenSprayer,years)
    v_interestSprayer(scenSprayer,years)
;

integer variables 
    v_numberSprayer(scenSprayer)
;

equations 
    e_SprayerTechno(scenSprayer,halfMonth)
    e_deprecTechnoTime(scenSprayer,years)
    e_deprecTechnoHa(scenSprayer,years)
    e_interestTechno(scenSprayer,years)
*    e_otherCostsTechno(scenSprayer,years)
;

e_sprayerTechno(scenSprayer,halfMonth)..
    v_numberSprayer(scenSprayer) 
    * fieldDays(halfMonth) * p_technoFieldDayHours(scenSprayer)
    =G=
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND p_technology_scenario(technology,scenario)
    ),      
        v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
            * p_plotData(curPlots,'size') * sizeFactor
            * p_datePestOpTechno(curCrops,KTBL_yield,technology,scenario,scenSprayer,halfMonth)
            * p_technoTimeReq(scenSprayer,KTBL_size,curMechan,KTBL_distance)
    ) 
    / card(years)
;

*
* --- Depreciation calculations - either time or hectare based
*

e_deprecTechnoTime(scenSprayer,years)..
    v_deprecSprayer(scenSprayer,years) 
    =G=
    sum(curMechan,
        v_numberSprayer(scenSprayer) 
            * (p_technoValue(scenSprayer,curMechan) - p_technoRemValue(scenSprayer,curMechan)) 
        / p_technoLifetime(scenSprayer)
    )
;

e_deprecTechnoHa(scenSprayer,years)..
    v_deprecSprayer(scenSprayer,years) 
    =G=
    sum(curMechan,
        ((p_technoValue(scenSprayer,curMechan) - p_technoRemValue(scenSprayer,curMechan)) 
        / p_technoAreaCapac(scenSprayer,curMechan))
    )
    * sum((curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND p_technology_scenario(technology,scenario)
    ),       
        v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
            * p_plotData(curPlots,'size') * sizeFactor
*            * p_numberSprayPassesScenarios(curCrops,KTBL_yield,technology,scenario,scenSprayer)
    )
;

*
* --- interest for sprayers is calculated with remaining value technique (KTBL)
*

e_interestTechno(scenSprayer,years)..
    v_interestSprayer(scenSprayer,years) 
    =E=
    sum(curMechan,
        ((p_technoValue(scenSprayer,curMechan) + p_technoRemValue(scenSprayer,curMechan)) /2 * 0.03) 
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
            * p_plotData(curPlots,'size') * sizeFactor
            * p_numberSprayPassesScenarios(curCrops,KTBL_yield,technology,scenario,scenSprayer)
            * p_technoFuelCons(scenSprayer,KTBL_size,curMechan,KTBL_distance) 
            * newFuelPrice
        + v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,curMechan,KTBL_distance,technology,scenario,scenSprayer,years)
            * p_plotData(curPlots,'size') * sizeFactor
            * p_numberSprayPassesScenarios(curCrops,KTBL_yield,technology,scenario,scenSprayer)
            * p_technoMaintenance(scenSprayer,KTBL_size,curMechan,KTBL_distance)
    )
;