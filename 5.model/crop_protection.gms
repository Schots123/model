*
* --- Pivotal module for spraying technologies
*

equation
    e_CropSprayerPlot(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance) Links crop allocation decision with sprayer decision
    e_SST_BA_AdoptionStrategy(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario) Links BA Sprayer and SST Sprayer to adoption strategy with both sprayer types 
;

*
* --- Linking binary variables for crop management decision with binary variable for technology allocation
*
e_cropSprayerPlot(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance)
    $ (
        curPlots_ktblSize(curPlots,KTBL_size)
        AND curPlots_ktblDistance(curPlots,KTBL_distance)
        AND curPlots_ktblYield(curPlots,KTBL_yield)
        AND ktblCrops_KtblYield(curCrops,KTBL_yield)
    )..
    sum((technology,scenario,scenSprayer) $ (p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)),
        v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
*following condition necessary because if additional BA sprayer is used, at least 1 passage has to be defined to ensure
*that the model has to buy the sprayer (in e_sprayerFieldDays)
        $ (sum((pestType,halfMonth),
            p_sprayerPassagesMonth(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType,halfMonth)) gt 0)
    ) 
*following part is required for scenarios, where pesticide treatments are split up between BA sprayer and SST
    - sum((technology,scenario,spotSprayer)
        $ (
            p_technology_scenario_scenSprayer(technology,scenario,spotSprayer)
            AND ((sameas(scenario,"FH")) OR (sameas(scenario,"FH+Bonus")))
            AND (sameas(technology,spotSprayer))
        ),
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,spotSprayer)
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
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    )
;

*
* --- Following equation only for scenarios where not all pesticides are applied with SST
* -- ensures that the BA sprayer and the SST are used for their defined treatments
e_SST_BA_AdoptionStrategy(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario)
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
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,BASprayer)
    )
    =E=
    sum(spotSprayer
        $ (
            p_technology_scenario_scenSprayer(technology,scenario,spotSprayer)
        ),
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,spotSprayer)
    )
;


*
*  --- 2. Part: Technology Integration and equations to calulate associated direct costs and variable and 
*       fix machine costs for spot sprayers 

positive variable v_dcPesti;

equation e_dcPestiSprayer;

*
*  --- Calculation of direct costs for plant protection products 
*
e_dcPestiSprayer..
*die Summe der Direktkosten für Pflanzenschutzmittel für die unterschiedlichen möglichen Technologien bei Berücksichtigung des
*Einsparpotenzials soll gleich sein mit den Kosten, die in der Baseline anfallen würden
*p_techPestType ist definiert, um einzelne Pflanzenschutzmittelanwendungen der Technologie hinzuzuschalten als Möglichkeit oder abzuschalten
    v_dcPesti
    =E=
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
        $ (
            curPlots_ktblSize(curPlots,KTBL_size) 
            AND curPlots_ktblDistance(curPlots,KTBL_distance)
            AND curPlots_ktblYield(curPlots,KTBL_yield)
            AND ktblCrops_KtblYield(curCrops,KTBL_yield)
            AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
            AND (sameas(technology,scenSprayer) OR (sameas(technology,"baseline")))
        ),    
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
        * p_plotData(curPlots,"size") * farmSizeVar
        * sum(pestType, 
            p_sprayInputCosts(curCrops,KTBL_yield,pestType) 
            * (1 - p_technoPestEff(curCrops,technology,scenario,pestType))
        )
    ) * pestPriceVar
;



*
*  --- Depreciation calculations of technologies 
*
positive variables
    v_deprecSprayer(scenSprayer)
    v_interestSprayer(scenSprayer)
    v_otherCostsSprayer(scenSprayer)
;

integer variables 
    v_numberSprayer(scenSprayer)
;

equations 
    e_sprayerFieldDays(scenSprayer,halfMonth)
    e_sprayerFieldDaysHalf(scenSprayer,halfMonth)
    e_deprecTimeSprayer(scenSprayer)
    e_deprecHaSprayer(scenSprayer)
    e_interestSprayer(scenSprayer)
    e_otherCostsSprayer(scenSprayer)
;

*Here, all 24 hours are availabe (if SSPAs can only be applied on day, the BAs could theoretically be carriout out over night)
e_sprayerFieldDays(scenSprayer,halfMonth)..
    v_numberSprayer(scenSprayer) * fieldDays(halfMonth)
    =G=
    (sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,pestType)
        $ (
            curPlots_ktblSize(curPlots,KTBL_size) 
            AND curPlots_ktblDistance(curPlots,KTBL_distance)
            AND curPlots_ktblYield(curPlots,KTBL_yield) 
            AND ktblCrops_KtblYield(curCrops,KTBL_yield)
            AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
            AND (not(sprayerScenHalfFieldDays(technology,scenario,pestType)))
        ),      
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
        * p_plotData(curPlots,"size") * farmSizeVar
        * p_sprayerPassagesMonth(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType,halfMonth)
        * passageVar(technology,scenario,pestType)
        * p_technoTimeReq(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) 
        * timeReqVar(technology,scenario,scenSprayer,pestType)
        
    ) 
    + sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,pestType)
        $ (
            curPlots_ktblSize(curPlots,KTBL_size) 
            AND curPlots_ktblDistance(curPlots,KTBL_distance)
            AND curPlots_ktblYield(curPlots,KTBL_yield) 
            AND ktblCrops_KtblYield(curCrops,KTBL_yield)
            AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
            AND sprayerScenHalfFieldDays(technology,scenario,pestType)
        ),      
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
        * p_plotData(curPlots,"size") * farmSizeVar
        * p_sprayerPassagesMonth(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType,halfMonth)
        * passageVar(technology,scenario,pestType)
        * p_technoTimeReq(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) 
        * timeReqVar(technology,scenario,scenSprayer,pestType)
    )) / 24
;

*SSPAs with SSTs require favorable light conditions for spraying - it is assumed that SST_27m can only utilize half of the available spraying days
e_sprayerFieldDaysHalf(scenSprayer,halfMonth) $ sprayerHalfFieldDays(scenSprayer)..
    v_numberSprayer(scenSprayer) * fieldDays(halfMonth) / 2
    =G=
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,pestType)
        $ (
            curPlots_ktblSize(curPlots,KTBL_size) 
            AND curPlots_ktblDistance(curPlots,KTBL_distance)
            AND curPlots_ktblYield(curPlots,KTBL_yield) 
            AND ktblCrops_KtblYield(curCrops,KTBL_yield)
            AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
            AND sprayerScenHalfFieldDays(technology,scenario,pestType)
        ),      
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
        * p_plotData(curPlots,"size") * farmSizeVar
        * p_sprayerPassagesMonth(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType,halfMonth)
        * passageVar(technology,scenario,pestType)
        * p_technoTimeReq(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) 
        * timeReqVar(technology,scenario,scenSprayer,pestType)
    ) / 24
;


*
* --- Depreciation calculations - time based
*
e_deprecTimeSprayer(scenSprayer)..
    v_deprecSprayer(scenSprayer) 
    =E=
    v_numberSprayer(scenSprayer) 
    * ((p_technoValue(scenSprayer) - p_technoRemValue(scenSprayer)) * technoValueVar(scenSprayer))
    / p_technoLifetime(scenSprayer)
    + p_tractorDeprec(scenSprayer) * v_labReq(scenSprayer)
;


*
* --- interest for sprayers is calculated with residual method (KTBL)
*
e_interestSprayer(scenSprayer)..
    v_interestSprayer(scenSprayer) 
    =E=
    ((p_technoValue(scenSprayer) + p_technoRemValue(scenSprayer)) * technoValueVar(scenSprayer)) / 2 * 0.03
    * v_numberSprayer(scenSprayer)
    + p_tractorInterest(scenSprayer) * v_labReq(scenSprayer)
;

*
* --- other costs for sprayers is calculated as proportion of depreciation
*
e_otherCostsSprayer(scenSprayer)..
    v_otherCostsSprayer(scenSprayer)
    =E=
    (v_deprecSprayer(scenSprayer) - p_tractorDeprec(scenSprayer) * v_labReq(scenSprayer)) * 0.1
    + p_tractorOtherCosts(scenSprayer) * v_labReq(scenSprayer)
;

*
* --- Overall fixed costs for all sprayers used combined
* 
positive variables
    v_varCostsSprayer(scenSprayer)
    v_fixCostsSprayer(scenSprayer)
;

equations
    e_fixCostsPestiSprayer(scenSprayer)
    e_varCostsPestiSprayer(scenSprayer)
;

parameter p_annualFeeSST(scenSprayer) parameter only required in sensitivity analysis where the impact of an annual fee is evaluated;
p_annualFeeSST(scenSprayer) = 0;

e_fixCostsPestiSprayer(scenSprayer)..
    v_fixCostsSprayer(scenSprayer) =E=
        v_deprecSprayer(scenSprayer) 
        + v_interestSprayer(scenSprayer)
        + v_otherCostsSprayer(scenSprayer)
        + v_labReq(scenSprayer) * labPrice
        + v_numberSprayer(scenSprayer) * p_annualFeeSST(scenSprayer)
;

parameter p_algorithmCostsPerHa(technology,scenario,scenSprayer,pestType) parameter only important for sensitivity analysis where algorithm costs are considered;
p_algorithmCostsPerHa(technology,scenario,scenSprayer,pestType) = 0;

e_varCostsPestiSprayer(scenSprayer)..
    v_varCostsSprayer(scenSprayer)  =E= 
    sum((curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario)
        $ (
            curPlots_ktblSize(curPlots,KTBL_size) 
            AND curPlots_ktblDistance(curPlots,KTBL_distance)
            AND curPlots_ktblYield(curPlots,KTBL_yield) 
            AND p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
        ), 
*fuel costs for spraying operation
    v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
        * p_plotData(curPlots,"size") * farmSizeVar
        * sum((pestType,halfMonth),
            p_sprayerPassagesMonth(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType,halfMonth)
            * passageVar(technology,scenario,pestType)
            * (
                p_technoFuelCons(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) 
                    * newFuelPrice 
                + p_technoFuelCons(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType)
                    * newFuelPrice 
                    * (3/12) * 0.03
            )
            * fuelConsVar(technology,scenario,scenSprayer,pestType)
        )
*reapir costs for spraying operation
    + v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
        * p_plotData(curPlots,"size") * farmSizeVar
        * sum((pestType,halfMonth),
            p_sprayerPassagesMonth(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType,halfMonth)
            * passageVar(technology,scenario,pestType)
            * (
                p_technoMaintenance(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) 
                + p_technoMaintenance(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) * (3/12) * 0.03
            )
            * repairCostsVar(scenSprayer)
        )
*algorithm costs for sensitivity analysis
    + v_binPlotTechno(curPlots,curCrops,KTBL_size,KTBL_yield,KTBL_distance,technology,scenario,scenSprayer)
        * p_plotData(curPlots,"size") * farmSizeVar
        * sum((pestType,halfMonth),
            p_sprayerPassagesMonth(curCrops,KTBL_yield,technology,scenario,scenSprayer,pestType,halfMonth)
            * passageVar(technology,scenario,pestType)
            * p_algorithmCostsPerHa(technology,scenario,scenSprayer,pestType)
        )
    )
;