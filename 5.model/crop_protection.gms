
$ontext
parameter p_ktbl_workingStepsBroadcast(KTBL_size,KTBL_mechanisation,KTBL_distance,workingStepsEle);

*load in ktbl Data for variable and fix machine costs of pesticide application operations with broadcast technology
$Gdxin 2.ktblData/gdxFiles/KTBL_WorkingStepsBroadcast.gdx
$load p_ktbl_workingStepsBroadcast=p_ktbl_workingStepsBroadcast
*option p_ktbl_workingStepsBroadcast:1:3:1 display p_ktbl_workingStepsBroadcast;

*$include '4.CropProtectionData/broadcastData.gms'
$offtext

equation
    e_CropTechnoPlot1(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,years)
    e_cropTechnoPlot2(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,years)
*    e_cropTechnoPlot3
;


*
* --- Linking binary variables for crop management decision with binary variable for technology allocation
*
e_cropTechnoPlot1(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size)
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
    )..
    sum((technology,scenario,scenSprayer) 
    $ (p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)),
        v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
    ) 
    =E=
    sum((KTBL_system,curMechan)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance) 
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
        AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    ),
        v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
    )
*following part is required for scenarios, where pesticide treatments are split up between BA sprayer and SST
*if v_binCropPlot is 1, the left hand side of the equation must be equal 2 in these scenarios
    + sum((technology,scenario,spotSprayer)
    $ (
        p_technology_scenario_scenSprayer(technology,scenario,spotSprayer)
        AND ((sameas(scenario,"FH")) OR (sameas(scenario,"FH+Bonus")))
*following condition required because otherwise the sum over v_binPlotTechno for the respective scenarios would be 2 and the result
*of the right hand side would be 3 instead of 2
        AND (sameas(technology,spotSprayer))
    ),
        v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,spotSprayer,years)
    )
;

*
* --- Following equation only for scenarios where not all pesticides are applied with SST
* -- ensures that the BA sprayer and the SST are used for their defined treatments
e_cropTechnoPlot2(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size)
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario(technology,scenario)
        AND ((sameas(scenario,"FH")) OR (sameas(scenario,"FH+Bonus")))
    )..
    sum(BASprayer
    $ (
        p_technology_scenario_scenSprayer(technology,scenario,BASprayer)
    ),
        v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,BASprayer,years)
    )
    =E=
    sum(spotSprayer
    $ (
        p_technology_scenario_scenSprayer(technology,scenario,spotSprayer)
    ),
        v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,spotSprayer,years)
    )
;

$ontext
ICH DENKE ICH KANN DIE FOLGENDE EQUATION LÖSCHEN! DADURCH IST AUCH GEWÄHRLEISTET, DASS IN DER THEORIE DIE SST NUR FÜR 
GEWISSE KULTUREN EINGESETZT WIRD 
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
        * (1/2) $ ((sameas(scenario,"FH")) OR (sameas(scenario,"FH+Bonus")))
*        * (1) $ ((sameas(scenario,"Base")) OR (sameas(scenario,"FH+BA")) OR (sameas(scenario,"FH+Bonus+BA")))
    ) 
    =E=
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size)
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
        AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
        AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    ),
        v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years)
    )
;
$offtext



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
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
        AND (sameas(technology,scenSprayer) OR (sameas(technology,"BA")))
    ),    
        v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
            * p_plotData(curPlots,"size") * farmSizeVar
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
    v_otherCostsSprayer(scenSprayer,years)
;

integer variables 
    v_numberSprayer(scenSprayer)
;

equations 
    e_SprayerTechno(scenSprayer,halfMonth)
    e_deprecTechnoTime(scenSprayer,years)
    e_deprecTechnoHa(scenSprayer,years)
    e_interestTechno(scenSprayer,years)
    e_otherCostsTechno(scenSprayer,years)
;

e_sprayerTechno(scenSprayer,halfMonth)..
    v_numberSprayer(scenSprayer) 
    * fieldDays(halfMonth) * p_technoFieldDayHours(scenSprayer)
    =G=
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,years)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
    ),      
        v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
            * p_plotData(curPlots,"size") * farmSizeVar
            * sum(pestType,
                p_datePestOpTechno(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType,halfMonth)
                * p_technoTimeReq(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) * timeReqVar(technology,scenario,scenSprayer,pestType)
            )
    ) 
    / card(years)
;

*
* --- Depreciation calculations - either time or hectare based
*
e_deprecTechnoTime(scenSprayer,years)..
    v_deprecSprayer(scenSprayer,years) 
    =G=
    v_numberSprayer(scenSprayer) 
    * ((p_technoValue(scenSprayer) - p_technoRemValue(scenSprayer)) * technoValueVar(scenSprayer))
    / p_technoLifetime(scenSprayer)
    + p_tractorDeprec(scenSprayer) * v_labReq(scenSprayer,years)
;

e_deprecTechnoHa(scenSprayer,years)..
    v_deprecSprayer(scenSprayer,years) 
    =G=
    ((p_technoValue(scenSprayer) - p_technoRemValue(scenSprayer)) * technoValueVar(scenSprayer)) 
    / p_technoAreaCapac(scenSprayer)
    * sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
    ),       
        v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
            * p_plotData(curPlots,"size") * farmSizeVar
*            * p_numberSprayPasScenTimeFuel(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType)
    )
    + p_tractorDeprec(scenSprayer) * v_labReq(scenSprayer,years)
;

*
* --- interest for sprayers is calculated with remaining value technique (KTBL)
*
e_interestTechno(scenSprayer,years)..
    v_interestSprayer(scenSprayer,years) 
    =E=
    ((p_technoValue(scenSprayer) + p_technoRemValue(scenSprayer)) * technoValueVar(scenSprayer)) / 2 * 0.03
    * v_numberSprayer(scenSprayer)
    + p_tractorInterest(scenSprayer) * v_labReq(scenSprayer,years)
;

*
* --- other costs for sprayers is calculated as proportion of depreciation
*
e_otherCostsTechno(scenSprayer,years)..
    v_otherCostsSprayer(scenSprayer,years)
    =E=
    v_deprecSprayer(scenSprayer,years) * 0.1
    + p_tractorOtherCosts(scenSprayer) * v_labReq(scenSprayer,years)
;

*
* --- Overall fixed costs for all sprayers used combined (other costs not included anymore?!)
* 
positive variables
    v_varCostsSprayer(scenSprayer,years)
    v_fixCostsSprayer(scenSprayer,years)
;

equations
    e_fixCostsPestiTechno(scenSprayer,years)
    e_varCostsPestiTechno(scenSprayer,years)
;

parameter p_annualFeeSST(scenSprayer) parameter only required in sensitivity analysis where the impact of an annual fee is evaluated;
p_annualFeeSST(scenSprayer) = 0;

e_fixCostsPestiTechno(scenSprayer,years)..
    v_fixCostsSprayer(scenSprayer,years) =E=
        v_deprecSprayer(scenSprayer,years) 
        + v_interestSprayer(scenSprayer,years)
        + v_otherCostsSprayer(scenSprayer,years)
        + p_annualFeeSST(scenSprayer)
;

parameter p_algorithmCostsPerHa(technology,scenario,scenSprayer,pestType) parameter only important for sensitivity analysis where algorithm costs are considered;
p_algorithmCostsPerHa(technology,scenario,scenSprayer,pestType) = 0;

e_varCostsPestiTechno(scenSprayer,years)..
    v_varCostsSprayer(scenSprayer,years)  =E= 
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size) 
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield) 
        AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
    ), 
        v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
            * p_plotData(curPlots,"size") * farmSizeVar
            * sum(pestType,
                p_numberSprayPasScenTimeFuel(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer,pestType)
                * p_technoFuelCons(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) 
                * fuelConsVar(technology,scenario,scenSprayer,pestType)
                * newFuelPrice 
            )
        + v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
            * p_plotData(curPlots,"size") * farmSizeVar
            * sum(pestType,
                p_numberSprayPasScenRepair(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer,pestType)
                * p_technoMaintenance(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) 
                * repairCostsVar(scenSprayer)
            )
*algorithm costs for sensitivity analysis
        + v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer,years)
            * p_plotData(curPlots,"size") * farmSizeVar
            * sum(pestType,
                p_numberSprayPassesScenarios(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType)
                * p_algorithmCostsPerHa(technology,scenario,scenSprayer,pestType)
            )
    )
    + v_labReq(scenSprayer,years) * labPrice
;