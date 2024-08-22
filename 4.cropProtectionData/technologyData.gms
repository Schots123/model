*
*  --- Sets with technologies and scenarios of interest for the study objective
*
set technology(allItems) /baseline, spot6m, spot27m/;
set SST(technology) /spot6m, spot27m/;

set scenSprayer(allItems) /spot6m, spot27m, BA_45kW, BA_67kW, BA_83kW, BA_102kW, BA_120kW, BA_200kW, BA_230kW/;
set BASprayer(scenSprayer) /BA_45kW, BA_67kW, BA_83kW, BA_102kW, BA_120kW, BA_200kW, BA_230kW/;
set spotSprayer(scenSprayer) /spot6m, spot27m/;
set spot6m_BASprayer(scenSprayer) /spot6m, BA_45kW, BA_67kW, BA_83kW, BA_102kW, BA_120kW, BA_200kW, BA_230kW/;
set spot27m_BASprayer(scenSprayer) /spot27m, BA_45kW, BA_67kW, BA_83kW, BA_102kW, BA_120kW, BA_200kW, BA_230kW/;

set scenario / 
    Base BA only with BA sprayer, 
    FH SS of foliar herbicides with SST and BA of remaining pesticides with BA sprayer
    FH+BA SS of foliar herbicides and BA of remaining pesticides with SST
    FH+Bonus SS of foliar herbicides fungicides insecticides and growth regulators with SST and BA of remaining pesticides with BA sprayer
    FH+Bonus+BA SS of foliar herbicides fungicides insecticides and growth regulators and BA of remaining pesticides with SST
    BA only BAs with SST
/;
set scenarioFH(scenario) scenarios if only foliar-active herbicides can be applied site-specifically /FH, FH+BA, BA/;
set scenarioFHBonus(scenario) scenarios for additional savings with other pesticide groups /FH+Bonus, FH+Bonus+BA, BA/;
set scenarioFHSavings(scenario) scenarios which are associated with SSPAs carried out with SSTs /FH, FH+BA/;
set scenarioFHBonusSavings(scenario) scenarios which are associated with SSPAs carried out with SSTs /FH+Bonus, FH+Bonus+BA/;

set sprayerHalfFieldDays(scenSprayer) spot sprayer which can only spray twelve hours per field working day /
    "spot27m" YES
/;

set sprayerScenHalfFieldDays(technology,scenario,pestType) pesticides applied site-specifically which can only be applied twelve hours /
    "spot27m"."FH".set.FH YES
    "spot27m"."FH+BA".set.FH YES
    "spot27m"."FH+Bonus".set.FHBonus YES
    "spot27m"."FH+Bonus+BA".set.FHBonus YES
/;

*the following three parameters are used to confine the possible solutions to the investigated scenarios 
parameters 
    p_technology_scenario(technology,scenario)
    p_scenario_scenSprayer(scenario,scenSprayer)
    p_technology_scenario_scenSprayer(technology,scenario,scenSprayer)
;

parameters
    p_technoValue(scenSprayer)
    p_technoRemValue(scenSprayer)
;

*techno value according to information from KTBL data and grey literature
p_technoValue("spot6m") = 130000;
p_technoValue("spot27m") = 207000;
p_technoValue("BA_45kW") = 15000;
p_technoValue("BA_67kW") = 22700;
p_technoValue("BA_83kW") = 30300;
p_technoValue("BA_102kW") = 36600;
p_technoValue("BA_120kW") = 51100;
p_technoValue("BA_200kW") = 58100;
p_technoValue("BA_230kW") = 71100;

*standard ktbl procedure for remaining technology value
p_technoRemValue(scenSprayer) 
    = p_technoValue(scenSprayer) * 0.2;


*fixec costs per working hour for tractor used to pull the sprayer according to maKost assuming full capacity exploitation(24.07.2024)
parameter p_tractorDeprec(scenSprayer) /
"spot6m" 3.56
"spot27m" 6.4
"BA_45kW" 3.56
"BA_67kW" 3.56
"BA_83kW" 5.2
"BA_102kW" 5.2
"BA_120kW" 5.2
"BA_200kW" 6.4
"BA_230kW" 6.4
/;
parameter p_tractorInterest(scenSprayer) /
"spot6m" 0.96
"spot27m" 1.73
"BA_45kW" 0.96
"BA_67kW" 0.96
"BA_83kW" 1.4
"BA_102kW" 1.4
"BA_120kW" 1.4
"BA_200kW" 1.73
"BA_230kW" 1.73
/;
parameter p_tractorOtherCosts(scenSprayer) /
"spot6m" 0.49
"spot27m" 0.93
"BA_45kW" 0.49
"BA_67kW" 0.49
"BA_83kW" 0.76
"BA_102kW" 0.76
"BA_120kW" 0.76
"BA_200kW" 0.93
"BA_230kW" 0.93
/;

parameter p_technoPestEff(KTBL_crops,technology,scenario,pestType) pesticide savings due to technology utilization for each type;

*pesticide efficiency block for SST
p_technoPestEff(KTBL_crops,technology,scenario,"soilHerb") $ (not(sameas(technology,"baseline"))) = 0;

p_technoPestEff(KTBL_crops,technology,scenario,"foliarHerb") 
    $ (
        (sameas(technology,"spot6m")) 
        AND ((not(sameas(scenario,"Base"))) AND (not(sameas(scenario,"BA"))))
    ) 
    = 0.7;
p_technoPestEff(KTBL_crops,technology,scenario,"foliarHerb") 
    $ (
        (sameas(technology,"spot27m")) 
        AND ((not(sameas(scenario,"Base"))) AND (not(sameas(scenario,"BA"))))
    ) 
    = 0.6;

p_technoPestEff(KTBL_rowCrops,technology,scenario,addSavings) 
    $ (
        (sameas(technology,"spot6m"))
        AND ((sameas(scenario,"FH+Bonus")) OR (sameas(scenario,"FH+Bonus+BA")))
    )
    = 0.4;
p_technoPestEff(KTBL_nonRowCrops,technology,scenario,addSavings) 
    $ (
        (sameas(technology,"spot6m"))
        AND ((sameas(scenario,"FH+Bonus")) OR (sameas(scenario,"FH+Bonus+BA")))
    ) 
    = 0.3;
p_technoPestEff(KTBL_crops,technology,scenario,addSavings) 
    $ (
        (sameas(technology,"spot27m"))
        AND ((sameas(scenario,"FH+Bonus")) OR (sameas(scenario,"FH+Bonus+BA")))
    ) 
    = 0.3;

p_technoPestEff(KTBL_crops,technology,scenario,"dessic") $ (not(sameas(technology,"baseline"))) = 0;


parameter p_technoLifetime(scenSprayer);
p_technoLifetime(scenSprayer) = 10;


*parameter p_technoAreaCapac(scenSprayer);
*
**standard KTBL procedure
*p_technoAreaCapac("BA_45kW") = 4800;
*p_technoAreaCapac("BA_67kW") = 6000;
*p_technoAreaCapac("BA_83kW") = 7200;
*p_technoAreaCapac("BA_102kW") = 9600;
*p_technoAreaCapac("BA_120kW") = 9600;
*p_technoAreaCapac("BA_200kW") = 9600;
*p_technoAreaCapac("BA_230kW") = 14400;
**sprayer for mechanization level of 45 kW has boom width of 12m (makost 17.05.2024)
*p_technoAreaCapac("spot6m") = p_technoAreaCapac("BA_45kW")/2;
**KTBL value for 27m sprayer (makost 17.05.2024)
*p_technoAreaCapac("spot27m") = 10800;



*
*  --- parameters for time requirements, other costs and variable costs 
*
parameters
    p_technoTimeReq(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType)
    p_technoFuelCons(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType)
    p_technoMaintenance(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType)
;

*
* --- Parameters for BA technology 
*
*p_technoTimeReq(KTBL_size,KTBL_mechanisation,KTBL_distance) = p_ktbl_workingStepsBroadcast(KTBL_size,"45",KTBL_distance,"time") * 2;
*sprayer is reportedly able to spray between 2.5 and 4 ha in an hour

* --- data source: KTBL-Feldarbeitsrechner: 24.06.2024

*45 kW tractor used, 300 l/ha
p_technoTimeReq("1","1",scenario,"BA_45kW",pestType) = 0.43;
p_technoFuelCons("1","1",scenario,"BA_45kW",pestType) = 1.27;
p_technoMaintenance("1","1",scenario,"BA_45kW",pestType) = 4.31;
p_technoTimeReq("1","2",scenario,"BA_45kW",pestType) = 0.46;
p_technoFuelCons("1","2",scenario,"BA_45kW",pestType) = 1.36;
p_technoMaintenance("1","2",scenario,"BA_45kW",pestType) = 4.46;
p_technoTimeReq("1","3",scenario,"BA_45kW",pestType) = 0.5;
p_technoFuelCons("1","3",scenario,"BA_45kW",pestType) = 1.45;
p_technoMaintenance("1","3",scenario,"BA_45kW",pestType) = 4.59;
p_technoTimeReq("1","4",scenario,"BA_45kW",pestType) = 0.53;
p_technoFuelCons("1","4",scenario,"BA_45kW",pestType) = 1.54;
p_technoMaintenance("1","4",scenario,"BA_45kW",pestType) = 4.71;
p_technoTimeReq("1","5",scenario,"BA_45kW",pestType) = 0.56;
p_technoFuelCons("1","5",scenario,"BA_45kW",pestType) = 1.63;
p_technoMaintenance("1","5",scenario,"BA_45kW",pestType) = 4.83;
p_technoTimeReq("1","10",scenario,"BA_45kW",pestType) = 0.7;
p_technoFuelCons("1","10",scenario,"BA_45kW",pestType) = 2.09;
p_technoMaintenance("1","10",scenario,"BA_45kW",pestType) = 5.41;
p_technoTimeReq("1","15",scenario,"BA_45kW",pestType) = 0.85;
p_technoFuelCons("1","15",scenario,"BA_45kW",pestType) = 2.57;
p_technoMaintenance("1","15",scenario,"BA_45kW",pestType) = 6.0;

p_technoTimeReq("2","1",scenario,"BA_45kW",pestType) = 0.35;
p_technoFuelCons("2","1",scenario,"BA_45kW",pestType) = 1.12;
p_technoMaintenance("2","1",scenario,"BA_45kW",pestType) = 4.0;
p_technoTimeReq("2","2",scenario,"BA_45kW",pestType) = 0.39;
p_technoFuelCons("2","2",scenario,"BA_45kW",pestType) = 1.21;
p_technoMaintenance("2","2",scenario,"BA_45kW",pestType) = 4.14;
p_technoTimeReq("2","3",scenario,"BA_45kW",pestType) = 0.42;
p_technoFuelCons("2","3",scenario,"BA_45kW",pestType) = 1.3;
p_technoMaintenance("2","3",scenario,"BA_45kW",pestType) = 4.27;
p_technoTimeReq("2","4",scenario,"BA_45kW",pestType) = 0.45;
p_technoFuelCons("2","4",scenario,"BA_45kW",pestType) = 1.39;
p_technoMaintenance("2","4",scenario,"BA_45kW",pestType) = 4.4;
p_technoTimeReq("2","5",scenario,"BA_45kW",pestType) = 0.48;
p_technoFuelCons("2","5",scenario,"BA_45kW",pestType) = 1.48;
p_technoMaintenance("2","5",scenario,"BA_45kW",pestType) = 4.51;
p_technoTimeReq("2","10",scenario,"BA_45kW",pestType) = 0.63;
p_technoFuelCons("2","10",scenario,"BA_45kW",pestType) = 1.94;
p_technoMaintenance("2","10",scenario,"BA_45kW",pestType) = 5.1;
p_technoTimeReq("2","15",scenario,"BA_45kW",pestType) = 0.78;
p_technoFuelCons("2","15",scenario,"BA_45kW",pestType) = 2.41;
p_technoMaintenance("2","15",scenario,"BA_45kW",pestType) = 5.69;

p_technoTimeReq("5","1",scenario,"BA_45kW",pestType) = 0.37;
p_technoFuelCons("5","1",scenario,"BA_45kW",pestType) = 1.2;
p_technoMaintenance("5","1",scenario,"BA_45kW",pestType) = 4.08;
p_technoTimeReq("5","2",scenario,"BA_45kW",pestType) = 0.4;
p_technoFuelCons("5","2",scenario,"BA_45kW",pestType) = 1.29;
p_technoMaintenance("5","2",scenario,"BA_45kW",pestType) = 4.21;
p_technoTimeReq("5","3",scenario,"BA_45kW",pestType) = 0.44;
p_technoFuelCons("5","3",scenario,"BA_45kW",pestType) = 1.38;
p_technoMaintenance("5","3",scenario,"BA_45kW",pestType) = 4.34;
p_technoTimeReq("5","4",scenario,"BA_45kW",pestType) = 0.47;
p_technoFuelCons("5","4",scenario,"BA_45kW",pestType) = 1.47;
p_technoMaintenance("5","4",scenario,"BA_45kW",pestType) = 4.47;
p_technoTimeReq("5","5",scenario,"BA_45kW",pestType) = 0.5;
p_technoFuelCons("5","5",scenario,"BA_45kW",pestType) = 1.56;
p_technoMaintenance("5","5",scenario,"BA_45kW",pestType) = 4.58;
p_technoTimeReq("5","10",scenario,"BA_45kW",pestType) = 0.64;
p_technoFuelCons("5","10",scenario,"BA_45kW",pestType) = 2.01;
p_technoMaintenance("5","10",scenario,"BA_45kW",pestType) = 5.16;
p_technoTimeReq("5","15",scenario,"BA_45kW",pestType) = 0.79;
p_technoFuelCons("5","15",scenario,"BA_45kW",pestType) = 2.49;
p_technoMaintenance("5","15",scenario,"BA_45kW",pestType) = 5.76;

p_technoTimeReq("10","1",scenario,"BA_45kW",pestType) = 0.34;
p_technoFuelCons("10","1",scenario,"BA_45kW",pestType) = 1.15;
p_technoMaintenance("10","1",scenario,"BA_45kW",pestType) = 3.97;
p_technoTimeReq("10","2",scenario,"BA_45kW",pestType) = 0.38;
p_technoFuelCons("10","2",scenario,"BA_45kW",pestType) = 1.24;
p_technoMaintenance("10","2",scenario,"BA_45kW",pestType) = 4.11;
p_technoTimeReq("10","3",scenario,"BA_45kW",pestType) = 0.41;
p_technoFuelCons("10","3",scenario,"BA_45kW",pestType) = 1.33;
p_technoMaintenance("10","3",scenario,"BA_45kW",pestType) = 4.24;
p_technoTimeReq("10","4",scenario,"BA_45kW",pestType) = 0.44;
p_technoFuelCons("10","4",scenario,"BA_45kW",pestType) = 1.42;
p_technoMaintenance("10","4",scenario,"BA_45kW",pestType) = 4.36;
p_technoTimeReq("10","5",scenario,"BA_45kW",pestType) = 0.47;
p_technoFuelCons("10","5",scenario,"BA_45kW",pestType) = 1.5;
p_technoMaintenance("10","5",scenario,"BA_45kW",pestType) = 4.48;
p_technoTimeReq("10","10",scenario,"BA_45kW",pestType) = 0.62;
p_technoFuelCons("10","10",scenario,"BA_45kW",pestType) = 1.96;
p_technoMaintenance("10","10",scenario,"BA_45kW",pestType) = 5.07;
p_technoTimeReq("10","15",scenario,"BA_45kW",pestType) = 0.77;
p_technoFuelCons("10","15",scenario,"BA_45kW",pestType) = 2.43;
p_technoMaintenance("10","15",scenario,"BA_45kW",pestType) = 5.66;

p_technoTimeReq("20","1",scenario,"BA_45kW",pestType) = 0.35;
p_technoFuelCons("20","1",scenario,"BA_45kW",pestType) = 1.19;
p_technoMaintenance("20","1",scenario,"BA_45kW",pestType) = 4.0;
p_technoTimeReq("20","2",scenario,"BA_45kW",pestType) = 0.39;
p_technoFuelCons("20","2",scenario,"BA_45kW",pestType) = 1.28;
p_technoMaintenance("20","2",scenario,"BA_45kW",pestType) = 4.14;
p_technoTimeReq("20","3",scenario,"BA_45kW",pestType) = 0.42;
p_technoFuelCons("20","3",scenario,"BA_45kW",pestType) = 1.37;
p_technoMaintenance("20","3",scenario,"BA_45kW",pestType) = 4.27;
p_technoTimeReq("20","4",scenario,"BA_45kW",pestType) = 0.45;
p_technoFuelCons("20","4",scenario,"BA_45kW",pestType) = 1.46;
p_technoMaintenance("20","4",scenario,"BA_45kW",pestType) = 4.39;
p_technoTimeReq("20","5",scenario,"BA_45kW",pestType) = 0.48;
p_technoFuelCons("20","5",scenario,"BA_45kW",pestType) = 1.55;
p_technoMaintenance("20","5",scenario,"BA_45kW",pestType) = 4.51;
p_technoTimeReq("20","10",scenario,"BA_45kW",pestType) = 0.62;
p_technoFuelCons("20","10",scenario,"BA_45kW",pestType) = 2.0;
p_technoMaintenance("20","10",scenario,"BA_45kW",pestType) = 5.1;
p_technoTimeReq("20","15",scenario,"BA_45kW",pestType) = 0.77;
p_technoFuelCons("20","15",scenario,"BA_45kW",pestType) = 2.48;
p_technoMaintenance("20","15",scenario,"BA_45kW",pestType) = 5.69;

p_technoTimeReq("40","1",scenario,"BA_45kW",pestType) = 0.36;
p_technoFuelCons("40","1",scenario,"BA_45kW",pestType) = 1.26;
p_technoMaintenance("40","1",scenario,"BA_45kW",pestType) = 4.05;
p_technoTimeReq("40","2",scenario,"BA_45kW",pestType) = 0.4;
p_technoFuelCons("40","2",scenario,"BA_45kW",pestType) = 1.35;
p_technoMaintenance("40","2",scenario,"BA_45kW",pestType) = 4.19;
p_technoTimeReq("40","3",scenario,"BA_45kW",pestType) = 0.43;
p_technoFuelCons("40","3",scenario,"BA_45kW",pestType) = 1.44;
p_technoMaintenance("40","3",scenario,"BA_45kW",pestType) = 4.33;
p_technoTimeReq("40","4",scenario,"BA_45kW",pestType) = 0.46;
p_technoFuelCons("40","4",scenario,"BA_45kW",pestType) = 1.53;
p_technoMaintenance("40","4",scenario,"BA_45kW",pestType) = 4.45;
p_technoTimeReq("40","5",scenario,"BA_45kW",pestType) = 0.49;
p_technoFuelCons("40","5",scenario,"BA_45kW",pestType) = 1.62;
p_technoMaintenance("40","5",scenario,"BA_45kW",pestType) = 4.56;
p_technoTimeReq("40","10",scenario,"BA_45kW",pestType) = 0.64;
p_technoFuelCons("40","10",scenario,"BA_45kW",pestType) = 2.08;
p_technoMaintenance("40","10",scenario,"BA_45kW",pestType) = 5.15;
p_technoTimeReq("40","15",scenario,"BA_45kW",pestType) = 0.79;
p_technoFuelCons("40","15",scenario,"BA_45kW",pestType) = 2.55;
p_technoMaintenance("40","15",scenario,"BA_45kW",pestType) = 5.74;

p_technoTimeReq("80","1",scenario,"BA_45kW",pestType) = 0.38;
p_technoFuelCons("80","1",scenario,"BA_45kW",pestType) = 1.36;
p_technoMaintenance("80","1",scenario,"BA_45kW",pestType) = 4.13;
p_technoTimeReq("80","2",scenario,"BA_45kW",pestType) = 0.42;
p_technoFuelCons("80","2",scenario,"BA_45kW",pestType) = 1.46;
p_technoMaintenance("80","2",scenario,"BA_45kW",pestType) = 4.28;
p_technoTimeReq("80","3",scenario,"BA_45kW",pestType) = 0.45;
p_technoFuelCons("80","3",scenario,"BA_45kW",pestType) = 1.55;
p_technoMaintenance("80","3",scenario,"BA_45kW",pestType) = 4.41;
p_technoTimeReq("80","4",scenario,"BA_45kW",pestType) = 0.48;
p_technoFuelCons("80","4",scenario,"BA_45kW",pestType) = 1.64;
p_technoMaintenance("80","4",scenario,"BA_45kW",pestType) = 4.53;
p_technoTimeReq("80","5",scenario,"BA_45kW",pestType) = 0.51;
p_technoFuelCons("80","5",scenario,"BA_45kW",pestType) = 1.72;
p_technoMaintenance("80","5",scenario,"BA_45kW",pestType) = 4.65;
p_technoTimeReq("80","10",scenario,"BA_45kW",pestType) = 0.66;
p_technoFuelCons("80","10",scenario,"BA_45kW",pestType) = 2.18;
p_technoMaintenance("80","10",scenario,"BA_45kW",pestType) = 5.23;
p_technoTimeReq("80","15",scenario,"BA_45kW",pestType) = 0.81;
p_technoFuelCons("80","15",scenario,"BA_45kW",pestType) = 2.66;
p_technoMaintenance("80","15",scenario,"BA_45kW",pestType) = 5.83;


*45 kW, 300 l/ha
p_technoTimeReq("1","1",scenario,"BA_67kW",pestType) = 0.37;
p_technoFuelCons("1","1",scenario,"BA_67kW",pestType) = 1.13;
p_technoMaintenance("1","1",scenario,"BA_67kW",pestType) = 4.07;
p_technoTimeReq("1","2",scenario,"BA_67kW",pestType) = 0.39;
p_technoFuelCons("1","2",scenario,"BA_67kW",pestType) = 1.19;
p_technoMaintenance("1","2",scenario,"BA_67kW",pestType) = 4.16;
p_technoTimeReq("1","3",scenario,"BA_67kW",pestType) = 0.41;
p_technoFuelCons("1","3",scenario,"BA_67kW",pestType) = 1.25;
p_technoMaintenance("1","3",scenario,"BA_67kW",pestType) = 4.24;
p_technoTimeReq("1","4",scenario,"BA_67kW",pestType) = 0.43;
p_technoFuelCons("1","4",scenario,"BA_67kW",pestType) = 1.31;
p_technoMaintenance("1","4",scenario,"BA_67kW",pestType) = 4.31;
p_technoTimeReq("1","5",scenario,"BA_67kW",pestType) = 0.44;
p_technoFuelCons("1","5",scenario,"BA_67kW",pestType) = 1.37;
p_technoMaintenance("1","5",scenario,"BA_67kW",pestType) = 4.38;
p_technoTimeReq("1","10",scenario,"BA_67kW",pestType) = 0.53;
p_technoFuelCons("1","10",scenario,"BA_67kW",pestType) = 1.67;
p_technoMaintenance("1","10",scenario,"BA_67kW",pestType) = 4.73;
p_technoTimeReq("1","15",scenario,"BA_67kW",pestType) = 0.62;
p_technoFuelCons("1","15",scenario,"BA_67kW",pestType) = 1.99;
p_technoMaintenance("1","15",scenario,"BA_67kW",pestType) = 5.08;

p_technoTimeReq("2","1",scenario,"BA_67kW",pestType) = 0.29;
p_technoFuelCons("2","1",scenario,"BA_67kW",pestType) = 0.96;
p_technoMaintenance("2","1",scenario,"BA_67kW",pestType) = 3.77;
p_technoTimeReq("2","2",scenario,"BA_67kW",pestType) = 0.32;
p_technoFuelCons("2","2",scenario,"BA_67kW",pestType) = 1.02;
p_technoMaintenance("2","2",scenario,"BA_67kW",pestType) = 3.85;
p_technoTimeReq("2","3",scenario,"BA_67kW",pestType) = 0.33;
p_technoFuelCons("2","3",scenario,"BA_67kW",pestType) = 1.08;
p_technoMaintenance("2","3",scenario,"BA_67kW",pestType) = 3.93;
p_technoTimeReq("2","4",scenario,"BA_67kW",pestType) = 0.35;
p_technoFuelCons("2","4",scenario,"BA_67kW",pestType) = 1.14;
p_technoMaintenance("2","4",scenario,"BA_67kW",pestType) = 4.0;
p_technoTimeReq("2","5",scenario,"BA_67kW",pestType) = 0.37;
p_technoFuelCons("2","5",scenario,"BA_67kW",pestType) = 1.19;
p_technoMaintenance("2","5",scenario,"BA_67kW",pestType) = 4.07;
p_technoTimeReq("2","10",scenario,"BA_67kW",pestType) = 0.46;
p_technoFuelCons("2","10",scenario,"BA_67kW",pestType) = 1.49;
p_technoMaintenance("2","10",scenario,"BA_67kW",pestType) = 4.42;
p_technoTimeReq("2","15",scenario,"BA_67kW",pestType) = 0.55;
p_technoFuelCons("2","15",scenario,"BA_67kW",pestType) = 1.8;
p_technoMaintenance("2","15",scenario,"BA_67kW",pestType) = 4.78;

p_technoTimeReq("5","1",scenario,"BA_67kW",pestType) = 0.27;
p_technoFuelCons("5","1",scenario,"BA_67kW",pestType) = 0.95;
p_technoMaintenance("5","1",scenario,"BA_67kW",pestType) = 3.69;
p_technoTimeReq("5","2",scenario,"BA_67kW",pestType) = 0.29;
p_technoFuelCons("5","2",scenario,"BA_67kW",pestType) = 1.01;
p_technoMaintenance("5","2",scenario,"BA_67kW",pestType) = 3.77;
p_technoTimeReq("5","3",scenario,"BA_67kW",pestType) = 0.31;
p_technoFuelCons("5","3",scenario,"BA_67kW",pestType) = 1.07;
p_technoMaintenance("5","3",scenario,"BA_67kW",pestType) = 3.85;
p_technoTimeReq("5","4",scenario,"BA_67kW",pestType) = 0.33;
p_technoFuelCons("5","4",scenario,"BA_67kW",pestType) = 1.13;
p_technoMaintenance("5","4",scenario,"BA_67kW",pestType) = 3.92;
p_technoTimeReq("5","5",scenario,"BA_67kW",pestType) = 0.35;
p_technoFuelCons("5","5",scenario,"BA_67kW",pestType) = 1.19;
p_technoMaintenance("5","5",scenario,"BA_67kW",pestType) = 4.0;
p_technoTimeReq("5","10",scenario,"BA_67kW",pestType) = 0.44;
p_technoFuelCons("5","10",scenario,"BA_67kW",pestType) = 1.48;
p_technoMaintenance("5","10",scenario,"BA_67kW",pestType) = 4.34;
p_technoTimeReq("5","15",scenario,"BA_67kW",pestType) = 0.53;
p_technoFuelCons("5","15",scenario,"BA_67kW",pestType) = 1.8;
p_technoMaintenance("5","15",scenario,"BA_67kW",pestType) = 4.71;

p_technoTimeReq("10","1",scenario,"BA_67kW",pestType) = 0.24;
p_technoFuelCons("10","1",scenario,"BA_67kW",pestType) = 0.88;
p_technoMaintenance("10","1",scenario,"BA_67kW",pestType) = 3.57;
p_technoTimeReq("10","2",scenario,"BA_67kW",pestType) = 0.27;
p_technoFuelCons("10","2",scenario,"BA_67kW",pestType) = 0.94;
p_technoMaintenance("10","2",scenario,"BA_67kW",pestType) = 3.66;
p_technoTimeReq("10","3",scenario,"BA_67kW",pestType) = 0.29;
p_technoFuelCons("10","3",scenario,"BA_67kW",pestType) = 1.0;
p_technoMaintenance("10","3",scenario,"BA_67kW",pestType) = 3.74;
p_technoTimeReq("10","4",scenario,"BA_67kW",pestType) = 0.3;
p_technoFuelCons("10","4",scenario,"BA_67kW",pestType) = 1.06;
p_technoMaintenance("10","4",scenario,"BA_67kW",pestType) = 3.81;
p_technoTimeReq("10","5",scenario,"BA_67kW",pestType) = 0.32;
p_technoFuelCons("10","5",scenario,"BA_67kW",pestType) = 1.12;
p_technoMaintenance("10","5",scenario,"BA_67kW",pestType) = 3.88;
p_technoTimeReq("10","10",scenario,"BA_67kW",pestType) = 0.41;
p_technoFuelCons("10","10",scenario,"BA_67kW",pestType) = 1.41;
p_technoMaintenance("10","10",scenario,"BA_67kW",pestType) = 4.23;
p_technoTimeReq("10","15",scenario,"BA_67kW",pestType) = 0.5;
p_technoFuelCons("10","15",scenario,"BA_67kW",pestType) = 1.72;
p_technoMaintenance("10","15",scenario,"BA_67kW",pestType) = 4.59;

p_technoTimeReq("20","1",scenario,"BA_67kW",pestType) = 0.25;
p_technoFuelCons("20","1",scenario,"BA_67kW",pestType) = 0.93;
p_technoMaintenance("20","1",scenario,"BA_67kW",pestType) = 3.6;
p_technoTimeReq("20","2",scenario,"BA_67kW",pestType) = 0.27;
p_technoFuelCons("20","2",scenario,"BA_67kW",pestType) = 0.99;
p_technoMaintenance("20","2",scenario,"BA_67kW",pestType) = 3.68;
p_technoTimeReq("20","3",scenario,"BA_67kW",pestType) = 0.29;
p_technoFuelCons("20","3",scenario,"BA_67kW",pestType) = 1.04;
p_technoMaintenance("20","3",scenario,"BA_67kW",pestType) = 3.76;
p_technoTimeReq("20","4",scenario,"BA_67kW",pestType) = 0.31;
p_technoFuelCons("20","4",scenario,"BA_67kW",pestType) = 1.1;
p_technoMaintenance("20","4",scenario,"BA_67kW",pestType) = 3.83;
p_technoTimeReq("20","5",scenario,"BA_67kW",pestType) = 0.33;
p_technoFuelCons("20","5",scenario,"BA_67kW",pestType) = 1.16;
p_technoMaintenance("20","5",scenario,"BA_67kW",pestType) = 3.91;
p_technoTimeReq("20","10",scenario,"BA_67kW",pestType) = 0.41;
p_technoFuelCons("20","10",scenario,"BA_67kW",pestType) = 1.45;
p_technoMaintenance("20","10",scenario,"BA_67kW",pestType) = 4.26;
p_technoTimeReq("20","15",scenario,"BA_67kW",pestType) = 0.5;
p_technoFuelCons("20","15",scenario,"BA_67kW",pestType) = 1.76;
p_technoMaintenance("20","15",scenario,"BA_67kW",pestType) = 4.61;

p_technoTimeReq("40","1",scenario,"BA_67kW",pestType) = 0.25;
p_technoFuelCons("40","1",scenario,"BA_67kW",pestType) = 0.95;
p_technoMaintenance("40","1",scenario,"BA_67kW",pestType) = 3.61;
p_technoTimeReq("40","2",scenario,"BA_67kW",pestType) = 0.27;
p_technoFuelCons("40","2",scenario,"BA_67kW",pestType) = 1.01;
p_technoMaintenance("40","2",scenario,"BA_67kW",pestType) = 3.7;
p_technoTimeReq("40","3",scenario,"BA_67kW",pestType) = 0.29;
p_technoFuelCons("40","3",scenario,"BA_67kW",pestType) = 1.07;
p_technoMaintenance("40","3",scenario,"BA_67kW",pestType) = 3.78;
p_technoTimeReq("40","4",scenario,"BA_67kW",pestType) = 0.31;
p_technoFuelCons("40","4",scenario,"BA_67kW",pestType) = 1.13;
p_technoMaintenance("40","4",scenario,"BA_67kW",pestType) = 3.85;
p_technoTimeReq("40","5",scenario,"BA_67kW",pestType) = 0.33;
p_technoFuelCons("40","5",scenario,"BA_67kW",pestType) = 1.18;
p_technoMaintenance("40","5",scenario,"BA_67kW",pestType) = 3.92;
p_technoTimeReq("40","10",scenario,"BA_67kW",pestType) = 0.42;
p_technoFuelCons("40","10",scenario,"BA_67kW",pestType) = 1.48;
p_technoMaintenance("40","10",scenario,"BA_67kW",pestType) = 4.27;
p_technoTimeReq("40","15",scenario,"BA_67kW",pestType) = 0.51;
p_technoFuelCons("40","15",scenario,"BA_67kW",pestType) = 1.79;
p_technoMaintenance("40","15",scenario,"BA_67kW",pestType) = 4.63;

p_technoTimeReq("80","1",scenario,"BA_67kW",pestType) = 0.27;
p_technoFuelCons("80","1",scenario,"BA_67kW",pestType) = 1.03;
p_technoMaintenance("80","1",scenario,"BA_67kW",pestType) = 3.67;
p_technoTimeReq("80","2",scenario,"BA_67kW",pestType) = 0.29;
p_technoFuelCons("80","2",scenario,"BA_67kW",pestType) = 1.09;
p_technoMaintenance("80","2",scenario,"BA_67kW",pestType) = 3.76;
p_technoTimeReq("80","3",scenario,"BA_67kW",pestType) = 0.31;
p_technoFuelCons("80","3",scenario,"BA_67kW",pestType) = 1.15;
p_technoMaintenance("80","3",scenario,"BA_67kW",pestType) = 3.83;
p_technoTimeReq("80","4",scenario,"BA_67kW",pestType) = 0.33;
p_technoFuelCons("80","4",scenario,"BA_67kW",pestType) = 1.2;
p_technoMaintenance("80","4",scenario,"BA_67kW",pestType) = 3.91;
p_technoTimeReq("80","5",scenario,"BA_67kW",pestType) = 0.34;
p_technoFuelCons("80","5",scenario,"BA_67kW",pestType) = 1.26;
p_technoMaintenance("80","5",scenario,"BA_67kW",pestType) = 3.98;
p_technoTimeReq("80","10",scenario,"BA_67kW",pestType) = 0.43;
p_technoFuelCons("80","10",scenario,"BA_67kW",pestType) = 1.56;
p_technoMaintenance("80","10",scenario,"BA_67kW",pestType) = 4.33;
p_technoTimeReq("80","15",scenario,"BA_67kW",pestType) = 0.52;
p_technoFuelCons("80","15",scenario,"BA_67kW",pestType) = 1.87;
p_technoMaintenance("80","15",scenario,"BA_67kW",pestType) = 4.69;


*18m, 1,500 l, 67 kW, 300 l/ha
p_technoTimeReq("1","1",scenario,"BA_83kW",pestType) = 0.31;
p_technoFuelCons("1","1",scenario,"BA_83kW",pestType) = 1.33;
p_technoMaintenance("1","1",scenario,"BA_83kW",pestType) = 4.49;
p_technoTimeReq("1","2",scenario,"BA_83kW",pestType) = 0.33;
p_technoFuelCons("1","2",scenario,"BA_83kW",pestType) = 1.39;
p_technoMaintenance("1","2",scenario,"BA_83kW",pestType) = 4.57;
p_technoTimeReq("1","3",scenario,"BA_83kW",pestType) = 0.34;
p_technoFuelCons("1","3",scenario,"BA_83kW",pestType) = 1.45;
p_technoMaintenance("1","3",scenario,"BA_83kW",pestType) = 4.65;
p_technoTimeReq("1","4",scenario,"BA_83kW",pestType) = 0.35;
p_technoFuelCons("1","4",scenario,"BA_83kW",pestType) = 1.51;
p_technoMaintenance("1","4",scenario,"BA_83kW",pestType) = 4.73;
p_technoTimeReq("1","5",scenario,"BA_83kW",pestType) = 0.37;
p_technoFuelCons("1","5",scenario,"BA_83kW",pestType) = 1.57;
p_technoMaintenance("1","5",scenario,"BA_83kW",pestType) = 4.79;
p_technoTimeReq("1","10",scenario,"BA_83kW",pestType) = 0.43;
p_technoFuelCons("1","10",scenario,"BA_83kW",pestType) = 1.87;
p_technoMaintenance("1","10",scenario,"BA_83kW",pestType) = 5.15;
p_technoTimeReq("1","15",scenario,"BA_83kW",pestType) = 0.48;
p_technoFuelCons("1","15",scenario,"BA_83kW",pestType) = 2.18;
p_technoMaintenance("1","15",scenario,"BA_83kW",pestType) = 5.51;

p_technoTimeReq("2","1",scenario,"BA_83kW",pestType) = 0.25;
p_technoFuelCons("2","1",scenario,"BA_83kW",pestType) = 1.12;
p_technoMaintenance("2","1",scenario,"BA_83kW",pestType) = 4.07;
p_technoTimeReq("2","2",scenario,"BA_83kW",pestType) = 0.26;
p_technoFuelCons("2","2",scenario,"BA_83kW",pestType) = 1.18;
p_technoMaintenance("2","2",scenario,"BA_83kW",pestType) = 4.16;
p_technoTimeReq("2","3",scenario,"BA_83kW",pestType) = 0.27;
p_technoFuelCons("2","3",scenario,"BA_83kW",pestType) = 1.24;
p_technoMaintenance("2","3",scenario,"BA_83kW",pestType) = 4.23;
p_technoTimeReq("2","4",scenario,"BA_83kW",pestType) = 0.29;
p_technoFuelCons("2","4",scenario,"BA_83kW",pestType) = 1.3;
p_technoMaintenance("2","4",scenario,"BA_83kW",pestType) = 4.31;
p_technoTimeReq("2","5",scenario,"BA_83kW",pestType) = 0.3;
p_technoFuelCons("2","5",scenario,"BA_83kW",pestType) = 1.35;
p_technoMaintenance("2","5",scenario,"BA_83kW",pestType) = 4.38;
p_technoTimeReq("2","10",scenario,"BA_83kW",pestType) = 0.36;
p_technoFuelCons("2","10",scenario,"BA_83kW",pestType) = 1.64;
p_technoMaintenance("2","10",scenario,"BA_83kW",pestType) = 4.73;
p_technoTimeReq("2","15",scenario,"BA_83kW",pestType) = 0.42;
p_technoFuelCons("2","15",scenario,"BA_83kW",pestType) = 1.95;
p_technoMaintenance("2","15",scenario,"BA_83kW",pestType) = 5.08;

p_technoTimeReq("5","1",scenario,"BA_83kW",pestType) = 0.18;
p_technoFuelCons("5","1",scenario,"BA_83kW",pestType) = 0.91;
p_technoMaintenance("5","1",scenario,"BA_83kW",pestType) = 3.68;
p_technoTimeReq("5","2",scenario,"BA_83kW",pestType) = 0.19;
p_technoFuelCons("5","2",scenario,"BA_83kW",pestType) = 0.97;
p_technoMaintenance("5","2",scenario,"BA_83kW",pestType) = 3.76;
p_technoTimeReq("5","3",scenario,"BA_83kW",pestType) = 0.21;
p_technoFuelCons("5","3",scenario,"BA_83kW",pestType) = 1.02;
p_technoMaintenance("5","3",scenario,"BA_83kW",pestType) = 3.84;
p_technoTimeReq("5","4",scenario,"BA_83kW",pestType) = 0.22;
p_technoFuelCons("5","4",scenario,"BA_83kW",pestType) = 1.08;
p_technoMaintenance("5","4",scenario,"BA_83kW",pestType) = 3.92;
p_technoTimeReq("5","5",scenario,"BA_83kW",pestType) = 0.23;
p_technoFuelCons("5","5",scenario,"BA_83kW",pestType) = 1.13;
p_technoMaintenance("5","5",scenario,"BA_83kW",pestType) = 3.99;
p_technoTimeReq("5","10",scenario,"BA_83kW",pestType) = 0.29;
p_technoFuelCons("5","10",scenario,"BA_83kW",pestType) = 1.42;
p_technoMaintenance("5","10",scenario,"BA_83kW",pestType) = 4.38;
p_technoTimeReq("5","15",scenario,"BA_83kW",pestType) = 0.35;
p_technoFuelCons("5","15",scenario,"BA_83kW",pestType) = 1.72;
p_technoMaintenance("5","15",scenario,"BA_83kW",pestType) = 4.7;

p_technoTimeReq("10","1",scenario,"BA_83kW",pestType) = 0.19;
p_technoFuelCons("10","1",scenario,"BA_83kW",pestType) = 0.98;
p_technoMaintenance("10","1",scenario,"BA_83kW",pestType) = 3.72;
p_technoTimeReq("10","2",scenario,"BA_83kW",pestType) = 0.2;
p_technoFuelCons("10","2",scenario,"BA_83kW",pestType) = 1.03;
p_technoMaintenance("10","2",scenario,"BA_83kW",pestType) = 3.8;
p_technoTimeReq("10","3",scenario,"BA_83kW",pestType) = 0.21;
p_technoFuelCons("10","3",scenario,"BA_83kW",pestType) = 1.09;
p_technoMaintenance("10","3",scenario,"BA_83kW",pestType) = 3.88;
p_technoTimeReq("10","4",scenario,"BA_83kW",pestType) = 0.23;
p_technoFuelCons("10","4",scenario,"BA_83kW",pestType) = 1.15;
p_technoMaintenance("10","4",scenario,"BA_83kW",pestType) = 3.96;
p_technoTimeReq("10","5",scenario,"BA_83kW",pestType) = 0.24;
p_technoFuelCons("10","5",scenario,"BA_83kW",pestType) = 1.2;
p_technoMaintenance("10","5",scenario,"BA_83kW",pestType) = 4.03;
p_technoTimeReq("10","10",scenario,"BA_83kW",pestType) = 0.3;
p_technoFuelCons("10","10",scenario,"BA_83kW",pestType) = 1.48;
p_technoMaintenance("10","10",scenario,"BA_83kW",pestType) = 4.38;
p_technoTimeReq("10","15",scenario,"BA_83kW",pestType) = 0.36;
p_technoFuelCons("10","15",scenario,"BA_83kW",pestType) = 1.78;
p_technoMaintenance("10","15",scenario,"BA_83kW",pestType) = 4.73;

p_technoTimeReq("20","1",scenario,"BA_83kW",pestType) = 0.19;
p_technoFuelCons("20","1",scenario,"BA_83kW",pestType) = 0.98;
p_technoMaintenance("20","1",scenario,"BA_83kW",pestType) = 3.71;
p_technoTimeReq("20","2",scenario,"BA_83kW",pestType) = 0.2;
p_technoFuelCons("20","2",scenario,"BA_83kW",pestType) = 1.04;
p_technoMaintenance("20","2",scenario,"BA_83kW",pestType) = 3.8;
p_technoTimeReq("20","3",scenario,"BA_83kW",pestType) = 0.21;
p_technoFuelCons("20","3",scenario,"BA_83kW",pestType) = 1.09;
p_technoMaintenance("20","3",scenario,"BA_83kW",pestType) = 3.88;
p_technoTimeReq("20","4",scenario,"BA_83kW",pestType) = 0.22;
p_technoFuelCons("20","4",scenario,"BA_83kW",pestType) = 1.15;
p_technoMaintenance("20","4",scenario,"BA_83kW",pestType) = 3.95;
p_technoTimeReq("20","5",scenario,"BA_83kW",pestType) = 0.24;
p_technoFuelCons("20","5",scenario,"BA_83kW",pestType) = 1.21;
p_technoMaintenance("20","5",scenario,"BA_83kW",pestType) = 4.02;
p_technoTimeReq("20","10",scenario,"BA_83kW",pestType) = 0.3;
p_technoFuelCons("20","10",scenario,"BA_83kW",pestType) = 1.49;
p_technoMaintenance("20","10",scenario,"BA_83kW",pestType) = 4.37;
p_technoTimeReq("20","15",scenario,"BA_83kW",pestType) = 0.35;
p_technoFuelCons("20","15",scenario,"BA_83kW",pestType) = 1.79;
p_technoMaintenance("20","15",scenario,"BA_83kW",pestType) = 4.73;

p_technoTimeReq("40","1",scenario,"BA_83kW",pestType) = 0.19;
p_technoFuelCons("40","1",scenario,"BA_83kW",pestType) = 1.01;
p_technoMaintenance("40","1",scenario,"BA_83kW",pestType) = 3.73;
p_technoTimeReq("40","2",scenario,"BA_83kW",pestType) = 0.2;
p_technoFuelCons("40","2",scenario,"BA_83kW",pestType) = 1.07;
p_technoMaintenance("40","2",scenario,"BA_83kW",pestType) = 3.81;
p_technoTimeReq("40","3",scenario,"BA_83kW",pestType) = 0.22;
p_technoFuelCons("40","3",scenario,"BA_83kW",pestType) = 1.12;
p_technoMaintenance("40","3",scenario,"BA_83kW",pestType) = 3.89;
p_technoTimeReq("40","4",scenario,"BA_83kW",pestType) = 0.23;
p_technoFuelCons("40","4",scenario,"BA_83kW",pestType) = 1.18;
p_technoMaintenance("40","4",scenario,"BA_83kW",pestType) = 3.97;
p_technoTimeReq("40","5",scenario,"BA_83kW",pestType) = 0.24;
p_technoFuelCons("40","5",scenario,"BA_83kW",pestType) = 1.24;
p_technoMaintenance("40","5",scenario,"BA_83kW",pestType) = 4.04;
p_technoTimeReq("40","10",scenario,"BA_83kW",pestType) = 0.3;
p_technoFuelCons("40","10",scenario,"BA_83kW",pestType) = 1.52;
p_technoMaintenance("40","10",scenario,"BA_83kW",pestType) = 4.39;
p_technoTimeReq("40","15",scenario,"BA_83kW",pestType) = 0.36;
p_technoFuelCons("40","15",scenario,"BA_83kW",pestType) = 1.82;
p_technoMaintenance("40","15",scenario,"BA_83kW",pestType) = 4.74;

p_technoTimeReq("80","1",scenario,"BA_83kW",pestType) = 0.2;
p_technoFuelCons("80","1",scenario,"BA_83kW",pestType) = 1.08;
p_technoMaintenance("80","1",scenario,"BA_83kW",pestType) = 3.79;
p_technoTimeReq("80","2",scenario,"BA_83kW",pestType) = 0.21;
p_technoFuelCons("80","2",scenario,"BA_83kW",pestType) = 1.14;
p_technoMaintenance("80","2",scenario,"BA_83kW",pestType) = 3.87;
p_technoTimeReq("80","3",scenario,"BA_83kW",pestType) = 0.23;
p_technoFuelCons("80","3",scenario,"BA_83kW",pestType) = 1.2;
p_technoMaintenance("80","3",scenario,"BA_83kW",pestType) = 3.95;
p_technoTimeReq("80","4",scenario,"BA_83kW",pestType) = 0.24;
p_technoFuelCons("80","4",scenario,"BA_83kW",pestType) = 1.26;
p_technoMaintenance("80","4",scenario,"BA_83kW",pestType) = 4.02;
p_technoTimeReq("80","5",scenario,"BA_83kW",pestType) = 0.25;
p_technoFuelCons("80","5",scenario,"BA_83kW",pestType) = 1.31;
p_technoMaintenance("80","5",scenario,"BA_83kW",pestType) = 4.09;
p_technoTimeReq("80","10",scenario,"BA_83kW",pestType) = 0.31;
p_technoFuelCons("80","10",scenario,"BA_83kW",pestType) = 1.6;
p_technoMaintenance("80","10",scenario,"BA_83kW",pestType) = 4.45;
p_technoTimeReq("80","15",scenario,"BA_83kW",pestType) = 0.37;
p_technoFuelCons("80","15",scenario,"BA_83kW",pestType) = 1.9;
p_technoMaintenance("80","15",scenario,"BA_83kW",pestType) = 4.8;


*24 m, 1,500 l, 67 kW, 300 l/ha
p_technoTimeReq("1","1",scenario,"BA_102kW",pestType) = 0.27;
p_technoFuelCons("1","1",scenario,"BA_102kW",pestType) = 1.13;
p_technoMaintenance("1","1",scenario,"BA_102kW",pestType) = 4.22;
p_technoTimeReq("1","2",scenario,"BA_102kW",pestType) = 0.28;
p_technoFuelCons("1","2",scenario,"BA_102kW",pestType) = 1.2;
p_technoMaintenance("1","2",scenario,"BA_102kW",pestType) = 4.31;
p_technoTimeReq("1","3",scenario,"BA_102kW",pestType) = 0.3;
p_technoFuelCons("1","3",scenario,"BA_102kW",pestType) = 1.26;
p_technoMaintenance("1","3",scenario,"BA_102kW",pestType) = 4.39;
p_technoTimeReq("1","4",scenario,"BA_102kW",pestType) = 0.31;
p_technoFuelCons("1","4",scenario,"BA_102kW",pestType) = 1.32;
p_technoMaintenance("1","4",scenario,"BA_102kW",pestType) = 4.46;
p_technoTimeReq("1","5",scenario,"BA_102kW",pestType) = 0.32;
p_technoFuelCons("1","5",scenario,"BA_102kW",pestType) = 1.38;
p_technoMaintenance("1","5",scenario,"BA_102kW",pestType) = 4.53;
p_technoTimeReq("1","10",scenario,"BA_102kW",pestType) = 0.38;
p_technoFuelCons("1","10",scenario,"BA_102kW",pestType) = 1.68;
p_technoMaintenance("1","10",scenario,"BA_102kW",pestType) = 4.88;
p_technoTimeReq("1","15",scenario,"BA_102kW",pestType) = 0.44;
p_technoFuelCons("1","15",scenario,"BA_102kW",pestType) = 2.0;
p_technoMaintenance("1","15",scenario,"BA_102kW",pestType) = 5.24;

p_technoTimeReq("2","1",scenario,"BA_102kW",pestType) = 0.22;
p_technoFuelCons("2","1",scenario,"BA_102kW",pestType) = 1.01;
p_technoMaintenance("2","1",scenario,"BA_102kW",pestType) = 3.9;
p_technoTimeReq("2","2",scenario,"BA_102kW",pestType) = 0.23;
p_technoFuelCons("2","2",scenario,"BA_102kW",pestType) = 1.07;
p_technoMaintenance("2","2",scenario,"BA_102kW",pestType) = 3.99;
p_technoTimeReq("2","3",scenario,"BA_102kW",pestType) = 0.25;
p_technoFuelCons("2","3",scenario,"BA_102kW",pestType) = 1.13;
p_technoMaintenance("2","3",scenario,"BA_102kW",pestType) = 4.06;
p_technoTimeReq("2","4",scenario,"BA_102kW",pestType) = 0.26;
p_technoFuelCons("2","4",scenario,"BA_102kW",pestType) = 1.19;
p_technoMaintenance("2","4",scenario,"BA_102kW",pestType) = 4.14;
p_technoTimeReq("2","5",scenario,"BA_102kW",pestType) = 0.27;
p_technoFuelCons("2","5",scenario,"BA_102kW",pestType) = 1.25;
p_technoMaintenance("2","5",scenario,"BA_102kW",pestType) = 4.21;
p_technoTimeReq("2","10",scenario,"BA_102kW",pestType) = 0.33;
p_technoFuelCons("2","10",scenario,"BA_102kW",pestType) = 1.55;
p_technoMaintenance("2","10",scenario,"BA_102kW",pestType) = 4.56;
p_technoTimeReq("2","15",scenario,"BA_102kW",pestType) = 0.39;
p_technoFuelCons("2","15",scenario,"BA_102kW",pestType) = 1.87;
p_technoMaintenance("2","15",scenario,"BA_102kW",pestType) = 4.91;

p_technoTimeReq("5","1",scenario,"BA_102kW",pestType) = 0.15;
p_technoFuelCons("5","1",scenario,"BA_102kW",pestType) = 0.79;
p_technoMaintenance("5","1",scenario,"BA_102kW",pestType) = 3.52;
p_technoTimeReq("5","2",scenario,"BA_102kW",pestType) = 0.17;
p_technoFuelCons("5","2",scenario,"BA_102kW",pestType) = 0.85;
p_technoMaintenance("5","2",scenario,"BA_102kW",pestType) = 3.61;
p_technoTimeReq("5","3",scenario,"BA_102kW",pestType) = 0.18;
p_technoFuelCons("5","3",scenario,"BA_102kW",pestType) = 0.91;
p_technoMaintenance("5","3",scenario,"BA_102kW",pestType) = 3.69;
p_technoTimeReq("5","4",scenario,"BA_102kW",pestType) = 0.19;
p_technoFuelCons("5","4",scenario,"BA_102kW",pestType) = 0.96;
p_technoMaintenance("5","4",scenario,"BA_102kW",pestType) = 3.76;
p_technoTimeReq("5","5",scenario,"BA_102kW",pestType) = 0.2;
p_technoFuelCons("5","5",scenario,"BA_102kW",pestType) = 1.02;
p_technoMaintenance("5","5",scenario,"BA_102kW",pestType) = 3.83;
p_technoTimeReq("5","10",scenario,"BA_102kW",pestType) = 0.26;
p_technoFuelCons("5","10",scenario,"BA_102kW",pestType) = 1.31;
p_technoMaintenance("5","10",scenario,"BA_102kW",pestType) = 4.18;
p_technoTimeReq("5","15",scenario,"BA_102kW",pestType) = 0.32;
p_technoFuelCons("5","15",scenario,"BA_102kW",pestType) = 1.62;
p_technoMaintenance("5","15",scenario,"BA_102kW",pestType) = 4.54;

p_technoTimeReq("10","1",scenario,"BA_102kW",pestType) = 0.16;
p_technoFuelCons("10","1",scenario,"BA_102kW",pestType) = 0.86;
p_technoMaintenance("10","1",scenario,"BA_102kW",pestType) = 3.57;
p_technoTimeReq("10","2",scenario,"BA_102kW",pestType) = 0.18;
p_technoFuelCons("10","2",scenario,"BA_102kW",pestType) = 0.92;
p_technoMaintenance("10","2",scenario,"BA_102kW",pestType) = 3.65;
p_technoTimeReq("10","3",scenario,"BA_102kW",pestType) = 0.19;
p_technoFuelCons("10","3",scenario,"BA_102kW",pestType) = 0.98;
p_technoMaintenance("10","3",scenario,"BA_102kW",pestType) = 3.73;
p_technoTimeReq("10","4",scenario,"BA_102kW",pestType) = 0.2;
p_technoFuelCons("10","4",scenario,"BA_102kW",pestType) = 1.04;
p_technoMaintenance("10","4",scenario,"BA_102kW",pestType) = 3.8;
p_technoTimeReq("10","5",scenario,"BA_102kW",pestType) = 0.21;
p_technoFuelCons("10","5",scenario,"BA_102kW",pestType) = 1.09;
p_technoMaintenance("10","5",scenario,"BA_102kW",pestType) = 3.87;
p_technoTimeReq("10","10",scenario,"BA_102kW",pestType) = 0.27;
p_technoFuelCons("10","10",scenario,"BA_102kW",pestType) = 1.39;
p_technoMaintenance("10","10",scenario,"BA_102kW",pestType) = 4.23;
p_technoTimeReq("10","15",scenario,"BA_102kW",pestType) = 0.33;
p_technoFuelCons("10","15",scenario,"BA_102kW",pestType) = 1.7;
p_technoMaintenance("10","15",scenario,"BA_102kW",pestType) = 4.58;

p_technoTimeReq("20","1",scenario,"BA_102kW",pestType) = 0.16;
p_technoFuelCons("20","1",scenario,"BA_102kW",pestType) = 0.88;
p_technoMaintenance("20","1",scenario,"BA_102kW",pestType) = 3.58;
p_technoTimeReq("20","2",scenario,"BA_102kW",pestType) = 0.18;
p_technoFuelCons("20","2",scenario,"BA_102kW",pestType) = 0.94;
p_technoMaintenance("20","2",scenario,"BA_102kW",pestType) = 3.66;
p_technoTimeReq("20","3",scenario,"BA_102kW",pestType) = 0.19;
p_technoFuelCons("20","3",scenario,"BA_102kW",pestType) = 1.0;
p_technoMaintenance("20","3",scenario,"BA_102kW",pestType) = 3.74;
p_technoTimeReq("20","4",scenario,"BA_102kW",pestType) = 0.2;
p_technoFuelCons("20","4",scenario,"BA_102kW",pestType) = 1.06;
p_technoMaintenance("20","4",scenario,"BA_102kW",pestType) = 3.81;
p_technoTimeReq("20","5",scenario,"BA_102kW",pestType) = 0.21;
p_technoFuelCons("20","5",scenario,"BA_102kW",pestType) = 1.11;
p_technoMaintenance("20","5",scenario,"BA_102kW",pestType) = 3.88;
p_technoTimeReq("20","10",scenario,"BA_102kW",pestType) = 0.27;
p_technoFuelCons("20","10",scenario,"BA_102kW",pestType) = 1.41;
p_technoMaintenance("20","10",scenario,"BA_102kW",pestType) = 4.24;
p_technoTimeReq("20","15",scenario,"BA_102kW",pestType) = 0.33;
p_technoFuelCons("20","15",scenario,"BA_102kW",pestType) = 1.71;
p_technoMaintenance("20","15",scenario,"BA_102kW",pestType) = 4.59;

p_technoTimeReq("40","1",scenario,"BA_102kW",pestType) = 0.17;
p_technoFuelCons("40","1",scenario,"BA_102kW",pestType) = 0.91;
p_technoMaintenance("40","1",scenario,"BA_102kW",pestType) = 3.59;
p_technoTimeReq("40","2",scenario,"BA_102kW",pestType) = 0.18;
p_technoFuelCons("40","2",scenario,"BA_102kW",pestType) = 0.97;
p_technoMaintenance("40","2",scenario,"BA_102kW",pestType) = 3.68;
p_technoTimeReq("40","3",scenario,"BA_102kW",pestType) = 0.19;
p_technoFuelCons("40","3",scenario,"BA_102kW",pestType) = 1.02;
p_technoMaintenance("40","3",scenario,"BA_102kW",pestType) = 3.75;
p_technoTimeReq("40","4",scenario,"BA_102kW",pestType) = 0.2;
p_technoFuelCons("40","4",scenario,"BA_102kW",pestType) = 1.08;
p_technoMaintenance("40","4",scenario,"BA_102kW",pestType) = 3.82;
p_technoTimeReq("40","5",scenario,"BA_102kW",pestType) = 0.22;
p_technoFuelCons("40","5",scenario,"BA_102kW",pestType) = 1.14;
p_technoMaintenance("40","5",scenario,"BA_102kW",pestType) = 3.9;
p_technoTimeReq("40","10",scenario,"BA_102kW",pestType) = 0.28;
p_technoFuelCons("40","10",scenario,"BA_102kW",pestType) = 1.43;
p_technoMaintenance("40","10",scenario,"BA_102kW",pestType) = 4.25;
p_technoTimeReq("40","15",scenario,"BA_102kW",pestType) = 0.33;
p_technoFuelCons("40","15",scenario,"BA_102kW",pestType) = 1.74;
p_technoMaintenance("40","15",scenario,"BA_102kW",pestType) = 4.6;

p_technoTimeReq("80","1",scenario,"BA_102kW",pestType) = 0.17;
p_technoFuelCons("80","1",scenario,"BA_102kW",pestType) = 0.98;
p_technoMaintenance("80","1",scenario,"BA_102kW",pestType) = 3.64;
p_technoTimeReq("80","2",scenario,"BA_102kW",pestType) = 0.19;
p_technoFuelCons("80","2",scenario,"BA_102kW",pestType) = 1.04;
p_technoMaintenance("80","2",scenario,"BA_102kW",pestType) = 3.73;
p_technoTimeReq("80","3",scenario,"BA_102kW",pestType) = 0.2;
p_technoFuelCons("80","3",scenario,"BA_102kW",pestType) = 1.1;
p_technoMaintenance("80","3",scenario,"BA_102kW",pestType) = 3.81;
p_technoTimeReq("80","4",scenario,"BA_102kW",pestType) = 0.21;
p_technoFuelCons("80","4",scenario,"BA_102kW",pestType) = 1.15;
p_technoMaintenance("80","4",scenario,"BA_102kW",pestType) = 3.88;
p_technoTimeReq("80","5",scenario,"BA_102kW",pestType) = 0.23;
p_technoFuelCons("80","5",scenario,"BA_102kW",pestType) = 1.21;
p_technoMaintenance("80","5",scenario,"BA_102kW",pestType) = 3.95;
p_technoTimeReq("80","10",scenario,"BA_102kW",pestType) = 0.28;
p_technoFuelCons("80","10",scenario,"BA_102kW",pestType) = 1.51;
p_technoMaintenance("80","10",scenario,"BA_102kW",pestType) = 4.3;
p_technoTimeReq("80","15",scenario,"BA_102kW",pestType) = 0.34;
p_technoFuelCons("80","15",scenario,"BA_102kW",pestType) = 1.82;
p_technoMaintenance("80","15",scenario,"BA_102kW",pestType) = 4.66;


*angehängt, 24 m, 3,000 l, 67 kW
p_technoTimeReq("1","1",scenario,"BA_120kW",pestType) = 0.27;
p_technoFuelCons("1","1",scenario,"BA_120kW",pestType) = 1.49;
p_technoMaintenance("1","1",scenario,"BA_120kW",pestType) = 4.24;
p_technoTimeReq("1","2",scenario,"BA_120kW",pestType) = 0.28;
p_technoFuelCons("1","2",scenario,"BA_120kW",pestType) = 1.53;
p_technoMaintenance("1","2",scenario,"BA_120kW",pestType) = 4.28;
p_technoTimeReq("1","3",scenario,"BA_120kW",pestType) = 0.29;
p_technoFuelCons("1","3",scenario,"BA_120kW",pestType) = 1.58;
p_technoMaintenance("1","3",scenario,"BA_120kW",pestType) = 4.33;
p_technoTimeReq("1","4",scenario,"BA_120kW",pestType) = 0.29;
p_technoFuelCons("1","4",scenario,"BA_120kW",pestType) = 1.62;
p_technoMaintenance("1","4",scenario,"BA_120kW",pestType) = 4.36;
p_technoTimeReq("1","5",scenario,"BA_120kW",pestType) = 0.3;
p_technoFuelCons("1","5",scenario,"BA_120kW",pestType) = 1.67;
p_technoMaintenance("1","5",scenario,"BA_120kW",pestType) = 4.4;
p_technoTimeReq("1","10",scenario,"BA_120kW",pestType) = 0.33;
p_technoFuelCons("1","10",scenario,"BA_120kW",pestType) = 1.89;
p_technoMaintenance("1","10",scenario,"BA_120kW",pestType) = 4.57;
p_technoTimeReq("1","15",scenario,"BA_120kW",pestType) = 0.36;
p_technoFuelCons("1","15",scenario,"BA_120kW",pestType) = 2.13;
p_technoMaintenance("1","15",scenario,"BA_120kW",pestType) = 4.76;

p_technoTimeReq("2","1",scenario,"BA_120KW",pestType) = 0.21;
p_technoFuelCons("2","1",scenario,"BA_120KW",pestType) = 1.31;
p_technoMaintenance("2","1",scenario,"BA_120KW",pestType) = 3.87;
p_technoTimeReq("2","2",scenario,"BA_120KW",pestType) = 0.22;
p_technoFuelCons("2","2",scenario,"BA_120KW",pestType) = 1.35;
p_technoMaintenance("2","2",scenario,"BA_120KW",pestType) = 3.92;
p_technoTimeReq("2","3",scenario,"BA_120KW",pestType) = 0.23;
p_technoFuelCons("2","3",scenario,"BA_120KW",pestType) = 1.39;
p_technoMaintenance("2","3",scenario,"BA_120KW",pestType) = 3.96;
p_technoTimeReq("2","4",scenario,"BA_120KW",pestType) = 0.24;
p_technoFuelCons("2","4",scenario,"BA_120KW",pestType) = 1.44;
p_technoMaintenance("2","4",scenario,"BA_120KW",pestType) = 4.0;
p_technoTimeReq("2","5",scenario,"BA_120KW",pestType) = 0.24;
p_technoFuelCons("2","5",scenario,"BA_120KW",pestType) = 1.48;
p_technoMaintenance("2","5",scenario,"BA_120KW",pestType) = 4.03;
p_technoTimeReq("2","10",scenario,"BA_120KW",pestType) = 0.27;
p_technoFuelCons("2","10",scenario,"BA_120KW",pestType) = 1.69;
p_technoMaintenance("2","10",scenario,"BA_120KW",pestType) = 4.21;
p_technoTimeReq("2","15",scenario,"BA_120KW",pestType) = 0.3;
p_technoFuelCons("2","15",scenario,"BA_120KW",pestType) = 1.92;
p_technoMaintenance("2","15",scenario,"BA_120KW",pestType) = 4.39;

p_technoTimeReq("5","1",scenario,"BA_120kW",pestType) = 0.15;
p_technoFuelCons("5","1",scenario,"BA_120kW",pestType) = 1.0;
p_technoMaintenance("5","1",scenario,"BA_120kW",pestType) = 3.49;
p_technoTimeReq("5","2",scenario,"BA_120kW",pestType) = 0.16;
p_technoFuelCons("5","2",scenario,"BA_120kW",pestType) = 1.04;
p_technoMaintenance("5","2",scenario,"BA_120kW",pestType) = 3.53;
p_technoTimeReq("5","3",scenario,"BA_120kW",pestType) = 0.16;
p_technoFuelCons("5","3",scenario,"BA_120kW",pestType) = 1.08;
p_technoMaintenance("5","3",scenario,"BA_120kW",pestType) = 3.57;
p_technoTimeReq("5","4",scenario,"BA_120kW",pestType) = 0.17;
p_technoFuelCons("5","4",scenario,"BA_120kW",pestType) = 1.12;
p_technoMaintenance("5","4",scenario,"BA_120kW",pestType) = 3.61;
p_technoTimeReq("5","5",scenario,"BA_120kW",pestType) = 0.17;
p_technoFuelCons("5","5",scenario,"BA_120kW",pestType) = 1.16;
p_technoMaintenance("5","5",scenario,"BA_120kW",pestType) = 3.64;
p_technoTimeReq("5","10",scenario,"BA_120kW",pestType) = 0.2;
p_technoFuelCons("5","10",scenario,"BA_120kW",pestType) = 1.36;
p_technoMaintenance("5","10",scenario,"BA_120kW",pestType) = 3.82;
p_technoTimeReq("5","15",scenario,"BA_120kW",pestType) = 0.23;
p_technoFuelCons("5","15",scenario,"BA_120kW",pestType) = 1.58;
p_technoMaintenance("5","15",scenario,"BA_120kW",pestType) = 4.0;

p_technoTimeReq("10","1",scenario,"BA_120kW",pestType) = 0.12;
p_technoFuelCons("10","1",scenario,"BA_120kW",pestType) = 0.9;
p_technoMaintenance("10","1",scenario,"BA_120kW",pestType) = 3.34;
p_technoTimeReq("10","2",scenario,"BA_120kW",pestType) = 0.13;
p_technoFuelCons("10","2",scenario,"BA_120kW",pestType) = 0.94;
p_technoMaintenance("10","2",scenario,"BA_120kW",pestType) = 3.38;
p_technoTimeReq("10","3",scenario,"BA_120kW",pestType) = 0.14;
p_technoFuelCons("10","3",scenario,"BA_120kW",pestType) = 0.98;
p_technoMaintenance("10","3",scenario,"BA_120kW",pestType) = 3.42;
p_technoTimeReq("10","4",scenario,"BA_120kW",pestType) = 0.14;
p_technoFuelCons("10","4",scenario,"BA_120kW",pestType) = 1.02;
p_technoMaintenance("10","4",scenario,"BA_120kW",pestType) = 3.46;
p_technoTimeReq("10","5",scenario,"BA_120kW",pestType) = 0.15;
p_technoFuelCons("10","5",scenario,"BA_120kW",pestType) = 1.06;
p_technoMaintenance("10","5",scenario,"BA_120kW",pestType) = 3.49;
p_technoTimeReq("10","10",scenario,"BA_120kW",pestType) = 0.18;
p_technoFuelCons("10","10",scenario,"BA_120kW",pestType) = 1.26;
p_technoMaintenance("10","10",scenario,"BA_120kW",pestType) = 3.67;
p_technoTimeReq("10","15",scenario,"BA_120kW",pestType) = 0.21;
p_technoFuelCons("10","15",scenario,"BA_120kW",pestType) = 1.47;
p_technoMaintenance("10","15",scenario,"BA_120kW",pestType) = 3.85;

p_technoTimeReq("20","1",scenario,"BA_120kW",pestType) = 0.13;
p_technoFuelCons("20","1",scenario,"BA_120kW",pestType) = 0.95;
p_technoMaintenance("20","1",scenario,"BA_120kW",pestType) = 3.36;
p_technoTimeReq("20","2",scenario,"BA_120kW",pestType) = 0.13;
p_technoFuelCons("20","2",scenario,"BA_120kW",pestType) = 0.99;
p_technoMaintenance("20","2",scenario,"BA_120kW",pestType) = 3.4;
p_technoTimeReq("20","3",scenario,"BA_120kW",pestType) = 0.14;
p_technoFuelCons("20","3",scenario,"BA_120kW",pestType) = 1.04;
p_technoMaintenance("20","3",scenario,"BA_120kW",pestType) = 3.44;
p_technoTimeReq("20","4",scenario,"BA_120kW",pestType) = 0.15;
p_technoFuelCons("20","4",scenario,"BA_120kW",pestType) = 1.07;
p_technoMaintenance("20","4",scenario,"BA_120kW",pestType) = 3.47;
p_technoTimeReq("20","5",scenario,"BA_120kW",pestType) = 0.15;
p_technoFuelCons("20","5",scenario,"BA_120kW",pestType) = 1.11;
p_technoMaintenance("20","5",scenario,"BA_120kW",pestType) = 3.51;
p_technoTimeReq("20","10",scenario,"BA_120kW",pestType) = 0.18;
p_technoFuelCons("20","10",scenario,"BA_120kW",pestType) = 1.32;
p_technoMaintenance("20","10",scenario,"BA_120kW",pestType) = 3.69;
p_technoTimeReq("20","15",scenario,"BA_120kW",pestType) = 0.21;
p_technoFuelCons("20","15",scenario,"BA_120kW",pestType) = 1.53;
p_technoMaintenance("20","15",scenario,"BA_120kW",pestType) = 3.87;

p_technoTimeReq("40","1",scenario,"BA_120kW",pestType) = 0.12;
p_technoFuelCons("40","1",scenario,"BA_120kW",pestType) = 0.95;
p_technoMaintenance("40","1",scenario,"BA_120kW",pestType) = 3.34;
p_technoTimeReq("40","2",scenario,"BA_120kW",pestType) = 0.13;
p_technoFuelCons("40","2",scenario,"BA_120kW",pestType) = 0.99;
p_technoMaintenance("40","2",scenario,"BA_120kW",pestType) = 3.38;
p_technoTimeReq("40","3",scenario,"BA_120kW",pestType) = 0.14;
p_technoFuelCons("40","3",scenario,"BA_120kW",pestType) = 1.03;
p_technoMaintenance("40","3",scenario,"BA_120kW",pestType) = 3.42;
p_technoTimeReq("40","4",scenario,"BA_120kW",pestType) = 0.14;
p_technoFuelCons("40","4",scenario,"BA_120kW",pestType) = 1.07;
p_technoMaintenance("40","4",scenario,"BA_120kW",pestType) = 3.46;
p_technoTimeReq("40","5",scenario,"BA_120kW",pestType) = 0.15;
p_technoFuelCons("40","5",scenario,"BA_120kW",pestType) = 1.11;
p_technoMaintenance("40","5",scenario,"BA_120kW",pestType) = 3.49;
p_technoTimeReq("40","10",scenario,"BA_120kW",pestType) = 0.18;
p_technoFuelCons("40","10",scenario,"BA_120kW",pestType) = 1.31;
p_technoMaintenance("40","10",scenario,"BA_120kW",pestType) = 3.67;
p_technoTimeReq("40","15",scenario,"BA_120kW",pestType) = 0.21;
p_technoFuelCons("40","15",scenario,"BA_120kW",pestType) = 1.52;
p_technoMaintenance("40","15",scenario,"BA_120kW",pestType) = 3.85;

p_technoTimeReq("80","1",scenario,"BA_120kW",pestType) = 0.13;
p_technoFuelCons("80","1",scenario,"BA_120kW",pestType) = 0.99;
p_technoMaintenance("80","1",scenario,"BA_120kW",pestType) = 3.36;
p_technoTimeReq("80","2",scenario,"BA_120kW",pestType) = 0.13;
p_technoFuelCons("80","2",scenario,"BA_120kW",pestType) = 1.03;
p_technoMaintenance("80","2",scenario,"BA_120kW",pestType) = 3.4;
p_technoTimeReq("80","3",scenario,"BA_120kW",pestType) = 0.14;
p_technoFuelCons("80","3",scenario,"BA_120kW",pestType) = 1.07;
p_technoMaintenance("80","3",scenario,"BA_120kW",pestType) = 3.44;
p_technoTimeReq("80","4",scenario,"BA_120kW",pestType) = 0.15;
p_technoFuelCons("80","4",scenario,"BA_120kW",pestType) = 1.11;
p_technoMaintenance("80","4",scenario,"BA_120kW",pestType) = 3.48;
p_technoTimeReq("80","5",scenario,"BA_120kW",pestType) = 0.15;
p_technoFuelCons("80","5",scenario,"BA_120kW",pestType) = 1.15;
p_technoMaintenance("80","5",scenario,"BA_120kW",pestType) = 3.41;
p_technoTimeReq("80","10",scenario,"BA_120kW",pestType) = 0.18;
p_technoFuelCons("80","10",scenario,"BA_120kW",pestType) = 1.35;
p_technoMaintenance("80","10",scenario,"BA_120kW",pestType) = 3.69;
p_technoTimeReq("80","15",scenario,"BA_120kW",pestType) = 0.21;
p_technoFuelCons("80","15",scenario,"BA_120kW",pestType) = 1.56;
p_technoMaintenance("80","15",scenario,"BA_120kW",pestType) = 3.87;


* angehängt, 27 m, 4,000 l, 83 kW, 300 l/ha
p_technoTimeReq("1","1",scenario,"BA_200kW",pestType) = 0.27;
p_technoFuelCons("1","1",scenario,"BA_200kW",pestType) = 1.73;
p_technoMaintenance("1","1",scenario,"BA_200kW",pestType) = 4.46;
p_technoTimeReq("1","2",scenario,"BA_200kW",pestType) = 0.27;
p_technoFuelCons("1","2",scenario,"BA_200kW",pestType) = 1.78;
p_technoMaintenance("1","2",scenario,"BA_200kW",pestType) = 4.51;
p_technoTimeReq("1","3",scenario,"BA_200kW",pestType) =0.28 ;
p_technoFuelCons("1","3",scenario,"BA_200kW",pestType) = 1.82;
p_technoMaintenance("1","3",scenario,"BA_200kW",pestType) = 4.54;
p_technoTimeReq("1","4",scenario,"BA_200kW",pestType) = 0.28;
p_technoFuelCons("1","4",scenario,"BA_200kW",pestType) = 1.86;
p_technoMaintenance("1","4",scenario,"BA_200kW",pestType) = 4.57;
p_technoTimeReq("1","5",scenario,"BA_200kW",pestType) = 0.29;
p_technoFuelCons("1","5",scenario,"BA_200kW",pestType) = 1.9;
p_technoMaintenance("1","5",scenario,"BA_200kW",pestType) = 4.6;
p_technoTimeReq("1","10",scenario,"BA_200kW",pestType) = 0.31;
p_technoFuelCons("1","10",scenario,"BA_200kW",pestType) = 2.12;
p_technoMaintenance("1","10",scenario,"BA_200kW",pestType) = 4.76;
p_technoTimeReq("1","15",scenario,"BA_200kW",pestType) = 0.33;
p_technoFuelCons("1","15",scenario,"BA_200kW",pestType) = 2.33;
p_technoMaintenance("1","15",scenario,"BA_200kW",pestType) = 4.91;

p_technoTimeReq("2","1",scenario,"BA_200kW",pestType) = 0.19;
p_technoFuelCons("2","1",scenario,"BA_200kW",pestType) = 1.34;
p_technoMaintenance("2","1",scenario,"BA_200kW",pestType) = 3.92;
p_technoTimeReq("2","2",scenario,"BA_200kW",pestType) = 0.2;
p_technoFuelCons("2","2",scenario,"BA_200kW",pestType) = 1.38;
p_technoMaintenance("2","2",scenario,"BA_200kW",pestType) = 3.95;
p_technoTimeReq("2","3",scenario,"BA_200kW",pestType) = 0.2;
p_technoFuelCons("2","3",scenario,"BA_200kW",pestType) = 1.42;
p_technoMaintenance("2","3",scenario,"BA_200kW",pestType) = 3.99;
p_technoTimeReq("2","4",scenario,"BA_200kW",pestType) = 0.21;
p_technoFuelCons("2","4",scenario,"BA_200kW",pestType) = 1.46;
p_technoMaintenance("2","4",scenario,"BA_200kW",pestType) = 4.02;
p_technoTimeReq("2","5",scenario,"BA_200kW",pestType) = 0.21;
p_technoFuelCons("2","5",scenario,"BA_200kW",pestType) = 1.49;
p_technoMaintenance("2","5",scenario,"BA_200kW",pestType) = 4.05;
p_technoTimeReq("2","10",scenario,"BA_200kW",pestType) = 0.23;
p_technoFuelCons("2","10",scenario,"BA_200kW",pestType) = 1.69;
p_technoMaintenance("2","10",scenario,"BA_200kW",pestType) = 4.21;
p_technoTimeReq("2","15",scenario,"BA_200kW",pestType) = 0.25;
p_technoFuelCons("2","15",scenario,"BA_200kW",pestType) = 1.89;
p_technoMaintenance("2","15",scenario,"BA_200kW",pestType) = 4.36;

p_technoTimeReq("5","1",scenario,"BA_200kW",pestType) = 0.13;
p_technoFuelCons("5","1",scenario,"BA_200kW",pestType) = 1.04;
p_technoMaintenance("5","1",scenario,"BA_200kW",pestType) = 3.52;
p_technoTimeReq("5","2",scenario,"BA_200kW",pestType) = 0.14;
p_technoFuelCons("5","2",scenario,"BA_200kW",pestType) = 1.08;
p_technoMaintenance("5","2",scenario,"BA_200kW",pestType) = 3.56;
p_technoTimeReq("5","3",scenario,"BA_200kW",pestType) = 0.14;
p_technoFuelCons("5","3",scenario,"BA_200kW",pestType) = 1.12;
p_technoMaintenance("5","3",scenario,"BA_200kW",pestType) = 3.6;
p_technoTimeReq("5","4",scenario,"BA_200kW",pestType) = 0.15;
p_technoFuelCons("5","4",scenario,"BA_200kW",pestType) = 1.15;
p_technoMaintenance("5","4",scenario,"BA_200kW",pestType) = 3.63;
p_technoTimeReq("5","5",scenario,"BA_200kW",pestType) = 0.15;
p_technoFuelCons("5","5",scenario,"BA_200kW",pestType) = 1.19;
p_technoMaintenance("5","5",scenario,"BA_200kW",pestType) = 3.66;
p_technoTimeReq("5","10",scenario,"BA_200kW",pestType) = 0.17;
p_technoFuelCons("5","10",scenario,"BA_200kW",pestType) = 1.38;
p_technoMaintenance("5","10",scenario,"BA_200kW",pestType) = 3.82;
p_technoTimeReq("5","15",scenario,"BA_200kW",pestType) = 0.2;
p_technoFuelCons("5","15",scenario,"BA_200kW",pestType) = 1.57;
p_technoMaintenance("5","15",scenario,"BA_200kW",pestType) = 3.97;

p_technoTimeReq("10","1",scenario,"BA_200kW",pestType) = 0.12;
p_technoFuelCons("10","1",scenario,"BA_200kW",pestType) = 0.98;
p_technoMaintenance("10","1",scenario,"BA_200kW",pestType) = 3.41;
p_technoTimeReq("10","2",scenario,"BA_200kW",pestType) = 0.12;
p_technoFuelCons("10","2",scenario,"BA_200kW",pestType) = 1.02;
p_technoMaintenance("10","2",scenario,"BA_200kW",pestType) = 3.45;
p_technoTimeReq("10","3",scenario,"BA_200kW",pestType) = 0.13;
p_technoFuelCons("10","3",scenario,"BA_200kW",pestType) = 1.06;
p_technoMaintenance("10","3",scenario,"BA_200kW",pestType) = 3.48;
p_technoTimeReq("10","4",scenario,"BA_200kW",pestType) = 0.13;
p_technoFuelCons("10","4",scenario,"BA_200kW",pestType) = 1.1;
p_technoMaintenance("10","4",scenario,"BA_200kW",pestType) = 3.52;
p_technoTimeReq("10","5",scenario,"BA_200kW",pestType) = 0.14;
p_technoFuelCons("10","5",scenario,"BA_200kW",pestType) = 1.13;
p_technoMaintenance("10","5",scenario,"BA_200kW",pestType) = 3.55;
p_technoTimeReq("10","10",scenario,"BA_200kW",pestType) = 0.16;
p_technoFuelCons("10","10",scenario,"BA_200kW",pestType) = 1.31;
p_technoMaintenance("10","10",scenario,"BA_200kW",pestType) = 3.7;
p_technoTimeReq("10","15",scenario,"BA_200kW",pestType) = 0.18;
p_technoFuelCons("10","15",scenario,"BA_200kW",pestType) = 1.51;
p_technoMaintenance("10","15",scenario,"BA_200kW",pestType) = 3.85;

p_technoTimeReq("20","1",scenario,"BA_200kW",pestType) = 0.11;
p_technoFuelCons("20","1",scenario,"BA_200kW",pestType) = 1.01;
p_technoMaintenance("20","1",scenario,"BA_200kW",pestType) = 3.4;
p_technoTimeReq("20","2",scenario,"BA_200kW",pestType) = 0.12;
p_technoFuelCons("20","2",scenario,"BA_200kW",pestType) = 1.05;
p_technoMaintenance("20","2",scenario,"BA_200kW",pestType) = 3.43;
p_technoTimeReq("20","3",scenario,"BA_200kW",pestType) = 0.12;
p_technoFuelCons("20","3",scenario,"BA_200kW",pestType) = 1.09;
p_technoMaintenance("20","3",scenario,"BA_200kW",pestType) = 3.47;
p_technoTimeReq("20","4",scenario,"BA_200kW",pestType) = 0.13;
p_technoFuelCons("20","4",scenario,"BA_200kW",pestType) = 1.13;
p_technoMaintenance("20","4",scenario,"BA_200kW",pestType) = 3.5;
p_technoTimeReq("20","5",scenario,"BA_200kW",pestType) = 0.13;
p_technoFuelCons("20","5",scenario,"BA_200kW",pestType) = 1.16;
p_technoMaintenance("20","5",scenario,"BA_200kW",pestType) = 3.54;
p_technoTimeReq("20","10",scenario,"BA_200kW",pestType) = 0.15;
p_technoFuelCons("20","10",scenario,"BA_200kW",pestType) = 1.34;
p_technoMaintenance("20","10",scenario,"BA_200kW",pestType) = 3.68;
p_technoTimeReq("20","15",scenario,"BA_200kW",pestType) = 0.18;
p_technoFuelCons("20","15",scenario,"BA_200kW",pestType) = 1.53;
p_technoMaintenance("20","15",scenario,"BA_200kW",pestType) = 3.84;

p_technoTimeReq("40","1",scenario,"BA_200kW",pestType) = 0.11;
p_technoFuelCons("40","1",scenario,"BA_200kW",pestType) = 0.98;
p_technoMaintenance("40","1",scenario,"BA_200kW",pestType) = 3.34;
p_technoTimeReq("40","2",scenario,"BA_200kW",pestType) = 0.11;
p_technoFuelCons("40","2",scenario,"BA_200kW",pestType) = 1.01;
p_technoMaintenance("40","2",scenario,"BA_200kW",pestType) = 3.38;
p_technoTimeReq("40","3",scenario,"BA_200kW",pestType) = 0.12;
p_technoFuelCons("40","3",scenario,"BA_200kW",pestType) = 1.05;
p_technoMaintenance("40","3",scenario,"BA_200kW",pestType) = 3.42;
p_technoTimeReq("40","4",scenario,"BA_200kW",pestType) = 0.12;
p_technoFuelCons("40","4",scenario,"BA_200kW",pestType) = 1.09;
p_technoMaintenance("40","4",scenario,"BA_200kW",pestType) = 3.45;
p_technoTimeReq("40","5",scenario,"BA_200kW",pestType) = 0.13;
p_technoFuelCons("40","5",scenario,"BA_200kW",pestType) = 1.12;
p_technoMaintenance("40","5",scenario,"BA_200kW",pestType) = 3.48;
p_technoTimeReq("40","10",scenario,"BA_200kW",pestType) = 0.15;
p_technoFuelCons("40","10",scenario,"BA_200kW",pestType) = 1.3;
p_technoMaintenance("40","10",scenario,"BA_200kW",pestType) = 3.63;
p_technoTimeReq("40","15",scenario,"BA_200kW",pestType) = 0.17;
p_technoFuelCons("40","15",scenario,"BA_200kW",pestType) = 1.5;
p_technoMaintenance("40","15",scenario,"BA_200kW",pestType) = 3.79;

p_technoTimeReq("80","1",scenario,"BA_200kW",pestType) = 0.11;
p_technoFuelCons("80","1",scenario,"BA_200kW",pestType) = 1.01;
p_technoMaintenance("80","1",scenario,"BA_200kW",pestType) = 3.35;
p_technoTimeReq("80","2",scenario,"BA_200kW",pestType) = 0.11;
p_technoFuelCons("80","2",scenario,"BA_200kW",pestType) = 1.05;
p_technoMaintenance("80","2",scenario,"BA_200kW",pestType) = 3.39;
p_technoTimeReq("80","3",scenario,"BA_200kW",pestType) = 0.12;
p_technoFuelCons("80","3",scenario,"BA_200kW",pestType) = 1.08;
p_technoMaintenance("80","3",scenario,"BA_200kW",pestType) = 3.43;
p_technoTimeReq("80","4",scenario,"BA_200kW",pestType) = 0.12;
p_technoFuelCons("80","4",scenario,"BA_200kW",pestType) = 1.12;
p_technoMaintenance("80","4",scenario,"BA_200kW",pestType) = 3.46;
p_technoTimeReq("80","5",scenario,"BA_200kW",pestType) = 0.13;
p_technoFuelCons("80","5",scenario,"BA_200kW",pestType) = 1.16;
p_technoMaintenance("80","5",scenario,"BA_200kW",pestType) = 3.49;
p_technoTimeReq("80","10",scenario,"BA_200kW",pestType) = 0.15;
p_technoFuelCons("80","10",scenario,"BA_200kW",pestType) = 1.34;
p_technoMaintenance("80","10",scenario,"BA_200kW",pestType) = 3.65;
p_technoTimeReq("80","15",scenario,"BA_200kW",pestType) = 0.17;
p_technoFuelCons("80","15",scenario,"BA_200kW",pestType) = 1.53;
p_technoMaintenance("80","15",scenario,"BA_200kW",pestType) = 3.8;


*angehängt, 36 m, 4,000 l, 83 kW 300 l/ha
p_technoTimeReq("1","1",scenario,"BA_230kW",pestType) = 0.23;
p_technoFuelCons("1","1",scenario,"BA_230kW",pestType) = 1.46;
p_technoMaintenance("1","1",scenario,"BA_230kW",pestType) = 4.24;
p_technoTimeReq("1","2",scenario,"BA_230kW",pestType) = 0.24;
p_technoFuelCons("1","2",scenario,"BA_230kW",pestType) = 1.5;
p_technoMaintenance("1","2",scenario,"BA_230kW",pestType) = 4.28;
p_technoTimeReq("1","3",scenario,"BA_230kW",pestType) = 0.24;
p_technoFuelCons("1","3",scenario,"BA_230kW",pestType) = 1.55;
p_technoMaintenance("1","3",scenario,"BA_230kW",pestType) = 4.31;
p_technoTimeReq("1","4",scenario,"BA_230kW",pestType) = 0.25;
p_technoFuelCons("1","4",scenario,"BA_230kW",pestType) = 1.59;
p_technoMaintenance("1","4",scenario,"BA_230kW",pestType) = 4.35;
p_technoTimeReq("1","5",scenario,"BA_230kW",pestType) = 0.25;
p_technoFuelCons("1","5",scenario,"BA_230kW",pestType) = 1.62;
p_technoMaintenance("1","5",scenario,"BA_230kW",pestType) = 4.37;
p_technoTimeReq("1","10",scenario,"BA_230kW",pestType) = 0.28;
p_technoFuelCons("1","10",scenario,"BA_230kW",pestType) = 1.84;
p_technoMaintenance("1","10",scenario,"BA_230kW",pestType) = 4.54;
p_technoTimeReq("1","15",scenario,"BA_230kW",pestType) = 0.3;
p_technoFuelCons("1","15",scenario,"BA_230kW",pestType) = 2.06;
p_technoMaintenance("1","15",scenario,"BA_230kW",pestType) = 4.69;

p_technoTimeReq("2","1",scenario,"BA_230kW",pestType) = 0.17;
p_technoFuelCons("2","1",scenario,"BA_230kW",pestType) = 1.15;
p_technoMaintenance("2","1",scenario,"BA_230kW",pestType) = 3.76;
p_technoTimeReq("2","2",scenario,"BA_230kW",pestType) = 0.17;
p_technoFuelCons("2","2",scenario,"BA_230kW",pestType) = 1.19;
p_technoMaintenance("2","2",scenario,"BA_230kW",pestType) = 3.8;
p_technoTimeReq("2","3",scenario,"BA_230kW",pestType) = 0.18;
p_technoFuelCons("2","3",scenario,"BA_230kW",pestType) = 1.23;
p_technoMaintenance("2","3",scenario,"BA_230kW",pestType) = 3.82;
p_technoTimeReq("2","4",scenario,"BA_230kW",pestType) = 0.18;
p_technoFuelCons("2","4",scenario,"BA_230kW",pestType) = 1.27;
p_technoMaintenance("2","4",scenario,"BA_230kW",pestType) = 3.87;
p_technoTimeReq("2","5",scenario,"BA_230kW",pestType) = 0.19;
p_technoFuelCons("2","5",scenario,"BA_230kW",pestType) = 1.31;
p_technoMaintenance("2","5",scenario,"BA_230kW",pestType) = 3.9;
p_technoTimeReq("2","10",scenario,"BA_230kW",pestType) = 0.21;
p_technoFuelCons("2","10",scenario,"BA_230kW",pestType) = 1.5;
p_technoMaintenance("2","10",scenario,"BA_230kW",pestType) = 4.05;
p_technoTimeReq("2","15",scenario,"BA_230kW",pestType) = 0.23;
p_technoFuelCons("2","15",scenario,"BA_230kW",pestType) = 1.71;
p_technoMaintenance("2","15",scenario,"BA_230kW",pestType) = 4.21;

p_technoTimeReq("5","1",scenario,"BA_230kW",pestType) = 0.12;
p_technoFuelCons("5","1",scenario,"BA_230kW",pestType) = 0.94;
p_technoMaintenance("5","1",scenario,"BA_230kW",pestType) = 3.43;
p_technoTimeReq("5","2",scenario,"BA_230kW",pestType) = 0.12;
p_technoFuelCons("5","2",scenario,"BA_230kW",pestType) = 0.98;
p_technoMaintenance("5","2",scenario,"BA_230kW",pestType) = 3.47;
p_technoTimeReq("5","3",scenario,"BA_230kW",pestType) = 0.13;
p_technoFuelCons("5","3",scenario,"BA_230kW",pestType) = 1.01;
p_technoMaintenance("5","3",scenario,"BA_230kW",pestType) = 3.5;
p_technoTimeReq("5","4",scenario,"BA_230kW",pestType) = 0.13;
p_technoFuelCons("5","4",scenario,"BA_230kW",pestType) = 1.05;
p_technoMaintenance("5","4",scenario,"BA_230kW",pestType) = 3.53;
p_technoTimeReq("5","5",scenario,"BA_230kW",pestType) = 0.14;
p_technoFuelCons("5","5",scenario,"BA_230kW",pestType) = 1.09;
p_technoMaintenance("5","5",scenario,"BA_230kW",pestType) = 3.57;
p_technoTimeReq("5","10",scenario,"BA_230kW",pestType) = 0.16;
p_technoFuelCons("5","10",scenario,"BA_230kW",pestType) = 1.27;
p_technoMaintenance("5","10",scenario,"BA_230kW",pestType) = 3.72;
p_technoTimeReq("5","15",scenario,"BA_230kW",pestType) = 0.18;
p_technoFuelCons("5","15",scenario,"BA_230kW",pestType) = 1.47;
p_technoMaintenance("5","15",scenario,"BA_230kW",pestType) = 3.87;

p_technoTimeReq("10","1",scenario,"BA_230kW",pestType) = 0.1;
p_technoFuelCons("10","1",scenario,"BA_230kW",pestType) = 0.84;
p_technoMaintenance("10","1",scenario,"BA_230kW",pestType) = 3.29;
p_technoTimeReq("10","2",scenario,"BA_230kW",pestType) = 0.1;
p_technoFuelCons("10","2",scenario,"BA_230kW",pestType) = 0.88;
p_technoMaintenance("10","2",scenario,"BA_230kW",pestType) = 3.33;
p_technoTimeReq("10","3",scenario,"BA_230kW",pestType) = 0.11;
p_technoFuelCons("10","3",scenario,"BA_230kW",pestType) = 0.92;
p_technoMaintenance("10","3",scenario,"BA_230kW",pestType) = 3.37;
p_technoTimeReq("10","4",scenario,"BA_230kW",pestType) = 0.11;
p_technoFuelCons("10","4",scenario,"BA_230kW",pestType) = 0.95;
p_technoMaintenance("10","4",scenario,"BA_230kW",pestType) = 3.39;
p_technoTimeReq("10","5",scenario,"BA_230kW",pestType) = 0.12;
p_technoFuelCons("10","5",scenario,"BA_230kW",pestType) = 0.98;
p_technoMaintenance("10","5",scenario,"BA_230kW",pestType) = 3.42;
p_technoTimeReq("10","10",scenario,"BA_230kW",pestType) = 0.14;
p_technoFuelCons("10","10",scenario,"BA_230kW",pestType) = 1.17;
p_technoMaintenance("10","10",scenario,"BA_230kW",pestType) = 3.58;
p_technoTimeReq("10","15",scenario,"BA_230kW",pestType) = 0.16;
p_technoFuelCons("10","15",scenario,"BA_230kW",pestType) = 1.37;
p_technoMaintenance("10","15",scenario,"BA_230kW",pestType) = 3.74;

p_technoTimeReq("20","1",scenario,"BA_230kW",pestType) = 0.1;
p_technoFuelCons("20","1",scenario,"BA_230kW",pestType) = 0.86;
p_technoMaintenance("20","1",scenario,"BA_230kW",pestType) = 3.27;
p_technoTimeReq("20","2",scenario,"BA_230kW",pestType) = 0.1;
p_technoFuelCons("20","2",scenario,"BA_230kW",pestType) = 0.9;
p_technoMaintenance("20","2",scenario,"BA_230kW",pestType) = 3.31;
p_technoTimeReq("20","3",scenario,"BA_230kW",pestType) = 0.11;
p_technoFuelCons("20","3",scenario,"BA_230kW",pestType) = 0.94;
p_technoMaintenance("20","3",scenario,"BA_230kW",pestType) = 3.35;
p_technoTimeReq("20","4",scenario,"BA_230kW",pestType) = 0.11;
p_technoFuelCons("20","4",scenario,"BA_230kW",pestType) = 0.98;
p_technoMaintenance("20","4",scenario,"BA_230kW",pestType) = 3.38;
p_technoTimeReq("20","5",scenario,"BA_230kW",pestType) = 0.12;
p_technoFuelCons("20","5",scenario,"BA_230kW",pestType) = 1.01;
p_technoMaintenance("20","5",scenario,"BA_230kW",pestType) = 3.41;
p_technoTimeReq("20","10",scenario,"BA_230kW",pestType) = 0.14;
p_technoFuelCons("20","10",scenario,"BA_230kW",pestType) = 1.19;
p_technoMaintenance("20","10",scenario,"BA_230kW",pestType) = 3.56;
p_technoTimeReq("20","15",scenario,"BA_230kW",pestType) = 0.16;
p_technoFuelCons("20","15",scenario,"BA_230kW",pestType) = 1.39;
p_technoMaintenance("20","15",scenario,"BA_230kW",pestType) = 3.72;

p_technoTimeReq("40","1",scenario,"BA_230kW",pestType) = 0.09;
p_technoFuelCons("40","1",scenario,"BA_230kW",pestType) = 0.84;
p_technoMaintenance("40","1",scenario,"BA_230kW",pestType) = 3.23;
p_technoTimeReq("40","2",scenario,"BA_230kW",pestType) = 0.1;
p_technoFuelCons("40","2",scenario,"BA_230kW",pestType) = 0.88;
p_technoMaintenance("40","2",scenario,"BA_230kW",pestType) = 3.27;
p_technoTimeReq("40","3",scenario,"BA_230kW",pestType) = 0.1;
p_technoFuelCons("40","3",scenario,"BA_230kW",pestType) = 0.92;
p_technoMaintenance("40","3",scenario,"BA_230kW",pestType) = 3.31;
p_technoTimeReq("40","4",scenario,"BA_230kW",pestType) = 0.11;
p_technoFuelCons("40","4",scenario,"BA_230kW",pestType) = 0.95;
p_technoMaintenance("40","4",scenario,"BA_230kW",pestType) = 3.34;
p_technoTimeReq("40","5",scenario,"BA_230kW",pestType) = 0.11;
p_technoFuelCons("40","5",scenario,"BA_230kW",pestType) = 0.99;
p_technoMaintenance("40","5",scenario,"BA_230kW",pestType) = 3.37;
p_technoTimeReq("40","10",scenario,"BA_230kW",pestType) = 0.13;
p_technoFuelCons("40","10",scenario,"BA_230kW",pestType) = 1.17;
p_technoMaintenance("40","10",scenario,"BA_230kW",pestType) = 3.52;
p_technoTimeReq("40","15",scenario,"BA_230kW",pestType) = 0.15;
p_technoFuelCons("40","15",scenario,"BA_230kW",pestType) = 1.36;
p_technoMaintenance("40","15",scenario,"BA_230kW",pestType) = 3.68;

p_technoTimeReq("80","1",scenario,"BA_230kW",pestType) = 0.09;
p_technoFuelCons("80","1",scenario,"BA_230kW",pestType) = 0.87;
p_technoMaintenance("80","1",scenario,"BA_230kW",pestType) = 3.24;
p_technoTimeReq("80","2",scenario,"BA_230kW",pestType) = 0.1;
p_technoFuelCons("80","2",scenario,"BA_230kW",pestType) = 0.91;
p_technoMaintenance("80","2",scenario,"BA_230kW",pestType) = 3.28;
p_technoTimeReq("80","3",scenario,"BA_230kW",pestType) = 0.1;
p_technoFuelCons("80","3",scenario,"BA_230kW",pestType) = 0.94;
p_technoMaintenance("80","3",scenario,"BA_230kW",pestType) = 3.31;
p_technoTimeReq("80","4",scenario,"BA_230kW",pestType) = 0.11;
p_technoFuelCons("80","4",scenario,"BA_230kW",pestType) = 0.98;
p_technoMaintenance("80","4",scenario,"BA_230kW",pestType) = 3.35;
p_technoTimeReq("80","5",scenario,"BA_230kW",pestType) = 0.11;
p_technoFuelCons("80","5",scenario,"BA_230kW",pestType) = 1.02;
p_technoMaintenance("80","5",scenario,"BA_230kW",pestType) = 3.38;
p_technoTimeReq("80","10",scenario,"BA_230kW",pestType) = 0.13;
p_technoFuelCons("80","10",scenario,"BA_230kW",pestType) = 1.2;
p_technoMaintenance("80","10",scenario,"BA_230kW",pestType) = 3.53;
p_technoTimeReq("80","15",scenario,"BA_230kW",pestType) = 0.16;
p_technoFuelCons("80","15",scenario,"BA_230kW",pestType) = 1.39;
p_technoMaintenance("80","15",scenario,"BA_230kW",pestType) = 3.69;


*
*  --- Parameters for SST
*
*12 m, 600 l, 45 kW, 100 l/ha (with pesticide savings) & 300 l/ha (for applications without savings)
*data drawn from sprayer with 12m boom width, 45 kW and 100 l/ha (ab Schlagrand) 24.06.2024

*
* -- spot6m scenario FH
*
p_technoTimeReq("1","1","FH","spot6m",FH) = 0.35;
p_technoFuelCons("1","1","FH","spot6m",FH) = 1.09;
p_technoMaintenance("1","1","FH","spot6m",FH) = 3.58;
p_technoTimeReq("1","2","FH","spot6m",FH) = 0.36;
p_technoFuelCons("1","2","FH","spot6m",FH) = 1.13;
p_technoMaintenance("1","2","FH","spot6m",FH) = 3.63;
p_technoTimeReq("1","3","FH","spot6m",FH) = 0.37;
p_technoFuelCons("1","3","FH","spot6m",FH) = 1.16;
p_technoMaintenance("1","3","FH","spot6m",FH) = 3.67;
p_technoTimeReq("1","4","FH","spot6m",FH) = 0.38;
p_technoFuelCons("1","4","FH","spot6m",FH) = 1.19;
p_technoMaintenance("1","4","FH","spot6m",FH) = 3.72;
p_technoTimeReq("1","5","FH","spot6m",FH) = 0.39;
p_technoFuelCons("1","5","FH","spot6m",FH) = 1.22;
p_technoMaintenance("1","5","FH","spot6m",FH) = 3.75;
p_technoTimeReq("1","10","FH","spot6m",FH) = 0.44;
p_technoFuelCons("1","10","FH","spot6m",FH) = 1.39;
p_technoMaintenance("1","10","FH","spot6m",FH) = 3.95;
p_technoTimeReq("1","15","FH","spot6m",FH) = 0.49;
p_technoFuelCons("1","15","FH","spot6m",FH) = 1.57;
p_technoMaintenance("1","15","FH","spot6m",FH) = 4.15;

p_technoTimeReq("2","1","FH","spot6m",FH) = 0.29;
p_technoFuelCons("2","1","FH","spot6m",FH) = 0.97;
p_technoMaintenance("2","1","FH","spot6m",FH) = 3.34;
p_technoTimeReq("2","2","FH","spot6m",FH) = 0.3;
p_technoFuelCons("2","2","FH","spot6m",FH) = 1.01;
p_technoMaintenance("2","2","FH","spot6m",FH) = 3.38;
p_technoTimeReq("2","3","FH","spot6m",FH) = 0.31;
p_technoFuelCons("2","3","FH","spot6m",FH) = 1.04;
p_technoMaintenance("2","3","FH","spot6m",FH) = 3.43;
p_technoTimeReq("2","4","FH","spot6m",FH) = 0.32;
p_technoFuelCons("2","4","FH","spot6m",FH) = 1.07;
p_technoMaintenance("2","4","FH","spot6m",FH) = 3.47;
p_technoTimeReq("2","5","FH","spot6m",FH) = 0.33;
p_technoFuelCons("2","5","FH","spot6m",FH) = 1.1;
p_technoMaintenance("2","5","FH","spot6m",FH) = 3.51;
p_technoTimeReq("2","10","FH","spot6m",FH) = 0.38;
p_technoFuelCons("2","10","FH","spot6m",FH) = 1.27;
p_technoMaintenance("2","10","FH","spot6m",FH) = 3.71;
p_technoTimeReq("2","15","FH","spot6m",FH) = 0.43;
p_technoFuelCons("2","15","FH","spot6m",FH) = 1.44;
p_technoMaintenance("2","15","FH","spot6m",FH) = 3.9;

p_technoTimeReq("5","1","FH","spot6m",FH) = 0.23;
p_technoFuelCons("5","1","FH","spot6m",FH) = 0.85;
p_technoMaintenance("5","1","FH","spot6m",FH) = 3.13;
p_technoTimeReq("5","2","FH","spot6m",FH) = 0.24;
p_technoFuelCons("5","2","FH","spot6m",FH) = 0.88;
p_technoMaintenance("5","2","FH","spot6m",FH) = 3.17;
p_technoTimeReq("5","3","FH","spot6m",FH) = 0.25;
p_technoFuelCons("5","3","FH","spot6m",FH) = 0.92;
p_technoMaintenance("5","3","FH","spot6m",FH) = 3.22;
p_technoTimeReq("5","4","FH","spot6m",FH) = 0.27;
p_technoFuelCons("5","4","FH","spot6m",FH) = 0.95;
p_technoMaintenance("5","4","FH","spot6m",FH) = 3.26;
p_technoTimeReq("5","5","FH","spot6m",FH) = 0.28;
p_technoFuelCons("5","5","FH","spot6m",FH) = 0.98;
p_technoMaintenance("5","5","FH","spot6m",FH) = 3.3;
p_technoTimeReq("5","10","FH","spot6m",FH) = 0.32;
p_technoFuelCons("5","10","FH","spot6m",FH) = 1.14;
p_technoMaintenance("5","10","FH","spot6m",FH) = 3.49;
p_technoTimeReq("5","15","FH","spot6m",FH) = 0.37;
p_technoFuelCons("5","15","FH","spot6m",FH) = 1.3;
p_technoMaintenance("5","15","FH","spot6m",FH) = 3.68;

p_technoTimeReq("10","1","FH","spot6m",FH) = 0.23;
p_technoFuelCons("10","1","FH","spot6m",FH) = 0.85;
p_technoMaintenance("10","1","FH","spot6m",FH) = 3.1;
p_technoTimeReq("10","2","FH","spot6m",FH) = 0.24;
p_technoFuelCons("10","2","FH","spot6m",FH) = 0.89;
p_technoMaintenance("10","2","FH","spot6m",FH) = 3.15;
p_technoTimeReq("10","3","FH","spot6m",FH) = 0.25;
p_technoFuelCons("10","3","FH","spot6m",FH) = 0.92;
p_technoMaintenance("10","3","FH","spot6m",FH) = 3.19;
p_technoTimeReq("10","4","FH","spot6m",FH) = 0.26;
p_technoFuelCons("10","4","FH","spot6m",FH) = 0.95;
p_technoMaintenance("10","4","FH","spot6m",FH) = 3.24;
p_technoTimeReq("10","5","FH","spot6m",FH) = 0.27;
p_technoFuelCons("10","5","FH","spot6m",FH) = 0.98;
p_technoMaintenance("10","5","FH","spot6m",FH) = 3.28;
p_technoTimeReq("10","10","FH","spot6m",FH) = 0.32;
p_technoFuelCons("10","10","FH","spot6m",FH) = 1.14;
p_technoMaintenance("10","10","FH","spot6m",FH) = 3.46;
p_technoTimeReq("10","15","FH","spot6m",FH) = 0.37;
p_technoFuelCons("10","15","FH","spot6m",FH) = 1.3;
p_technoMaintenance("10","15","FH","spot6m",FH) = 3.66;

p_technoTimeReq("20","1","FH","spot6m",FH) = 0.22;
p_technoFuelCons("20","1","FH","spot6m",FH) = 0.86;
p_technoMaintenance("20","1","FH","spot6m",FH) = 3.09;
p_technoTimeReq("20","2","FH","spot6m",FH) = 0.24;
p_technoFuelCons("20","2","FH","spot6m",FH) = 0.89;
p_technoMaintenance("20","2","FH","spot6m",FH) = 3.14;
p_technoTimeReq("20","3","FH","spot6m",FH) = 0.25;
p_technoFuelCons("20","3","FH","spot6m",FH) = 0.92;
p_technoMaintenance("20","3","FH","spot6m",FH) = 3.19;
p_technoTimeReq("20","4","FH","spot6m",FH) = 0.26;
p_technoFuelCons("20","4","FH","spot6m",FH) = 0.96;
p_technoMaintenance("20","4","FH","spot6m",FH) = 3.23;
p_technoTimeReq("20","5","FH","spot6m",FH) = 0.27;
p_technoFuelCons("20","5","FH","spot6m",FH) = 0.99;
p_technoMaintenance("20","5","FH","spot6m",FH) = 3.27;
p_technoTimeReq("20","10","FH","spot6m",FH) = 0.31;
p_technoFuelCons("20","10","FH","spot6m",FH) = 1.14;
p_technoMaintenance("20","10","FH","spot6m",FH) = 3.45;
p_technoTimeReq("20","15","FH","spot6m",FH) = 0.36;
p_technoFuelCons("20","15","FH","spot6m",FH) = 1.3;
p_technoMaintenance("20","15","FH","spot6m",FH) = 3.65;

p_technoTimeReq("40","1","FH","spot6m",FH) = 0.22;
p_technoFuelCons("40","1","FH","spot6m",FH) = 0.86;
p_technoMaintenance("40","1","FH","spot6m",FH) = 3.07;
p_technoTimeReq("40","2","FH","spot6m",FH) = 0.23;
p_technoFuelCons("40","2","FH","spot6m",FH) = 0.89;
p_technoMaintenance("40","2","FH","spot6m",FH) = 3.12;
p_technoTimeReq("40","3","FH","spot6m",FH) = 0.24;
p_technoFuelCons("40","3","FH","spot6m",FH) = 0.92;
p_technoMaintenance("40","3","FH","spot6m",FH) = 3.16;
p_technoTimeReq("40","4","FH","spot6m",FH) = 0.25;
p_technoFuelCons("40","4","FH","spot6m",FH) = 0.95;
p_technoMaintenance("40","4","FH","spot6m",FH) = 3.21;
p_technoTimeReq("40","5","FH","spot6m",FH) = 0.26;
p_technoFuelCons("40","5","FH","spot6m",FH) = 0.98;
p_technoMaintenance("40","5","FH","spot6m",FH) = 3.24;
p_technoTimeReq("40","10","FH","spot6m",FH) = 0.31;
p_technoFuelCons("40","10","FH","spot6m",FH) = 1.14;
p_technoMaintenance("40","10","FH","spot6m",FH) = 3.44;
p_technoTimeReq("40","15","FH","spot6m",FH) = 0.36;
p_technoFuelCons("40","15","FH","spot6m",FH) = 1.31;
p_technoMaintenance("40","15","FH","spot6m",FH) = 3.64;

p_technoTimeReq("80","1","FH","spot6m",FH) = 0.22;
p_technoFuelCons("80","1","FH","spot6m",FH) = 0.88;
p_technoMaintenance("80","1","FH","spot6m",FH) = 3.09;
p_technoTimeReq("80","2","FH","spot6m",FH) = 0.23;
p_technoFuelCons("80","2","FH","spot6m",FH) = 0.92;
p_technoMaintenance("80","2","FH","spot6m",FH) = 3.14;
p_technoTimeReq("80","3","FH","spot6m",FH) = 0.25;
p_technoFuelCons("80","3","FH","spot6m",FH) = 0.95;
p_technoMaintenance("80","3","FH","spot6m",FH) = 3.18;
p_technoTimeReq("80","4","FH","spot6m",FH) = 0.26;
p_technoFuelCons("80","4","FH","spot6m",FH) = 0.98;
p_technoMaintenance("80","4","FH","spot6m",FH) = 3.22;
p_technoTimeReq("80","5","FH","spot6m",FH) = 0.27;
p_technoFuelCons("80","5","FH","spot6m",FH) = 1.01;
p_technoMaintenance("80","5","FH","spot6m",FH) = 3.26;
p_technoTimeReq("80","10","FH","spot6m",FH) = 0.31;
p_technoFuelCons("80","10","FH","spot6m",FH) = 1.17;
p_technoMaintenance("80","10","FH","spot6m",FH) = 3.46;
p_technoTimeReq("80","15","FH","spot6m",FH) = 0.36;
p_technoFuelCons("80","15","FH","spot6m",FH) = 1.33;
p_technoMaintenance("80","15","FH","spot6m",FH) = 3.66;


*
* -- spot6m scenario FH+BA FH: 100 l/ha, notFH: 300 l/ha, BA 300 l/ha
*
p_technoTimeReq(KTBL_size,KTBL_distance,"FH+BA","spot6m",FH) = p_technoTimeReq(KTBL_size,KTBL_distance,"FH","spot6m",FH);
p_technoFuelCons(KTBL_size,KTBL_distance,"FH+BA","spot6m",FH) = p_technoFuelCons(KTBL_size,KTBL_distance,"FH","spot6m",FH);
p_technoMaintenance(KTBL_size,KTBL_distance,"FH+BA","spot6m",FH) = p_technoMaintenance(KTBL_size,KTBL_distance,"FH","spot6m",FH);

p_technoTimeReq("1","1","FH+BA","spot6m",notFH) = 0.43;
p_technoFuelCons("1","1","FH+BA","spot6m",notFH) = 1.27;
p_technoMaintenance("1","1","FH+BA","spot6m",notFH) = 4.31;
p_technoTimeReq("1","2","FH+BA","spot6m",notFH) = 0.46;
p_technoFuelCons("1","2","FH+BA","spot6m",notFH) = 1.36;
p_technoMaintenance("1","2","FH+BA","spot6m",notFH) = 4.46;
p_technoTimeReq("1","3","FH+BA","spot6m",notFH) = 0.5;
p_technoFuelCons("1","3","FH+BA","spot6m",notFH) = 1.45;
p_technoMaintenance("1","3","FH+BA","spot6m",notFH) = 4.59;
p_technoTimeReq("1","4","FH+BA","spot6m",notFH) = 0.53;
p_technoFuelCons("1","4","FH+BA","spot6m",notFH) = 1.54;
p_technoMaintenance("1","4","FH+BA","spot6m",notFH) = 4.71;
p_technoTimeReq("1","5","FH+BA","spot6m",notFH) = 0.56;
p_technoFuelCons("1","5","FH+BA","spot6m",notFH) = 1.63;
p_technoMaintenance("1","5","FH+BA","spot6m",notFH) = 4.83;
p_technoTimeReq("1","10","FH+BA","spot6m",notFH) = 0.7;
p_technoFuelCons("1","10","FH+BA","spot6m",notFH) = 2.09;
p_technoMaintenance("1","10","FH+BA","spot6m",notFH) = 5.41;
p_technoTimeReq("1","15","FH+BA","spot6m",notFH) = 0.85;
p_technoFuelCons("1","15","FH+BA","spot6m",notFH) = 2.57;
p_technoMaintenance("1","15","FH+BA","spot6m",notFH) = 6;

p_technoTimeReq("2","1","FH+BA","spot6m",notFH) = 0.35;
p_technoFuelCons("2","1","FH+BA","spot6m",notFH) = 1.12;
p_technoMaintenance("2","1","FH+BA","spot6m",notFH) = 4.0;
p_technoTimeReq("2","2","FH+BA","spot6m",notFH) = 0.39;
p_technoFuelCons("2","2","FH+BA","spot6m",notFH) = 1.21;
p_technoMaintenance("2","2","FH+BA","spot6m",notFH) = 4.14;
p_technoTimeReq("2","3","FH+BA","spot6m",notFH) = 0.42;
p_technoFuelCons("2","3","FH+BA","spot6m",notFH) = 1.3;
p_technoMaintenance("2","3","FH+BA","spot6m",notFH) = 4.27;
p_technoTimeReq("2","4","FH+BA","spot6m",notFH) = 0.45;
p_technoFuelCons("2","4","FH+BA","spot6m",notFH) = 1.39;
p_technoMaintenance("2","4","FH+BA","spot6m",notFH) = 4.4;
p_technoTimeReq("2","5","FH+BA","spot6m",notFH) = 0.48;
p_technoFuelCons("2","5","FH+BA","spot6m",notFH) = 1.48;
p_technoMaintenance("2","5","FH+BA","spot6m",notFH) = 4.51;
p_technoTimeReq("2","10","FH+BA","spot6m",notFH) = 0.63;
p_technoFuelCons("2","10","FH+BA","spot6m",notFH) = 1.94;
p_technoMaintenance("2","10","FH+BA","spot6m",notFH) = 5.1;
p_technoTimeReq("2","15","FH+BA","spot6m",notFH) = 0.78;
p_technoFuelCons("2","15","FH+BA","spot6m",notFH) = 2.41;
p_technoMaintenance("2","15","FH+BA","spot6m",notFH) = 5.69;

p_technoTimeReq("5","1","FH+BA","spot6m",notFH) = 0.37;
p_technoFuelCons("5","1","FH+BA","spot6m",notFH) = 1.2;
p_technoMaintenance("5","1","FH+BA","spot6m",notFH) = 4.08;
p_technoTimeReq("5","2","FH+BA","spot6m",notFH) = 0.4;
p_technoFuelCons("5","2","FH+BA","spot6m",notFH) = 1.29;
p_technoMaintenance("5","2","FH+BA","spot6m",notFH) = 4.21;
p_technoTimeReq("5","3","FH+BA","spot6m",notFH) = 0.44;
p_technoFuelCons("5","3","FH+BA","spot6m",notFH) = 1.38;
p_technoMaintenance("5","3","FH+BA","spot6m",notFH) = 4.34;
p_technoTimeReq("5","4","FH+BA","spot6m",notFH) = 0.47;
p_technoFuelCons("5","4","FH+BA","spot6m",notFH) = 1.47;
p_technoMaintenance("5","4","FH+BA","spot6m",notFH) = 4.47;
p_technoTimeReq("5","5","FH+BA","spot6m",notFH) = 0.5;
p_technoFuelCons("5","5","FH+BA","spot6m",notFH) = 1.56;
p_technoMaintenance("5","5","FH+BA","spot6m",notFH) = 4.58;
p_technoTimeReq("5","10","FH+BA","spot6m",notFH) = 0.64;
p_technoFuelCons("5","10","FH+BA","spot6m",notFH) = 2.01;
p_technoMaintenance("5","10","FH+BA","spot6m",notFH) = 5.16;
p_technoTimeReq("5","15","FH+BA","spot6m",notFH) = 0.79;
p_technoFuelCons("5","15","FH+BA","spot6m",notFH) = 2.49;
p_technoMaintenance("5","15","FH+BA","spot6m",notFH) = 5.76;

p_technoTimeReq("10","1","FH+BA","spot6m",notFH) = 0.34;
p_technoFuelCons("10","1","FH+BA","spot6m",notFH) = 1.15;
p_technoMaintenance("10","1","FH+BA","spot6m",notFH) = 3.97;
p_technoTimeReq("10","2","FH+BA","spot6m",notFH) = 0.38;
p_technoFuelCons("10","2","FH+BA","spot6m",notFH) = 1.24;
p_technoMaintenance("10","2","FH+BA","spot6m",notFH) = 4.11;
p_technoTimeReq("10","3","FH+BA","spot6m",notFH) = 0.41;
p_technoFuelCons("10","3","FH+BA","spot6m",notFH) = 1.33;
p_technoMaintenance("10","3","FH+BA","spot6m",notFH) = 4.24;
p_technoTimeReq("10","4","FH+BA","spot6m",notFH) = 0.44;
p_technoFuelCons("10","4","FH+BA","spot6m",notFH) = 1.42;
p_technoMaintenance("10","4","FH+BA","spot6m",notFH) = 4.36;
p_technoTimeReq("10","5","FH+BA","spot6m",notFH) = 0.47;
p_technoFuelCons("10","5","FH+BA","spot6m",notFH) = 1.5;
p_technoMaintenance("10","5","FH+BA","spot6m",notFH) = 4.48;
p_technoTimeReq("10","10","FH+BA","spot6m",notFH) = 0.62;
p_technoFuelCons("10","10","FH+BA","spot6m",notFH) = 1.96;
p_technoMaintenance("10","10","FH+BA","spot6m",notFH) = 5.07;
p_technoTimeReq("10","15","FH+BA","spot6m",notFH) = 0.77;
p_technoFuelCons("10","15","FH+BA","spot6m",notFH) = 2.43;
p_technoMaintenance("10","15","FH+BA","spot6m",notFH) = 5.66;

p_technoTimeReq("20","1","FH+BA","spot6m",notFH) = 0.35;
p_technoFuelCons("20","1","FH+BA","spot6m",notFH) = 1.19;
p_technoMaintenance("20","1","FH+BA","spot6m",notFH) = 4.0;
p_technoTimeReq("20","2","FH+BA","spot6m",notFH) = 0.39;
p_technoFuelCons("20","2","FH+BA","spot6m",notFH) = 1.28;
p_technoMaintenance("20","2","FH+BA","spot6m",notFH) = 4.14;
p_technoTimeReq("20","3","FH+BA","spot6m",notFH) = 0.42;
p_technoFuelCons("20","3","FH+BA","spot6m",notFH) = 1.37;
p_technoMaintenance("20","3","FH+BA","spot6m",notFH) = 4.27;
p_technoTimeReq("20","4","FH+BA","spot6m",notFH) = 0.45;
p_technoFuelCons("20","4","FH+BA","spot6m",notFH) = 1.46;
p_technoMaintenance("20","4","FH+BA","spot6m",notFH) = 4.39;
p_technoTimeReq("20","5","FH+BA","spot6m",notFH) = 0.48;
p_technoFuelCons("20","5","FH+BA","spot6m",notFH) = 1.55;
p_technoMaintenance("20","5","FH+BA","spot6m",notFH) = 4.51;
p_technoTimeReq("20","10","FH+BA","spot6m",notFH) = 0.62;
p_technoFuelCons("20","10","FH+BA","spot6m",notFH) = 2.0;
p_technoMaintenance("20","10","FH+BA","spot6m",notFH) = 5.1;
p_technoTimeReq("20","15","FH+BA","spot6m",notFH) = 0.77;
p_technoFuelCons("20","15","FH+BA","spot6m",notFH) = 2.48;
p_technoMaintenance("20","15","FH+BA","spot6m",notFH) = 5.69;

p_technoTimeReq("40","1","FH+BA","spot6m",notFH) = 0.36;
p_technoFuelCons("40","1","FH+BA","spot6m",notFH) = 1.26;
p_technoMaintenance("40","1","FH+BA","spot6m",notFH) = 4.05;
p_technoTimeReq("40","2","FH+BA","spot6m",notFH) = 0.4;
p_technoFuelCons("40","2","FH+BA","spot6m",notFH) = 1.35;
p_technoMaintenance("40","2","FH+BA","spot6m",notFH) = 4.19;
p_technoTimeReq("40","3","FH+BA","spot6m",notFH) = 0.43;
p_technoFuelCons("40","3","FH+BA","spot6m",notFH) = 1.44;
p_technoMaintenance("40","3","FH+BA","spot6m",notFH) = 4.33;
p_technoTimeReq("40","4","FH+BA","spot6m",notFH) = 0.46;
p_technoFuelCons("40","4","FH+BA","spot6m",notFH) = 1.53;
p_technoMaintenance("40","4","FH+BA","spot6m",notFH) = 4.45;
p_technoTimeReq("40","5","FH+BA","spot6m",notFH) = 0.49;
p_technoFuelCons("40","5","FH+BA","spot6m",notFH) = 1.62;
p_technoMaintenance("40","5","FH+BA","spot6m",notFH) = 4.56;
p_technoTimeReq("40","10","FH+BA","spot6m",notFH) = 0.64;
p_technoFuelCons("40","10","FH+BA","spot6m",notFH) = 2.08;
p_technoMaintenance("40","10","FH+BA","spot6m",notFH) = 5.15;
p_technoTimeReq("40","15","FH+BA","spot6m",notFH) = 0.79;
p_technoFuelCons("40","15","FH+BA","spot6m",notFH) = 2.55;
p_technoMaintenance("40","15","FH+BA","spot6m",notFH) = 5.74;

p_technoTimeReq("80","1","FH+BA","spot6m",notFH) = 0.38;
p_technoFuelCons("80","1","FH+BA","spot6m",notFH) = 1.36;
p_technoMaintenance("80","1","FH+BA","spot6m",notFH) = 4.13;
p_technoTimeReq("80","2","FH+BA","spot6m",notFH) = 0.42;
p_technoFuelCons("80","2","FH+BA","spot6m",notFH) = 1.46;
p_technoMaintenance("80","2","FH+BA","spot6m",notFH) = 4.28;
p_technoTimeReq("80","3","FH+BA","spot6m",notFH) = 0.45;
p_technoFuelCons("80","3","FH+BA","spot6m",notFH) = 1.55;
p_technoMaintenance("80","3","FH+BA","spot6m",notFH) = 4.41;
p_technoTimeReq("80","4","FH+BA","spot6m",notFH) = 0.48;
p_technoFuelCons("80","4","FH+BA","spot6m",notFH) = 1.64;
p_technoMaintenance("80","4","FH+BA","spot6m",notFH) = 4.53;
p_technoTimeReq("80","5","FH+BA","spot6m",notFH) = 0.51;
p_technoFuelCons("80","5","FH+BA","spot6m",notFH) = 1.72;
p_technoMaintenance("80","5","FH+BA","spot6m",notFH) = 4.65;
p_technoTimeReq("80","10","FH+BA","spot6m",notFH) = 0.66;
p_technoFuelCons("80","10","FH+BA","spot6m",notFH) = 2.18;
p_technoMaintenance("80","10","FH+BA","spot6m",notFH) = 5.23;
p_technoTimeReq("80","15","FH+BA","spot6m",notFH) = 0.81;
p_technoFuelCons("80","15","FH+BA","spot6m",notFH) = 2.66;
p_technoMaintenance("80","15","FH+BA","spot6m",notFH) = 5.83;


p_technoTimeReq(KTBL_size,KTBL_distance,"BA","spot6m",pestType) = p_technoTimeReq(KTBL_size,KTBL_distance,"FH+BA","spot6m","soilHerb");
p_technoFuelCons(KTBL_size,KTBL_distance,"BA","spot6m",pestType) = p_technoFuelCons(KTBL_size,KTBL_distance,"FH+BA","spot6m","soilHerb");
p_technoMaintenance(KTBL_size,KTBL_distance,"BA","spot6m",pestType) = p_technoMaintenance(KTBL_size,KTBL_distance,"FH+BA","spot6m","soilHerb");


*
* -- Spot6m scenario FH+Bonus: FHBonus: 100 l/ha
*
p_technoTimeReq(KTBL_size,KTBL_distance,"FH+Bonus","spot6m",FHBonus) = p_technoTimeReq(KTBL_size,KTBL_distance,"FH","spot6m","foliarHerb");
p_technoFuelCons(KTBL_size,KTBL_distance,"FH+Bonus","spot6m",FHBonus) = p_technoFuelCons(KTBL_size,KTBL_distance,"FH","spot6m","foliarHerb");
p_technoMaintenance(KTBL_size,KTBL_distance,"FH+Bonus","spot6m",FHBonus) = p_technoMaintenance(KTBL_size,KTBL_distance,"FH","spot6m","foliarHerb");


*
* -- Spot6m scenario FH+Bonus+BA: FHBonus: 100 l/ha, notFHBonus: 300 l/ha
*
p_technoTimeReq(KTBL_size,KTBL_distance,"FH+Bonus+BA","spot6m",FHBonus) = p_technoTimeReq(KTBL_size,KTBL_distance,"FH","spot6m","foliarHerb");
p_technoFuelCons(KTBL_size,KTBL_distance,"FH+Bonus+BA","spot6m",FHBonus) = p_technoFuelCons(KTBL_size,KTBL_distance,"FH","spot6m","foliarHerb");
p_technoMaintenance(KTBL_size,KTBL_distance,"FH+Bonus+BA","spot6m",FHBonus) = p_technoMaintenance(KTBL_size,KTBL_distance,"FH","spot6m","foliarHerb");

p_technoTimeReq(KTBL_size,KTBL_distance,"FH+Bonus+BA","spot6m",notFHBonus) = p_technoTimeReq(KTBL_size,KTBL_distance,"FH+BA","spot6m","soilHerb");
p_technoFuelCons(KTBL_size,KTBL_distance,"FH+Bonus+BA","spot6m",notFHBonus) = p_technoFuelCons(KTBL_size,KTBL_distance,"FH+BA","spot6m","soilHerb");
p_technoMaintenance(KTBL_size,KTBL_distance,"FH+Bonus+BA","spot6m",notFHBonus) = p_technoMaintenance(KTBL_size,KTBL_distance,"FH+BA","spot6m","soilHerb");



*
* --- Parameters for correction of data for spot6m which is drawn from a sprayer with 12m
* it is assumed, that the factor by which the parameters are higher for the spot6m sprayer is the same like the factor by which the data is higher for a 12m sprayer compared to a 24m sprayer with same tank volume
parameters
   p_spot6mCorTimeReq(KTBL_size,KTBL_distance,scenario,pestType)
   p_spot6mCorFuelCons(KTBL_size,KTBL_distance,scenario,pestType)
   p_spot6mCorMaintenance(KTBL_size,KTBL_distance,scenario,pestType)
;

p_spot6mCorTimeReq("1","1","FH",FH) = 0.26;
p_spot6mCorFuelCons("1","1","FH",FH) = 0.81;
p_spot6mCorMaintenance("1","1","FH",FH) = 3.25;
p_spot6mCorTimeReq("1","2","FH",FH) = 0.27;
p_spot6mCorFuelCons("1","2","FH",FH) = 0.85;
p_spot6mCorMaintenance("1","2","FH",FH) = 3.3; 
p_spot6mCorTimeReq("1","3","FH",FH) = 0.28;
p_spot6mCorFuelCons("1","3","FH",FH) = 0.89;
p_spot6mCorMaintenance("1","3","FH",FH) = 3.34;
p_spot6mCorTimeReq("1","4","FH",FH) = 0.29;
p_spot6mCorFuelCons("1","4","FH",FH) = 0.92;
p_spot6mCorMaintenance("1","4","FH",FH) = 3.38;
p_spot6mCorTimeReq("1","5","FH",FH) = 0.30;
p_spot6mCorFuelCons("1","5","FH",FH) = 0.96;
p_spot6mCorMaintenance("1","5","FH",FH) = 3.42;
p_spot6mCorTimeReq("1","10","FH",FH) = 0.35;
p_spot6mCorFuelCons("1","10","FH",FH) = 1.14;
p_spot6mCorMaintenance("1","10","FH",FH) = 3.61;
p_spot6mCorTimeReq("1","15","FH",FH) = 0.4;
p_spot6mCorFuelCons("1","15","FH",FH) = 1.33;
p_spot6mCorMaintenance("1","15","FH",FH) = 3.81;

p_spot6mCorTimeReq("2","1","FH",FH) = 0.21;
p_spot6mCorFuelCons("2","1","FH",FH) = 0.73;
p_spot6mCorMaintenance("2","1","FH",FH) = 3.03;
p_spot6mCorTimeReq("2","2","FH",FH) = 0.22;
p_spot6mCorFuelCons("2","2","FH",FH) = 0.77;
p_spot6mCorMaintenance("2","2","FH",FH) = 3.08;
p_spot6mCorTimeReq("2","3","FH",FH) = 0.23;
p_spot6mCorFuelCons("2","3","FH",FH) = 0.81;
p_spot6mCorMaintenance("2","3","FH",FH) = 3.13;
p_spot6mCorTimeReq("2","4","FH",FH) = 0.24;
p_spot6mCorFuelCons("2","4","FH",FH) = 0.84;
p_spot6mCorMaintenance("2","4","FH",FH) = 3.16;
p_spot6mCorTimeReq("2","5","FH",FH) = 0.25;
p_spot6mCorFuelCons("2","5","FH",FH) = 0.88;
p_spot6mCorMaintenance("2","5","FH",FH) = 3.21;
p_spot6mCorTimeReq("2","10","FH",FH) = 0.3;
p_spot6mCorFuelCons("2","10","FH",FH) = 1.06;
p_spot6mCorMaintenance("2","10","FH",FH) = 3.4;
p_spot6mCorTimeReq("2","15","FH",FH) = 0.35;
p_spot6mCorFuelCons("2","15","FH",FH) = 1.24;
p_spot6mCorMaintenance("2","15","FH",FH) = 3.59;

p_spot6mCorTimeReq("5","1","FH",FH) = 0.15;
p_spot6mCorFuelCons("5","1","FH",FH) =  0.59;
p_spot6mCorMaintenance("5","1","FH",FH) = 2.82;
p_spot6mCorTimeReq("5","2","FH",FH) = 0.17;
p_spot6mCorFuelCons("5","2","FH",FH) = 0.62;
p_spot6mCorMaintenance("5","2","FH",FH) = 2.86;
p_spot6mCorTimeReq("5","3","FH",FH) = 0.18;
p_spot6mCorFuelCons("5","3","FH",FH) = 0.66;
p_spot6mCorMaintenance("5","3","FH",FH) = 2.91;
p_spot6mCorTimeReq("5","4","FH",FH) = 0.19;
p_spot6mCorFuelCons("5","4","FH",FH) = 0.69;
p_spot6mCorMaintenance("5","4","FH",FH) = 2.95;
p_spot6mCorTimeReq("5","5","FH",FH) = 0.2;
p_spot6mCorFuelCons("5","5","FH",FH) = 0.73;
p_spot6mCorMaintenance("5","5","FH",FH) = 2.98;
p_spot6mCorTimeReq("5","10","FH",FH) = 0.25;
p_spot6mCorFuelCons("5","10","FH",FH) = 0.90;
p_spot6mCorMaintenance("5","10","FH",FH) = 3.18;
p_spot6mCorTimeReq("5","15","FH",FH) = 0.29;
p_spot6mCorFuelCons("5","15","FH",FH) = 1.08;
p_spot6mCorMaintenance("5","15","FH",FH) = 3.37;

p_spot6mCorTimeReq("10","1","FH",FH) = 0.16;
p_spot6mCorFuelCons("10","1","FH",FH) = 0.64;
p_spot6mCorMaintenance("10","1","FH",FH) = 2.83;
p_spot6mCorTimeReq("10","2","FH",FH) = 0.17;
p_spot6mCorFuelCons("10","2","FH",FH) = 0.67;
p_spot6mCorMaintenance("10","2","FH",FH) = 2.88;
p_spot6mCorTimeReq("10","3","FH",FH) = 0.18;
p_spot6mCorFuelCons("10","3","FH",FH) = 0.71;
p_spot6mCorMaintenance("10","3","FH",FH) = 2.92;
p_spot6mCorTimeReq("10","4","FH",FH) = 0.19;
p_spot6mCorFuelCons("10","4","FH",FH) = 0.74;
p_spot6mCorMaintenance("10","4","FH",FH) = 2.96;
p_spot6mCorTimeReq("10","5","FH",FH) = 0.20;
p_spot6mCorFuelCons("10","5","FH",FH) = 0.77;
p_spot6mCorMaintenance("10","5","FH",FH) = 3.00;
p_spot6mCorTimeReq("10","10","FH",FH) = 0.25;
p_spot6mCorFuelCons("10","10","FH",FH) = 0.95;
p_spot6mCorMaintenance("10","10","FH",FH) = 3.2;
p_spot6mCorTimeReq("10","15","FH",FH) = 0.30;
p_spot6mCorFuelCons("10","15","FH",FH) = 1.13;
p_spot6mCorMaintenance("10","15","FH",FH) = 3.39;

p_spot6mCorTimeReq("20","1","FH",FH) = 0.16;
p_spot6mCorFuelCons("20","1","FH",FH) = 0.64;
p_spot6mCorMaintenance("20","1","FH",FH) = 2.82;
p_spot6mCorTimeReq("20","2","FH",FH) = 0.17;
p_spot6mCorFuelCons("20","2","FH",FH) = 0.68;
p_spot6mCorMaintenance("20","2","FH",FH) = 2.87;
p_spot6mCorTimeReq("20","3","FH",FH) = 0.18;
p_spot6mCorFuelCons("20","3","FH",FH) = 0.71;
p_spot6mCorMaintenance("20","3","FH",FH) = 2.92;
p_spot6mCorTimeReq("20","4","FH",FH) = 0.19;
p_spot6mCorFuelCons("20","4","FH",FH) = 0.75;
p_spot6mCorMaintenance("20","4","FH",FH) = 2.96;
p_spot6mCorTimeReq("20","5","FH",FH) = 0.20;
p_spot6mCorFuelCons("20","5","FH",FH) = 0.78;
p_spot6mCorMaintenance("20","5","FH",FH) = 3.00;
p_spot6mCorTimeReq("20","10","FH",FH) = 0.25;
p_spot6mCorFuelCons("20","10","FH",FH) = 0.96;
p_spot6mCorMaintenance("20","10","FH",FH) = 3.20;
p_spot6mCorTimeReq("20","15","FH",FH) = 0.30;
p_spot6mCorFuelCons("20","15","FH",FH) = 1.14;
p_spot6mCorMaintenance("20","15","FH",FH) = 3.38;

p_spot6mCorTimeReq("40","1","FH",FH) = 0.15;
p_spot6mCorFuelCons("40","1","FH",FH) = 0.63;
p_spot6mCorMaintenance("40","1","FH",FH) = 2.80;
p_spot6mCorTimeReq("40","2","FH",FH) = 0.16;
p_spot6mCorFuelCons("40","2","FH",FH) = 0.67;
p_spot6mCorMaintenance("40","2","FH",FH) = 2.85;
p_spot6mCorTimeReq("40","3","FH",FH) = 0.17;
p_spot6mCorFuelCons("40","3","FH",FH) = 0.7;
p_spot6mCorMaintenance("40","3","FH",FH) = 2.90;
p_spot6mCorTimeReq("40","4","FH",FH) = 0.18;
p_spot6mCorFuelCons("40","4","FH",FH) = 0.74;
p_spot6mCorMaintenance("40","4","FH",FH) = 2.94;
p_spot6mCorTimeReq("40","5","FH",FH) = 0.19;
p_spot6mCorFuelCons("40","5","FH",FH) = 0.77;
p_spot6mCorMaintenance("40","5","FH",FH) = 2.98;
p_spot6mCorTimeReq("40","10","FH",FH) = 0.24;
p_spot6mCorFuelCons("40","10","FH",FH) = 0.95;
p_spot6mCorMaintenance("40","10","FH",FH) = 3.17;
p_spot6mCorTimeReq("40","15","FH",FH) = 0.29;
p_spot6mCorFuelCons("40","15","FH",FH) = 1.13;
p_spot6mCorMaintenance("40","15","FH",FH) = 3.37;

p_spot6mCorTimeReq("80","1","FH",FH) = 0.16;
p_spot6mCorFuelCons("80","1","FH",FH) = 0.68;
p_spot6mCorMaintenance("80","1","FH",FH) = 2.84;
p_spot6mCorTimeReq("80","2","FH",FH) = 0.17;
p_spot6mCorFuelCons("80","2","FH",FH) = 0.71;
p_spot6mCorMaintenance("80","2","FH",FH) = 2.88;
p_spot6mCorTimeReq("80","3","FH",FH) = 0.18;
p_spot6mCorFuelCons("80","3","FH",FH) = 0.75;
p_spot6mCorMaintenance("80","3","FH",FH) = 2.93;
p_spot6mCorTimeReq("80","4","FH",FH) = 0.19;
p_spot6mCorFuelCons("80","4","FH",FH) = 0.78;
p_spot6mCorMaintenance("80","4","FH",FH) = 2.97;
p_spot6mCorTimeReq("80","5","FH",FH) = 0.20;
p_spot6mCorFuelCons("80","5","FH",FH) = 0.82;
p_spot6mCorMaintenance("80","5","FH",FH) = 3.01;
p_spot6mCorTimeReq("80","10","FH",FH) = 0.25;
p_spot6mCorFuelCons("80","10","FH",FH) = 0.99;
p_spot6mCorMaintenance("80","10","FH",FH) = 3.20;
p_spot6mCorTimeReq("80","15","FH",FH) = 0.30;
p_spot6mCorFuelCons("80","15","FH",FH) = 1.18;
p_spot6mCorMaintenance("80","15","FH",FH) = 3.40;


*
* -- spot6m scenario FH+BA FH: 100 l/ha, notFH: 300 l/ha, BA: 300 l/ha
*
p_spot6mCorTimeReq(KTBL_size,KTBL_distance,"FH+BA",FH) = p_spot6mCorTimeReq(KTBL_size,KTBL_distance,"FH","foliarHerb");
p_spot6mCorFuelCons(KTBL_size,KTBL_distance,"FH+BA",FH) = p_spot6mCorFuelCons(KTBL_size,KTBL_distance,"FH","foliarHerb");
p_spot6mCorMaintenance(KTBL_size,KTBL_distance,"FH+BA",FH) = p_spot6mCorMaintenance(KTBL_size,KTBL_distance,"FH","foliarHerb");

p_spot6mCorTimeReq("1","1","FH+BA",notFH) = 0.35;
p_spot6mCorFuelCons("1","1","FH+BA",notFH) = 1.00;
p_spot6mCorMaintenance("1","1","FH+BA",notFH) = 3.99;
p_spot6mCorTimeReq("1","2","FH+BA",notFH) = 0.38;
p_spot6mCorFuelCons("1","2","FH+BA",notFH) = 1.11;
p_spot6mCorMaintenance("1","2","FH+BA",notFH) = 4.13;
p_spot6mCorTimeReq("1","3","FH+BA",notFH) = 0.41;
p_spot6mCorFuelCons("1","3","FH+BA",notFH) = 1.21;
p_spot6mCorMaintenance("1","3","FH+BA",notFH) = 4.26;
p_spot6mCorTimeReq("1","4","FH+BA",notFH) = 0.45;
p_spot6mCorFuelCons("1","4","FH+BA",notFH) = 1.31;
p_spot6mCorMaintenance("1","4","FH+BA",notFH) = 4.38;
p_spot6mCorTimeReq("1","5","FH+BA",notFH) = 0.47;
p_spot6mCorFuelCons("1","5","FH+BA",notFH) = 1.41;
p_spot6mCorMaintenance("1","5","FH+BA",notFH) = 4.50;
p_spot6mCorTimeReq("1","10","FH+BA",notFH) = 0.62;
p_spot6mCorFuelCons("1","10","FH+BA",notFH) = 1.93;
p_spot6mCorMaintenance("1","10","FH+BA",notFH) = 5.08;
p_spot6mCorTimeReq("1","15","FH+BA",notFH) = 0.77;
p_spot6mCorFuelCons("1","15","FH+BA",notFH) = 2.48;
p_spot6mCorMaintenance("1","15","FH+BA",notFH) = 5.68;

p_spot6mCorTimeReq("2","1","FH+BA",notFH) = 0.28;
p_spot6mCorFuelCons("2","1","FH+BA",notFH) = 0.89;
p_spot6mCorMaintenance("2","1","FH+BA",notFH) = 3.71;
p_spot6mCorTimeReq("2","2","FH+BA",notFH) = 0.31;
p_spot6mCorFuelCons("2","2","FH+BA",notFH) = 0.99;
p_spot6mCorMaintenance("2","2","FH+BA",notFH) = 3.85;
p_spot6mCorTimeReq("2","3","FH+BA",notFH) = 0.35;
p_spot6mCorFuelCons("2","3","FH+BA",notFH) = 1.10;
p_spot6mCorMaintenance("2","3","FH+BA",notFH) = 3.98;
p_spot6mCorTimeReq("2","4","FH+BA",notFH) = 0.38;
p_spot6mCorFuelCons("2","4","FH+BA",notFH) = 1.20;
p_spot6mCorMaintenance("2","4","FH+BA",notFH) = 4.10;
p_spot6mCorTimeReq("2","5","FH+BA",notFH) = 0.41;
p_spot6mCorFuelCons("2","5","FH+BA",notFH) = 1.30;
p_spot6mCorMaintenance("2","5","FH+BA",notFH) = 4.22;
p_spot6mCorTimeReq("2","10","FH+BA",notFH) = 0.55;
p_spot6mCorFuelCons("2","10","FH+BA",notFH) = 1.81;
p_spot6mCorMaintenance("2","10","FH+BA",notFH) = 4.81; 
p_spot6mCorTimeReq("2","15","FH+BA",notFH) = 0.70;
p_spot6mCorFuelCons("2","15","FH+BA",notFH) = 2.35;
p_spot6mCorMaintenance("2","15","FH+BA",notFH) = 5.40;

p_spot6mCorTimeReq("5","1","FH+BA",notFH) = 0.30;
p_spot6mCorFuelCons("5","1","FH+BA",notFH) = 0.98;
p_spot6mCorMaintenance("5","1","FH+BA",notFH) = 3.80;
p_spot6mCorTimeReq("5","2","FH+BA",notFH) = 0.34;
p_spot6mCorFuelCons("5","2","FH+BA",notFH) = 1.09;
p_spot6mCorMaintenance("5","2","FH+BA",notFH) = 3.94;
p_spot6mCorTimeReq("5","3","FH+BA",notFH) = 0.37;
p_spot6mCorFuelCons("5","3","FH+BA",notFH) = 1.19;
p_spot6mCorMaintenance("5","3","FH+BA",notFH) = 4.08;
p_spot6mCorTimeReq("5","4","FH+BA",notFH) = 0.40;
p_spot6mCorFuelCons("5","4","FH+BA",notFH) = 1.28;
p_spot6mCorMaintenance("5","4","FH+BA",notFH) = 4.19;
p_spot6mCorTimeReq("5","5","FH+BA",notFH) = 0.43;
p_spot6mCorFuelCons("5","5","FH+BA",notFH) = 1.39;
p_spot6mCorMaintenance("5","5","FH+BA",notFH) = 4.31;
p_spot6mCorTimeReq("5","10","FH+BA",notFH) = 0.57;
p_spot6mCorFuelCons("5","10","FH+BA",notFH) = 1.89;
p_spot6mCorMaintenance("5","10","FH+BA",notFH) = 4.88;
p_spot6mCorTimeReq("5","15","FH+BA",notFH) = 0.72;
p_spot6mCorFuelCons("5","15","FH+BA",notFH) = 2.44;
p_spot6mCorMaintenance("5","15","FH+BA",notFH) = 5.48;

p_spot6mCorTimeReq("10","1","FH+BA",notFH) = 0.28;
p_spot6mCorFuelCons("10","1","FH+BA",notFH) = 0.96;
p_spot6mCorMaintenance("10","1","FH+BA",notFH) = 3.74;
p_spot6mCorTimeReq("10","2","FH+BA",notFH) = 0.32;
p_spot6mCorFuelCons("10","2","FH+BA",notFH) = 1.07;
p_spot6mCorMaintenance("10","2","FH+BA",notFH) = 3.87;
p_spot6mCorTimeReq("10","3","FH+BA",notFH) = 0.35;
p_spot6mCorFuelCons("10","3","FH+BA",notFH) = 1.17;
p_spot6mCorMaintenance("10","3","FH+BA",notFH) = 4.00;
p_spot6mCorTimeReq("10","4","FH+BA",notFH) = 0.38;
p_spot6mCorFuelCons("10","4","FH+BA",notFH) = 1.27;
p_spot6mCorMaintenance("10","4","FH+BA",notFH) = 4.13;
p_spot6mCorTimeReq("10","5","FH+BA",notFH) = 0.41;
p_spot6mCorFuelCons("10","5","FH+BA",notFH) = 1.37;
p_spot6mCorMaintenance("10","5","FH+BA",notFH) = 4.24;
p_spot6mCorTimeReq("10","10","FH+BA",notFH) = 0.56;
p_spot6mCorFuelCons("10","10","FH+BA",notFH) = 1.88;
p_spot6mCorMaintenance("10","10","FH+BA",notFH) = 4.83;
p_spot6mCorTimeReq("10","15","FH+BA",notFH) = 0.71;
p_spot6mCorFuelCons("10","15","FH+BA",notFH) = 2.42;
p_spot6mCorMaintenance("10","15","FH+BA",notFH) = 5.42;

p_spot6mCorTimeReq("20","1","FH+BA",notFH) = 0.29;
p_spot6mCorFuelCons("20","1","FH+BA",notFH) = 1.02;
p_spot6mCorMaintenance("20","1","FH+BA",notFH) = 3.77;
p_spot6mCorTimeReq("20","2","FH+BA",notFH) = 0.33;
p_spot6mCorFuelCons("20","2","FH+BA",notFH) = 1.12;
p_spot6mCorMaintenance("20","2","FH+BA",notFH) = 3.91;
p_spot6mCorTimeReq("20","3","FH+BA",notFH) = 0.36;
p_spot6mCorFuelCons("20","3","FH+BA",notFH) = 1.22;
p_spot6mCorMaintenance("20","3","FH+BA",notFH) = 4.04;
p_spot6mCorTimeReq("20","4","FH+BA",notFH) = 0.39;
p_spot6mCorFuelCons("20","4","FH+BA",notFH) = 1.32;
p_spot6mCorMaintenance("20","4","FH+BA",notFH) = 4.16;
p_spot6mCorTimeReq("20","5","FH+BA",notFH) = 0.42;
p_spot6mCorFuelCons("20","5","FH+BA",notFH) = 1.42;
p_spot6mCorMaintenance("20","5","FH+BA",notFH) = 4.28;
p_spot6mCorTimeReq("20","10","FH+BA",notFH) = 0.57;
p_spot6mCorFuelCons("20","10","FH+BA",notFH) = 1.93;
p_spot6mCorMaintenance("20","10","FH+BA",notFH) = 4.87;
p_spot6mCorTimeReq("20","15","FH+BA",notFH) = 0.71;
p_spot6mCorFuelCons("20","15","FH+BA",notFH) = 2.47;
p_spot6mCorMaintenance("20","15","FH+BA",notFH) = 5.46;

p_spot6mCorTimeReq("40","1","FH+BA",notFH) = 0.30;
p_spot6mCorFuelCons("40","1","FH+BA",notFH) = 1.09;
p_spot6mCorMaintenance("40","1","FH+BA",notFH) = 3.82;
p_spot6mCorTimeReq("40","2","FH+BA",notFH) = 0.34;
p_spot6mCorFuelCons("40","2","FH+BA",notFH) = 1.19;
p_spot6mCorMaintenance("40","2","FH+BA",notFH) = 3.96;
p_spot6mCorTimeReq("40","3","FH+BA",notFH) = 0.37;
p_spot6mCorFuelCons("40","3","FH+BA",notFH) = 1.30;
p_spot6mCorMaintenance("40","3","FH+BA",notFH) = 4.09;
p_spot6mCorTimeReq("40","4","FH+BA",notFH) = 0.40;
p_spot6mCorFuelCons("40","4","FH+BA",notFH) = 1.40;
p_spot6mCorMaintenance("40","4","FH+BA",notFH) = 4.21;
p_spot6mCorTimeReq("40","5","FH+BA",notFH) = 0.43;
p_spot6mCorFuelCons("40","5","FH+BA",notFH) = 1.50;
p_spot6mCorMaintenance("40","5","FH+BA",notFH) = 4.33;
p_spot6mCorTimeReq("40","10","FH+BA",notFH) = 0.58;
p_spot6mCorFuelCons("40","10","FH+BA",notFH) = 2.01;
p_spot6mCorMaintenance("40","10","FH+BA",notFH) = 4.92;
p_spot6mCorTimeReq("40","15","FH+BA",notFH) = 0.73;
p_spot6mCorFuelCons("40","15","FH+BA",notFH) = 2.55;
p_spot6mCorMaintenance("40","15","FH+BA",notFH) = 5.51;

p_spot6mCorTimeReq("80","1","FH+BA",notFH) = 0.33;
p_spot6mCorFuelCons("80","1","FH+BA",notFH) = 1.22;
p_spot6mCorMaintenance("80","1","FH+BA",notFH) = 3.91;
p_spot6mCorTimeReq("80","2","FH+BA",notFH) = 0.36;
p_spot6mCorFuelCons("80","2","FH+BA",notFH) = 1.33;
p_spot6mCorMaintenance("80","2","FH+BA",notFH) = 4.06;
p_spot6mCorTimeReq("80","3","FH+BA",notFH) = 0.40;
p_spot6mCorFuelCons("80","3","FH+BA",notFH) = 1.43;
p_spot6mCorMaintenance("80","3","FH+BA",notFH) = 4.19;
p_spot6mCorTimeReq("80","4","FH+BA",notFH) = 0.43;
p_spot6mCorFuelCons("80","4","FH+BA",notFH) = 1.53;
p_spot6mCorMaintenance("80","4","FH+BA",notFH) = 4.31;
p_spot6mCorTimeReq("80","5","FH+BA",notFH) = 0.46;
p_spot6mCorFuelCons("80","5","FH+BA",notFH) = 1.63;
p_spot6mCorMaintenance("80","5","FH+BA",notFH) = 4.42;
p_spot6mCorTimeReq("80","10","FH+BA",notFH) = 0.60;
p_spot6mCorFuelCons("80","10","FH+BA",notFH) = 2.15;
p_spot6mCorMaintenance("80","10","FH+BA",notFH) = 5.01;
p_spot6mCorTimeReq("80","15","FH+BA",notFH) = 0.75;
p_spot6mCorFuelCons("80","15","FH+BA",notFH) = 2.69;
p_spot6mCorMaintenance("80","15","FH+BA",notFH) = 5.60;


p_spot6mCorTimeReq(KTBL_size,KTBL_distance,"BA",pestType) = p_spot6mCorTimeReq(KTBL_size,KTBL_distance,"FH+BA","soilHerb");
p_spot6mCorFuelCons(KTBL_size,KTBL_distance,"BA",pestType) = p_spot6mCorFuelCons(KTBL_size,KTBL_distance,"FH+BA","soilHerb");
p_spot6mCorMaintenance(KTBL_size,KTBL_distance,"BA",pestType) = p_spot6mCorMaintenance(KTBL_size,KTBL_distance,"FH+BA","soilHerb");

*
* -- Correction spot6m scenario FH+Bonus: FHBonus: 100 l/ha
*
p_spot6mCorTimeReq(KTBL_size,KTBL_distance,"FH+Bonus",FHBonus) = p_spot6mCorTimeReq(KTBL_size,KTBL_distance,"FH","foliarHerb");
p_spot6mCorFuelCons(KTBL_size,KTBL_distance,"FH+Bonus",FHBonus) = p_spot6mCorFuelCons(KTBL_size,KTBL_distance,"FH","foliarHerb");
p_spot6mCorMaintenance(KTBL_size,KTBL_distance,"FH+Bonus",FHBonus) = p_spot6mCorMaintenance(KTBL_size,KTBL_distance,"FH","foliarHerb");


*
* -- Correction spot6m scenario FH+Bonus+BA: FHBonus: 100 l/ha, notFHBonus: 300 l/ha
*
p_spot6mCorTimeReq(KTBL_size,KTBL_distance,"FH+Bonus+BA",FHBonus) = p_spot6mCorTimeReq(KTBL_size,KTBL_distance,"FH","foliarHerb");
p_spot6mCorFuelCons(KTBL_size,KTBL_distance,"FH+Bonus+BA",FHBonus) = p_spot6mCorFuelCons(KTBL_size,KTBL_distance,"FH","foliarHerb");
p_spot6mCorMaintenance(KTBL_size,KTBL_distance,"FH+Bonus+BA",FHBonus) = p_spot6mCorMaintenance(KTBL_size,KTBL_distance,"FH","foliarHerb");

p_spot6mCorTimeReq(KTBL_size,KTBL_distance,"FH+Bonus+BA",notFHBonus) = p_spot6mCorTimeReq(KTBL_size,KTBL_distance,"FH+BA","soilHerb");
p_spot6mCorFuelCons(KTBL_size,KTBL_distance,"FH+Bonus+BA",notFHBonus) = p_spot6mCorFuelCons(KTBL_size,KTBL_distance,"FH+BA","soilHerb");
p_spot6mCorMaintenance(KTBL_size,KTBL_distance,"FH+Bonus+BA",notFHBonus) = p_spot6mCorMaintenance(KTBL_size,KTBL_distance,"FH+BA","soilHerb");






p_technoMaintenance(KTBL_size,KTBL_distance,scenario,"spot6m",pestType) = 
    p_technoMaintenance(KTBL_size,KTBL_distance,scenario,"spot6m",pestType) 
    * (p_technoMaintenance(KTBL_size,KTBL_distance,scenario,"spot6m",pestType) / p_spot6mCorMaintenance(KTBL_size,KTBL_distance,scenario,pestType))
;

p_technoMaintenance(KTBL_size,KTBL_distance,scenario,"spot6m",pestType) = 
    p_technoMaintenance(KTBL_size,KTBL_distance,scenario,"spot6m",pestType) * 2
;


p_technoTimeReq(KTBL_size,KTBL_distance,scenario,"spot6m",pestType) = 
    p_technoTimeReq(KTBL_size,KTBL_distance,scenario,"spot6m",pestType) 
    * (p_technoTimeReq(KTBL_size,KTBL_distance,scenario,"spot6m",pestType) / p_spot6mCorTimeReq(KTBL_size,KTBL_distance,scenario,pestType))
;


p_technoFuelCons(KTBL_size,KTBL_distance,scenario,"spot6m",pestType) =
    p_technoFuelCons(KTBL_size,KTBL_distance,scenario,"spot6m",pestType) 
    * (p_technoFuelCons(KTBL_size,KTBL_distance,scenario,"spot6m",pestType) / p_spot6mCorFuelCons(KTBL_size,KTBL_distance,scenario,pestType))
;

*assumption: 27m, 3.000 l; 83 kW (KTBL Feldarbeitsrechner) -> 25.07.2024, 100 l/ha
*
* -- spot 27m scenario FH: FH: 100 l/ha, notFH: 300 l/ha
*
p_technoTimeReq("1","1","FH","spot27m",FH) = 0.25;
p_technoFuelCons("1","1","FH","spot27m",FH) = 1.63;
p_technoMaintenance("1","1","FH","spot27m",FH) = 3.98;
p_technoTimeReq("1","2","FH","spot27m",FH) = 0.26;
p_technoFuelCons("1","2","FH","spot27m",FH) = 1.64;
p_technoMaintenance("1","2","FH","spot27m",FH) = 3.99;
p_technoTimeReq("1","3","FH","spot27m",FH) = 0.26;
p_technoFuelCons("1","3","FH","spot27m",FH) = 1.67;
p_technoMaintenance("1","3","FH","spot27m",FH) = 4.02;
p_technoTimeReq("1","4","FH","spot27m",FH) = 0.26;
p_technoFuelCons("1","4","FH","spot27m",FH) = 1.70;
p_technoMaintenance("1","4","FH","spot27m",FH) = 4.04;
p_technoTimeReq("1","5","FH","spot27m",FH) = 0.26;
p_technoFuelCons("1","5","FH","spot27m",FH) = 1.72;
p_technoMaintenance("1","5","FH","spot27m",FH) = 4.05;
p_technoTimeReq("1","10","FH","spot27m",FH) = 0.28;
p_technoFuelCons("1","10","FH","spot27m",FH) = 1.86;
p_technoMaintenance("1","10","FH","spot27m",FH) = 4.16;
p_technoTimeReq("1","15","FH","spot27m",FH) = 0.30;
p_technoFuelCons("1","15","FH","spot27m",FH) = 2.04;
p_technoMaintenance("1","15","FH","spot27m",FH) = 4.30;

p_technoTimeReq("2","1","FH","spot27m",FH) = 0.18;
p_technoFuelCons("2","1","FH","spot27m",FH) = 1.23;
p_technoMaintenance("2","1","FH","spot27m",FH) = 3.43;
p_technoTimeReq("2","2","FH","spot27m",FH) = 0.18;
p_technoFuelCons("2","2","FH","spot27m",FH) = 1.25;
p_technoMaintenance("2","2","FH","spot27m",FH) = 3.44;
p_technoTimeReq("2","3","FH","spot27m",FH) = 0.18;
p_technoFuelCons("2","3","FH","spot27m",FH) = 1.27;
p_technoMaintenance("2","3","FH","spot27m",FH) = 3.45;
p_technoTimeReq("2","4","FH","spot27m",FH) = 0.18;
p_technoFuelCons("2","4","FH","spot27m",FH) = 1.29;
p_technoMaintenance("2","4","FH","spot27m",FH) = 3.47;
p_technoTimeReq("2","5","FH","spot27m",FH) = 0.19;
p_technoFuelCons("2","5","FH","spot27m",FH) = 1.30;
p_technoMaintenance("2","5","FH","spot27m",FH) = 3.48;
p_technoTimeReq("2","10","FH","spot27m",FH) = 0.20;
p_technoFuelCons("2","10","FH","spot27m",FH) = 1.40;
p_technoMaintenance("2","10","FH","spot27m",FH) = 3.55;
p_technoTimeReq("2","15","FH","spot27m",FH) = 0.21;
p_technoFuelCons("2","15","FH","spot27m",FH) = 1.51;
p_technoMaintenance("2","15","FH","spot27m",FH) = 3.63;

p_technoTimeReq("5","1","FH","spot27m",FH) = 0.12;
p_technoFuelCons("5","1","FH","spot27m",FH) = 0.94;
p_technoMaintenance("5","1","FH","spot27m",FH) = 3.03;
p_technoTimeReq("5","2","FH","spot27m",FH) = 0.12;
p_technoFuelCons("5","2","FH","spot27m",FH) = 0.96;
p_technoMaintenance("5","2","FH","spot27m",FH) = 3.04;
p_technoTimeReq("5","3","FH","spot27m",FH) = 0.12;
p_technoFuelCons("5","3","FH","spot27m",FH) = 0.98;
p_technoMaintenance("5","3","FH","spot27m",FH) = 3.06;
p_technoTimeReq("5","4","FH","spot27m",FH) = 0.12;
p_technoFuelCons("5","4","FH","spot27m",FH) = 1.00;
p_technoMaintenance("5","4","FH","spot27m",FH) = 3.07;
p_technoTimeReq("5","5","FH","spot27m",FH) = 0.13;
p_technoFuelCons("5","5","FH","spot27m",FH) = 1.01;
p_technoMaintenance("5","5","FH","spot27m",FH) = 3.09;
p_technoTimeReq("5","10","FH","spot27m",FH) = 0.14;
p_technoFuelCons("5","10","FH","spot27m",FH) = 1.10;
p_technoMaintenance("5","10","FH","spot27m",FH) = 3.16;
p_technoTimeReq("5","15","FH","spot27m",FH) = 0.15;
p_technoFuelCons("5","15","FH","spot27m",FH) = 1.20;
p_technoMaintenance("5","15","FH","spot27m",FH) = 3.23;

p_technoTimeReq("10","1","FH","spot27m",FH) = 0.10;
p_technoFuelCons("10","1","FH","spot27m",FH) = 0.88;
p_technoMaintenance("10","1","FH","spot27m",FH) = 2.91;
p_technoTimeReq("10","2","FH","spot27m",FH) = 0.10;
p_technoFuelCons("10","2","FH","spot27m",FH) = 0.90;
p_technoMaintenance("10","2","FH","spot27m",FH) = 2.93;
p_technoTimeReq("10","3","FH","spot27m",FH) = 0.11;
p_technoFuelCons("10","3","FH","spot27m",FH) = 0.92;
p_technoMaintenance("10","3","FH","spot27m",FH) = 2.95;
p_technoTimeReq("10","4","FH","spot27m",FH) = 0.11;
p_technoFuelCons("10","4","FH","spot27m",FH) = 0.94;
p_technoMaintenance("10","4","FH","spot27m",FH) = 2.96;
p_technoTimeReq("10","5","FH","spot27m",FH) = 0.11;
p_technoFuelCons("10","5","FH","spot27m",FH) = 0.95;
p_technoMaintenance("10","5","FH","spot27m",FH) = 2.98;
p_technoTimeReq("10","10","FH","spot27m",FH) = 0.12;
p_technoFuelCons("10","10","FH","spot27m",FH) = 1.04;
p_technoMaintenance("10","10","FH","spot27m",FH) = 3.04;
p_technoTimeReq("10","15","FH","spot27m",FH) = 0.13;
p_technoFuelCons("10","15","FH","spot27m",FH) = 1.13;
p_technoMaintenance("10","15","FH","spot27m",FH) = 3.12;

p_technoTimeReq("20","1","FH","spot27m",FH) = 0.09;
p_technoFuelCons("20","1","FH","spot27m",FH) = 0.79;
p_technoMaintenance("20","1","FH","spot27m",FH) = 2.81;
p_technoTimeReq("20","2","FH","spot27m",FH) = 0.09;
p_technoFuelCons("20","2","FH","spot27m",FH) = 0.80;
p_technoMaintenance("20","2","FH","spot27m",FH) = 2.83;
p_technoTimeReq("20","3","FH","spot27m",FH) = 0.09;
p_technoFuelCons("20","3","FH","spot27m",FH) = 0.82;
p_technoMaintenance("20","3","FH","spot27m",FH) = 2.84;
p_technoTimeReq("20","4","FH","spot27m",FH) = 0.09;
p_technoFuelCons("20","4","FH","spot27m",FH) = 0.83;
p_technoMaintenance("20","4","FH","spot27m",FH) = 2.85;
p_technoTimeReq("20","5","FH","spot27m",FH) = 0.10;
p_technoFuelCons("20","5","FH","spot27m",FH) = 0.85;
p_technoMaintenance("20","5","FH","spot27m",FH) = 2.87;
p_technoTimeReq("20","10","FH","spot27m",FH) = 0.11;
p_technoFuelCons("20","10","FH","spot27m",FH) = 0.94;
p_technoMaintenance("20","10","FH","spot27m",FH) = 2.94;
p_technoTimeReq("20","15","FH","spot27m",FH) = 0.12;
p_technoFuelCons("20","15","FH","spot27m",FH) = 1.03;
p_technoMaintenance("20","15","FH","spot27m",FH) = 3.01;

p_technoTimeReq("40","1","FH","spot27m",FH) = 0.09;
p_technoFuelCons("40","1","FH","spot27m",FH) = 0.83;
p_technoMaintenance("40","1","FH","spot27m",FH) = 2.82;
p_technoTimeReq("40","2","FH","spot27m",FH) = 0.09;
p_technoFuelCons("40","2","FH","spot27m",FH) = 0.85;
p_technoMaintenance("40","2","FH","spot27m",FH) = 2.83;
p_technoTimeReq("40","3","FH","spot27m",FH) = 0.09;
p_technoFuelCons("40","3","FH","spot27m",FH) = 0.87;
p_technoMaintenance("40","3","FH","spot27m",FH) = 2.85;
p_technoTimeReq("40","4","FH","spot27m",FH) = 0.10;
p_technoFuelCons("40","4","FH","spot27m",FH) = 0.89;
p_technoMaintenance("40","4","FH","spot27m",FH) = 2.86;
p_technoTimeReq("40","5","FH","spot27m",FH) = 0.10;
p_technoFuelCons("40","5","FH","spot27m",FH) = 0.90;
p_technoMaintenance("40","5","FH","spot27m",FH) = 2.88;
p_technoTimeReq("40","10","FH","spot27m",FH) = 0.11;
p_technoFuelCons("40","10","FH","spot27m",FH) = 0.99;
p_technoMaintenance("40","10","FH","spot27m",FH) = 2.95;
p_technoTimeReq("40","15","FH","spot27m",FH) = 0.12;
p_technoFuelCons("40","15","FH","spot27m",FH) = 1.08;
p_technoMaintenance("40","15","FH","spot27m",FH) = 3.02;

p_technoTimeReq("80","1","FH","spot27m",FH) = 0.08;
p_technoFuelCons("80","1","FH","spot27m",FH) = 0.81;
p_technoMaintenance("80","1","FH","spot27m",FH) = 2.79;
p_technoTimeReq("80","2","FH","spot27m",FH) = 0.09;
p_technoFuelCons("80","2","FH","spot27m",FH) = 0.83;
p_technoMaintenance("80","2","FH","spot27m",FH) = 2.80;
p_technoTimeReq("80","3","FH","spot27m",FH) = 0.09;
p_technoFuelCons("80","3","FH","spot27m",FH) = 0.85;
p_technoMaintenance("80","3","FH","spot27m",FH) = 2.82;
p_technoTimeReq("80","4","FH","spot27m",FH) = 0.09;
p_technoFuelCons("80","4","FH","spot27m",FH) = 0.86;
p_technoMaintenance("80","4","FH","spot27m",FH) = 2.83;
p_technoTimeReq("80","5","FH","spot27m",FH) = 0.09;
p_technoFuelCons("80","5","FH","spot27m",FH) = 0.88;
p_technoMaintenance("80","5","FH","spot27m",FH) = 2.85;
p_technoTimeReq("80","10","FH","spot27m",FH) = 0.10;
p_technoFuelCons("80","10","FH","spot27m",FH) = 0.96;
p_technoMaintenance("80","10","FH","spot27m",FH) = 2.92;
p_technoTimeReq("80","15","FH","spot27m",FH) = 0.11;
p_technoFuelCons("80","15","FH","spot27m",FH) = 1.05;
p_technoMaintenance("80","15","FH","spot27m",FH) = 2.99;



*
* -- scenario FH+BA spot 27m: FH: 100 l/ha, notFH: 300 l/ha, BA: 300 l/ha
*
p_technoTimeReq(KTBL_size,KTBL_distance,"FH+BA","spot27m",FH) = p_technoTimeReq(KTBL_size,KTBL_distance,"FH","spot27m","foliarHerb");
p_technoFuelCons(KTBL_size,KTBL_distance,"FH+BA","spot27m",FH) = p_technoFuelCons(KTBL_size,KTBL_distance,"FH","spot27m","foliarHerb");
p_technoMaintenance(KTBL_size,KTBL_distance,"FH+BA","spot27m",FH) = p_technoMaintenance(KTBL_size,KTBL_distance,"FH","spot27m","foliarHerb");

p_technoTimeReq("1","1","FH+BA","spot27m",notFH) = 0.27;
p_technoFuelCons("1","1","FH+BA","spot27m",notFH) = 1.69;
p_technoMaintenance("1","1","FH+BA","spot27m",notFH) = 4.49;
p_technoTimeReq("1","2","FH+BA","spot27m",notFH) = 0.28;
p_technoFuelCons("1","2","FH+BA","spot27m",notFH) = 1.74;
p_technoMaintenance("1","2","FH+BA","spot27m",notFH) = 4.55;
p_technoTimeReq("1","3","FH+BA","spot27m",notFH) = 0.28;
p_technoFuelCons("1","3","FH+BA","spot27m",notFH) = 1.80;
p_technoMaintenance("1","3","FH+BA","spot27m",notFH) = 4.59;
p_technoTimeReq("1","4","FH+BA","spot27m",notFH) = 0.29;
p_technoFuelCons("1","4","FH+BA","spot27m",notFH) = 1.84;
p_technoMaintenance("1","4","FH+BA","spot27m",notFH) = 4.63;
p_technoTimeReq("1","5","FH+BA","spot27m",notFH) = 0.30;
p_technoFuelCons("1","5","FH+BA","spot27m",notFH) = 1.90;
p_technoMaintenance("1","5","FH+BA","spot27m",notFH) = 4.68;
p_technoTimeReq("1","10","FH+BA","spot27m",notFH) = 0.33;
p_technoFuelCons("1","10","FH+BA","spot27m",notFH) = 2.15;
p_technoMaintenance("1","10","FH+BA","spot27m",notFH) = 4.88;
p_technoTimeReq("1","15","FH+BA","spot27m",notFH) = 0.36;
p_technoFuelCons("1","15","FH+BA","spot27m",notFH) = 2.42;
p_technoMaintenance("1","15","FH+BA","spot27m",notFH) = 5.09;

p_technoTimeReq("2","1","FH+BA","spot27m",notFH) = 0.20;
p_technoFuelCons("2","1","FH+BA","spot27m",notFH) = 1.31;
p_technoMaintenance("2","1","FH+BA","spot27m",notFH) = 3.95;
p_technoTimeReq("2","2","FH+BA","spot27m",notFH) = 0.20;
p_technoFuelCons("2","2","FH+BA","spot27m",notFH) = 1.36;
p_technoMaintenance("2","2","FH+BA","spot27m",notFH) = 4.00;
p_technoTimeReq("2","3","FH+BA","spot27m",notFH) = 0.21;
p_technoFuelCons("2","3","FH+BA","spot27m",notFH) = 1.41;
p_technoMaintenance("2","3","FH+BA","spot27m",notFH) = 4.04;
p_technoTimeReq("2","4","FH+BA","spot27m",notFH) = 0.21;
p_technoFuelCons("2","4","FH+BA","spot27m",notFH) = 1.45;
p_technoMaintenance("2","4","FH+BA","spot27m",notFH) = 4.08;
p_technoTimeReq("2","5","FH+BA","spot27m",notFH) = 0.22;
p_technoFuelCons("2","5","FH+BA","spot27m",notFH) = 1.50;
p_technoMaintenance("2","5","FH+BA","spot27m",notFH) = 4.13;
p_technoTimeReq("2","10","FH+BA","spot27m",notFH) = 0.25;
p_technoFuelCons("2","10","FH+BA","spot27m",notFH) = 1.74; 
p_technoMaintenance("2","10","FH+BA","spot27m",notFH) = 4.34;
p_technoTimeReq("2","15","FH+BA","spot27m",notFH) = 0.28;
p_technoFuelCons("2","15","FH+BA","spot27m",notFH) = 1.99;
p_technoMaintenance("2","15","FH+BA","spot27m",notFH) = 4.54;

p_technoTimeReq("5","1","FH+BA","spot27m",notFH) = 0.14;
p_technoFuelCons("5","1","FH+BA","spot27m",notFH) = 1.02;
p_technoMaintenance("5","1","FH+BA","spot27m",notFH) = 3.55;
p_technoTimeReq("5","2","FH+BA","spot27m",notFH) = 0.14;
p_technoFuelCons("5","2","FH+BA","spot27m",notFH) = 1.07;
p_technoMaintenance("5","2","FH+BA","spot27m",notFH) = 3.60;
p_technoTimeReq("5","3","FH+BA","spot27m",notFH) = 0.15;
p_technoFuelCons("5","3","FH+BA","spot27m",notFH) = 1.12;
p_technoMaintenance("5","3","FH+BA","spot27m",notFH) = 3.65;
p_technoTimeReq("5","4","FH+BA","spot27m",notFH) = 0.16;
p_technoFuelCons("5","4","FH+BA","spot27m",notFH) = 1.16;
p_technoMaintenance("5","4","FH+BA","spot27m",notFH) = 3.69;
p_technoTimeReq("5","5","FH+BA","spot27m",notFH) = 0.16;
p_technoFuelCons("5","5","FH+BA","spot27m",notFH) = 1.21;
p_technoMaintenance("5","5","FH+BA","spot27m",notFH) = 3.73;
p_technoTimeReq("5","10","FH+BA","spot27m",notFH) = 0.19;
p_technoFuelCons("5","10","FH+BA","spot27m",notFH) = 1.44;
p_technoMaintenance("5","10","FH+BA","spot27m",notFH) = 4.94;
p_technoTimeReq("5","15","FH+BA","spot27m",notFH) = 0.22;
p_technoFuelCons("5","15","FH+BA","spot27m",notFH) = 1.68;
p_technoMaintenance("5","15","FH+BA","spot27m",notFH) = 4.14;

p_technoTimeReq("10","1","FH+BA","spot27m",notFH) = 0.12;
p_technoFuelCons("10","1","FH+BA","spot27m",notFH) = 0.94;
p_technoMaintenance("10","1","FH+BA","spot27m",notFH) = 3.40;
p_technoTimeReq("10","2","FH+BA","spot27m",notFH) = 0.12;
p_technoFuelCons("10","2","FH+BA","spot27m",notFH) = 0.99;
p_technoMaintenance("10","2","FH+BA","spot27m",notFH) = 3.45;
p_technoTimeReq("10","3","FH+BA","spot27m",notFH) = 0.13;
p_technoFuelCons("10","3","FH+BA","spot27m",notFH) = 1.03;
p_technoMaintenance("10","3","FH+BA","spot27m",notFH) = 3.50;
p_technoTimeReq("10","4","FH+BA","spot27m",notFH) = 0.14;
p_technoFuelCons("10","4","FH+BA","spot27m",notFH) = 1.08;
p_technoMaintenance("10","4","FH+BA","spot27m",notFH) = 3.55;
p_technoTimeReq("10","5","FH+BA","spot27m",notFH) = 0.14;
p_technoFuelCons("10","5","FH+BA","spot27m",notFH) = 1.12;
p_technoMaintenance("10","5","FH+BA","spot27m",notFH) = 3.58;
p_technoTimeReq("10","10","FH+BA","spot27m",notFH) = 0.17;
p_technoFuelCons("10","10","FH+BA","spot27m",notFH) = 1.35;
p_technoMaintenance("10","10","FH+BA","spot27m",notFH) = 3.79;
p_technoTimeReq("10","15","FH+BA","spot27m",notFH) = 0.20;
p_technoFuelCons("10","15","FH+BA","spot27m",notFH) = 1.59;
p_technoMaintenance("10","15","FH+BA","spot27m",notFH) = 4.00;

p_technoTimeReq("20","1","FH+BA","spot27m",notFH) = 0.12;
p_technoFuelCons("20","1","FH+BA","spot27m",notFH) = 0.98;
p_technoMaintenance("20","1","FH+BA","spot27m",notFH) = 3.40;
p_technoTimeReq("20","2","FH+BA","spot27m",notFH) = 0.12;
p_technoFuelCons("20","2","FH+BA","spot27m",notFH) = 1.02;
p_technoMaintenance("20","2","FH+BA","spot27m",notFH) = 3.45;
p_technoTimeReq("20","3","FH+BA","spot27m",notFH) = 0.13;
p_technoFuelCons("20","3","FH+BA","spot27m",notFH) = 1.07;
p_technoMaintenance("20","3","FH+BA","spot27m",notFH) = 3.50; 
p_technoTimeReq("20","4","FH+BA","spot27m",notFH) = 0.13;
p_technoFuelCons("20","4","FH+BA","spot27m",notFH) = 1.11;
p_technoMaintenance("20","4","FH+BA","spot27m",notFH) = 3.54;
p_technoTimeReq("20","5","FH+BA","spot27m",notFH) = 0.14;
p_technoFuelCons("20","5","FH+BA","spot27m",notFH) = 1.16;
p_technoMaintenance("20","5","FH+BA","spot27m",notFH) = 3.58;
p_technoTimeReq("20","10","FH+BA","spot27m",notFH) = 0.17;
p_technoFuelCons("20","10","FH+BA","spot27m",notFH) = 1.39;
p_technoMaintenance("20","10","FH+BA","spot27m",notFH) = 3.79;
p_technoTimeReq("20","15","FH+BA","spot27m",notFH) = 0.20;
p_technoFuelCons("20","15","FH+BA","spot27m",notFH) = 1.63;
p_technoMaintenance("20","15","FH+BA","spot27m",notFH) = 4.00;

p_technoTimeReq("40","1","FH+BA","spot27m",notFH) = 0.12;
p_technoFuelCons("40","1","FH+BA","spot27m",notFH) = 1.00;
p_technoMaintenance("40","1","FH+BA","spot27m",notFH) = 3.41;
p_technoTimeReq("40","2","FH+BA","spot27m",notFH) = 0.12;
p_technoFuelCons("40","2","FH+BA","spot27m",notFH) = 1.05;
p_technoMaintenance("40","2","FH+BA","spot27m",notFH) = 3.46;
p_technoTimeReq("40","3","FH+BA","spot27m",notFH) = 0.13;
p_technoFuelCons("40","3","FH+BA","spot27m",notFH) = 1.09;
p_technoMaintenance("40","3","FH+BA","spot27m",notFH) = 3.51;
p_technoTimeReq("40","4","FH+BA","spot27m",notFH) = 0.14;
p_technoFuelCons("40","4","FH+BA","spot27m",notFH) = 1.14;
p_technoMaintenance("40","4","FH+BA","spot27m",notFH) = 3.55;
p_technoTimeReq("40","5","FH+BA","spot27m",notFH) = 0.14;
p_technoFuelCons("40","5","FH+BA","spot27m",notFH) = 1.19;
p_technoMaintenance("40","5","FH+BA","spot27m",notFH) = 3.59;
p_technoTimeReq("40","10","FH+BA","spot27m",notFH) = 0.17;
p_technoFuelCons("40","10","FH+BA","spot27m",notFH) = 1.41;
p_technoMaintenance("40","10","FH+BA","spot27m",notFH) = 3.80;
p_technoTimeReq("40","15","FH+BA","spot27m",notFH) = 0.20;
p_technoFuelCons("40","15","FH+BA","spot27m",notFH) = 1.65;
p_technoMaintenance("40","15","FH+BA","spot27m",notFH) = 4.00;

p_technoTimeReq("80","1","FH+BA","spot27m",notFH) = 0.12;
p_technoFuelCons("80","1","FH+BA","spot27m",notFH) = 1.05;
p_technoMaintenance("80","1","FH+BA","spot27m",notFH) = 3.43;
p_technoTimeReq("80","2","FH+BA","spot27m",notFH) = 0.13;
p_technoFuelCons("80","2","FH+BA","spot27m",notFH) = 1.10;
p_technoMaintenance("80","2","FH+BA","spot27m",notFH) = 3.48;
p_technoTimeReq("80","3","FH+BA","spot27m",notFH) = 0.13;
p_technoFuelCons("80","3","FH+BA","spot27m",notFH) = 1.14;
p_technoMaintenance("80","3","FH+BA","spot27m",notFH) = 3.53;
p_technoTimeReq("80","4","FH+BA","spot27m",notFH) = 0.14;
p_technoFuelCons("80","4","FH+BA","spot27m",notFH) = 1.19;
p_technoMaintenance("80","4","FH+BA","spot27m",notFH) = 3.57;
p_technoTimeReq("80","5","FH+BA","spot27m",notFH) = 0.14;
p_technoFuelCons("80","5","FH+BA","spot27m",notFH) = 1.23;
p_technoMaintenance("80","5","FH+BA","spot27m",notFH) = 3.61;
p_technoTimeReq("80","10","FH+BA","spot27m",notFH) = 0.17;
p_technoFuelCons("80","10","FH+BA","spot27m",notFH) = 1.46;
p_technoMaintenance("80","10","FH+BA","spot27m",notFH) = 3.82;
p_technoTimeReq("80","15","FH+BA","spot27m",notFH) = 0.20;
p_technoFuelCons("80","15","FH+BA","spot27m",notFH) = 1.70;
p_technoMaintenance("80","15","FH+BA","spot27m",notFH) = 4.02;

*
* -- For BA which are applied simultaneously with SSPAs for SST27m -> values for BAs are sometimes taken instead of SSPAs because they are more restrictive
*
p_technoTimeReq(KTBL_size,KTBL_distance,"FH","spot27m",notFH) = p_technoTimeReq(KTBL_size,KTBL_distance,"FH+BA","spot27m","soilHerb");
p_technoFuelCons(KTBL_size,KTBL_distance,"FH","spot27m",notFH) = p_technoFuelCons(KTBL_size,KTBL_distance,"FH+BA","spot27m","soilHerb");
p_technoMaintenance(KTBL_size,KTBL_distance,"FH","spot27m",notFH) = p_technoMaintenance(KTBL_size,KTBL_distance,"FH+BA","spot27m","soilHerb");


*
* -- If all applications are performed as BAs with SST_27m
*
p_technoTimeReq(KTBL_size,KTBL_distance,"BA","spot27m",pestType) = p_technoTimeReq(KTBL_size,KTBL_distance,"FH","spot27m","soilHerb");
p_technoFuelCons(KTBL_size,KTBL_distance,"BA","spot27m",pestType) = p_technoFuelCons(KTBL_size,KTBL_distance,"FH","spot27m","soilHerb");
p_technoMaintenance(KTBL_size,KTBL_distance,"BA","spot27m",pestType) = p_technoMaintenance(KTBL_size,KTBL_distance,"FH","spot27m","soilHerb");


*
* -- scenario FH+Bonus spot 27m: FHBonus: 100 l/ha, notFHBonus: 300 l/ha
*
p_technoTimeReq(KTBL_size,KTBL_distance,"FH+Bonus","spot27m",FHBonus) = p_technoTimeReq(KTBL_size,KTBL_distance,"FH","spot27m","foliarHerb");
p_technoFuelCons(KTBL_size,KTBL_distance,"FH+Bonus","spot27m",FHBonus) = p_technoFuelCons(KTBL_size,KTBL_distance,"FH","spot27m","foliarHerb");
p_technoMaintenance(KTBL_size,KTBL_distance,"FH+Bonus","spot27m",FHBonus) = p_technoMaintenance(KTBL_size,KTBL_distance,"FH","spot27m","foliarHerb");



*
* -- scenario FH+Bonus+BA spot 27m: FHBonus: 100 l/ha, not FHBonus: 300 l/ha
*
p_technoTimeReq(KTBL_size,KTBL_distance,"FH+Bonus+BA","spot27m",FHBonus) = p_technoTimeReq(KTBL_size,KTBL_distance,"FH","spot27m","foliarHerb");
p_technoFuelCons(KTBL_size,KTBL_distance,"FH+Bonus+BA","spot27m",FHBonus) = p_technoFuelCons(KTBL_size,KTBL_distance,"FH","spot27m","foliarHerb");
p_technoMaintenance(KTBL_size,KTBL_distance,"FH+Bonus+BA","spot27m",FHBonus) = p_technoMaintenance(KTBL_size,KTBL_distance,"FH","spot27m","foliarHerb");

p_technoTimeReq(KTBL_size,KTBL_distance,"FH+Bonus+BA","spot27m",notFHBonus) = p_technoTimeReq(KTBL_size,KTBL_distance,"FH+BA","spot27m","soilHerb");
p_technoFuelCons(KTBL_size,KTBL_distance,"FH+Bonus+BA","spot27m",notFHBonus) = p_technoFuelCons(KTBL_size,KTBL_distance,"FH+BA","spot27m","soilHerb");
p_technoMaintenance(KTBL_size,KTBL_distance,"FH+Bonus+BA","spot27m",notFHBonus) = p_technoMaintenance(KTBL_size,KTBL_distance,"FH+BA","spot27m","soilHerb");



*reason for the formula is, that the data for other costs is drawn from KTBL makost (17.05.2024)
*and it is assumed here that costs for maintenance are twice as high as for BA technology
p_technoMaintenance(KTBL_size,KTBL_distance,scenario,"spot27m",pestType) = 
    p_technoMaintenance(KTBL_size,KTBL_distance,scenario,"spot27m",pestType) * 2
;

option 
   p_technoMaintenance:2:4:1
   p_technoTimeReq:2:4:1
   p_technoFuelCons:2:4:1
;


parameter p_datePestOpTechnoLWK(LWK_crops,LWK_yield,technology,scenario,scenSprayer,pestType,halfMonth) /
$ontext 
zusätzliche genutzte Quellen: 
- Getreide Zeitpunkte Anwendungen:
    1. https://www.yara.de/pflanzenernaehrung/weizen/agronomische-grundsaetze/#:~:text=Wichtigstes%20Ziel%20beim%20Getreideanbau%20ist,gesunden%20gr%C3%BCnen%20Blattmasse%20angestrebt%20werden.
    2. https://www.isip.de/isip/servlet/resource/blob/158864/b2eab6854d120472a63ebddcf021f565/18-02-getreide-data.pdf
- Winterraps Zeitpunkte Anwendungen:
    1. https://www.yara.de/pflanzenernaehrung/raps/agronomische-grundsaetze/
    2. https://www.nap-pflanzenschutz.de/fileadmin/SITE_MASTER/content/IPS/Integrierter_Pflanzenschutz/Leitlinien_IPS/201111_RL_UFOP_1738_Leitlinie_Raps_final.pdf
- Kartoffel Zeitpunkt Anwendungen: https://www.isip.de/isip/servlet/resource/blob/307402/a7029ab2b89401c4ff3744310e3a8df5/19-06-kartoffeln-data.pdf
- Zuckerrübe Zeitpunkt Anwendungen: https://www.isip.de/isip/servlet/resource/blob/158866/c50b95b756770dd93fe1b60570d6e57a/18-05-zuckerrueben-data.pdf
$offtext
*
* -------------------- BA
*
*KTBL BP 18/19
'Winterweizen'.'< 70 dt/ha'."baseline"."Base".set.BASprayer."soilHerb"."OKT2" 0.5
'Winterweizen'.'< 70 dt/ha'."baseline"."Base".set.BASprayer."foliarHerb"."OKT2" 0.5
'Winterweizen'.'< 70 dt/ha'."baseline"."Base".set.BASprayer."foliarHerb"."APR1" 1
'Winterweizen'.'< 70 dt/ha'."baseline"."Base".set.BASprayer."growthReg"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."baseline"."Base".set.BASprayer."insect"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."baseline"."Base".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."baseline"."Base".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."baseline"."Base".set.BASprayer."foliarHerb"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."baseline"."Base".set.BASprayer."foliarHerb"."APR1" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."baseline"."Base".set.BASprayer."growthReg"."APR1" 0.5
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."baseline"."Base".set.BASprayer."insect"."APR2" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."baseline"."Base".set.BASprayer."fung"."APR2" 0.5
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."baseline"."Base".set.BASprayer."foliarHerb"."MAI1" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."baseline"."Base".set.BASprayer."growthReg"."MAI1" 0.5
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."baseline"."Base".set.BASprayer."fung"."JUN1" 1

*gleich wie Winterweizen
'Wintergerste'.'< 70 dt/ha'."baseline"."Base".set.BASprayer."soilHerb"."OKT2" 1
'Wintergerste'.'< 70 dt/ha'."baseline"."Base".set.BASprayer."foliarHerb"."APR1" 1
'Wintergerste'.'< 70 dt/ha'."baseline"."Base".set.BASprayer."growthReg"."APR2" 1
'Wintergerste'.'< 70 dt/ha'."baseline"."Base".set.BASprayer."fung"."JUN1" 1

*zusätzliche Anwendung im Mai1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."baseline"."Base".set.BASprayer."soilHerb"."OKT2" 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."baseline"."Base".set.BASprayer."foliarHerb"."APR1" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."baseline"."Base".set.BASprayer."growthReg"."APR1" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."baseline"."Base".set.BASprayer."growthReg"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."baseline"."Base".set.BASprayer."fung"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."baseline"."Base".set.BASprayer."fung"."JUN1" 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."baseline"."Base".set.BASprayer."foliarHerb"."MAI1" 1

'Winterroggen & Triticale'.'< 60 dt/ha'."baseline"."Base".set.BASprayer."soilHerb"."OKT2" 1
'Winterroggen & Triticale'.'< 60 dt/ha'."baseline"."Base".set.BASprayer."foliarHerb"."APR1" 1
'Winterroggen & Triticale'.'< 60 dt/ha'."baseline"."Base".set.BASprayer."growthReg"."APR2" 1
'Winterroggen & Triticale'.'< 60 dt/ha'."baseline"."Base".set.BASprayer."fung"."JUN1" 1

'Winterroggen & Triticale'.'> 60 dt/ha'."baseline"."Base".set.BASprayer."soilHerb"."OKT2" 1
'Winterroggen & Triticale'.'> 60 dt/ha'."baseline"."Base".set.BASprayer."foliarHerb"."APR1" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."baseline"."Base".set.BASprayer."growthReg"."APR1" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."baseline"."Base".set.BASprayer."growthReg"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."baseline"."Base".set.BASprayer."insect"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."baseline"."Base".set.BASprayer."foliarHerb"."MAI1" 1
'Winterroggen & Triticale'.'> 60 dt/ha'."baseline"."Base".set.BASprayer."fung"."JUN1" 1

*1 zusätzliche Anwendung in MAI1
'Raps'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."soilHerb"."AUG2" 1
'Raps'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."growthReg"."OKT2" 1
'Raps'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."foliarHerb"."APR1" 1
'Raps'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."growthReg"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."insect"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."insect"."MAI1" 1


*Blatt- und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."soilHerb"."MAI1" 0.5
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."foliarHerb"."MAI1" 0.5
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."fung"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."fung"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."fung"."JUN2" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."insect"."JUN2" 1
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."fung"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."fung"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."fung"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."fung"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."dessic"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."dessic"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."foliarHerb"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."foliarHerb"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."insect"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."foliarHerb"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."fung"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."fung"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."foliarHerb"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."foliarHerb"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."baseline"."Base".set.BASprayer."foliarHerb"."AUG1" 0.5

*
* -------------------- Scenario FH for SPOT 6m
*
*Bodenherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH"."spot6m"."foliarHerb"."OKT2" 1
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH"."spot6m"."foliarHerb"."APR1" 1
*Wachstumsregler 1 & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH".set.BASprayer."growthReg"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH".set.BASprayer."insect"."APR2" 0.5
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."spot6m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."spot6m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH".set.BASprayer."growthReg"."APR1" 1
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH".set.BASprayer."insect"."APR2" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH".set.BASprayer."fung"."APR2" 0.5
*Blattherbizid 3
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."spot6m"."foliarHerb"."MAI1" 1
*Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH".set.BASprayer."growthReg"."MAI1" 1
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH"."spot6m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH".set.BASprayer."growthReg"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."spot6m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH".set.BASprayer."growthReg"."APR1" 1
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH".set.BASprayer."growthReg"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH".set.BASprayer."fung"."APR2" 0.5
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."spot6m"."foliarHerb"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH"."spot6m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH".set.BASprayer."growthReg"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH"."spot6m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH".set.BASprayer."growthReg"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH".set.BASprayer."growthReg"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH".set.BASprayer."insect"."APR2" 0.5
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH"."spot6m"."foliarHerb"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."soilHerb"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."growthReg"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH"."spot6m"."foliarHerb"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."growthReg"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."insect"."APR2" 0.5
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."insect"."MAI1" 1

*Blattherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH"."spot6m"."foliarHerb"."MAI1" 1
*Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."soilHerb"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."fung"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."fung"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."fung"."JUN2" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."insect"."JUN2" 1
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."fung"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."fung"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."fung"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."fung"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."dessic"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."dessic"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH"."spot6m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH"."spot6m"."foliarHerb"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."insect"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH"."spot6m"."foliarHerb"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."fung"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH".set.BASprayer."fung"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot6m"."FH"."spot6m"."foliarHerb"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot6m"."FH"."spot6m"."foliarHerb"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot6m"."FH"."spot6m"."foliarHerb"."AUG1" 0.5



*
* -------------------- Scenario FH+BA for SPOT 6m
*
*Boden- & Blattherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."soilHerb"."OKT2" 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."foliarHerb"."OKT2" 1
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."foliarHerb"."APR1" 1
*Wachstumsregler & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."growthReg"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."insect"."APR2" 0.5
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."foliarHerb"."APR1" 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."growthReg"."APR1" 1
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."insect"."APR2" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."fung"."APR2" 0.5
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."foliarHerb"."MAI1" 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."growthReg"."MAI1" 1
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."soilHerb"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."growthReg"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."foliarHerb"."APR1" 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."growthReg"."APR1" 1
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."growthReg"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."fung"."APR2" 0.5
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."foliarHerb"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+BA"."spot6m"."soilHerb"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+BA"."spot6m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+BA"."spot6m"."growthReg"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+BA"."spot6m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+BA"."spot6m"."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+BA"."spot6m"."foliarHerb"."APR1" 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+BA"."spot6m"."growthReg"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+BA"."spot6m"."growthReg"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+BA"."spot6m"."insect"."APR2" 0.5
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+BA"."spot6m"."foliarHerb"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+BA"."spot6m"."fung"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."soilHerb"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."growthReg"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."foliarHerb"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."growthReg"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."insect"."APR2" 0.5
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."insect"."MAI1" 1

*Blattherbizid 1 und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."foliarHerb"."MAI1" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."soilHerb"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."fung"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."fung"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."fung"."JUN2" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."insect"."JUN2" 1
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."fung"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."fung"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."fung"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."fung"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."dessic"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."dessic"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."foliarHerb"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."insect"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."foliarHerb"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."fung"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."fung"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."foliarHerb"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."foliarHerb"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."foliarHerb"."AUG1" 0.5



*
* -------------------- Scenario FH+Bonus for SPOT 6m
*
*Bodenherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+Bonus".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."OKT2" 1
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."APR1" 1
*Wachstumsregler 1 & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+Bonus"."spot6m"."growthReg"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+Bonus"."spot6m"."insect"."APR2" 0.5
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+Bonus"."spot6m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."APR1" 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."growthReg"."APR1" 1
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."insect"."APR2" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."fung"."APR2" 0.5
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."MAI1" 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."growthReg"."MAI1" 1
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+Bonus".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+Bonus"."spot6m"."growthReg"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+Bonus"."spot6m"."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1 
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."APR1" 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."growthReg"."APR1" 1
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."growthReg"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."fung"."APR2" 0.5
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+Bonus".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+Bonus"."spot6m"."growthReg"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+Bonus"."spot6m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+Bonus".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."APR1" 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+Bonus"."spot6m"."growthReg"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+Bonus"."spot6m"."growthReg"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+Bonus"."spot6m"."insect"."APR2" 0.5
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+Bonus"."spot6m"."fung"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH+Bonus".set.BASprayer."soilHerb"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."growthReg"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."growthReg"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."insect"."APR2" 0.5
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."insect"."MAI1" 1

*Blattherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."MAI1" 1
*Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus".set.BASprayer."soilHerb"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."fung"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."fung"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."fung"."JUN2" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."insect"."JUN2" 1
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."fung"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."fung"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."fung"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."fung"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus".set.BASprayer."dessic"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus".set.BASprayer."dessic"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."insect"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."fung"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."fung"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."foliarHerb"."AUG1" 0.5



*
* -------------------- Scenario FH for SPOT 27m
* If a SSPA and a BA are performed simultaneously enabled by the dual-spraying technology, the passage is counted for the 
* BA, because the number of passages is later used to calculate the variable work execution costs of the spraying operation
* and it makes more sense to use the time requirements, fuel consumption and repair costs of the BA performed with the SST27m
*Blattherbizid 1 & Bodenherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1 & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH".set.BASprayer."growthReg"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH".set.BASprayer."insect"."APR2" 0.5
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m"."growthReg"."APR1" 1
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH".set.BASprayer."insect"."APR2" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH".set.BASprayer."fung"."APR2" 0.5
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m"."growthReg"."MAI1" 1
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH".set.BASprayer."growthReg"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m"."growthReg"."APR1" 1
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH".set.BASprayer."growthReg"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH".set.BASprayer."fung"."APR2" 0.5
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH".set.BASprayer."growthReg"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH"."spot27m"."growthReg"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH".set.BASprayer."growthReg"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH".set.BASprayer."insect"."APR2" 0.5
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."soilHerb"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."growthReg"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."growthReg"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."insect"."APR2" 0.5
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."insect"."MAI1" 1

*Blattherbizid 1 und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."soilHerb"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."JUN2" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."insect"."JUN2" 1
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."dessic"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."dessic"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."foliarHerb"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."insect"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."foliarHerb"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."foliarHerb"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."foliarHerb"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."foliarHerb"."AUG1" 0.5



*
* -------------------- Scenario FH+BA for SPOT 27m
*
*Blattherbizid 1 & Bodenherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1 & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."growthReg"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."insect"."APR2" 0.5
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."growthReg"."APR1" 1
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."insect"."APR2" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."fung"."APR2" 0.5
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."growthReg"."MAI1" 1
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."growthReg"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."growthReg"."APR1" 1
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."growthReg"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."fung"."APR2" 0.5
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+BA"."spot27m"."growthReg"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."growthReg"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."growthReg"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."insect"."APR2" 0.5
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."soilHerb"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."growthReg"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."growthReg"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."insect"."APR2" 0.5
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."insect"."MAI1" 1

*Blattherbizid 1 und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."soilHerb"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."JUN2" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."insect"."JUN2" 1
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."dessic"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."dessic"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."foliarHerb"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."insect"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."foliarHerb"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."foliarHerb"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."foliarHerb"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."foliarHerb"."AUG1" 0.5



*
* -------------------- Scenario FH+Bonus for SPOT 27m
*
*Blattherbizid 1 & Bodenherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1 & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."insect"."APR2" 0.5
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR1" 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR1" 1
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."insect"."APR2" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."fung"."APR2" 0.5
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."MAI1" 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."growthReg"."MAI1" 1
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR1" 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR1" 1
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."fung"."APR2" 0.5
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR1" 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."insect"."APR2" 0.5
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus".set.BASprayer."soilHerb"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."growthReg"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."insect"."APR2" 0.5
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."insect"."MAI1" 1

*Blattherbizid 1 und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."soilHerb"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."JUN2" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."insect"."JUN2" 1
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus".set.BASprayer."dessic"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus".set.BASprayer."dessic"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."insect"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."AUG1" 0.5



*
* -------------------- Scenario FH+Bonus+BA for SPOT 27m
*
*Blattherbizid 1 & Bodenherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1 & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."insect"."APR2" 0.5
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR1" 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR1" 1
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."insect"."APR2" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."APR2" 0.5
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."MAI1" 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."MAI1" 1
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR1" 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR1" 1
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."APR2" 0.5
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR1" 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."insect"."APR2" 0.5
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."soilHerb"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."insect"."APR2" 0.5
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."insect"."MAI1" 1

*Blattherbizid 1 und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."soilHerb"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUN2" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."insect"."JUN2" 1
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."dessic"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."dessic"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."insect"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."AUG1" 0.5

*
* --- Assignment of sprayer passages for SSTs if all applications are BAs
*
'Winterweizen'.'< 70 dt/ha'."spot6m"."BA"."spot6m"."soilHerb"."OKT2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot6m"."BA"."spot6m"."foliarHerb"."OKT2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot6m"."BA"."spot6m"."foliarHerb"."APR1" 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."BA"."spot6m"."growthReg"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot6m"."BA"."spot6m"."insect"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot6m"."BA"."spot6m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."BA"."spot6m"."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."BA"."spot6m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."BA"."spot6m"."foliarHerb"."APR1" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."BA"."spot6m"."growthReg"."APR1" 0.5
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."BA"."spot6m"."insect"."APR2" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."BA"."spot6m"."fung"."APR2" 0.5
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."BA"."spot6m"."foliarHerb"."MAI1" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."BA"."spot6m"."growthReg"."MAI1" 0.5
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."BA"."spot6m"."fung"."JUN1" 1

*gleich wie Winterweizen
'Wintergerste'.'< 70 dt/ha'."spot6m"."BA"."spot6m"."soilHerb"."OKT2" 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."BA"."spot6m"."foliarHerb"."APR1" 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."BA"."spot6m"."growthReg"."APR2" 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."BA"."spot6m"."fung"."JUN1" 1

*zusätzliche Anwendung im Mai1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."BA"."spot6m"."soilHerb"."OKT2" 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."BA"."spot6m"."foliarHerb"."APR1" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."BA"."spot6m"."growthReg"."APR1" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."BA"."spot6m"."growthReg"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."BA"."spot6m"."fung"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."BA"."spot6m"."fung"."JUN1" 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."BA"."spot6m"."foliarHerb"."MAI1" 1

'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."BA"."spot6m"."soilHerb"."OKT2" 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."BA"."spot6m"."foliarHerb"."APR1" 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."BA"."spot6m"."growthReg"."APR2" 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."BA"."spot6m"."fung"."JUN1" 1

'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."BA"."spot6m"."soilHerb"."OKT2" 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."BA"."spot6m"."foliarHerb"."APR1" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."BA"."spot6m"."growthReg"."APR1" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."BA"."spot6m"."growthReg"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."BA"."spot6m"."insect"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."BA"."spot6m"."foliarHerb"."MAI1" 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."BA"."spot6m"."fung"."JUN1" 1

*1 zusätzliche Anwendung in MAI1
'Raps'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."soilHerb"."AUG2" 1
'Raps'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."growthReg"."OKT2" 1
'Raps'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."foliarHerb"."APR1" 1
'Raps'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."growthReg"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."insect"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."insect"."MAI1" 1


*Blatt- und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."soilHerb"."MAI1" 0.5
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."foliarHerb"."MAI1" 0.5
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."fung"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."fung"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."fung"."JUN2" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."insect"."JUN2" 1
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."fung"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."fung"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."fung"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."fung"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."dessic"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."dessic"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."foliarHerb"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."insect"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."foliarHerb"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."fung"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."fung"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."foliarHerb"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."foliarHerb"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot6m"."BA"."spot6m"."foliarHerb"."AUG1" 0.5


***Spot27m
'Winterweizen'.'< 70 dt/ha'."spot27m"."BA"."spot27m"."soilHerb"."OKT2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot27m"."BA"."spot27m"."foliarHerb"."OKT2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot27m"."BA"."spot27m"."foliarHerb"."APR1" 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."BA"."spot27m"."growthReg"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot27m"."BA"."spot27m"."insect"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot27m"."BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."BA"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."BA"."spot27m"."foliarHerb"."APR1" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."BA"."spot27m"."growthReg"."APR1" 0.5
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."BA"."spot27m"."insect"."APR2" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."BA"."spot27m"."fung"."APR2" 0.5
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."BA"."spot27m"."foliarHerb"."MAI1" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."BA"."spot27m"."growthReg"."MAI1" 0.5
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."BA"."spot27m"."fung"."JUN1" 1

*gleich wie Winterweizen
'Wintergerste'.'< 70 dt/ha'."spot27m"."BA"."spot27m"."soilHerb"."OKT2" 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."BA"."spot27m"."foliarHerb"."APR1" 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."BA"."spot27m"."growthReg"."APR2" 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."BA"."spot27m"."fung"."JUN1" 1

*zusätzliche Anwendung im Mai1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."BA"."spot27m"."soilHerb"."OKT2" 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."BA"."spot27m"."foliarHerb"."APR1" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."BA"."spot27m"."growthReg"."APR1" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."BA"."spot27m"."growthReg"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."BA"."spot27m"."fung"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."BA"."spot27m"."fung"."JUN1" 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."BA"."spot27m"."foliarHerb"."MAI1" 1

'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."BA"."spot27m"."soilHerb"."OKT2" 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."BA"."spot27m"."foliarHerb"."APR1" 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."BA"."spot27m"."growthReg"."APR2" 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."BA"."spot27m"."fung"."JUN1" 1

'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."BA"."spot27m"."soilHerb"."OKT2" 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."BA"."spot27m"."foliarHerb"."APR1" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."BA"."spot27m"."growthReg"."APR1" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."BA"."spot27m"."growthReg"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."BA"."spot27m"."insect"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."BA"."spot27m"."foliarHerb"."MAI1" 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."BA"."spot27m"."fung"."JUN1" 1

*1 zusätzliche Anwendung in MAI1
'Raps'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."soilHerb"."AUG2" 1
'Raps'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."growthReg"."OKT2" 1
'Raps'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."foliarHerb"."APR1" 1
'Raps'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."growthReg"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."insect"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."insect"."MAI1" 1


*Blatt- und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."soilHerb"."MAI1" 0.5
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."foliarHerb"."MAI1" 0.5
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."fung"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."fung"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."fung"."JUN2" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."insect"."JUN2" 1
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."fung"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."fung"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."fung"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."fung"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."dessic"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."dessic"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."foliarHerb"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."insect"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."foliarHerb"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."fung"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."fung"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."foliarHerb"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."foliarHerb"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot27m"."BA"."spot27m"."foliarHerb"."AUG1" 0.5
/;



p_datePestOpTechnoLWK(LWK_crops,LWK_yield,"spot6m","FH+Bonus+BA","spot6m",pestType,halfMonth) 
    = p_datePestOpTechnoLWK(LWK_crops,LWK_yield,"spot6m","FH+BA","spot6m",pestType,halfMonth) 
;
*
* --- Number of sprayer passages converted to KTBL notation
*
parameters 
    p_sprayerPassagesMonth(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer,pestType) 
;

p_sprayerPassagesMonth(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer,pestType) =
    sum((LWK_crops,LWK_yield,halfMonth),
    p_datePestOpTechnoLWK(LWK_crops,LWK_yield,technology,scenario,scenSprayer,pestType,halfMonth)
    * p_lwkCrops_lwkYield_ktblYield(LWK_crops,LWK_yield,KTBL_yield)
    * p_ktblCrops_lwkCrops(KTBL_crops,LWK_crops)
    )
;



parameter p_datePestOpTechnoLWKFieldDays(LWK_crops,LWK_yield,technology,scenario,scenSprayer,pestType,halfMonth) /
*
* -------------------- Scenario FH for SPOT 27m
* For field days the passage of SST_27m for simultaneous SSPAs and BAs is counted for the SSPAs since the SSPA requires favorable 
* conditions and no simultaneous applications are possible if SSPA is not possible 
*Blattherbizid 1 & Bodenherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH"."spot27m"."foliarHerb"."OKT2" 1
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1 & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH".set.BASprayer."growthReg"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH".set.BASprayer."insect"."APR2" 0.5
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m"."foliarHerb"."APR1" 1
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH".set.BASprayer."insect"."APR2" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH".set.BASprayer."fung"."APR2" 0.5
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH".set.BASprayer."growthReg"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH".set.BASprayer."growthReg"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH".set.BASprayer."fung"."APR2" 0.5
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH".set.BASprayer."growthReg"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH".set.BASprayer."growthReg"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH".set.BASprayer."insect"."APR2" 0.5
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH".set.BASprayer."fung"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."soilHerb"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."growthReg"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."growthReg"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."insect"."APR2" 0.5
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."insect"."MAI1" 1

*Blattherbizid 1 und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."JUN2" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."insect"."JUN2" 1
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."dessic"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."dessic"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."foliarHerb"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."insect"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."foliarHerb"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH".set.BASprayer."fung"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."foliarHerb"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."foliarHerb"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."foliarHerb"."AUG1" 0.5



*
* -------------------- Scenario FH+BA for SPOT 27m
*
*Blattherbizid 1 & Bodenherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."foliarHerb"."OKT2" 1
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1 & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."growthReg"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."insect"."APR2" 0.5
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."foliarHerb"."APR1" 1
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."insect"."APR2" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."fung"."APR2" 0.5
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."growthReg"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."growthReg"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."fung"."APR2" 0.5
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+BA"."spot27m"."growthReg"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."growthReg"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."insect"."APR2" 0.5
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."soilHerb"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."growthReg"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."growthReg"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."insect"."APR2" 0.5
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."insect"."MAI1" 1

*Blattherbizid 1 und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."JUN2" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."insect"."JUN2" 1
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."dessic"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."dessic"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."foliarHerb"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."insect"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."foliarHerb"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."fung"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."foliarHerb"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."foliarHerb"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."foliarHerb"."AUG1" 0.5



*
* -------------------- Scenario FH+Bonus for SPOT 27m
*
*Blattherbizid 1 & Bodenherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."OKT2" 1
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1 & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."insect"."APR2" 0.5
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR1" 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR1" 1
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."insect"."APR2" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."fung"."APR2" 0.5
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."MAI1" 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."growthReg"."MAI1" 1
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR1" 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR1" 1
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."fung"."APR2" 0.5
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus".set.BASprayer."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR1" 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."insect"."APR2" 0.5
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus".set.BASprayer."soilHerb"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."growthReg"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."growthReg"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."insect"."APR2" 0.5
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."insect"."MAI1" 1

*Blattherbizid 1 und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."JUN2" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."insect"."JUN2" 1
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus".set.BASprayer."dessic"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus".set.BASprayer."dessic"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."insect"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."fung"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."foliarHerb"."AUG1" 0.5



*
* -------------------- Scenario FH+Bonus+BA for SPOT 27m
*
*Blattherbizid 1 & Bodenherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."OKT2" 1
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1 & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR2" 0.5
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."insect"."APR2" 0.5
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR1" 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR1" 1
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."insect"."APR2" 0.5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."APR2" 0.5
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."MAI1" 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."MAI1" 1
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR1" 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR1" 1
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR2" 0.5
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."APR2" 0.5
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."soilHerb"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR1" 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR2" 0.5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."insect"."APR2" 0.5
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."soilHerb"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."growthReg"."APR2" 0.5
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."insect"."APR2" 0.5
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."insect"."MAI1" 1

*Blattherbizid 1 und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUN2" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."insect"."JUN2" 1
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."dessic"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."dessic"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."insect"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."fung"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot27m"."FH+Bonus+BA"."spot27m"."foliarHerb"."AUG1" 0.5
/;


p_datePestOpTechnoLWKFieldDays(LWK_crops,LWK_yield,technology,scenario,scenSprayer,pestType,halfMonth)
    $ (not(sameas(technology,"spot27m"))) 
    = p_datePestOpTechnoLWK(LWK_crops,LWK_yield,technology,scenario,scenSprayer,pestType,halfMonth)
;

p_datePestOpTechnoLWKFieldDays(LWK_crops,LWK_yield,"spot27m","BA","spot27m",pestType,halfMonth) = p_datePestOpTechnoLWK(LWK_crops,LWK_yield,"spot27m","BA","spot27m",pestType,halfMonth);

parameter p_sprayerPassagesMonthSST27m(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer,pestType,halfMonth);

p_sprayerPassagesMonthSST27m(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer,pestType,halfMonth)= 
    sum((LWK_crops,LWK_yield),
        p_datePestOpTechnoLWKFieldDays(LWK_crops,LWK_yield,technology,scenario,scenSprayer,pestType,halfMonth)
        * p_lwkCrops_lwkYield_ktblYield(LWK_crops,LWK_yield,KTBL_yield)
        * p_ktblCrops_lwkCrops(KTBL_crops,LWK_crops)
    )
;