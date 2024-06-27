

set technology /BA, spot6m, spot27m/;
alias (technology,scenSprayer);

set scenSprayerSST(scenSprayer) /spot6m, spot27m/;

set scenario / 
    Base BA only with BA sprayer, 
    FH SS of foliar herbicides with SST and BA of remaining pesticides with BA sprayer
    FH+BA SS of foliar herbicides and BA of remaining pesticides with SST
    FH+Bonus SS of foliar herbicides fungicides and insecticides on row crops with SST and BA of remaining pesticides with BA sprayer, 
    FH+Bonus+BA SS of foliar herbicides fungicides and insecticides on row crops and BA of remaining pesticides with SST
    /;


parameters
    p_technoValue(scenSprayer,KTBL_mechanisation)
    p_technoRemValue(scenSprayer,KTBL_mechanisation)
;

*techno value according to information from KTBL data and grey literature
p_technoValue("spot6m",KTBL_mechanisation) = 130000;
p_technoValue("spot27m",KTBL_mechanisation) = 207000;
p_technoValue("BA","45") = 15000;
p_technoValue("BA","67") = 22700;
p_technoValue("BA","83") = 30300;
p_technoValue("BA","102") = 36600;
p_technoValue("BA","120") = 51100;
p_technoValue("BA","200") = 58100;
p_technoValue("BA","230") = 71100;

*standard ktbl procedure for remaining technology value
p_technoRemValue(scenSprayer,KTBL_mechanisation) 
    = p_technoValue(scenSprayer,KTBL_mechanisation) * 0.2;


parameter p_technoPestEff(KTBL_crops,technology,scenario,pestType) pesticide savings due to technology utilization for each type;

*pesticide efficiency block for SST
p_technoPestEff(KTBL_crops,technology,scenario,"soilHerb") $ (not(sameas(technology,"BA"))) = 0;

p_technoPestEff(KTBL_crops,technology,scenario,"foliarHerb") 
    $ (
        (sameas(technology,"spot6m")) 
        AND (not(sameas(scenario,"Base")))
    ) 
    = 0.7;
p_technoPestEff(KTBL_crops,technology,scenario,"foliarHerb") 
    $ (
        (sameas(technology,"spot27m")) 
        AND (not(sameas(scenario,"Base")))
    ) 
    = 0.6;

p_technoPestEff(KTBL_rowCrops,technology,scenario,"fung") 
    $ (
        (sameas(technology,"spot6m"))
        AND ((sameas(scenario,"FH+Bonus")) OR (sameas(scenario,"FH+Bonus+BA")))
    )
    = 0.4;
p_technoPestEff(KTBL_nonRowCrops,technology,scenario,"fung") 
    $ (
        (sameas(technology,"spot6m"))
        AND ((sameas(scenario,"FH+Bonus")) OR (sameas(scenario,"FH+Bonus+BA")))
    ) 
    = 0.3;
p_technoPestEff(KTBL_crops,technology,scenario,"fung") 
    $ (
        (sameas(technology,"spot27m"))
        AND ((sameas(scenario,"FH+Bonus")) OR (sameas(scenario,"FH+Bonus+BA")))
    ) 
    = 0.3;

p_technoPestEff(KTBL_rowCrops,technology,scenario,"insect") 
    $ (
        (sameas(technology,"spot6m"))
        AND ((sameas(scenario,"FH+Bonus")) OR (sameas(scenario,"FH+Bonus+BA")))
    ) 
    = 0.4;
p_technoPestEff(KTBL_nonRowCrops,technology,scenario,"insect") 
    $ (
        (sameas(technology,"spot6m"))
        AND ((sameas(scenario,"FH+Bonus")) OR (sameas(scenario,"FH+Bonus+BA")))
    ) 
    = 0.3;
p_technoPestEff(KTBL_crops,technology,scenario,"insect") 
    $ (
        (sameas(technology,"spot27m"))
        AND ((sameas(scenario,"FH+Bonus")) OR (sameas(scenario,"FH+Bonus+BA")))
    )
    = 0.3;

p_technoPestEff(KTBL_crops,technology,scenario,"growthReg") 
    $ (
        (sameas(technology,"spot6m"))
        AND ((sameas(scenario,"FH+Bonus")) OR (sameas(scenario,"FH+Bonus+BA")))
    ) 
    = 0.3;
p_technoPestEff(KTBL_crops,technology,scenario,"growthReg") 
    $ (
        (sameas(technology,"spot27m"))
        AND ((sameas(scenario,"FH+Bonus")) OR (sameas(scenario,"FH+Bonus+BA")))
    ) 
    = 0.3;

p_technoPestEff(KTBL_crops,technology,scenario,"dessic") $ (not(sameas(technology,"BA"))) = 0;


parameter p_technoLifetime(scenSprayer);

*source: makost KTBL 17.05.2024 Standartwert Spritze 
p_technoLifetime(technology) = 10;


parameter p_technoAreaCapac(scenSprayer,KTBL_mechanisation);

*standard KTBL procedure
p_technoAreaCapac("BA","45") = 4800;
p_technoAreaCapac("BA","67") = 6000;
p_technoAreaCapac("BA","83") = 7200;
p_technoAreaCapac("BA","102") = 9600;
p_technoAreaCapac("BA","120") = 9600;
p_technoAreaCapac("BA","200") = 9600;
p_technoAreaCapac("BA","230") = 14400;
*sprayer for mechanization level of 45 kW has boom width of 12m (makost 17.05.2024)
p_technoAreaCapac("spot6m",KTBL_mechanisation) = p_technoAreaCapac("BA","45")/2;
*KTBL value for 27m sprayer (makost 17.05.2024)
p_technoAreaCapac("spot27m",KTBL_mechanisation) = 10800;


parameter p_technoFieldDayHours(scenSprayer);

*hours per field day available for spraying (S-S requires good light conditions, 
*wich are facilitated over night for spot6m with cover on top of the boom and light sources)
p_technoFieldDayHours("BA") = 16;
p_technoFieldDayHours("spot6m") = 24;
p_technoFieldDayHours("spot27m") = 16;
;

*
*  --- parameters for time requirements, other costs and variable costs 
*
parameters
    p_technoTimeReq(scenSprayer,KTBL_size,KTBL_mechanisation,KTBL_distance)
    p_technoFuelCons(scenSprayer,KTBL_size,KTBL_mechanisation,KTBL_distance)
    p_technoMaintenance(scenSprayer,KTBL_size,KTBL_mechanisation,KTBL_distance)
    p_technoOtherCosts(scenSprayer,KTBL_size,KTBL_mechanisation,KTBL_distance)
;

*
* --- Parameters for BA technology 
*
*p_technoTimeReq("spot6m",KTBL_size,KTBL_mechanisation,KTBL_distance) = p_ktbl_workingStepsBroadcast(KTBL_size,"45",KTBL_distance,"time") * 2;
*sprayer is reportedly able to spray between 2.5 and 4 ha in an hour

* --- data source: KTBL-Feldarbeitsrechner: 24.06.2024

*45 kW tractor used, 300 l/ha
p_technoTimeReq("BA","1","45","1") = 0.43;
p_technoFuelCons("BA","1","45","1") = 1.27;
p_technoOtherCosts("BA","1","45","1") = 0.64;
p_technoMaintenance("BA","1","45","1") = 4.31;
p_technoTimeReq("BA","1","45","2") = 0.46;
p_technoFuelCons("BA","1","45","2") = 1.36;
p_technoOtherCosts("BA","1","45","2") = 0.66;
p_technoMaintenance("BA","1","45","2") = 4.46;
p_technoTimeReq("BA","1","45","3") = 0.5;
p_technoFuelCons("BA","1","45","3") = 1.45;
p_technoOtherCosts("BA","1","45","3") = 0.68;
p_technoMaintenance("BA","1","45","3") = 4.59;
p_technoTimeReq("BA","1","45","4") = 0.53;
p_technoFuelCons("BA","1","45","4") = 1.54;
p_technoOtherCosts("BA","1","45","4") = 0.7;
p_technoMaintenance("BA","1","45","4") = 4.71;
p_technoTimeReq("BA","1","45","5") = 0.56;
p_technoFuelCons("BA","1","45","5") = 1.63;
p_technoOtherCosts("BA","1","45","5") = 0.72;
p_technoMaintenance("BA","1","45","5") = 4.83;
p_technoTimeReq("BA","1","45","10") = 0.7;
p_technoFuelCons("BA","1","45","10") = 2.09;
p_technoOtherCosts("BA","1","45","10") = 0.81;
p_technoMaintenance("BA","1","45","10") = 5.41;
p_technoTimeReq("BA","1","45","15") = 0.85;
p_technoFuelCons("BA","1","45","15") = 2.57;
p_technoOtherCosts("BA","1","45","15") = 0.91;
p_technoMaintenance("BA","1","45","15") = 6.0;

p_technoTimeReq("BA","2","45","1") = 0.35;
p_technoFuelCons("BA","2","45","1") = 1.12;
p_technoOtherCosts("BA","2","45","1") = 0.59;
p_technoMaintenance("BA","2","45","1") = 4.0;
p_technoTimeReq("BA","2","45","2") = 0.39;
p_technoFuelCons("BA","2","45","2") = 1.21;
p_technoOtherCosts("BA","2","45","2") = 0.61;
p_technoMaintenance("BA","2","45","2") = 4.14;
p_technoTimeReq("BA","2","45","3") = 0.42;
p_technoFuelCons("BA","2","45","3") = 1.3;
p_technoOtherCosts("BA","2","45","3") = 0.63;
p_technoMaintenance("BA","2","45","3") = 4.27;
p_technoTimeReq("BA","2","45","4") = 0.45;
p_technoFuelCons("BA","2","45","4") = 1.39;
p_technoOtherCosts("BA","2","45","4") = 0.65;
p_technoMaintenance("BA","2","45","4") = 4.4;
p_technoTimeReq("BA","2","45","5") = 0.48;
p_technoFuelCons("BA","2","45","5") = 1.48;
p_technoOtherCosts("BA","2","45","5") = 0.67;
p_technoMaintenance("BA","2","45","5") = 4.51;
p_technoTimeReq("BA","2","45","10") = 0.63;
p_technoFuelCons("BA","2","45","10") = 1.94;
p_technoOtherCosts("BA","2","45","10") = 0.76;
p_technoMaintenance("BA","2","45","10") = 5.1;
p_technoTimeReq("BA","2","45","15") = 0.78;
p_technoFuelCons("BA","2","45","15") = 2.41;
p_technoOtherCosts("BA","2","45","15") = 0.86;
p_technoMaintenance("BA","2","45","15") = 5.69;

p_technoTimeReq("BA","5","45","1") = 0.37;
p_technoFuelCons("BA","5","45","1") = 1.2;
p_technoOtherCosts("BA","5","45","1") = 0.6;
p_technoMaintenance("BA","5","45","1") = 4.08;
p_technoTimeReq("BA","5","45","2") = 0.4;
p_technoFuelCons("BA","5","45","2") = 1.29;
p_technoOtherCosts("BA","5","45","2") = 0.62;
p_technoMaintenance("BA","5","45","2") = 4.21;
p_technoTimeReq("BA","5","45","3") = 0.44;
p_technoFuelCons("BA","5","45","3") = 1.38;
p_technoOtherCosts("BA","5","45","3") = 0.64;
p_technoMaintenance("BA","5","45","3") = 4.34;
p_technoTimeReq("BA","5","45","4") = 0.47;
p_technoFuelCons("BA","5","45","4") = 1.47;
p_technoOtherCosts("BA","5","45","4") = 0.66;
p_technoMaintenance("BA","5","45","4") = 4.47;
p_technoTimeReq("BA","5","45","5") = 0.5;
p_technoFuelCons("BA","5","45","5") = 1.56;
p_technoOtherCosts("BA","5","45","5") = 0.68;
p_technoMaintenance("BA","5","45","5") = 4.58;
p_technoTimeReq("BA","5","45","10") = 0.64;
p_technoFuelCons("BA","5","45","10") = 2.01;
p_technoOtherCosts("BA","5","45","10") = 0.77;
p_technoMaintenance("BA","5","45","10") = 5.16;
p_technoTimeReq("BA","5","45","15") = 0.79;
p_technoFuelCons("BA","5","45","15") = 2.49;
p_technoOtherCosts("BA","5","45","15") = 0.87;
p_technoMaintenance("BA","5","45","15") = 5.76;

p_technoTimeReq("BA","10","45","1") = 0.34;
p_technoFuelCons("BA","10","45","1") = 1.15;
p_technoOtherCosts("BA","10","45","1") = 0.58;
p_technoMaintenance("BA","10","45","1") = 3.97;
p_technoTimeReq("BA","10","45","2") = 0.38;
p_technoFuelCons("BA","10","45","2") = 1.24;
p_technoOtherCosts("BA","10","45","2") = 0.6;
p_technoMaintenance("BA","10","45","2") = 4.11;
p_technoTimeReq("BA","10","45","3") = 0.41;
p_technoFuelCons("BA","10","45","3") = 1.33;
p_technoOtherCosts("BA","10","45","3") = 0.62;
p_technoMaintenance("BA","10","45","3") = 4.24;
p_technoTimeReq("BA","10","45","4") = 0.44;
p_technoFuelCons("BA","10","45","4") = 1.42;
p_technoOtherCosts("BA","10","45","4") = 0.64;
p_technoMaintenance("BA","10","45","4") = 4.36;
p_technoTimeReq("BA","10","45","5") = 0.47;
p_technoFuelCons("BA","10","45","5") = 1.5;
p_technoOtherCosts("BA","10","45","5") = 0.66;
p_technoMaintenance("BA","10","45","5") = 4.48;
p_technoTimeReq("BA","10","45","10") = 0.62;
p_technoFuelCons("BA","10","45","10") = 1.96;
p_technoOtherCosts("BA","10","45","10") = 0.76; 
p_technoMaintenance("BA","10","45","10") = 5.07;
p_technoTimeReq("BA","10","45","15") = 0.77;
p_technoFuelCons("BA","10","45","15") = 2.43;
p_technoOtherCosts("BA","10","45","15") = 0.85;
p_technoMaintenance("BA","10","45","15") = 5.66;

p_technoTimeReq("BA","20","45","1") = 0.35;
p_technoFuelCons("BA","20","45","1") = 1.19;
p_technoOtherCosts("BA","20","45","1") = 0.59;
p_technoMaintenance("BA","20","45","1") = 4.0;
p_technoTimeReq("BA","20","45","2") = 0.39;
p_technoFuelCons("BA","20","45","2") = 1.28;
p_technoOtherCosts("BA","20","45","2") = 0.61;
p_technoMaintenance("BA","20","45","2") = 4.14;
p_technoTimeReq("BA","20","45","3") = 0.42;
p_technoFuelCons("BA","20","45","3") = 1.37;
p_technoOtherCosts("BA","20","45","3") = 0.63;
p_technoMaintenance("BA","20","45","3") = 4.27;
p_technoTimeReq("BA","20","45","4") = 0.45;
p_technoFuelCons("BA","20","45","4") = 1.46;
p_technoOtherCosts("BA","20","45","4") = 0.65;
p_technoMaintenance("BA","20","45","4") = 4.39;
p_technoTimeReq("BA","20","45","5") = 0.48;
p_technoFuelCons("BA","20","45","5") = 1.55;
p_technoOtherCosts("BA","20","45","5") = 0.67;
p_technoMaintenance("BA","20","45","5") = 4.51;
p_technoTimeReq("BA","20","45","10") = 0.62;
p_technoFuelCons("BA","20","45","10") = 2.0;
p_technoOtherCosts("BA","20","45","10") = 0.76;
p_technoMaintenance("BA","20","45","10") = 5.1;
p_technoTimeReq("BA","20","45","15") = 0.77;
p_technoFuelCons("BA","20","45","15") = 2.48;
p_technoOtherCosts("BA","20","45","15") = 0.86;
p_technoMaintenance("BA","20","45","15") = 5.69;

p_technoTimeReq("BA","40","45","1") = 0.36;
p_technoFuelCons("BA","40","45","1") = 1.26;
p_technoOtherCosts("BA","40","45","1") = 0.59;
p_technoMaintenance("BA","40","45","1") = 4.05;
p_technoTimeReq("BA","40","45","2") = 0.4;
p_technoFuelCons("BA","40","45","2") = 1.35;
p_technoOtherCosts("BA","40","45","2") = 0.62;
p_technoMaintenance("BA","40","45","2") = 4.19;
p_technoTimeReq("BA","40","45","3") = 0.43;
p_technoFuelCons("BA","40","45","3") = 1.44;
p_technoOtherCosts("BA","40","45","3") = 0.64;
p_technoMaintenance("BA","40","45","3") = 4.33;
p_technoTimeReq("BA","40","45","4") = 0.46;
p_technoFuelCons("BA","40","45","4") = 1.53;
p_technoOtherCosts("BA","40","45","4") = 0.66;
p_technoMaintenance("BA","40","45","4") = 4.45;
p_technoTimeReq("BA","40","45","5") = 0.49;
p_technoFuelCons("BA","40","45","5") = 1.62;
p_technoOtherCosts("BA","40","45","5") = 0.68;
p_technoMaintenance("BA","40","45","5") = 4.56;
p_technoTimeReq("BA","40","45","10") = 0.64;
p_technoFuelCons("BA","40","45","10") = 2.08;
p_technoOtherCosts("BA","40","45","10") = 0.77;
p_technoMaintenance("BA","40","45","10") = 5.15;
p_technoTimeReq("BA","40","45","15") = 0.79;
p_technoFuelCons("BA","40","45","15") = 2.55;
p_technoOtherCosts("BA","40","45","15") = 0.86;
p_technoMaintenance("BA","40","45","15") = 5.74;

p_technoTimeReq("BA","80","45","1") = 0.38;
p_technoFuelCons("BA","80","45","1") = 1.36;
p_technoOtherCosts("BA","80","45","1") = 0.61;
p_technoMaintenance("BA","80","45","1") = 4.13;
p_technoTimeReq("BA","80","45","2") = 0.42;
p_technoFuelCons("BA","80","45","2") = 1.46;
p_technoOtherCosts("BA","80","45","2") = 0.63;
p_technoMaintenance("BA","80","45","2") = 4.28;
p_technoTimeReq("BA","80","45","3") = 0.45;
p_technoFuelCons("BA","80","45","3") = 1.55;
p_technoOtherCosts("BA","80","45","3") = 0.65;
p_technoMaintenance("BA","80","45","3") = 4.41;
p_technoTimeReq("BA","80","45","4") = 0.48;
p_technoFuelCons("BA","80","45","4") = 1.64;
p_technoOtherCosts("BA","80","45","4") = 0.67;
p_technoMaintenance("BA","80","45","4") = 4.53;
p_technoTimeReq("BA","80","45","5") = 0.51;
p_technoFuelCons("BA","80","45","5") = 1.72;
p_technoOtherCosts("BA","80","45","5") = 0.69;
p_technoMaintenance("BA","80","45","5") = 4.65;
p_technoTimeReq("BA","80","45","10") = 0.66;
p_technoFuelCons("BA","80","45","10") = 2.18;
p_technoOtherCosts("BA","80","45","10") = 0.78;
p_technoMaintenance("BA","80","45","10") = 5.23;
p_technoTimeReq("BA","80","45","15") = 0.81;
p_technoFuelCons("BA","80","45","15") = 2.66;
p_technoOtherCosts("BA","80","45","15") = 0.88;
p_technoMaintenance("BA","80","45","15") = 5.83;


*45 kW, 300 l/ha
p_technoTimeReq("BA","1","67","1") = 0.37;
p_technoFuelCons("BA","1","67","1") = 1.13;
p_technoOtherCosts("BA","1","67","1") = 0.57;
p_technoMaintenance("BA","1","67","1") = 4.07;
p_technoTimeReq("BA","1","67","2") = 0.39;
p_technoFuelCons("BA","1","67","2") = 1.19;
p_technoOtherCosts("BA","1","67","2") = 0.58;
p_technoMaintenance("BA","1","67","2") = 4.16;
p_technoTimeReq("BA","1","67","3") = 0.41;
p_technoFuelCons("BA","1","67","3") = 1.25;
p_technoOtherCosts("BA","1","67","3") = 0.59;
p_technoMaintenance("BA","1","67","3") = 4.24;
p_technoTimeReq("BA","1","67","4") = 0.43;
p_technoFuelCons("BA","1","67","4") = 1.31;
p_technoOtherCosts("BA","1","67","4") = 0.6;
p_technoMaintenance("BA","1","67","4") = 4.31;
p_technoTimeReq("BA","1","67","5") = 0.44;
p_technoFuelCons("BA","1","67","5") = 1.37;
p_technoOtherCosts("BA","1","67","5") = 0.62;
p_technoMaintenance("BA","1","67","5") = 4.38;
p_technoTimeReq("BA","1","67","10") = 0.53;
p_technoFuelCons("BA","1","67","10") = 1.67;
p_technoOtherCosts("BA","1","67","10") = 0.67;
p_technoMaintenance("BA","1","67","10") = 4.73;
p_technoTimeReq("BA","1","67","15") = 0.62;
p_technoFuelCons("BA","1","67","15") = 1.99;
p_technoOtherCosts("BA","1","67","15") = 0.73;
p_technoMaintenance("BA","1","67","15") = 5.08;

p_technoTimeReq("BA","2","67","1") = 0.29;
p_technoFuelCons("BA","2","67","1") = 0.96;
p_technoOtherCosts("BA","2","67","1") = 0.52;
p_technoMaintenance("BA","2","67","1") = 3.77;
p_technoTimeReq("BA","2","67","2") = 0.32;
p_technoFuelCons("BA","2","67","2") = 1.02;
p_technoOtherCosts("BA","2","67","2") = 0.53;
p_technoMaintenance("BA","2","67","2") = 3.85;
p_technoTimeReq("BA","2","67","3") = 0.33;
p_technoFuelCons("BA","2","67","3") = 1.08;
p_technoOtherCosts("BA","2","67","3") = 0.54;
p_technoMaintenance("BA","2","67","3") = 3.93;
p_technoTimeReq("BA","2","67","4") = 0.35;
p_technoFuelCons("BA","2","67","4") = 1.14;
p_technoOtherCosts("BA","2","67","4") = 0.56;
p_technoMaintenance("BA","2","67","4") = 4.0;
p_technoTimeReq("BA","2","67","5") = 0.37;
p_technoFuelCons("BA","2","67","5") = 1.19;
p_technoOtherCosts("BA","2","67","5") = 0.57;
p_technoMaintenance("BA","2","67","5") = 4.07;
p_technoTimeReq("BA","2","67","10") = 0.46;
p_technoFuelCons("BA","2","67","10") = 1.49;
p_technoOtherCosts("BA","2","67","10") = 0.62;
p_technoMaintenance("BA","2","67","10") = 4.42;
p_technoTimeReq("BA","2","67","15") = 0.55;
p_technoFuelCons("BA","2","67","15") = 1.8;
p_technoOtherCosts("BA","2","67","15") = 0.68;
p_technoMaintenance("BA","2","67","15") = 4.78;

p_technoTimeReq("BA","5","67","1") = 0.27;
p_technoFuelCons("BA","5","67","1") = 0.95;
p_technoOtherCosts("BA","5","67","1") = 0.51;
p_technoMaintenance("BA","5","67","1") = 3.69;
p_technoTimeReq("BA","5","67","2") = 0.29;
p_technoFuelCons("BA","5","67","2") = 1.01;
p_technoOtherCosts("BA","5","67","2") = 0.52;
p_technoMaintenance("BA","5","67","2") = 3.77;
p_technoTimeReq("BA","5","67","3") = 0.31;
p_technoFuelCons("BA","5","67","3") = 1.07;
p_technoOtherCosts("BA","5","67","3") = 0.53;
p_technoMaintenance("BA","5","67","3") = 3.85;
p_technoTimeReq("BA","5","67","4") = 0.33;
p_technoFuelCons("BA","5","67","4") = 1.13;
p_technoOtherCosts("BA","5","67","4") = 0.54;
p_technoMaintenance("BA","5","67","4") = 3.92;
p_technoTimeReq("BA","5","67","5") = 0.35;
p_technoFuelCons("BA","5","67","5") = 1.19;
p_technoOtherCosts("BA","5","67","5") = 0.55;
p_technoMaintenance("BA","5","67","5") = 4.0;
p_technoTimeReq("BA","5","67","10") = 0.44;
p_technoFuelCons("BA","5","67","10") = 1.48;
p_technoOtherCosts("BA","5","67","10") = 0.61;
p_technoMaintenance("BA","5","67","10") = 4.34;
p_technoTimeReq("BA","5","67","15") = 0.53;
p_technoFuelCons("BA","5","67","15") = 1.8;
p_technoOtherCosts("BA","5","67","15") = 0.67;
p_technoMaintenance("BA","5","67","15") = 4.71;

p_technoTimeReq("BA","10","67","1") = 0.24;
p_technoFuelCons("BA","10","67","1") = 0.88;
p_technoOtherCosts("BA","10","67","1") = 0.49;
p_technoMaintenance("BA","10","67","1") = 3.57;
p_technoTimeReq("BA","10","67","2") = 0.27;
p_technoFuelCons("BA","10","67","2") = 0.94;
p_technoOtherCosts("BA","10","67","2") = 0.5;
p_technoMaintenance("BA","10","67","2") = 3.66;
p_technoTimeReq("BA","10","67","3") = 0.29;
p_technoFuelCons("BA","10","67","3") = 1.0;
p_technoOtherCosts("BA","10","67","3") = 0.51;
p_technoMaintenance("BA","10","67","3") = 3.74;
p_technoTimeReq("BA","10","67","4") = 0.3;
p_technoFuelCons("BA","10","67","4") = 1.06;
p_technoOtherCosts("BA","10","67","4") = 0.52;
p_technoMaintenance("BA","10","67","4") = 3.81;
p_technoTimeReq("BA","10","67","5") = 0.32;
p_technoFuelCons("BA","10","67","5") = 1.12;
p_technoOtherCosts("BA","10","67","5") = 0.54;
p_technoMaintenance("BA","10","67","5") = 3.88;
p_technoTimeReq("BA","10","67","10") = 0.41;
p_technoFuelCons("BA","10","67","10") = 1.41;
p_technoOtherCosts("BA","10","67","10") = 0.59;
p_technoMaintenance("BA","10","67","10") = 4.23;
p_technoTimeReq("BA","10","67","15") = 0.5;
p_technoFuelCons("BA","10","67","15") = 1.72;
p_technoOtherCosts("BA","10","67","15") = 0.65;
p_technoMaintenance("BA","10","67","15") = 4.59;

p_technoTimeReq("BA","20","67","1") = 0.25;
p_technoFuelCons("BA","20","67","1") = 0.93;
p_technoOtherCosts("BA","20","67","1") = 0.49;
p_technoMaintenance("BA","20","67","1") = 3.6;
p_technoTimeReq("BA","20","67","2") = 0.27;
p_technoFuelCons("BA","20","67","2") = 0.99;
p_technoOtherCosts("BA","20","67","2") = 0.5;
p_technoMaintenance("BA","20","67","2") = 3.68;
p_technoTimeReq("BA","20","67","3") = 0.29;
p_technoFuelCons("BA","20","67","3") = 1.04;
p_technoOtherCosts("BA","20","67","3") = 0.52;
p_technoMaintenance("BA","20","67","3") = 3.76;
p_technoTimeReq("BA","20","67","4") = 0.31;
p_technoFuelCons("BA","20","67","4") = 1.1;
p_technoOtherCosts("BA","20","67","4") = 0.53;
p_technoMaintenance("BA","20","67","4") = 3.83;
p_technoTimeReq("BA","20","67","5") = 0.33;
p_technoFuelCons("BA","20","67","5") = 1.16;
p_technoOtherCosts("BA","20","67","5") = 0.54;
p_technoMaintenance("BA","20","67","5") = 3.91;
p_technoTimeReq("BA","20","67","10") = 0.41;
p_technoFuelCons("BA","20","67","10") = 1.45;
p_technoOtherCosts("BA","20","67","10") = 0.6;
p_technoMaintenance("BA","20","67","10") = 4.26;
p_technoTimeReq("BA","20","67","15") = 0.5;
p_technoFuelCons("BA","20","67","15") = 1.76;
p_technoOtherCosts("BA","20","67","15") = 0.65;
p_technoMaintenance("BA","20","67","15") = 4.61;

p_technoTimeReq("BA","40","67","1") = 0.25;
p_technoFuelCons("BA","40","67","1") = 0.95;
p_technoOtherCosts("BA","40","67","1") = 0.49;
p_technoMaintenance("BA","40","67","1") = 3.61;
p_technoTimeReq("BA","40","67","2") = 0.27;
p_technoFuelCons("BA","40","67","2") = 1.01;
p_technoOtherCosts("BA","40","67","2") = 0.51;
p_technoMaintenance("BA","40","67","2") = 3.7;
p_technoTimeReq("BA","40","67","3") = 0.29;
p_technoFuelCons("BA","40","67","3") = 1.07;
p_technoOtherCosts("BA","40","67","3") = 0.52;
p_technoMaintenance("BA","40","67","3") = 3.78;
p_technoTimeReq("BA","40","67","4") = 0.31;
p_technoFuelCons("BA","40","67","4") = 1.13;
p_technoOtherCosts("BA","40","67","4") = 0.53;
p_technoMaintenance("BA","40","67","4") = 3.85;
p_technoTimeReq("BA","40","67","5") = 0.33;
p_technoFuelCons("BA","40","67","5") = 1.18;
p_technoOtherCosts("BA","40","67","5") = 0.54;
p_technoMaintenance("BA","40","67","5") = 3.92;
p_technoTimeReq("BA","40","67","10") = 0.42;
p_technoFuelCons("BA","40","67","10") = 1.48;
p_technoOtherCosts("BA","40","67","10") = 0.6;
p_technoMaintenance("BA","40","67","10") = 4.27;
p_technoTimeReq("BA","40","67","15") = 0.51;
p_technoFuelCons("BA","40","67","15") = 1.79;
p_technoOtherCosts("BA","40","67","15") = 0.66;
p_technoMaintenance("BA","40","67","15") = 4.63;

p_technoTimeReq("BA","80","67","1") = 0.27;
p_technoFuelCons("BA","80","67","1") = 1.03;
p_technoOtherCosts("BA","80","67","1") = 0.5;
p_technoMaintenance("BA","80","67","1") = 3.67;
p_technoTimeReq("BA","80","67","2") = 0.29;
p_technoFuelCons("BA","80","67","2") = 1.09;
p_technoOtherCosts("BA","80","67","2") = 0.52;
p_technoMaintenance("BA","80","67","2") = 3.76;
p_technoTimeReq("BA","80","67","3") = 0.31;
p_technoFuelCons("BA","80","67","3") = 1.15;
p_technoOtherCosts("BA","80","67","3") = 0.53;
p_technoMaintenance("BA","80","67","3") = 3.83;
p_technoTimeReq("BA","80","67","4") = 0.33;
p_technoFuelCons("BA","80","67","4") = 1.2;
p_technoOtherCosts("BA","80","67","4") = 0.54;
p_technoMaintenance("BA","80","67","4") = 3.91;
p_technoTimeReq("BA","80","67","5") = 0.34;
p_technoFuelCons("BA","80","67","5") = 1.26;
p_technoOtherCosts("BA","80","67","5") = 0.55;
p_technoMaintenance("BA","80","67","5") = 3.98;
p_technoTimeReq("BA","80","67","10") = 0.43;
p_technoFuelCons("BA","80","67","10") = 1.56;
p_technoOtherCosts("BA","80","67","10") = 0.61;
p_technoMaintenance("BA","80","67","10") = 4.33;
p_technoTimeReq("BA","80","67","15") = 0.52;
p_technoFuelCons("BA","80","67","15") = 1.87;
p_technoOtherCosts("BA","80","67","15") = 0.66;
p_technoMaintenance("BA","80","67","15") = 4.69;


*18m, 1,500 l, 67 kW, 300 l/ha
p_technoTimeReq("BA","1","83","1") = 0.31;
p_technoFuelCons("BA","1","83","1") = 1.33;
p_technoOtherCosts("BA","1","83","1") = 0.61;
p_technoMaintenance("BA","1","83","1") = 4.49;
p_technoTimeReq("BA","1","83","2") = 0.33;
p_technoFuelCons("BA","1","83","2") = 1.39;
p_technoOtherCosts("BA","1","83","2") = 0.62;
p_technoMaintenance("BA","1","83","2") = 4.57;
p_technoTimeReq("BA","1","83","3") = 0.34;
p_technoFuelCons("BA","1","83","3") = 1.45;
p_technoOtherCosts("BA","1","83","3") = 0.63;
p_technoMaintenance("BA","1","83","3") = 4.65;
p_technoTimeReq("BA","1","83","4") = 0.35;
p_technoFuelCons("BA","1","83","4") = 1.51;
p_technoOtherCosts("BA","1","83","4") = 0.64;
p_technoMaintenance("BA","1","83","4") = 4.73;
p_technoTimeReq("BA","1","83","5") = 0.37;
p_technoFuelCons("BA","1","83","5") = 1.57;
p_technoOtherCosts("BA","1","83","5") = 0.65;
p_technoMaintenance("BA","1","83","5") = 4.79;
p_technoTimeReq("BA","1","83","10") = 0.43;
p_technoFuelCons("BA","1","83","10") = 1.87;
p_technoOtherCosts("BA","1","83","10") = 0.71;
p_technoMaintenance("BA","1","83","10") = 5.15;
p_technoTimeReq("BA","1","83","15") = 0.48;
p_technoFuelCons("BA","1","83","15") = 2.18;
p_technoOtherCosts("BA","1","83","15") = 0.77;
p_technoMaintenance("BA","1","83","15") = 5.51;

p_technoTimeReq("BA","2","83","1") = 0.25;
p_technoFuelCons("BA","2","83","1") = 1.12;
p_technoOtherCosts("BA","2","83","1") = 0.54;
p_technoMaintenance("BA","2","83","1") = 4.07;
p_technoTimeReq("BA","2","83","2") = 0.26;
p_technoFuelCons("BA","2","83","2") = 1.18;
p_technoOtherCosts("BA","2","83","2") = 0.56;
p_technoMaintenance("BA","2","83","2") = 4.16;
p_technoTimeReq("BA","2","83","3") = 0.27;
p_technoFuelCons("BA","2","83","3") = 1.24;
p_technoOtherCosts("BA","2","83","3") = 0.57;
p_technoMaintenance("BA","2","83","3") = 4.23;
p_technoTimeReq("BA","2","83","4") = 0.29;
p_technoFuelCons("BA","2","83","4") = 1.3;
p_technoOtherCosts("BA","2","83","4") = 0.58;
p_technoMaintenance("BA","2","83","4") = 4.31;
p_technoTimeReq("BA","2","83","5") = 0.3;
p_technoFuelCons("BA","2","83","5") = 1.35;
p_technoOtherCosts("BA","2","83","5") = 0.59;
p_technoMaintenance("BA","2","83","5") = 4.38;
p_technoTimeReq("BA","2","83","10") = 0.36;
p_technoFuelCons("BA","2","83","10") = 1.64;
p_technoOtherCosts("BA","2","83","10") = 0.64;
p_technoMaintenance("BA","2","83","10") = 4.73;
p_technoTimeReq("BA","2","83","15") = 0.42;
p_technoFuelCons("BA","2","83","15") = 1.95;
p_technoOtherCosts("BA","2","83","15") = 0.7;
p_technoMaintenance("BA","2","83","15") = 5.08;

p_technoTimeReq("BA","5","83","1") = 0.18;
p_technoFuelCons("BA","5","83","1") = 0.91;
p_technoOtherCosts("BA","5","83","1") = 0.48;
p_technoMaintenance("BA","5","83","1") = 3.68;
p_technoTimeReq("BA","5","83","2") = 0.19;
p_technoFuelCons("BA","5","83","2") = 0.97;
p_technoOtherCosts("BA","5","83","2") = 0.5;
p_technoMaintenance("BA","5","83","2") = 3.76;
p_technoTimeReq("BA","5","83","3") = 0.21;
p_technoFuelCons("BA","5","83","3") = 1.02;
p_technoOtherCosts("BA","5","83","3") = 0.51;
p_technoMaintenance("BA","5","83","3") = 3.84;
p_technoTimeReq("BA","5","83","4") = 0.22;
p_technoFuelCons("BA","5","83","4") = 1.08;
p_technoOtherCosts("BA","5","83","4") = 0.52;
p_technoMaintenance("BA","5","83","4") = 3.92;
p_technoTimeReq("BA","5","83","5") = 0.23;
p_technoFuelCons("BA","5","83","5") = 1.13;
p_technoOtherCosts("BA","5","83","5") = 0.53;
p_technoMaintenance("BA","5","83","5") = 3.99;
p_technoTimeReq("BA","5","83","10") = 0.29;
p_technoFuelCons("BA","5","83","10") = 1.42;
p_technoOtherCosts("BA","5","83","10") = 0.58;
p_technoMaintenance("BA","5","83","10") = 4.38;
p_technoTimeReq("BA","5","83","15") = 0.35;
p_technoFuelCons("BA","5","83","15") = 1.72;
p_technoOtherCosts("BA","5","83","15") = 0.64;
p_technoMaintenance("BA","5","83","15") = 4.7;

p_technoTimeReq("BA","10","83","1") = 0.19;
p_technoFuelCons("BA","10","83","1") = 0.98;
p_technoOtherCosts("BA","10","83","1") = 0.49;
p_technoMaintenance("BA","10","83","1") = 3.72;
p_technoTimeReq("BA","10","83","2") = 0.2;
p_technoFuelCons("BA","10","83","2") = 1.03;
p_technoOtherCosts("BA","10","83","2") = 0.5;
p_technoMaintenance("BA","10","83","2") = 3.8;
p_technoTimeReq("BA","10","83","3") = 0.21;
p_technoFuelCons("BA","10","83","3") = 1.09;
p_technoOtherCosts("BA","10","83","3") = 0.51;
p_technoMaintenance("BA","10","83","3") = 3.88;
p_technoTimeReq("BA","10","83","4") = 0.23;
p_technoFuelCons("BA","10","83","4") = 1.15;
p_technoOtherCosts("BA","10","83","4") = 0.52;
p_technoMaintenance("BA","10","83","4") = 3.96;
p_technoTimeReq("BA","10","83","5") = 0.24;
p_technoFuelCons("BA","10","83","5") = 1.2;
p_technoOtherCosts("BA","10","83","5") = 0.54;
p_technoMaintenance("BA","10","83","5") = 4.03;
p_technoTimeReq("BA","10","83","10") = 0.3;
p_technoFuelCons("BA","10","83","10") = 1.48;
p_technoOtherCosts("BA","10","83","10") = 0.59; 
p_technoMaintenance("BA","10","83","10") = 4.38;
p_technoTimeReq("BA","10","83","15") = 0.36;
p_technoFuelCons("BA","10","83","15") = 1.78;
p_technoOtherCosts("BA","10","83","15") = 0.65;
p_technoMaintenance("BA","10","83","15") = 4.73;

p_technoTimeReq("BA","20","83","1") = 0.19;
p_technoFuelCons("BA","20","83","1") = 0.98;
p_technoOtherCosts("BA","20","83","1") = 0.49;
p_technoMaintenance("BA","20","83","1") = 3.71;
p_technoTimeReq("BA","20","83","2") = 0.2;
p_technoFuelCons("BA","20","83","2") = 1.04;
p_technoOtherCosts("BA","20","83","2") = 0.5;
p_technoMaintenance("BA","20","83","2") = 3.8;
p_technoTimeReq("BA","20","83","3") = 0.21;
p_technoFuelCons("BA","20","83","3") = 1.09;
p_technoOtherCosts("BA","20","83","3") = 0.51;
p_technoMaintenance("BA","20","83","3") = 3.88;
p_technoTimeReq("BA","20","83","4") = 0.22;
p_technoFuelCons("BA","20","83","4") = 1.15;
p_technoOtherCosts("BA","20","83","4") = 0.52;
p_technoMaintenance("BA","20","83","4") = 3.95;
p_technoTimeReq("BA","20","83","5") = 0.24;
p_technoFuelCons("BA","20","83","5") = 1.21;
p_technoOtherCosts("BA","20","83","5") = 0.53;
p_technoMaintenance("BA","20","83","5") = 4.02;
p_technoTimeReq("BA","20","83","10") = 0.3;
p_technoFuelCons("BA","20","83","10") = 1.49;
p_technoOtherCosts("BA","20","83","10") = 0.59;
p_technoMaintenance("BA","20","83","10") = 4.37;
p_technoTimeReq("BA","20","83","15") = 0.35;
p_technoFuelCons("BA","20","83","15") = 1.79;
p_technoOtherCosts("BA","20","83","15") = 0.64;
p_technoMaintenance("BA","20","83","15") = 4.73;

p_technoTimeReq("BA","40","83","1") = 0.19;
p_technoFuelCons("BA","40","83","1") = 1.01;
p_technoOtherCosts("BA","40","83","1") = 0.49;
p_technoMaintenance("BA","40","83","1") = 3.73;
p_technoTimeReq("BA","40","83","2") = 0.2;
p_technoFuelCons("BA","40","83","2") = 1.07;
p_technoOtherCosts("BA","40","83","2") = 0.5;
p_technoMaintenance("BA","40","83","2") = 3.81;
p_technoTimeReq("BA","40","83","3") = 0.22;
p_technoFuelCons("BA","40","83","3") = 1.12;
p_technoOtherCosts("BA","40","83","3") = 0.51;
p_technoMaintenance("BA","40","83","3") = 3.89;
p_technoTimeReq("BA","40","83","4") = 0.23;
p_technoFuelCons("BA","40","83","4") = 1.18;
p_technoOtherCosts("BA","40","83","4") = 0.53;
p_technoMaintenance("BA","40","83","4") = 3.97;
p_technoTimeReq("BA","40","83","5") = 0.24;
p_technoFuelCons("BA","40","83","5") = 1.24;
p_technoOtherCosts("BA","40","83","5") = 0.54;
p_technoMaintenance("BA","40","83","5") = 4.04;
p_technoTimeReq("BA","40","83","10") = 0.3;
p_technoFuelCons("BA","40","83","10") = 1.52;
p_technoOtherCosts("BA","40","83","10") = 0.59;
p_technoMaintenance("BA","40","83","10") = 4.39;
p_technoTimeReq("BA","40","83","15") = 0.36;
p_technoFuelCons("BA","40","83","15") = 1.82;
p_technoOtherCosts("BA","40","83","15") = 0.65;
p_technoMaintenance("BA","40","83","15") = 4.74;

p_technoTimeReq("BA","80","83","1") = 0.2;
p_technoFuelCons("BA","80","83","1") = 1.08;
p_technoOtherCosts("BA","80","83","1") = 0.5;
p_technoMaintenance("BA","80","83","1") = 3.79;
p_technoTimeReq("BA","80","83","2") = 0.21;
p_technoFuelCons("BA","80","83","2") = 1.14;
p_technoOtherCosts("BA","80","83","2") = 0.51;
p_technoMaintenance("BA","80","83","2") = 3.87;
p_technoTimeReq("BA","80","83","3") = 0.23;
p_technoFuelCons("BA","80","83","3") = 1.2;
p_technoOtherCosts("BA","80","83","3") = 0.52;
p_technoMaintenance("BA","80","83","3") = 3.95;
p_technoTimeReq("BA","80","83","4") = 0.24;
p_technoFuelCons("BA","80","83","4") = 1.26;
p_technoOtherCosts("BA","80","83","4") = 0.54;
p_technoMaintenance("BA","80","83","4") = 4.02;
p_technoTimeReq("BA","80","83","5") = 0.25;
p_technoFuelCons("BA","80","83","5") = 1.31;
p_technoOtherCosts("BA","80","83","5") = 0.55;
p_technoMaintenance("BA","80","83","5") = 4.09;
p_technoTimeReq("BA","80","83","10") = 0.31;
p_technoFuelCons("BA","80","83","10") = 1.6;
p_technoOtherCosts("BA","80","83","10") = 0.6;
p_technoMaintenance("BA","80","83","10") = 4.45;
p_technoTimeReq("BA","80","83","15") = 0.37;
p_technoFuelCons("BA","80","83","15") = 1.9;
p_technoOtherCosts("BA","80","83","15") = 0.66;
p_technoMaintenance("BA","80","83","15") = 4.8;


*24 m, 1,500 l, 67 kW, 300 l/ha
p_technoTimeReq("BA","1","102","1") = 0.27;
p_technoFuelCons("BA","1","102","1") = 1.13;
p_technoOtherCosts("BA","1","102","1") = 0.56;
p_technoMaintenance("BA","1","102","1") = 4.22;
p_technoTimeReq("BA","1","102","2") = 0.28;
p_technoFuelCons("BA","1","102","2") = 1.2;
p_technoOtherCosts("BA","1","102","2") = 0.57;
p_technoMaintenance("BA","1","102","2") = 4.31;
p_technoTimeReq("BA","1","102","3") = 0.3;
p_technoFuelCons("BA","1","102","3") = 1.26;
p_technoOtherCosts("BA","1","102","3") = 0.59;
p_technoMaintenance("BA","1","102","3") = 4.39;
p_technoTimeReq("BA","1","102","4") = 0.31;
p_technoFuelCons("BA","1","102","4") = 1.32;
p_technoOtherCosts("BA","1","102","4") = 0.6;
p_technoMaintenance("BA","1","102","4") = 4.46;
p_technoTimeReq("BA","1","102","5") = 0.32;
p_technoFuelCons("BA","1","102","5") = 1.38;
p_technoOtherCosts("BA","1","102","5") = 0.61;
p_technoMaintenance("BA","1","102","5") = 4.53;
p_technoTimeReq("BA","1","102","10") = 0.38;
p_technoFuelCons("BA","1","102","10") = 1.68;
p_technoOtherCosts("BA","1","102","10") = 0.66;
p_technoMaintenance("BA","1","102","10") = 4.88;
p_technoTimeReq("BA","1","102","15") = 0.44;
p_technoFuelCons("BA","1","102","15") = 2.0;
p_technoOtherCosts("BA","1","102","15") = 0.72;
p_technoMaintenance("BA","1","102","15") = 5.24;

p_technoTimeReq("BA","2","102","1") = 0.22;
p_technoFuelCons("BA","2","102","1") = 1.01;
p_technoOtherCosts("BA","2","102","1") = 0.51;
p_technoMaintenance("BA","2","102","1") = 3.9;
p_technoTimeReq("BA","2","102","2") = 0.23;
p_technoFuelCons("BA","2","102","2") = 1.07;
p_technoOtherCosts("BA","2","102","2") = 0.52;
p_technoMaintenance("BA","2","102","2") = 3.99;
p_technoTimeReq("BA","2","102","3") = 0.25;
p_technoFuelCons("BA","2","102","3") = 1.13;
p_technoOtherCosts("BA","2","102","3") = 0.54;
p_technoMaintenance("BA","2","102","3") = 4.06;
p_technoTimeReq("BA","2","102","4") = 0.26;
p_technoFuelCons("BA","2","102","4") = 1.19;
p_technoOtherCosts("BA","2","102","4") = 0.55;
p_technoMaintenance("BA","2","102","4") = 4.14;
p_technoTimeReq("BA","2","102","5") = 0.27;
p_technoFuelCons("BA","2","102","5") = 1.25;
p_technoOtherCosts("BA","2","102","5") = 0.56;
p_technoMaintenance("BA","2","102","5") = 4.21;
p_technoTimeReq("BA","2","102","10") = 0.33;
p_technoFuelCons("BA","2","102","10") = 1.55;
p_technoOtherCosts("BA","2","102","10") = 0.61;
p_technoMaintenance("BA","2","102","10") = 4.56;
p_technoTimeReq("BA","2","102","15") = 0.39;
p_technoFuelCons("BA","2","102","15") = 1.87;
p_technoOtherCosts("BA","2","102","15") = 0.67;
p_technoMaintenance("BA","2","102","15") = 4.91;

p_technoTimeReq("BA","5","102","1") = 0.15;
p_technoFuelCons("BA","5","102","1") = 0.79;
p_technoOtherCosts("BA","5","102","1") = 0.45;
p_technoMaintenance("BA","5","102","1") = 3.52;
p_technoTimeReq("BA","5","102","2") = 0.17;
p_technoFuelCons("BA","5","102","2") = 0.85;
p_technoOtherCosts("BA","5","102","2") = 0.47;
p_technoMaintenance("BA","5","102","2") = 3.61;
p_technoTimeReq("BA","5","102","3") = 0.18;
p_technoFuelCons("BA","5","102","3") = 0.91;
p_technoOtherCosts("BA","5","102","3") = 0.48;
p_technoMaintenance("BA","5","102","3") = 3.69;
p_technoTimeReq("BA","5","102","4") = 0.19;
p_technoFuelCons("BA","5","102","4") = 0.96;
p_technoOtherCosts("BA","5","102","4") = 0.49;
p_technoMaintenance("BA","5","102","4") = 3.76;
p_technoTimeReq("BA","5","102","5") = 0.2;
p_technoFuelCons("BA","5","102","5") = 1.02;
p_technoOtherCosts("BA","5","102","5") = 0.5;
p_technoMaintenance("BA","5","102","5") = 3.83;
p_technoTimeReq("BA","5","102","10") = 0.26;
p_technoFuelCons("BA","5","102","10") = 1.31;
p_technoOtherCosts("BA","5","102","10") = 0.55;
p_technoMaintenance("BA","5","102","10") = 4.18;
p_technoTimeReq("BA","5","102","15") = 0.32;
p_technoFuelCons("BA","5","102","15") = 1.62;
p_technoOtherCosts("BA","5","102","15") = 0.61;
p_technoMaintenance("BA","5","102","15") = 4.54;

p_technoTimeReq("BA","10","102","1") = 0.16;
p_technoFuelCons("BA","10","102","1") = 0.86;
p_technoOtherCosts("BA","10","102","1") = 0.46;
p_technoMaintenance("BA","10","102","1") = 3.57;
p_technoTimeReq("BA","10","102","2") = 0.18;
p_technoFuelCons("BA","10","102","2") = 0.92;
p_technoOtherCosts("BA","10","102","2") = 0.47;
p_technoMaintenance("BA","10","102","2") = 3.65;
p_technoTimeReq("BA","10","102","3") = 0.19;
p_technoFuelCons("BA","10","102","3") = 0.98;
p_technoOtherCosts("BA","10","102","3") = 0.49;
p_technoMaintenance("BA","10","102","3") = 3.73;
p_technoTimeReq("BA","10","102","4") = 0.2;
p_technoFuelCons("BA","10","102","4") = 1.04;
p_technoOtherCosts("BA","10","102","4") = 0.5;
p_technoMaintenance("BA","10","102","4") = 3.8;
p_technoTimeReq("BA","10","102","5") = 0.21;
p_technoFuelCons("BA","10","102","5") = 1.09;
p_technoOtherCosts("BA","10","102","5") = 0.51;
p_technoMaintenance("BA","10","102","5") = 3.87;
p_technoTimeReq("BA","10","102","10") = 0.27;
p_technoFuelCons("BA","10","102","10") = 1.39;
p_technoOtherCosts("BA","10","102","10") = 0.56;
p_technoMaintenance("BA","10","102","10") = 4.23;
p_technoTimeReq("BA","10","102","15") = 0.33;
p_technoFuelCons("BA","10","102","15") = 1.7;
p_technoOtherCosts("BA","10","102","15") = 0.62;
p_technoMaintenance("BA","10","102","15") = 4.58;

p_technoTimeReq("BA","20","102","1") = 0.16;
p_technoFuelCons("BA","20","102","1") = 0.88;
p_technoOtherCosts("BA","20","102","1") = 0.46;
p_technoMaintenance("BA","20","102","1") = 3.58;
p_technoTimeReq("BA","20","102","2") = 0.18;
p_technoFuelCons("BA","20","102","2") = 0.94;
p_technoOtherCosts("BA","20","102","2") = 0.47;
p_technoMaintenance("BA","20","102","2") = 3.66;
p_technoTimeReq("BA","20","102","3") = 0.19;
p_technoFuelCons("BA","20","102","3") = 1.0;
p_technoOtherCosts("BA","20","102","3") = 0.49;
p_technoMaintenance("BA","20","102","3") = 3.74;
p_technoTimeReq("BA","20","102","4") = 0.2;
p_technoFuelCons("BA","20","102","4") = 1.06;
p_technoOtherCosts("BA","20","102","4") = 0.5;
p_technoMaintenance("BA","20","102","4") = 3.81;
p_technoTimeReq("BA","20","102","5") = 0.21;
p_technoFuelCons("BA","20","102","5") = 1.11;
p_technoOtherCosts("BA","20","102","5") = 0.51;
p_technoMaintenance("BA","20","102","5") = 3.88;
p_technoTimeReq("BA","20","102","10") = 0.27;
p_technoFuelCons("BA","20","102","10") = 1.41;
p_technoOtherCosts("BA","20","102","10") = 0.56;
p_technoMaintenance("BA","20","102","10") = 4.24;
p_technoTimeReq("BA","20","102","15") = 0.33;
p_technoFuelCons("BA","20","102","15") = 1.71;
p_technoOtherCosts("BA","20","102","15") = 0.62;
p_technoMaintenance("BA","20","102","15") = 4.59;

p_technoTimeReq("BA","40","102","1") = 0.17;
p_technoFuelCons("BA","40","102","1") = 0.91;
p_technoOtherCosts("BA","40","102","1") = 0.46;
p_technoMaintenance("BA","40","102","1") = 3.59;
p_technoTimeReq("BA","40","102","2") = 0.18;
p_technoFuelCons("BA","40","102","2") = 0.97;
p_technoOtherCosts("BA","40","102","2") = 0.48;
p_technoMaintenance("BA","40","102","2") = 3.68;
p_technoTimeReq("BA","40","102","3") = 0.19;
p_technoFuelCons("BA","40","102","3") = 1.02;
p_technoOtherCosts("BA","40","102","3") = 0.49;
p_technoMaintenance("BA","40","102","3") = 3.75;
p_technoTimeReq("BA","40","102","4") = 0.2;
p_technoFuelCons("BA","40","102","4") = 1.08;
p_technoOtherCosts("BA","40","102","4") = 0.5;
p_technoMaintenance("BA","40","102","4") = 3.82;
p_technoTimeReq("BA","40","102","5") = 0.22;
p_technoFuelCons("BA","40","102","5") = 1.14;
p_technoOtherCosts("BA","40","102","5") = 0.51;
p_technoMaintenance("BA","40","102","5") = 3.9;
p_technoTimeReq("BA","40","102","10") = 0.28;
p_technoFuelCons("BA","40","102","10") = 1.43;
p_technoOtherCosts("BA","40","102","10") = 0.57;
p_technoMaintenance("BA","40","102","10") = 4.25;
p_technoTimeReq("BA","40","102","15") = 0.33;
p_technoFuelCons("BA","40","102","15") = 1.74;
p_technoOtherCosts("BA","40","102","15") = 0.62;
p_technoMaintenance("BA","40","102","15") = 4.6;

p_technoTimeReq("BA","80","102","1") = 0.17;
p_technoFuelCons("BA","80","102","1") = 0.98;
p_technoOtherCosts("BA","80","102","1") = 0.47;
p_technoMaintenance("BA","80","102","1") = 3.64;
p_technoTimeReq("BA","80","102","2") = 0.19;
p_technoFuelCons("BA","80","102","2") = 1.04;
p_technoOtherCosts("BA","80","102","2") = 0.48;
p_technoMaintenance("BA","80","102","2") = 3.73;
p_technoTimeReq("BA","80","102","3") = 0.2;
p_technoFuelCons("BA","80","102","3") = 1.1;
p_technoOtherCosts("BA","80","102","3") = 0.5;
p_technoMaintenance("BA","80","102","3") = 3.81;
p_technoTimeReq("BA","80","102","4") = 0.21;
p_technoFuelCons("BA","80","102","4") = 1.15;
p_technoOtherCosts("BA","80","102","4") = 0.51;
p_technoMaintenance("BA","80","102","4") = 3.88;
p_technoTimeReq("BA","80","102","5") = 0.23;
p_technoFuelCons("BA","80","102","5") = 1.21;
p_technoOtherCosts("BA","80","102","5") = 0.52;
p_technoMaintenance("BA","80","102","5") = 3.95;
p_technoTimeReq("BA","80","102","10") = 0.28;
p_technoFuelCons("BA","80","102","10") = 1.51;
p_technoOtherCosts("BA","80","102","10") = 0.57;
p_technoMaintenance("BA","80","102","10") = 4.3;
p_technoTimeReq("BA","80","102","15") = 0.34;
p_technoFuelCons("BA","80","102","15") = 1.82;
p_technoOtherCosts("BA","80","102","15") = 0.63;
p_technoMaintenance("BA","80","102","15") = 4.66;


*angehängt, 24 m, 3,000 l, 67 kW
p_technoTimeReq("BA","1","120","1") = 0.27;
p_technoFuelCons("BA","1","120","1") = 1.49;
p_technoOtherCosts("BA","1","120","1") = 0.62;
p_technoMaintenance("BA","1","120","1") = 4.24;
p_technoTimeReq("BA","1","120","2") = 0.28;
p_technoFuelCons("BA","1","120","2") = 1.53;
p_technoOtherCosts("BA","1","120","2") = 0.63;
p_technoMaintenance("BA","1","120","2") = 4.28;
p_technoTimeReq("BA","1","120","3") = 0.29;
p_technoFuelCons("BA","1","120","3") = 1.58;
p_technoOtherCosts("BA","1","120","3") = 0.63;
p_technoMaintenance("BA","1","120","3") = 4.33;
p_technoTimeReq("BA","1","120","4") = 0.29;
p_technoFuelCons("BA","1","120","4") = 1.62;
p_technoOtherCosts("BA","1","120","4") = 0.64;
p_technoMaintenance("BA","1","120","4") = 4.36;
p_technoTimeReq("BA","1","120","5") = 0.3;
p_technoFuelCons("BA","1","120","5") = 1.67;
p_technoOtherCosts("BA","1","120","5") = 0.64;
p_technoMaintenance("BA","1","120","5") = 4.4;
p_technoTimeReq("BA","1","120","10") = 0.33;
p_technoFuelCons("BA","1","120","10") = 1.89;
p_technoOtherCosts("BA","1","120","10") = 0.67;
p_technoMaintenance("BA","1","120","10") = 4.57;
p_technoTimeReq("BA","1","120","15") = 0.36;
p_technoFuelCons("BA","1","120","15") = 2.13;
p_technoOtherCosts("BA","1","120","15") = 0.7;
p_technoMaintenance("BA","1","120","15") = 4.76;

p_technoTimeReq("BA","2","120","1") = 0.21;
p_technoFuelCons("BA","2","120","1") = 1.31;
p_technoOtherCosts("BA","2","120","1") = 0.56;
p_technoMaintenance("BA","2","120","1") = 3.87;
p_technoTimeReq("BA","2","120","2") = 0.22;
p_technoFuelCons("BA","2","120","2") = 1.35;
p_technoOtherCosts("BA","2","120","2") = 0.57;
p_technoMaintenance("BA","2","120","2") = 3.92;
p_technoTimeReq("BA","2","120","3") = 0.23;
p_technoFuelCons("BA","2","120","3") = 1.39;
p_technoOtherCosts("BA","2","120","3") = 0.57;
p_technoMaintenance("BA","2","120","3") = 3.96;
p_technoTimeReq("BA","2","120","4") = 0.24;
p_technoFuelCons("BA","2","120","4") = 1.44;
p_technoOtherCosts("BA","2","120","4") = 0.58;
p_technoMaintenance("BA","2","120","4") = 4.0;
p_technoTimeReq("BA","2","120","5") = 0.24;
p_technoFuelCons("BA","2","120","5") = 1.48;
p_technoOtherCosts("BA","2","120","5") = 0.59;
p_technoMaintenance("BA","2","120","5") = 4.03;
p_technoTimeReq("BA","2","120","10") = 0.27;
p_technoFuelCons("BA","2","120","10") = 1.69;
p_technoOtherCosts("BA","2","120","10") = 0.61;
p_technoMaintenance("BA","2","120","10") = 4.21;
p_technoTimeReq("BA","2","120","15") = 0.3;
p_technoFuelCons("BA","2","120","15") = 1.92;
p_technoOtherCosts("BA","2","120","15") = 0.64;
p_technoMaintenance("BA","2","120","15") = 4.39;

p_technoTimeReq("BA","5","120","1") = 0.15;
p_technoFuelCons("BA","5","120","1") = 1.0;
p_technoOtherCosts("BA","5","120","1") = 0.5;
p_technoMaintenance("BA","5","120","1") = 3.49;
p_technoTimeReq("BA","5","120","2") = 0.16;
p_technoFuelCons("BA","5","120","2") = 1.04;
p_technoOtherCosts("BA","5","120","2") = 0.51;
p_technoMaintenance("BA","5","120","2") = 3.53;
p_technoTimeReq("BA","5","120","3") = 0.16;
p_technoFuelCons("BA","5","120","3") = 1.08;
p_technoOtherCosts("BA","5","120","3") = 0.52;
p_technoMaintenance("BA","5","120","3") = 3.57;
p_technoTimeReq("BA","5","120","4") = 0.17;
p_technoFuelCons("BA","5","120","4") = 1.12;
p_technoOtherCosts("BA","5","120","4") = 0.52;
p_technoMaintenance("BA","5","120","4") = 3.61;
p_technoTimeReq("BA","5","120","5") = 0.17;
p_technoFuelCons("BA","5","120","5") = 1.16;
p_technoOtherCosts("BA","5","120","5") = 0.53;
p_technoMaintenance("BA","5","120","5") = 3.64;
p_technoTimeReq("BA","5","120","10") = 0.2;
p_technoFuelCons("BA","5","120","10") = 1.36;
p_technoOtherCosts("BA","5","120","10") = 0.55;
p_technoMaintenance("BA","5","120","10") = 3.82;
p_technoTimeReq("BA","5","120","15") = 0.23;
p_technoFuelCons("BA","5","120","15") = 1.58;
p_technoOtherCosts("BA","5","120","15") = 0.58;
p_technoMaintenance("BA","5","120","15") = 4.0;

p_technoTimeReq("BA","10","120","1") = 0.12;
p_technoFuelCons("BA","10","120","1") = 0.9;
p_technoOtherCosts("BA","10","120","1") = 0.48;
p_technoMaintenance("BA","10","120","1") = 3.34;
p_technoTimeReq("BA","10","120","2") = 0.13;
p_technoFuelCons("BA","10","120","2") = 0.94;
p_technoOtherCosts("BA","10","120","2") = 0.49;
p_technoMaintenance("BA","10","120","2") = 3.38;
p_technoTimeReq("BA","10","120","3") = 0.14;
p_technoFuelCons("BA","10","120","3") = 0.98;
p_technoOtherCosts("BA","10","120","3") = 0.49;
p_technoMaintenance("BA","10","120","3") = 3.42;
p_technoTimeReq("BA","10","120","4") = 0.14;
p_technoFuelCons("BA","10","120","4") = 1.02;
p_technoOtherCosts("BA","10","120","4") = 0.5;
p_technoMaintenance("BA","10","120","4") = 3.46;
p_technoTimeReq("BA","10","120","5") = 0.15;
p_technoFuelCons("BA","10","120","5") = 1.06;
p_technoOtherCosts("BA","10","120","5") = 0.5;
p_technoMaintenance("BA","10","120","5") = 3.49;
p_technoTimeReq("BA","10","120","10") = 0.18;
p_technoFuelCons("BA","10","120","10") = 1.26;
p_technoOtherCosts("BA","10","120","10") =0.53; 
p_technoMaintenance("BA","10","120","10") = 3.67;
p_technoTimeReq("BA","10","120","15") = 0.21;
p_technoFuelCons("BA","10","120","15") = 1.47;
p_technoOtherCosts("BA","10","120","15") = 0.56;
p_technoMaintenance("BA","10","120","15") = 3.85;

p_technoTimeReq("BA","20","120","1") = 0.13;
p_technoFuelCons("BA","20","120","1") = 0.95;
p_technoOtherCosts("BA","20","120","1") = 0.48;
p_technoMaintenance("BA","20","120","1") = 3.36;
p_technoTimeReq("BA","20","120","2") = 0.13;
p_technoFuelCons("BA","20","120","2") = 0.99;
p_technoOtherCosts("BA","20","120","2") = 0.49;
p_technoMaintenance("BA","20","120","2") = 3.4;
p_technoTimeReq("BA","20","120","3") = 0.14;
p_technoFuelCons("BA","20","120","3") = 1.04;
p_technoOtherCosts("BA","20","120","3") = 0.49;
p_technoMaintenance("BA","20","120","3") = 3.44;
p_technoTimeReq("BA","20","120","4") = 0.15;
p_technoFuelCons("BA","20","120","4") = 1.07;
p_technoOtherCosts("BA","20","120","4") = 0.5;
p_technoMaintenance("BA","20","120","4") = 3.47;
p_technoTimeReq("BA","20","120","5") = 0.15;
p_technoFuelCons("BA","20","120","5") = 1.11;
p_technoOtherCosts("BA","20","120","5") = 0.51;
p_technoMaintenance("BA","20","120","5") = 3.51;
p_technoTimeReq("BA","20","120","10") = 0.18;
p_technoFuelCons("BA","20","120","10") = 1.32;
p_technoOtherCosts("BA","20","120","10") = 0.53;
p_technoMaintenance("BA","20","120","10") = 3.69;
p_technoTimeReq("BA","20","120","15") = 0.21;
p_technoFuelCons("BA","20","120","15") = 1.53;
p_technoOtherCosts("BA","20","120","15") = 0.56;
p_technoMaintenance("BA","20","120","15") = 3.87;

p_technoTimeReq("BA","40","120","1") = 0.12;
p_technoFuelCons("BA","40","120","1") = 0.95;
p_technoOtherCosts("BA","40","120","1") = 0.48;
p_technoMaintenance("BA","40","120","1") = 3.34;
p_technoTimeReq("BA","40","120","2") = 0.13;
p_technoFuelCons("BA","40","120","2") = 0.99;
p_technoOtherCosts("BA","40","120","2") = 0.49;
p_technoMaintenance("BA","40","120","2") = 3.38;
p_technoTimeReq("BA","40","120","3") = 0.14;
p_technoFuelCons("BA","40","120","3") = 1.03;
p_technoOtherCosts("BA","40","120","3") = 0.49;
p_technoMaintenance("BA","40","120","3") = 3.42;
p_technoTimeReq("BA","40","120","4") = 0.14;
p_technoFuelCons("BA","40","120","4") = 1.07;
p_technoOtherCosts("BA","40","120","4") = 0.5;
p_technoMaintenance("BA","40","120","4") = 3.46;
p_technoTimeReq("BA","40","120","5") = 0.15;
p_technoFuelCons("BA","40","120","5") = 1.11;
p_technoOtherCosts("BA","40","120","5") = 0.5;
p_technoMaintenance("BA","40","120","5") = 3.49;
p_technoTimeReq("BA","40","120","10") = 0.18;
p_technoFuelCons("BA","40","120","10") = 1.31;
p_technoOtherCosts("BA","40","120","10") = 0.53;
p_technoMaintenance("BA","40","120","10") = 3.67;
p_technoTimeReq("BA","40","120","15") = 0.21;
p_technoFuelCons("BA","40","120","15") = 1.52;
p_technoOtherCosts("BA","40","120","15") = 0.56;
p_technoMaintenance("BA","40","120","15") = 3.85;

p_technoTimeReq("BA","80","120","1") = 0.13;
p_technoFuelCons("BA","80","120","1") = 0.99;
p_technoOtherCosts("BA","80","120","1") = 0.48;
p_technoMaintenance("BA","80","120","1") = 3.36;
p_technoTimeReq("BA","80","120","2") = 0.13;
p_technoFuelCons("BA","80","120","2") = 1.03;
p_technoOtherCosts("BA","80","120","2") = 0.49;
p_technoMaintenance("BA","80","120","2") = 3.4;
p_technoTimeReq("BA","80","120","3") = 0.14;
p_technoFuelCons("BA","80","120","3") = 1.07;
p_technoOtherCosts("BA","80","120","3") = 0.49;
p_technoMaintenance("BA","80","120","3") = 3.44;
p_technoTimeReq("BA","80","120","4") = 0.15;
p_technoFuelCons("BA","80","120","4") = 1.11;
p_technoOtherCosts("BA","80","120","4") = 0.5;
p_technoMaintenance("BA","80","120","4") = 3.48;
p_technoTimeReq("BA","80","120","5") = 0.15;
p_technoFuelCons("BA","80","120","5") = 1.15;
p_technoOtherCosts("BA","80","120","5") = 0.51;
p_technoMaintenance("BA","80","120","5") = 3.41;
p_technoTimeReq("BA","80","120","10") = 0.18;
p_technoFuelCons("BA","80","120","10") = 1.35;
p_technoOtherCosts("BA","80","120","10") = 0.53;
p_technoMaintenance("BA","80","120","10") = 3.69;
p_technoTimeReq("BA","80","120","15") = 0.21;
p_technoFuelCons("BA","80","120","15") = 1.56;
p_technoOtherCosts("BA","80","120","15") = 0.56;
p_technoMaintenance("BA","80","120","15") = 3.87;


* angehängt, 27 m, 4,000 l, 83 kW, 300 l/ha
p_technoTimeReq("BA","1","200","1") = 0.27;
p_technoFuelCons("BA","1","200","1") = 1.73;
p_technoOtherCosts("BA","1","200","1") = 0.58;
p_technoMaintenance("BA","1","200","1") = 4.46;
p_technoTimeReq("BA","1","200","2") = 0.27;
p_technoFuelCons("BA","1","200","2") = 1.78;
p_technoOtherCosts("BA","1","200","2") = 0.58;
p_technoMaintenance("BA","1","200","2") = 4.51;
p_technoTimeReq("BA","1","200","3") =0.28 ;
p_technoFuelCons("BA","1","200","3") = 1.82;
p_technoOtherCosts("BA","1","200","3") = 0.59;
p_technoMaintenance("BA","1","200","3") = 4.54;
p_technoTimeReq("BA","1","200","4") = 0.28;
p_technoFuelCons("BA","1","200","4") = 1.86;
p_technoOtherCosts("BA","1","200","4") = 0.59;
p_technoMaintenance("BA","1","200","4") = 4.57;
p_technoTimeReq("BA","1","200","5") = 0.29;
p_technoFuelCons("BA","1","200","5") = 1.9;
p_technoOtherCosts("BA","1","200","5") = 0.6;
p_technoMaintenance("BA","1","200","5") = 4.6;
p_technoTimeReq("BA","1","200","10") = 0.31;
p_technoFuelCons("BA","1","200","10") = 2.12;
p_technoOtherCosts("BA","1","200","10") = 0.62;
p_technoMaintenance("BA","1","200","10") = 4.76;
p_technoTimeReq("BA","1","200","15") = 0.33;
p_technoFuelCons("BA","1","200","15") = 2.33;
p_technoOtherCosts("BA","1","200","15") = 0.65;
p_technoMaintenance("BA","1","200","15") = 4.91;

p_technoTimeReq("BA","2","200","1") = 0.19;
p_technoFuelCons("BA","2","200","1") = 1.34;
p_technoOtherCosts("BA","2","200","1") = 0.49;
p_technoMaintenance("BA","2","200","1") = 3.92;
p_technoTimeReq("BA","2","200","2") = 0.2;
p_technoFuelCons("BA","2","200","2") = 1.38;
p_technoOtherCosts("BA","2","200","2") = 0.5;
p_technoMaintenance("BA","2","200","2") = 3.95;
p_technoTimeReq("BA","2","200","3") = 0.2;
p_technoFuelCons("BA","2","200","3") = 1.42;
p_technoOtherCosts("BA","2","200","3") = 0.5;
p_technoMaintenance("BA","2","200","3") = 3.99;
p_technoTimeReq("BA","2","200","4") = 0.21;
p_technoFuelCons("BA","2","200","4") = 1.46;
p_technoOtherCosts("BA","2","200","4") = 0.51;
p_technoMaintenance("BA","2","200","4") = 4.02;
p_technoTimeReq("BA","2","200","5") = 0.21;
p_technoFuelCons("BA","2","200","5") = 1.49;
p_technoOtherCosts("BA","2","200","5") = 0.51;
p_technoMaintenance("BA","2","200","5") = 4.05;
p_technoTimeReq("BA","2","200","10") = 0.23;
p_technoFuelCons("BA","2","200","10") = 1.69;
p_technoOtherCosts("BA","2","200","10") = 0.54;
p_technoMaintenance("BA","2","200","10") = 4.21;
p_technoTimeReq("BA","2","200","15") = 0.25;
p_technoFuelCons("BA","2","200","15") = 1.89;
p_technoOtherCosts("BA","2","200","15") = 0.56;
p_technoMaintenance("BA","2","200","15") = 4.36;

p_technoTimeReq("BA","5","200","1") = 0.13;
p_technoFuelCons("BA","5","200","1") = 1.04;
p_technoOtherCosts("BA","5","200","1") = 0.43;
p_technoMaintenance("BA","5","200","1") = 3.52;
p_technoTimeReq("BA","5","200","2") = 0.14;
p_technoFuelCons("BA","5","200","2") = 1.08;
p_technoOtherCosts("BA","5","200","2") = 0.43;
p_technoMaintenance("BA","5","200","2") = 3.56;
p_technoTimeReq("BA","5","200","3") = 0.14;
p_technoFuelCons("BA","5","200","3") = 1.12;
p_technoOtherCosts("BA","5","200","3") = 0.44;
p_technoMaintenance("BA","5","200","3") = 3.6;
p_technoTimeReq("BA","5","200","4") = 0.15;
p_technoFuelCons("BA","5","200","4") = 1.15;
p_technoOtherCosts("BA","5","200","4") = 0.44;
p_technoMaintenance("BA","5","200","4") = 3.63;
p_technoTimeReq("BA","5","200","5") = 0.15;
p_technoFuelCons("BA","5","200","5") = 1.19;
p_technoOtherCosts("BA","5","200","5") = 0.45;
p_technoMaintenance("BA","5","200","5") = 3.66;
p_technoTimeReq("BA","5","200","10") = 0.17;
p_technoFuelCons("BA","5","200","10") = 1.38;
p_technoOtherCosts("BA","5","200","10") = 0.47;
p_technoMaintenance("BA","5","200","10") = 3.82;
p_technoTimeReq("BA","5","200","15") = 0.2;
p_technoFuelCons("BA","5","200","15") = 1.57;
p_technoOtherCosts("BA","5","200","15") = 0.5;
p_technoMaintenance("BA","5","200","15") = 3.97;

p_technoTimeReq("BA","10","200","1") = 0.12;
p_technoFuelCons("BA","10","200","1") = 0.98;
p_technoOtherCosts("BA","10","200","1") = 0.41;
p_technoMaintenance("BA","10","200","1") = 3.41;
p_technoTimeReq("BA","10","200","2") = 0.12;
p_technoFuelCons("BA","10","200","2") = 1.02;
p_technoOtherCosts("BA","10","200","2") = 0.42;
p_technoMaintenance("BA","10","200","2") = 3.45;
p_technoTimeReq("BA","10","200","3") = 0.13;
p_technoFuelCons("BA","10","200","3") = 1.06;
p_technoOtherCosts("BA","10","200","3") = 0.42;
p_technoMaintenance("BA","10","200","3") = 3.48;
p_technoTimeReq("BA","10","200","4") = 0.13;
p_technoFuelCons("BA","10","200","4") = 1.1;
p_technoOtherCosts("BA","10","200","4") = 0.43;
p_technoMaintenance("BA","10","200","4") = 3.52;
p_technoTimeReq("BA","10","200","5") = 0.14;
p_technoFuelCons("BA","10","200","5") = 1.13;
p_technoOtherCosts("BA","10","200","5") = 0.43;
p_technoMaintenance("BA","10","200","5") = 3.55;
p_technoTimeReq("BA","10","200","10") = 0.16;
p_technoFuelCons("BA","10","200","10") = 1.31;
p_technoOtherCosts("BA","10","200","10") = 0.46; 
p_technoMaintenance("BA","10","200","10") = 3.7;
p_technoTimeReq("BA","10","200","15") = 0.18;
p_technoFuelCons("BA","10","200","15") = 1.51;
p_technoOtherCosts("BA","10","200","15") = 0.48;
p_technoMaintenance("BA","10","200","15") = 3.85;

p_technoTimeReq("BA","20","200","1") = 0.11;
p_technoFuelCons("BA","20","200","1") = 1.01;
p_technoOtherCosts("BA","20","200","1") = 0.41;
p_technoMaintenance("BA","20","200","1") = 3.4;
p_technoTimeReq("BA","20","200","2") = 0.12;
p_technoFuelCons("BA","20","200","2") = 1.05;
p_technoOtherCosts("BA","20","200","2") = 0.41;
p_technoMaintenance("BA","20","200","2") = 3.43;
p_technoTimeReq("BA","20","200","3") = 0.12;
p_technoFuelCons("BA","20","200","3") = 1.09;
p_technoOtherCosts("BA","20","200","3") = 0.42;
p_technoMaintenance("BA","20","200","3") = 3.47;
p_technoTimeReq("BA","20","200","4") = 0.13;
p_technoFuelCons("BA","20","200","4") = 1.13;
p_technoOtherCosts("BA","20","200","4") = 0.42;
p_technoMaintenance("BA","20","200","4") = 3.5;
p_technoTimeReq("BA","20","200","5") = 0.13;
p_technoFuelCons("BA","20","200","5") = 1.16;
p_technoOtherCosts("BA","20","200","5") = 0.43;
p_technoMaintenance("BA","20","200","5") = 3.54;
p_technoTimeReq("BA","20","200","10") = 0.15;
p_technoFuelCons("BA","20","200","10") = 1.34;
p_technoOtherCosts("BA","20","200","10") = 0.45;
p_technoMaintenance("BA","20","200","10") = 3.68;
p_technoTimeReq("BA","20","200","15") = 0.18;
p_technoFuelCons("BA","20","200","15") = 1.53;
p_technoOtherCosts("BA","20","200","15") = 0.48;
p_technoMaintenance("BA","20","200","15") = 3.84;

p_technoTimeReq("BA","40","200","1") = 0.11;
p_technoFuelCons("BA","40","200","1") = 0.98;
p_technoOtherCosts("BA","40","200","1") = 0.4;
p_technoMaintenance("BA","40","200","1") = 3.34;
p_technoTimeReq("BA","40","200","2") = 0.11;
p_technoFuelCons("BA","40","200","2") = 1.01;
p_technoOtherCosts("BA","40","200","2") = 0.4;
p_technoMaintenance("BA","40","200","2") = 3.38;
p_technoTimeReq("BA","40","200","3") = 0.12;
p_technoFuelCons("BA","40","200","3") = 1.05;
p_technoOtherCosts("BA","40","200","3") = 0.41;
p_technoMaintenance("BA","40","200","3") = 3.42;
p_technoTimeReq("BA","40","200","4") = 0.12;
p_technoFuelCons("BA","40","200","4") = 1.09;
p_technoOtherCosts("BA","40","200","4") = 0.42;
p_technoMaintenance("BA","40","200","4") = 3.45;
p_technoTimeReq("BA","40","200","5") = 0.13;
p_technoFuelCons("BA","40","200","5") = 1.12;
p_technoOtherCosts("BA","40","200","5") = 0.42;
p_technoMaintenance("BA","40","200","5") = 3.48;
p_technoTimeReq("BA","40","200","10") = 0.15;
p_technoFuelCons("BA","40","200","10") = 1.3;
p_technoOtherCosts("BA","40","200","10") = 0.45;
p_technoMaintenance("BA","40","200","10") = 3.63;
p_technoTimeReq("BA","40","200","15") = 0.17;
p_technoFuelCons("BA","40","200","15") = 1.5;
p_technoOtherCosts("BA","40","200","15") = 0.47;
p_technoMaintenance("BA","40","200","15") = 3.79;

p_technoTimeReq("BA","80","200","1") = 0.11;
p_technoFuelCons("BA","80","200","1") = 1.01;
p_technoOtherCosts("BA","80","200","1") = 0.4;
p_technoMaintenance("BA","80","200","1") = 3.35;
p_technoTimeReq("BA","80","200","2") = 0.11;
p_technoFuelCons("BA","80","200","2") = 1.05;
p_technoOtherCosts("BA","80","200","2") = 0.41;
p_technoMaintenance("BA","80","200","2") = 3.39;
p_technoTimeReq("BA","80","200","3") = 0.12;
p_technoFuelCons("BA","80","200","3") = 1.08;
p_technoOtherCosts("BA","80","200","3") = 0.41;
p_technoMaintenance("BA","80","200","3") = 3.43;
p_technoTimeReq("BA","80","200","4") = 0.12;
p_technoFuelCons("BA","80","200","4") = 1.12;
p_technoOtherCosts("BA","80","200","4") = 0.42;
p_technoMaintenance("BA","80","200","4") = 3.46;
p_technoTimeReq("BA","80","200","5") = 0.13;
p_technoFuelCons("BA","80","200","5") = 1.16;
p_technoOtherCosts("BA","80","200","5") = 0.42;
p_technoMaintenance("BA","80","200","5") = 3.49;
p_technoTimeReq("BA","80","200","10") = 0.15;
p_technoFuelCons("BA","80","200","10") = 1.34;
p_technoOtherCosts("BA","80","200","10") = 0.45;
p_technoMaintenance("BA","80","200","10") = 3.65;
p_technoTimeReq("BA","80","200","15") = 0.17;
p_technoFuelCons("BA","80","200","15") = 1.53;
p_technoOtherCosts("BA","80","200","15") = 0.47;
p_technoMaintenance("BA","80","200","15") = 3.8;


*angehängt, 36 m, 4,000 l, 83 kW 300 l/ha
p_technoTimeReq("BA","1","230","1") = 0.23;
p_technoFuelCons("BA","1","230","1") = 1.46;
p_technoOtherCosts("BA","1","230","1") = 0.53;
p_technoMaintenance("BA","1","230","1") = 4.24;
p_technoTimeReq("BA","1","230","2") = 0.24;
p_technoFuelCons("BA","1","230","2") = 1.5;
p_technoOtherCosts("BA","1","230","2") = 0.54;
p_technoMaintenance("BA","1","230","2") = 4.28;
p_technoTimeReq("BA","1","230","3") = 0.24;
p_technoFuelCons("BA","1","230","3") = 1.55;
p_technoOtherCosts("BA","1","230","3") = 0.54;
p_technoMaintenance("BA","1","230","3") = 4.31;
p_technoTimeReq("BA","1","230","4") = 0.25;
p_technoFuelCons("BA","1","230","4") = 1.59;
p_technoOtherCosts("BA","1","230","4") = 0.55;
p_technoMaintenance("BA","1","230","4") = 4.35;
p_technoTimeReq("BA","1","230","5") = 0.25;
p_technoFuelCons("BA","1","230","5") = 1.62;
p_technoOtherCosts("BA","1","230","5") = 0.55;
p_technoMaintenance("BA","1","230","5") = 4.37;
p_technoTimeReq("BA","1","230","10") = 0.28;
p_technoFuelCons("BA","1","230","10") = 1.84;
p_technoOtherCosts("BA","1","230","10") = 0.58;
p_technoMaintenance("BA","1","230","10") = 4.54;
p_technoTimeReq("BA","1","230","15") = 0.3;
p_technoFuelCons("BA","1","230","15") = 2.06;
p_technoOtherCosts("BA","1","230","15") = 0.6;
p_technoMaintenance("BA","1","230","15") = 4.69;

p_technoTimeReq("BA","2","230","1") = 0.17;
p_technoFuelCons("BA","2","230","1") = 1.15;
p_technoOtherCosts("BA","2","230","1") = 0.46;
p_technoMaintenance("BA","2","230","1") = 3.76;
p_technoTimeReq("BA","2","230","2") = 0.17;
p_technoFuelCons("BA","2","230","2") = 1.19;
p_technoOtherCosts("BA","2","230","2") = 0.46;
p_technoMaintenance("BA","2","230","2") = 3.8;
p_technoTimeReq("BA","2","230","3") = 0.18;
p_technoFuelCons("BA","2","230","3") = 1.23;
p_technoOtherCosts("BA","2","230","3") = 0.47;
p_technoMaintenance("BA","2","230","3") = 3.82;
p_technoTimeReq("BA","2","230","4") = 0.18;
p_technoFuelCons("BA","2","230","4") = 1.27;
p_technoOtherCosts("BA","2","230","4") = 0.47;
p_technoMaintenance("BA","2","230","4") = 3.87;
p_technoTimeReq("BA","2","230","5") = 0.19;
p_technoFuelCons("BA","2","230","5") = 1.31;
p_technoOtherCosts("BA","2","230","5") = 0.48;
p_technoMaintenance("BA","2","230","5") = 3.9;
p_technoTimeReq("BA","2","230","10") = 0.21;
p_technoFuelCons("BA","2","230","10") = 1.5;
p_technoOtherCosts("BA","2","230","10") = 0.5;
p_technoMaintenance("BA","2","230","10") = 4.05;
p_technoTimeReq("BA","2","230","15") = 0.23;
p_technoFuelCons("BA","2","230","15") = 1.71;
p_technoOtherCosts("BA","2","230","15") = 0.53;
p_technoMaintenance("BA","2","230","15") = 4.21;

p_technoTimeReq("BA","5","230","1") = 0.12;
p_technoFuelCons("BA","5","230","1") = 0.94;
p_technoOtherCosts("BA","5","230","1") = 0.4;
p_technoMaintenance("BA","5","230","1") = 3.43;
p_technoTimeReq("BA","5","230","2") = 0.12;
p_technoFuelCons("BA","5","230","2") = 0.98;
p_technoOtherCosts("BA","5","230","2") = 0.41;
p_technoMaintenance("BA","5","230","2") = 3.47;
p_technoTimeReq("BA","5","230","3") = 0.13;
p_technoFuelCons("BA","5","230","3") = 1.01;
p_technoOtherCosts("BA","5","230","3") = 0.42;
p_technoMaintenance("BA","5","230","3") = 3.5;
p_technoTimeReq("BA","5","230","4") = 0.13;
p_technoFuelCons("BA","5","230","4") = 1.05;
p_technoOtherCosts("BA","5","230","4") = 0.42;
p_technoMaintenance("BA","5","230","4") = 3.53;
p_technoTimeReq("BA","5","230","5") = 0.14;
p_technoFuelCons("BA","5","230","5") = 1.09;
p_technoOtherCosts("BA","5","230","5") = 0.43;
p_technoMaintenance("BA","5","230","5") = 3.57;
p_technoTimeReq("BA","5","230","10") = 0.16;
p_technoFuelCons("BA","5","230","10") = 1.27;
p_technoOtherCosts("BA","5","230","10") = 0.45;
p_technoMaintenance("BA","5","230","10") = 3.72;
p_technoTimeReq("BA","5","230","15") = 0.18;
p_technoFuelCons("BA","5","230","15") = 1.47;
p_technoOtherCosts("BA","5","230","15") = 0.47;
p_technoMaintenance("BA","5","230","15") = 3.87;

p_technoTimeReq("BA","10","230","1") = 0.1;
p_technoFuelCons("BA","10","230","1") = 0.84;
p_technoOtherCosts("BA","10","230","1") = 0.38;
p_technoMaintenance("BA","10","230","1") = 3.29;
p_technoTimeReq("BA","10","230","2") = 0.1;
p_technoFuelCons("BA","10","230","2") = 0.88;
p_technoOtherCosts("BA","10","230","2") = 0.39;
p_technoMaintenance("BA","10","230","2") = 3.33;
p_technoTimeReq("BA","10","230","3") = 0.11;
p_technoFuelCons("BA","10","230","3") = 0.92;
p_technoOtherCosts("BA","10","230","3") = 0.39;
p_technoMaintenance("BA","10","230","3") = 3.37;
p_technoTimeReq("BA","10","230","4") = 0.11;
p_technoFuelCons("BA","10","230","4") = 0.95;
p_technoOtherCosts("BA","10","230","4") = 0.4;
p_technoMaintenance("BA","10","230","4") = 3.39;
p_technoTimeReq("BA","10","230","5") = 0.12;
p_technoFuelCons("BA","10","230","5") = 0.98;
p_technoOtherCosts("BA","10","230","5") = 0.4;
p_technoMaintenance("BA","10","230","5") = 3.42;
p_technoTimeReq("BA","10","230","10") = 0.14;
p_technoFuelCons("BA","10","230","10") = 1.17;
p_technoOtherCosts("BA","10","230","10") = 0.43;
p_technoMaintenance("BA","10","230","10") = 3.58;
p_technoTimeReq("BA","10","230","15") = 0.16;
p_technoFuelCons("BA","10","230","15") = 1.37;
p_technoOtherCosts("BA","10","230","15") = 0.45;
p_technoMaintenance("BA","10","230","15") = 3.74;

p_technoTimeReq("BA","20","230","1") = 0.1;
p_technoFuelCons("BA","20","230","1") = 0.86;
p_technoOtherCosts("BA","20","230","1") = 0.38;
p_technoMaintenance("BA","20","230","1") = 3.27;
p_technoTimeReq("BA","20","230","2") = 0.1;
p_technoFuelCons("BA","20","230","2") = 0.9;
p_technoOtherCosts("BA","20","230","2") = 0.39;
p_technoMaintenance("BA","20","230","2") = 3.31;
p_technoTimeReq("BA","20","230","3") = 0.11;
p_technoFuelCons("BA","20","230","3") = 0.94;
p_technoOtherCosts("BA","20","230","3") = 0.39;
p_technoMaintenance("BA","20","230","3") = 3.35;
p_technoTimeReq("BA","20","230","4") = 0.11;
p_technoFuelCons("BA","20","230","4") = 0.98;
p_technoOtherCosts("BA","20","230","4") = 0.4;
p_technoMaintenance("BA","20","230","4") = 3.38;
p_technoTimeReq("BA","20","230","5") = 0.12;
p_technoFuelCons("BA","20","230","5") = 1.01;
p_technoOtherCosts("BA","20","230","5") = 0.4;
p_technoMaintenance("BA","20","230","5") = 3.41;
p_technoTimeReq("BA","20","230","10") = 0.14;
p_technoFuelCons("BA","20","230","10") = 1.19;
p_technoOtherCosts("BA","20","230","10") = 0.42;
p_technoMaintenance("BA","20","230","10") = 3.56;
p_technoTimeReq("BA","20","230","15") = 0.16;
p_technoFuelCons("BA","20","230","15") = 1.39;
p_technoOtherCosts("BA","20","230","15") = 0.45;
p_technoMaintenance("BA","20","230","15") = 3.72;

p_technoTimeReq("BA","40","230","1") = 0.09;
p_technoFuelCons("BA","40","230","1") = 0.84;
p_technoOtherCosts("BA","40","230","1") = 0.37;
p_technoMaintenance("BA","40","230","1") = 3.23;
p_technoTimeReq("BA","40","230","2") = 0.1;
p_technoFuelCons("BA","40","230","2") = 0.88;
p_technoOtherCosts("BA","40","230","2") = 0.38;
p_technoMaintenance("BA","40","230","2") = 3.27;
p_technoTimeReq("BA","40","230","3") = 0.1;
p_technoFuelCons("BA","40","230","3") = 0.92;
p_technoOtherCosts("BA","40","230","3") = 0.38;
p_technoMaintenance("BA","40","230","3") = 3.31;
p_technoTimeReq("BA","40","230","4") = 0.11;
p_technoFuelCons("BA","40","230","4") = 0.95;
p_technoOtherCosts("BA","40","230","4") = 0.39;
p_technoMaintenance("BA","40","230","4") = 3.34;
p_technoTimeReq("BA","40","230","5") = 0.11;
p_technoFuelCons("BA","40","230","5") = 0.99;
p_technoOtherCosts("BA","40","230","5") = 0.39;
p_technoMaintenance("BA","40","230","5") = 3.37;
p_technoTimeReq("BA","40","230","10") = 0.13;
p_technoFuelCons("BA","40","230","10") = 1.17;
p_technoOtherCosts("BA","40","230","10") = 0.42;
p_technoMaintenance("BA","40","230","10") = 3.52;
p_technoTimeReq("BA","40","230","15") = 0.15;
p_technoFuelCons("BA","40","230","15") = 1.36;
p_technoOtherCosts("BA","40","230","15") = 0.44;
p_technoMaintenance("BA","40","230","15") = 3.68;

p_technoTimeReq("BA","80","230","1") = 0.09;
p_technoFuelCons("BA","80","230","1") = 0.87;
p_technoOtherCosts("BA","80","230","1") = 0.37;
p_technoMaintenance("BA","80","230","1") = 3.24;
p_technoTimeReq("BA","80","230","2") = 0.1;
p_technoFuelCons("BA","80","230","2") = 0.91;
p_technoOtherCosts("BA","80","230","2") = 0.38;
p_technoMaintenance("BA","80","230","2") = 3.28;
p_technoTimeReq("BA","80","230","3") = 0.1;
p_technoFuelCons("BA","80","230","3") = 0.94;
p_technoOtherCosts("BA","80","230","3") = 0.39;
p_technoMaintenance("BA","80","230","3") = 3.31;
p_technoTimeReq("BA","80","230","4") = 0.11;
p_technoFuelCons("BA","80","230","4") = 0.98;
p_technoOtherCosts("BA","80","230","4") = 0.39;
p_technoMaintenance("BA","80","230","4") = 3.35;
p_technoTimeReq("BA","80","230","5") = 0.11;
p_technoFuelCons("BA","80","230","5") = 1.02;
p_technoOtherCosts("BA","80","230","5") = 0.4;
p_technoMaintenance("BA","80","230","5") = 3.38;
p_technoTimeReq("BA","80","230","10") = 0.13;
p_technoFuelCons("BA","80","230","10") = 1.2;
p_technoOtherCosts("BA","80","230","10") = 0.42;
p_technoMaintenance("BA","80","230","10") = 3.53;
p_technoTimeReq("BA","80","230","15") = 0.16;
p_technoFuelCons("BA","80","230","15") = 1.39;
p_technoOtherCosts("BA","80","230","15") = 0.44;
p_technoMaintenance("BA","80","230","15") = 3.69;



*
*  --- Parameters for SST
*
*12 m, 600 l, 45 kW, 100 l/ha
*data drawn from sprayer with 12m boom width, 45 kW and 100 l/ha (ab Schlagrand) 24.06.2024
p_technoTimeReq("spot6m","1",KTBL_mechanisation,"1") = 0.35;
p_technoFuelCons("spot6m","1",KTBL_mechanisation,"1") = 1.09;
p_technoOtherCosts("spot6m","1",KTBL_mechanisation,"1") = 0.4;
p_technoMaintenance("spot6m","1",KTBL_mechanisation,"1") = 3.58;
p_technoTimeReq("spot6m","1",KTBL_mechanisation,"2") = 0.36;
p_technoFuelCons("spot6m","1",KTBL_mechanisation,"2") = 1.13;
p_technoOtherCosts("spot6m","1",KTBL_mechanisation,"2") = 0.41;
p_technoMaintenance("spot6m","1",KTBL_mechanisation,"2") = 3.63;
p_technoTimeReq("spot6m","1",KTBL_mechanisation,"3") = 0.37;
p_technoFuelCons("spot6m","1",KTBL_mechanisation,"3") = 1.16;
p_technoOtherCosts("spot6m","1",KTBL_mechanisation,"3") = 0.41;
p_technoMaintenance("spot6m","1",KTBL_mechanisation,"3") = 3.67;
p_technoTimeReq("spot6m","1",KTBL_mechanisation,"4") = 0.38;
p_technoFuelCons("spot6m","1",KTBL_mechanisation,"4") = 1.19;
p_technoOtherCosts("spot6m","1",KTBL_mechanisation,"4") = 0.42;
p_technoMaintenance("spot6m","1",KTBL_mechanisation,"4") = 3.72;
p_technoTimeReq("spot6m","1",KTBL_mechanisation,"5") = 0.39;
p_technoFuelCons("spot6m","1",KTBL_mechanisation,"5") = 1.22;
p_technoOtherCosts("spot6m","1",KTBL_mechanisation,"5") = 0.43;
p_technoMaintenance("spot6m","1",KTBL_mechanisation,"5") = 3.75;
p_technoTimeReq("spot6m","1",KTBL_mechanisation,"10") = 0.44;
p_technoFuelCons("spot6m","1",KTBL_mechanisation,"10") = 1.39;
p_technoOtherCosts("spot6m","1",KTBL_mechanisation,"10") = 0.46;
p_technoMaintenance("spot6m","1",KTBL_mechanisation,"10") = 3.95;
p_technoTimeReq("spot6m","1",KTBL_mechanisation,"15") = 0.49;
p_technoFuelCons("spot6m","1",KTBL_mechanisation,"15") = 1.57;
p_technoOtherCosts("spot6m","1",KTBL_mechanisation,"15") = 0.49;
p_technoMaintenance("spot6m","1",KTBL_mechanisation,"15") = 4.15;

p_technoTimeReq("spot6m","2",KTBL_mechanisation,"1") = 0.29;
p_technoFuelCons("spot6m","2",KTBL_mechanisation,"1") = 0.97;
p_technoOtherCosts("spot6m","2",KTBL_mechanisation,"1") = 0.36;
p_technoMaintenance("spot6m","2",KTBL_mechanisation,"1") = 3.34;
p_technoTimeReq("spot6m","2",KTBL_mechanisation,"2") = 0.3;
p_technoFuelCons("spot6m","2",KTBL_mechanisation,"2") = 1.01;
p_technoOtherCosts("spot6m","2",KTBL_mechanisation,"2") = 0.37;
p_technoMaintenance("spot6m","2",KTBL_mechanisation,"2") = 3.38;
p_technoTimeReq("spot6m","2",KTBL_mechanisation,"3") = 0.31;
p_technoFuelCons("spot6m","2",KTBL_mechanisation,"3") = 1.04;
p_technoOtherCosts("spot6m","2",KTBL_mechanisation,"3") = 0.37;
p_technoMaintenance("spot6m","2",KTBL_mechanisation,"3") = 3.43;
p_technoTimeReq("spot6m","2",KTBL_mechanisation,"4") = 0.32;
p_technoFuelCons("spot6m","2",KTBL_mechanisation,"4") = 1.07;
p_technoOtherCosts("spot6m","2",KTBL_mechanisation,"4") = 0.38;
p_technoMaintenance("spot6m","2",KTBL_mechanisation,"4") = 3.47;
p_technoTimeReq("spot6m","2",KTBL_mechanisation,"5") = 0.33;
p_technoFuelCons("spot6m","2",KTBL_mechanisation,"5") = 1.1;
p_technoOtherCosts("spot6m","2",KTBL_mechanisation,"5") = 0.39;
p_technoMaintenance("spot6m","2",KTBL_mechanisation,"5") = 3.51;
p_technoTimeReq("spot6m","2",KTBL_mechanisation,"10") = 0.38;
p_technoFuelCons("spot6m","2",KTBL_mechanisation,"10") = 1.27;
p_technoOtherCosts("spot6m","2",KTBL_mechanisation,"10") = 0.42;
p_technoMaintenance("spot6m","2",KTBL_mechanisation,"10") = 3.71;
p_technoTimeReq("spot6m","2",KTBL_mechanisation,"15") = 0.43;
p_technoFuelCons("spot6m","2",KTBL_mechanisation,"15") = 1.44;
p_technoOtherCosts("spot6m","2",KTBL_mechanisation,"15") = 0.45;
p_technoMaintenance("spot6m","2",KTBL_mechanisation,"15") = 3.9;

p_technoTimeReq("spot6m","5",KTBL_mechanisation,"1") = 0.23;
p_technoFuelCons("spot6m","5",KTBL_mechanisation,"1") = 0.85;
p_technoOtherCosts("spot6m","5",KTBL_mechanisation,"1") = 0.32;
p_technoMaintenance("spot6m","5",KTBL_mechanisation,"1") = 3.13;
p_technoTimeReq("spot6m","5",KTBL_mechanisation,"2") = 0.24;
p_technoFuelCons("spot6m","5",KTBL_mechanisation,"2") = 0.88;
p_technoOtherCosts("spot6m","5",KTBL_mechanisation,"2") = 0.33;
p_technoMaintenance("spot6m","5",KTBL_mechanisation,"2") = 3.17;
p_technoTimeReq("spot6m","5",KTBL_mechanisation,"3") = 0.25;
p_technoFuelCons("spot6m","5",KTBL_mechanisation,"3") = 0.92;
p_technoOtherCosts("spot6m","5",KTBL_mechanisation,"3") = 0.34;
p_technoMaintenance("spot6m","5",KTBL_mechanisation,"3") = 3.22;
p_technoTimeReq("spot6m","5",KTBL_mechanisation,"4") = 0.27;
p_technoFuelCons("spot6m","5",KTBL_mechanisation,"4") = 0.95;
p_technoOtherCosts("spot6m","5",KTBL_mechanisation,"4") = 0.35;
p_technoMaintenance("spot6m","5",KTBL_mechanisation,"4") = 3.26;
p_technoTimeReq("spot6m","5",KTBL_mechanisation,"5") = 0.28;
p_technoFuelCons("spot6m","5",KTBL_mechanisation,"5") = 0.98;
p_technoOtherCosts("spot6m","5",KTBL_mechanisation,"5") = 0.35;
p_technoMaintenance("spot6m","5",KTBL_mechanisation,"5") = 3.3;
p_technoTimeReq("spot6m","5",KTBL_mechanisation,"10") = 0.32;
p_technoFuelCons("spot6m","5",KTBL_mechanisation,"10") = 1.14;
p_technoOtherCosts("spot6m","5",KTBL_mechanisation,"10") = 0.38;
p_technoMaintenance("spot6m","5",KTBL_mechanisation,"10") = 3.49;
p_technoTimeReq("spot6m","5",KTBL_mechanisation,"15") = 0.37;
p_technoFuelCons("spot6m","5",KTBL_mechanisation,"15") = 1.3;
p_technoOtherCosts("spot6m","5",KTBL_mechanisation,"15") = 0.41;
p_technoMaintenance("spot6m","5",KTBL_mechanisation,"15") = 3.68;

p_technoTimeReq("spot6m","10",KTBL_mechanisation,"1") = 0.23;
p_technoFuelCons("spot6m","10",KTBL_mechanisation,"1") = 0.85;
p_technoOtherCosts("spot6m","10",KTBL_mechanisation,"1") = 0.32;
p_technoMaintenance("spot6m","10",KTBL_mechanisation,"1") = 3.1;
p_technoTimeReq("spot6m","10",KTBL_mechanisation,"2") = 0.24;
p_technoFuelCons("spot6m","10",KTBL_mechanisation,"2") = 0.89;
p_technoOtherCosts("spot6m","10",KTBL_mechanisation,"2") = 0.33;
p_technoMaintenance("spot6m","10",KTBL_mechanisation,"2") = 3.15;
p_technoTimeReq("spot6m","10",KTBL_mechanisation,"3") = 0.25;
p_technoFuelCons("spot6m","10",KTBL_mechanisation,"3") = 0.92;
p_technoOtherCosts("spot6m","10",KTBL_mechanisation,"3") = 0.34;
p_technoMaintenance("spot6m","10",KTBL_mechanisation,"3") = 3.19;
p_technoTimeReq("spot6m","10",KTBL_mechanisation,"4") = 0.26;
p_technoFuelCons("spot6m","10",KTBL_mechanisation,"4") = 0.95;
p_technoOtherCosts("spot6m","10",KTBL_mechanisation,"4") = 0.34;
p_technoMaintenance("spot6m","10",KTBL_mechanisation,"4") = 3.24;
p_technoTimeReq("spot6m","10",KTBL_mechanisation,"5") = 0.27;
p_technoFuelCons("spot6m","10",KTBL_mechanisation,"5") = 0.98;
p_technoOtherCosts("spot6m","10",KTBL_mechanisation,"5") = 0.35;
p_technoMaintenance("spot6m","10",KTBL_mechanisation,"5") = 3.28;
p_technoTimeReq("spot6m","10",KTBL_mechanisation,"10") = 0.32;
p_technoFuelCons("spot6m","10",KTBL_mechanisation,"10") = 1.14;
p_technoOtherCosts("spot6m","10",KTBL_mechanisation,"10") = 0.38;
p_technoMaintenance("spot6m","10",KTBL_mechanisation,"10") = 3.46;
p_technoTimeReq("spot6m","10",KTBL_mechanisation,"15") = 0.37;
p_technoFuelCons("spot6m","10",KTBL_mechanisation,"15") = 1.3;
p_technoOtherCosts("spot6m","10",KTBL_mechanisation,"15") = 0.41;
p_technoMaintenance("spot6m","10",KTBL_mechanisation,"15") = 3.66;

p_technoTimeReq("spot6m","20",KTBL_mechanisation,"1") = 0.22;
p_technoFuelCons("spot6m","20",KTBL_mechanisation,"1") = 0.86;
p_technoOtherCosts("spot6m","20",KTBL_mechanisation,"1") = 0.32;
p_technoMaintenance("spot6m","20",KTBL_mechanisation,"1") = 3.09;
p_technoTimeReq("spot6m","20",KTBL_mechanisation,"2") = 0.24;
p_technoFuelCons("spot6m","20",KTBL_mechanisation,"2") = 0.89;
p_technoOtherCosts("spot6m","20",KTBL_mechanisation,"2") = 0.33;
p_technoMaintenance("spot6m","20",KTBL_mechanisation,"2") = 3.14;
p_technoTimeReq("spot6m","20",KTBL_mechanisation,"3") = 0.25;
p_technoFuelCons("spot6m","20",KTBL_mechanisation,"3") = 0.92;
p_technoOtherCosts("spot6m","20",KTBL_mechanisation,"3") = 0.33;
p_technoMaintenance("spot6m","20",KTBL_mechanisation,"3") = 3.19;
p_technoTimeReq("spot6m","20",KTBL_mechanisation,"4") = 0.26;
p_technoFuelCons("spot6m","20",KTBL_mechanisation,"4") = 0.96;
p_technoOtherCosts("spot6m","20",KTBL_mechanisation,"4") = 0.34;
p_technoMaintenance("spot6m","20",KTBL_mechanisation,"4") = 3.23;
p_technoTimeReq("spot6m","20",KTBL_mechanisation,"5") = 0.27;
p_technoFuelCons("spot6m","20",KTBL_mechanisation,"5") = 0.99;
p_technoOtherCosts("spot6m","20",KTBL_mechanisation,"5") = 0.35;
p_technoMaintenance("spot6m","20",KTBL_mechanisation,"5") = 3.27;
p_technoTimeReq("spot6m","20",KTBL_mechanisation,"10") = 0.31;
p_technoFuelCons("spot6m","20",KTBL_mechanisation,"10") = 1.14;
p_technoOtherCosts("spot6m","20",KTBL_mechanisation,"10") = 0.38;
p_technoMaintenance("spot6m","20",KTBL_mechanisation,"10") = 3.45;
p_technoTimeReq("spot6m","20",KTBL_mechanisation,"15") = 0.36;
p_technoFuelCons("spot6m","20",KTBL_mechanisation,"15") = 1.3;
p_technoOtherCosts("spot6m","20",KTBL_mechanisation,"15") = 0.41;
p_technoMaintenance("spot6m","20",KTBL_mechanisation,"15") = 3.65;

p_technoTimeReq("spot6m","40",KTBL_mechanisation,"1") = 0.22;
p_technoFuelCons("spot6m","40",KTBL_mechanisation,"1") = 0.86;
p_technoOtherCosts("spot6m","40",KTBL_mechanisation,"1") = 0.32;
p_technoMaintenance("spot6m","40",KTBL_mechanisation,"1") = 3.07;
p_technoTimeReq("spot6m","40",KTBL_mechanisation,"2") = 0.23;
p_technoFuelCons("spot6m","40",KTBL_mechanisation,"2") = 0.89;
p_technoOtherCosts("spot6m","40",KTBL_mechanisation,"2") = 0.32;
p_technoMaintenance("spot6m","40",KTBL_mechanisation,"2") = 3.12;
p_technoTimeReq("spot6m","40",KTBL_mechanisation,"3") = 0.24;
p_technoFuelCons("spot6m","40",KTBL_mechanisation,"3") = 0.92;
p_technoOtherCosts("spot6m","40",KTBL_mechanisation,"3") = 0.33;
p_technoMaintenance("spot6m","40",KTBL_mechanisation,"3") = 3.16;
p_technoTimeReq("spot6m","40",KTBL_mechanisation,"4") = 0.25;
p_technoFuelCons("spot6m","40",KTBL_mechanisation,"4") = 0.95;
p_technoOtherCosts("spot6m","40",KTBL_mechanisation,"4") = 0.34;
p_technoMaintenance("spot6m","40",KTBL_mechanisation,"4") = 3.21;
p_technoTimeReq("spot6m","40",KTBL_mechanisation,"5") = 0.26;
p_technoFuelCons("spot6m","40",KTBL_mechanisation,"5") = 0.98;
p_technoOtherCosts("spot6m","40",KTBL_mechanisation,"5") = 0.34;
p_technoMaintenance("spot6m","40",KTBL_mechanisation,"5") = 3.24;
p_technoTimeReq("spot6m","40",KTBL_mechanisation,"10") = 0.31;
p_technoFuelCons("spot6m","40",KTBL_mechanisation,"10") = 1.14;
p_technoOtherCosts("spot6m","40",KTBL_mechanisation,"10") = 0.38;
p_technoMaintenance("spot6m","40",KTBL_mechanisation,"10") = 3.44;
p_technoTimeReq("spot6m","40",KTBL_mechanisation,"15") = 0.36;
p_technoFuelCons("spot6m","40",KTBL_mechanisation,"15") = 1.31;
p_technoOtherCosts("spot6m","40",KTBL_mechanisation,"15") = 0.41;
p_technoMaintenance("spot6m","40",KTBL_mechanisation,"15") = 3.64;

p_technoTimeReq("spot6m","80",KTBL_mechanisation,"1") = 0.22;
p_technoFuelCons("spot6m","80",KTBL_mechanisation,"1") = 0.88;
p_technoOtherCosts("spot6m","80",KTBL_mechanisation,"1") = 0.32;
p_technoMaintenance("spot6m","80",KTBL_mechanisation,"1") = 3.09;
p_technoTimeReq("spot6m","80",KTBL_mechanisation,"2") = 0.23;
p_technoFuelCons("spot6m","80",KTBL_mechanisation,"2") = 0.92;
p_technoOtherCosts("spot6m","80",KTBL_mechanisation,"2") = 0.33;
p_technoMaintenance("spot6m","80",KTBL_mechanisation,"2") = 3.14;
p_technoTimeReq("spot6m","80",KTBL_mechanisation,"3") = 0.25;
p_technoFuelCons("spot6m","80",KTBL_mechanisation,"3") = 0.95;
p_technoOtherCosts("spot6m","80",KTBL_mechanisation,"3") = 0.33;
p_technoMaintenance("spot6m","80",KTBL_mechanisation,"3") = 3.18;
p_technoTimeReq("spot6m","80",KTBL_mechanisation,"4") = 0.26;
p_technoFuelCons("spot6m","80",KTBL_mechanisation,"4") = 0.98;
p_technoOtherCosts("spot6m","80",KTBL_mechanisation,"4") = 0.34;
p_technoMaintenance("spot6m","80",KTBL_mechanisation,"4") = 3.22;
p_technoTimeReq("spot6m","80",KTBL_mechanisation,"5") = 0.27;
p_technoFuelCons("spot6m","80",KTBL_mechanisation,"5") = 1.01;
p_technoOtherCosts("spot6m","80",KTBL_mechanisation,"5") = 0.35;
p_technoMaintenance("spot6m","80",KTBL_mechanisation,"5") = 3.26;
p_technoTimeReq("spot6m","80",KTBL_mechanisation,"10") = 0.31;
p_technoFuelCons("spot6m","80",KTBL_mechanisation,"10") = 1.17;
p_technoOtherCosts("spot6m","80",KTBL_mechanisation,"10") = 0.38;
p_technoMaintenance("spot6m","80",KTBL_mechanisation,"10") = 3.46;
p_technoTimeReq("spot6m","80",KTBL_mechanisation,"15") = 0.36;
p_technoFuelCons("spot6m","80",KTBL_mechanisation,"15") = 1.33;
p_technoOtherCosts("spot6m","80",KTBL_mechanisation,"15") = 0.41;
p_technoMaintenance("spot6m","80",KTBL_mechanisation,"15") = 3.66;



*assumption: 27m, 4.000 l; 67 kW (KTBL Feldarbeitsrechner) -> 24.06.2024, 100 l/ha
p_technoTimeReq("spot27m","1",KTBL_mechanisation,"1") = 0.25;
p_technoFuelCons("spot27m","1",KTBL_mechanisation,"1") = 1.49;
p_technoOtherCosts("spot27m","1",KTBL_mechanisation,"1") = 0.36;
p_technoMaintenance("spot27m","1",KTBL_mechanisation,"1") = 3.73;
p_technoTimeReq("spot27m","1",KTBL_mechanisation,"2") = 0.26;
p_technoFuelCons("spot27m","1",KTBL_mechanisation,"2") = 1.5;
p_technoOtherCosts("spot27m","1",KTBL_mechanisation,"2") = 0.37;
p_technoMaintenance("spot27m","1",KTBL_mechanisation,"2") = 3.73;
p_technoTimeReq("spot27m","1",KTBL_mechanisation,"3") = 0.26;
p_technoFuelCons("spot27m","1",KTBL_mechanisation,"3") = 1.53;
p_technoOtherCosts("spot27m","1",KTBL_mechanisation,"3") = 0.37;
p_technoMaintenance("spot27m","1",KTBL_mechanisation,"3") = 3.76;
p_technoTimeReq("spot27m","1",KTBL_mechanisation,"4") = 0.26;
p_technoFuelCons("spot27m","1",KTBL_mechanisation,"4") = 1.55;
p_technoOtherCosts("spot27m","1",KTBL_mechanisation,"4") = 0.37;
p_technoMaintenance("spot27m","1",KTBL_mechanisation,"4") = 3.77;
p_technoTimeReq("spot27m","1",KTBL_mechanisation,"5") = 0.26;
p_technoFuelCons("spot27m","1",KTBL_mechanisation,"5") = 1.58;
p_technoOtherCosts("spot27m","1",KTBL_mechanisation,"5") = 0.37;
p_technoMaintenance("spot27m","1",KTBL_mechanisation,"5") = 3.79;
p_technoTimeReq("spot27m","1",KTBL_mechanisation,"10") = 0.28;
p_technoFuelCons("spot27m","1",KTBL_mechanisation,"10") = 1.7;
p_technoOtherCosts("spot27m","1",KTBL_mechanisation,"10") = 0.39;
p_technoMaintenance("spot27m","1",KTBL_mechanisation,"10") = 3.88;
p_technoTimeReq("spot27m","1",KTBL_mechanisation,"15") = 0.3;
p_technoFuelCons("spot27m","1",KTBL_mechanisation,"15") = 1.86;
p_technoOtherCosts("spot27m","1",KTBL_mechanisation,"15") = 0.41;
p_technoMaintenance("spot27m","1",KTBL_mechanisation,"15") = 3.99;

p_technoTimeReq("spot27m","2",KTBL_mechanisation,"1") = 0.18;
p_technoFuelCons("spot27m","2",KTBL_mechanisation,"1") = 1.13;
p_technoOtherCosts("spot27m","2",KTBL_mechanisation,"1") = 0.29;
p_technoMaintenance("spot27m","2",KTBL_mechanisation,"1") = 3.24;
p_technoTimeReq("spot27m","2",KTBL_mechanisation,"2") = 0.18;
p_technoFuelCons("spot27m","2",KTBL_mechanisation,"2") = 1.14;
p_technoOtherCosts("spot27m","2",KTBL_mechanisation,"2") = 0.29;
p_technoMaintenance("spot27m","2",KTBL_mechanisation,"2") = 3.25;
p_technoTimeReq("spot27m","2",KTBL_mechanisation,"3") = 0.18;
p_technoFuelCons("spot27m","2",KTBL_mechanisation,"3") = 1.16;
p_technoOtherCosts("spot27m","2",KTBL_mechanisation,"3") = 0.29;
p_technoMaintenance("spot27m","2",KTBL_mechanisation,"3") = 3.27;
p_technoTimeReq("spot27m","2",KTBL_mechanisation,"4") = 0.18;
p_technoFuelCons("spot27m","2",KTBL_mechanisation,"4") = 1.18;
p_technoOtherCosts("spot27m","2",KTBL_mechanisation,"4") = 0.29;
p_technoMaintenance("spot27m","2",KTBL_mechanisation,"4") = 3.28;
p_technoTimeReq("spot27m","2",KTBL_mechanisation,"5") = 0.18;
p_technoFuelCons("spot27m","2",KTBL_mechanisation,"5") = 1.2;
p_technoOtherCosts("spot27m","2",KTBL_mechanisation,"5") = 0.3;
p_technoMaintenance("spot27m","2",KTBL_mechanisation,"5") = 3.29;
p_technoTimeReq("spot27m","2",KTBL_mechanisation,"10") = 0.19;
p_technoFuelCons("spot27m","2",KTBL_mechanisation,"10") = 1.28;
p_technoOtherCosts("spot27m","2",KTBL_mechanisation,"10") = 0.31;
p_technoMaintenance("spot27m","2",KTBL_mechanisation,"10") = 3.35;
p_technoTimeReq("spot27m","2",KTBL_mechanisation,"15") = 0.21;
p_technoFuelCons("spot27m","2",KTBL_mechanisation,"15") = 1.39;
p_technoOtherCosts("spot27m","2",KTBL_mechanisation,"15") = 0.32;
p_technoMaintenance("spot27m","2",KTBL_mechanisation,"15") = 3.42;

p_technoTimeReq("spot27m","5",KTBL_mechanisation,"1") = 0.12;
p_technoFuelCons("spot27m","5",KTBL_mechanisation,"1") = 0.87;
p_technoOtherCosts("spot27m","5",KTBL_mechanisation,"1") = 0.24;
p_technoMaintenance("spot27m","5",KTBL_mechanisation,"1") = 2.9;
p_technoTimeReq("spot27m","5",KTBL_mechanisation,"2") = 0.12;
p_technoFuelCons("spot27m","5",KTBL_mechanisation,"2") = 0.88;
p_technoOtherCosts("spot27m","5",KTBL_mechanisation,"2") = 0.24;
p_technoMaintenance("spot27m","5",KTBL_mechanisation,"2") = 2.91;
p_technoTimeReq("spot27m","5",KTBL_mechanisation,"3") = 0.12;
p_technoFuelCons("spot27m","5",KTBL_mechanisation,"3") = 0.9;
p_technoOtherCosts("spot27m","5",KTBL_mechanisation,"3") = 0.24;
p_technoMaintenance("spot27m","5",KTBL_mechanisation,"3") = 2.92;
p_technoTimeReq("spot27m","5",KTBL_mechanisation,"4") = 0.12;
p_technoFuelCons("spot27m","5",KTBL_mechanisation,"4") = 0.91;
p_technoOtherCosts("spot27m","5",KTBL_mechanisation,"4") = 0.24;
p_technoMaintenance("spot27m","5",KTBL_mechanisation,"4") = 2.93;
p_technoTimeReq("spot27m","5",KTBL_mechanisation,"5") = 0.12;
p_technoFuelCons("spot27m","5",KTBL_mechanisation,"5") = 0.92;
p_technoOtherCosts("spot27m","5",KTBL_mechanisation,"5") = 0.24;
p_technoMaintenance("spot27m","5",KTBL_mechanisation,"5") = 2.94;
p_technoTimeReq("spot27m","5",KTBL_mechanisation,"10") = 0.13;
p_technoFuelCons("spot27m","5",KTBL_mechanisation,"10") = 0.99;
p_technoOtherCosts("spot27m","5",KTBL_mechanisation,"10") = 0.25;
p_technoMaintenance("spot27m","5",KTBL_mechanisation,"10") = 2.98;
p_technoTimeReq("spot27m","5",KTBL_mechanisation,"15") = 0.14;
p_technoFuelCons("spot27m","5",KTBL_mechanisation,"15") = 1.06;
p_technoOtherCosts("spot27m","5",KTBL_mechanisation,"15") = 0.26;
p_technoMaintenance("spot27m","5",KTBL_mechanisation,"15") = 3.03;

p_technoTimeReq("spot27m","10",KTBL_mechanisation,"1") = 0.1;
p_technoFuelCons("spot27m","10",KTBL_mechanisation,"1") = 0.82;
p_technoOtherCosts("spot27m","10",KTBL_mechanisation,"1") = 0.22;
p_technoMaintenance("spot27m","10",KTBL_mechanisation,"1") = 2.8;
p_technoTimeReq("spot27m","10",KTBL_mechanisation,"2") = 0.1;
p_technoFuelCons("spot27m","10",KTBL_mechanisation,"2") = 0.83;
p_technoOtherCosts("spot27m","10",KTBL_mechanisation,"2") = 0.22;
p_technoMaintenance("spot27m","10",KTBL_mechanisation,"2") = 2.81;
p_technoTimeReq("spot27m","10",KTBL_mechanisation,"3") = 0.1;
p_technoFuelCons("spot27m","10",KTBL_mechanisation,"3") = 0.85;
p_technoOtherCosts("spot27m","10",KTBL_mechanisation,"3") = 0.22;
p_technoMaintenance("spot27m","10",KTBL_mechanisation,"3") = 2.82;
p_technoTimeReq("spot27m","10",KTBL_mechanisation,"4") = 0.11;
p_technoFuelCons("spot27m","10",KTBL_mechanisation,"4") = 0.86;
p_technoOtherCosts("spot27m","10",KTBL_mechanisation,"4") = 0.23;
p_technoMaintenance("spot27m","10",KTBL_mechanisation,"4") = 2.83;
p_technoTimeReq("spot27m","10",KTBL_mechanisation,"5") = 0.11;
p_technoFuelCons("spot27m","10",KTBL_mechanisation,"5") = 0.87;
p_technoOtherCosts("spot27m","10",KTBL_mechanisation,"5") = 0.23;
p_technoMaintenance("spot27m","10",KTBL_mechanisation,"5") = 2.84;
p_technoTimeReq("spot27m","10",KTBL_mechanisation,"10") = 0.11;
p_technoFuelCons("spot27m","10",KTBL_mechanisation,"10") = 0.93;
p_technoOtherCosts("spot27m","10",KTBL_mechanisation,"10") = 0.23;
p_technoMaintenance("spot27m","10",KTBL_mechanisation,"10") = 2.88;
p_technoTimeReq("spot27m","10",KTBL_mechanisation,"15") = 0.12;
p_technoFuelCons("spot27m","10",KTBL_mechanisation,"15") = 1.0;
p_technoOtherCosts("spot27m","10",KTBL_mechanisation,"15") = 0.24;
p_technoMaintenance("spot27m","10",KTBL_mechanisation,"15") = 2.93;

p_technoTimeReq("spot27m","20",KTBL_mechanisation,"1") = 0.09;
p_technoFuelCons("spot27m","20",KTBL_mechanisation,"1") = 0.73;
p_technoOtherCosts("spot27m","20",KTBL_mechanisation,"1") = 0.21;
p_technoMaintenance("spot27m","20",KTBL_mechanisation,"1") = 2.71;
p_technoTimeReq("spot27m","20",KTBL_mechanisation,"2") = 0.09;
p_technoFuelCons("spot27m","20",KTBL_mechanisation,"2") = 0.74;
p_technoOtherCosts("spot27m","20",KTBL_mechanisation,"2") = 0.21;
p_technoMaintenance("spot27m","20",KTBL_mechanisation,"2") = 2.73;
p_technoTimeReq("spot27m","20",KTBL_mechanisation,"3") = 0.09;
p_technoFuelCons("spot27m","20",KTBL_mechanisation,"3") = 0.76;
p_technoOtherCosts("spot27m","20",KTBL_mechanisation,"3") = 0.21;
p_technoMaintenance("spot27m","20",KTBL_mechanisation,"3") = 2.74;
p_technoTimeReq("spot27m","20",KTBL_mechanisation,"4") = 0.09;
p_technoFuelCons("spot27m","20",KTBL_mechanisation,"4") = 0.77;
p_technoOtherCosts("spot27m","20",KTBL_mechanisation,"4") = 0.21;
p_technoMaintenance("spot27m","20",KTBL_mechanisation,"4") = 2.75;
p_technoTimeReq("spot27m","20",KTBL_mechanisation,"5") = 0.09;
p_technoFuelCons("spot27m","20",KTBL_mechanisation,"5") = 0.78;
p_technoOtherCosts("spot27m","20",KTBL_mechanisation,"5") = 0.21;
p_technoMaintenance("spot27m","20",KTBL_mechanisation,"5") = 2.76;
p_technoTimeReq("spot27m","20",KTBL_mechanisation,"10") = 0.1;
p_technoFuelCons("spot27m","20",KTBL_mechanisation,"10") = 0.84;
p_technoOtherCosts("spot27m","20",KTBL_mechanisation,"10") = 0.22;
p_technoMaintenance("spot27m","20",KTBL_mechanisation,"10") = 2.79;
p_technoTimeReq("spot27m","20",KTBL_mechanisation,"15") = 0.11;
p_technoFuelCons("spot27m","20",KTBL_mechanisation,"15") = 0.9;
p_technoOtherCosts("spot27m","20",KTBL_mechanisation,"15") = 0.23;
p_technoMaintenance("spot27m","20",KTBL_mechanisation,"15") = 2.84;

p_technoTimeReq("spot27m","40",KTBL_mechanisation,"1") = 0.08;
p_technoFuelCons("spot27m","40",KTBL_mechanisation,"1") = 0.69;
p_technoOtherCosts("spot27m","40",KTBL_mechanisation,"1") = 0.2;
p_technoMaintenance("spot27m","40",KTBL_mechanisation,"1") = 2.66;
p_technoTimeReq("spot27m","40",KTBL_mechanisation,"2") = 0.08;
p_technoFuelCons("spot27m","40",KTBL_mechanisation,"2") = 0.7;
p_technoOtherCosts("spot27m","40",KTBL_mechanisation,"2") = 0.2;
p_technoMaintenance("spot27m","40",KTBL_mechanisation,"2") = 2.67;
p_technoTimeReq("spot27m","40",KTBL_mechanisation,"3") = 0.08;
p_technoFuelCons("spot27m","40",KTBL_mechanisation,"3") = 0.72;
p_technoOtherCosts("spot27m","40",KTBL_mechanisation,"3") = 0.2;
p_technoMaintenance("spot27m","40",KTBL_mechanisation,"3") = 2.68;
p_technoTimeReq("spot27m","40",KTBL_mechanisation,"4") = 0.08;
p_technoFuelCons("spot27m","40",KTBL_mechanisation,"4") = 0.73;
p_technoOtherCosts("spot27m","40",KTBL_mechanisation,"4") = 0.2;
p_technoMaintenance("spot27m","40",KTBL_mechanisation,"4") = 2.69;
p_technoTimeReq("spot27m","40",KTBL_mechanisation,"5") = 0.08;
p_technoFuelCons("spot27m","40",KTBL_mechanisation,"5") = 0.74;
p_technoOtherCosts("spot27m","40",KTBL_mechanisation,"5") = 0.21;
p_technoMaintenance("spot27m","40",KTBL_mechanisation,"5") = 2.7;
p_technoTimeReq("spot27m","40",KTBL_mechanisation,"10") = 0.09;
p_technoFuelCons("spot27m","40",KTBL_mechanisation,"10") = 0.8;
p_technoOtherCosts("spot27m","40",KTBL_mechanisation,"10") = 0.21;
p_technoMaintenance("spot27m","40",KTBL_mechanisation,"10") = 2.75;
p_technoTimeReq("spot27m","40",KTBL_mechanisation,"15") = 0.1;
p_technoFuelCons("spot27m","40",KTBL_mechanisation,"15") = 0.86;
p_technoOtherCosts("spot27m","40",KTBL_mechanisation,"15") = 0.22;
p_technoMaintenance("spot27m","40",KTBL_mechanisation,"15") = 2.79;

p_technoTimeReq("spot27m","80",KTBL_mechanisation,"1") = 0.08;
p_technoFuelCons("spot27m","80",KTBL_mechanisation,"1") = 0.73;
p_technoOtherCosts("spot27m","80",KTBL_mechanisation,"1") = 0.2;
p_technoMaintenance("spot27m","80",KTBL_mechanisation,"1") = 2.68;
p_technoTimeReq("spot27m","80",KTBL_mechanisation,"2") = 0.08;
p_technoFuelCons("spot27m","80",KTBL_mechanisation,"2") = 0.74;
p_technoOtherCosts("spot27m","80",KTBL_mechanisation,"2") = 0.2;
p_technoMaintenance("spot27m","80",KTBL_mechanisation,"2") = 2.69;
p_technoTimeReq("spot27m","80",KTBL_mechanisation,"3") = 0.08;
p_technoFuelCons("spot27m","80",KTBL_mechanisation,"3") = 0.75;
p_technoOtherCosts("spot27m","80",KTBL_mechanisation,"3") = 0.2;
p_technoMaintenance("spot27m","80",KTBL_mechanisation,"3") = 2.7;
p_technoTimeReq("spot27m","80",KTBL_mechanisation,"4") = 0.08;
p_technoFuelCons("spot27m","80",KTBL_mechanisation,"4") = 0.77;
p_technoOtherCosts("spot27m","80",KTBL_mechanisation,"4") = 0.21;
p_technoMaintenance("spot27m","80",KTBL_mechanisation,"4") = 2.71;
p_technoTimeReq("spot27m","80",KTBL_mechanisation,"5") = 0.09;
p_technoFuelCons("spot27m","80",KTBL_mechanisation,"5") = 0.78;
p_technoOtherCosts("spot27m","80",KTBL_mechanisation,"5") = 0.21;
p_technoMaintenance("spot27m","80",KTBL_mechanisation,"5") = 2.71;
p_technoTimeReq("spot27m","80",KTBL_mechanisation,"10") = 0.09;
p_technoFuelCons("spot27m","80",KTBL_mechanisation,"10") = 0.84;
p_technoOtherCosts("spot27m","80",KTBL_mechanisation,"10") = 0.21;
p_technoMaintenance("spot27m","80",KTBL_mechanisation,"10") = 2.76;
p_technoTimeReq("spot27m","80",KTBL_mechanisation,"15") = 0.1;
p_technoFuelCons("spot27m","80",KTBL_mechanisation,"15") = 0.9;
p_technoOtherCosts("spot27m","80",KTBL_mechanisation,"15") = 0.22;
p_technoMaintenance("spot27m","80",KTBL_mechanisation,"15") = 2.8;



*reason for the formula is, that the data for other costs is drawn from KTBL makost (17.05.2024)
*and it is assumed here that costs for maintenance and the other costs are proportionally higher according to the value of the technology
p_technoMaintenance("spot27m",KTBL_size,KTBL_mechanisation,KTBL_distance) = 
    p_technoMaintenance("spot27m",KTBL_size,KTBL_mechanisation,KTBL_distance)
    * (p_technoValue("spot27m",KTBL_mechanisation)/54300)
;

p_technoMaintenance("spot6m",KTBL_size,KTBL_mechanisation,KTBL_distance) =
    p_technoMaintenance("spot6m",KTBL_size,KTBL_mechanisation,KTBL_distance)
    * (p_technoValue("spot6m",KTBL_mechanisation) / p_technoValue("BA","45"))
;

p_technoTimeReq("spot6m",KTBL_size,KTBL_mechanisation,KTBL_distance) = p_technoTimeReq("spot6m",KTBL_size,KTBL_mechanisation,KTBL_distance) * 2;
p_technoFuelCons("spot6m",KTBL_size,KTBL_mechanisation,KTBL_distance) = p_technoFuelCons("spot6m",KTBL_size,KTBL_mechanisation,KTBL_distance) * 2;

*
* --- Parameter definition to ensure that technologies are selected which are linked to the
*   scenario chosen
parameter p_technology_scenario(technology,scenario) /
"BA"."Base" 1
"spot6m"."FH" 1
"spot27m"."FH" 1
"spot6m"."FH+BA" 1
"spot27m"."FH+BA" 1
"spot6m"."FH+Bonus" 1
"spot27m"."FH+Bonus" 1
"spot6m"."FH+Bonus+BA" 1
"spot27m"."FH+Bonus+BA" 1
/;

parameter p_scenario_scenSprayer(scenario,scenSprayer) /
"Base"."BA" 1
"FH"."BA" 1
"FH"."spot6m" 1
"FH"."spot27m" 1
"FH+BA"."spot6m" 1
"FH+BA"."spot27m" 1
"FH+Bonus"."spot6m" 1
"FH+Bonus"."spot27m" 1
"FH+Bonus"."BA" 1
"FH+Bonus+BA"."spot6m" 1
"FH+Bonus+BA"."spot27m" 1
/;

parameter p_technology_scenario_scenSprayer(technology,scenario,scenSprayer) /
"BA"."Base"."BA" 1
"spot6m"."FH"."spot6m" 1
"spot6m"."FH"."BA" 1
"spot27m"."FH"."spot27m" 1
"spot27m"."FH"."BA" 1
"spot6m"."FH+BA"."spot6m" 1
"spot27m"."FH+BA"."spot27m" 1
"spot6m"."FH+Bonus"."spot6m" 1
"spot6m"."FH+Bonus"."BA" 1
"spot27m"."FH+Bonus"."spot27m" 1
"spot27m"."FH+Bonus"."BA" 1
"spot6m"."FH+Bonus+BA"."spot6m" 1
"spot27m"."FH+Bonus+BA"."spot27m" 1

/;



parameter p_datePestOpTechnoLWK_(LWK_crops,LWK_yield,technology,scenario,scenSprayer,halfMonth) /
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
'Winterweizen'.'< 70 dt/ha'."BA"."Base"."BA"."OKT2" 1
'Winterweizen'.'< 70 dt/ha'."BA"."Base"."BA"."APR1" 1
'Winterweizen'.'< 70 dt/ha'."BA"."Base"."BA"."APR2" 1
'Winterweizen'.'< 70 dt/ha'."BA"."Base"."BA"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."BA"."Base"."BA"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."BA"."Base"."BA"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."BA"."Base"."BA"."APR1" 1
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."BA"."Base"."BA"."APR2" 1
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."BA"."Base"."BA"."MAI1" 1
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."BA"."Base"."BA"."JUN1" 1

*gleich wie Winterweizen
'Wintergerste'.'< 70 dt/ha'."BA"."Base"."BA"."OKT2" 1
'Wintergerste'.'< 70 dt/ha'."BA"."Base"."BA"."APR1" 1
'Wintergerste'.'< 70 dt/ha'."BA"."Base"."BA"."APR2" 1
'Wintergerste'.'< 70 dt/ha'."BA"."Base"."BA"."JUN1" 1

*zusätzliche Anwendung im Mai1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."BA"."Base"."BA"."OKT2" 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."BA"."Base"."BA"."APR1" 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."BA"."Base"."BA"."APR2" 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."BA"."Base"."BA"."JUN1" 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."BA"."Base"."BA"."MAI1" 1

'Winterroggen & Triticale'.'< 60 dt/ha'."BA"."Base"."BA"."OKT2" 1
'Winterroggen & Triticale'.'< 60 dt/ha'."BA"."Base"."BA"."APR1" 1
'Winterroggen & Triticale'.'< 60 dt/ha'."BA"."Base"."BA"."APR2" 1
'Winterroggen & Triticale'.'< 60 dt/ha'."BA"."Base"."BA"."JUN1" 1

'Winterroggen & Triticale'.'> 60 dt/ha'."BA"."Base"."BA"."OKT2" 1
'Winterroggen & Triticale'.'> 60 dt/ha'."BA"."Base"."BA"."APR1" 1
'Winterroggen & Triticale'.'> 60 dt/ha'."BA"."Base"."BA"."APR2" 1
'Winterroggen & Triticale'.'> 60 dt/ha'."BA"."Base"."BA"."JUN1" 1
'Winterroggen & Triticale'.'> 60 dt/ha'."BA"."Base"."BA"."MAI1" 1

*1 zusätzliche Anwendung in MAI1
'Raps'.'alle Ertragsklassen'."BA"."Base"."BA"."AUG2" 1
'Raps'.'alle Ertragsklassen'."BA"."Base"."BA"."OKT2" 1
'Raps'.'alle Ertragsklassen'."BA"."Base"."BA"."APR1" 1
'Raps'.'alle Ertragsklassen'."BA"."Base"."BA"."APR2" 1
'Raps'.'alle Ertragsklassen'."BA"."Base"."BA"."MAI1" 1

*Blatt- und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."BA"."Base"."BA"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."BA"."Base"."BA"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."BA"."Base"."BA"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."BA"."Base"."BA"."JUN2" 2
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."BA"."Base"."BA"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."BA"."Base"."BA"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."BA"."Base"."BA"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."BA"."Base"."BA"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."BA"."Base"."BA"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."BA"."Base"."BA"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."BA"."Base"."BA"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."BA"."Base"."BA"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."BA"."Base"."BA"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."BA"."Base"."BA"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."BA"."Base"."BA"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."BA"."Base"."BA"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."BA"."Base"."BA"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."BA"."Base"."BA"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."BA"."Base"."BA"."AUG1" 0.5

*
* -------------------- Scenario FH for SPOT 6m
*
*Bodenherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH"."BA"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH"."spot6m"."OKT2" 1
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH"."spot6m"."APR1" 1
*Wachstumsregler 1 & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH"."BA"."APR2" 1
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH"."BA"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."BA"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."spot6m"."MRZ2" 1
*Blattherbizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."spot6m"."APR1" 1
*Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."BA"."APR1" 1
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."BA"."APR2" 1
*Blattherbizid 3
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."spot6m"."MAI1" 1
*Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."BA"."MAI1" 1
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."BA"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH"."BA"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH"."spot6m"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH"."BA"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH"."BA"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."BA"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."spot6m"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."BA"."APR1" 1
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."BA"."APR2" 1
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."spot6m"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."BA"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH"."BA"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH"."spot6m"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH"."BA"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH"."BA"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH"."BA"."OKT2" 1
*Blattherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH"."spot6m"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH"."BA"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH"."BA"."APR2" 1
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH"."spot6m"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH"."BA"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH"."BA"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH"."BA"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH"."spot6m"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH"."BA"."APR2" 1
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot6m"."FH"."BA"."MAI1" 1

*Blattherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH"."spot6m"."MAI1" 1
*Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH"."BA"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH"."BA"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH"."BA"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH"."BA"."JUN2" 2
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH"."BA"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH"."BA"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH"."BA"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH"."BA"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH"."BA"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH"."BA"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH"."spot6m"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH"."spot6m"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH"."BA"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH"."spot6m"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH"."BA"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH"."BA"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot6m"."FH"."spot6m"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot6m"."FH"."spot6m"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot6m"."FH"."spot6m"."AUG1" 0.5



*
* -------------------- Scenario FH+BA for SPOT 6m
*
*Boden- & Blattherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."OKT2" 2
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."APR1" 1
*Wachstumsregler & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."APR2" 1
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."APR1" 2
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."APR2" 1
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."MAI1" 2
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."APR1" 2
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."APR2" 1
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+BA"."spot6m"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+BA"."spot6m"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+BA"."spot6m"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+BA"."spot6m"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+BA"."spot6m"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+BA"."spot6m"."APR1" 2
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+BA"."spot6m"."APR2" 1
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+BA"."spot6m"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+BA"."spot6m"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."APR2" 1
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."MAI1" 1

*Blattherbizid 1 und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."MAI1" 2
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."JUN2" 2
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."AUG1" 0.5



*
* -------------------- Scenario FH+Bonus for SPOT 6m
*
*Bodenherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+Bonus"."BA"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+Bonus"."spot6m"."OKT2" 1
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+Bonus"."spot6m"."APR1" 1
*Wachstumsregler 1 & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+Bonus"."spot6m"."APR2" 1
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+Bonus"."spot6m"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."BA"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."APR1" 2
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."APR2" 1
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."MAI1" 2
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+Bonus"."BA"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+Bonus"."spot6m"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+Bonus"."spot6m"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+Bonus"."spot6m"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."BA"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1 
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."APR1" 2
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."APR2" 1
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+Bonus"."spot6m"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+Bonus"."BA"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+Bonus"."spot6m"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+Bonus"."spot6m"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+Bonus"."spot6m"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+Bonus"."BA"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+Bonus"."spot6m"."APR1" 2
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+Bonus"."spot6m"."APR2" 1
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+Bonus"."spot6m"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+Bonus"."spot6m"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."BA"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."APR2" 1
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."MAI1" 1

*Blattherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."MAI1" 1
*Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."BA"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."JUN2" 2
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."BA"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."BA"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot6m"."FH+Bonus"."spot6m"."AUG1" 0.5



*
* -------------------- Scenario FH for SPOT 27m
*
*Blattherbizid 1 & Bodenherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH"."spot27m"."OKT2" 1
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH"."spot27m"."APR1" 1
*Wachstumsregler 1 & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH"."BA"."APR2" 1
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH"."BA"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."BA"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m"."APR1" 1
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."BA"."APR2" 1
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m"."MAI1" 1
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."BA"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH"."BA"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH"."spot27m"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH"."BA"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH"."BA"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."BA"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m"."APR1" 1
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."BA"."APR2" 1
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."BA"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH"."BA"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH"."spot27m"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH"."BA"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH"."BA"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH"."BA"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH"."spot27m"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH"."BA"."APR2" 1
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH"."spot27m"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH"."BA"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH"."BA"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH"."BA"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH"."BA"."APR2" 1
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot27m"."FH"."BA"."MAI1" 1

*Blattherbizid 1 und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH"."BA"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH"."BA"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH"."BA"."JUN2" 2
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH"."BA"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH"."BA"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH"."BA"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH"."BA"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH"."BA"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH"."BA"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH"."BA"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH"."BA"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH"."BA"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot27m"."FH"."spot27m"."AUG1" 0.5



*
* -------------------- Scenario FH+BA for SPOT 27m
*
*Blattherbizid 1 & Bodenherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."OKT2" 1
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."APR1" 1
*Wachstumsregler 1 & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."APR2" 1
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."APR1" 1
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."APR2" 1
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."MAI1" 1
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."APR1" 1
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."APR2" 1
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+BA"."spot27m"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+BA"."spot27m"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+BA"."spot27m"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+BA"."spot27m"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."APR2" 1
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."APR2" 1
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."MAI1" 1

*Blattherbizid 1 und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."JUN2" 2
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."AUG1" 0.5



*
* -------------------- Scenario FH+Bonus for SPOT 27m
*
*Blattherbizid 1 & Bodenherbizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."OKT2" 1
*Blattherbizid 2
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."APR1" 1
*Wachstumsregler 1 & Insektizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."APR2" 1
*Fungizid 1
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."JUN1" 1

*Bodenherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."BA"."OKT2" 1
*Blattherbizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."MRZ2" 1
*Blattherbizid 2 & Wachstumsregler 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."APR1" 1
*Insektizid 1 & Fungizid 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."APR2" 1
*Blattherbizid 3 & Wachstumsregler 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."MAI1" 1
*Fungizid 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus"."BA"."OKT2" 1
*Blattherbizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."APR1" 1
*Wachstumsregler 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."APR2" 1
*Fungizid 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+Bonus"."spot27m"."JUN1" 1

*Bodenherbizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."BA"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."APR1" 1
*Wachstumsregler 2 & Fungizid 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."APR2" 1
*Blattherbizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."MAI1" 1
*Fungizid 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+Bonus"."spot27m"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus"."BA"."OKT2" 1
*Blattherbizd 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."APR1" 1
*Wachstumsregler 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."APR2" 1
*Fungizid 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."JUN1" 1

*Bodenherbizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."BA"."OKT2" 1
*Blattherbizid 1 & Wachstumsregler 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."APR2" 1
*Blattherbizid 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."MAI1" 1
*Fungizid 1
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+Bonus"."spot27m"."JUN1" 1

*Bodenherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."BA"."AUG2" 1
*Wachstumsregler 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."OKT2" 1
*Blattherbizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."APR1" 1
*Wachstumsregler 2 & Insektizid 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."APR2" 1
*Insektizid 2
'Raps'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."MAI1" 1

*Blattherbizid 1 und Bodenherbizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."MAI1" 1
*Fungizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."MAI2" 1
*Fungizid 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."JUN1" 1
*Fungizid 3 & Insektizid 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."JUN2" 2
*Fungizid 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."JUL1" 1
*Fungizid 5 & 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."JUL2" 2
*Fungizid 6
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."AUG1" 1
*Fungizid 7
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."AUG2" 1
*Krautabtötung 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."BA"."SEP1" 1
*Krautabtötung 2
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."BA"."SEP2" 1

*Blattherbizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."MRZ2" 1
*Blattherbizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."APR2" 1
*Insektizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot27m"."FH+Bonus"."spot27m"."AUG1" 0.5
/;

p_datePestOpTechnoLWK_(LWK_crops,LWK_yield,technology,"FH+Bonus+BA",scenSprayer,halfMonth) 
    $ (not(sameas(technology,"BA")))
    = p_datePestOpTechnoLWK_(LWK_crops,LWK_yield,technology,"FH+BA",scenSprayer,halfMonth) 
;

parameter p_datePestOpTechno(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer,halfMonth);

p_datePestOpTechno(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer,halfMonth) =
    sum((LWK_crops,LWK_yield),
    p_datePestOpTechnoLWK_(LWK_crops,LWK_yield,technology,scenario,scenSprayer,halfMonth)
    * p_lwkCrops_lwkYield_ktblYield(LWK_crops,LWK_yield,KTBL_yield)
    * p_ktblCrops_lwkCrops(KTBL_crops,LWK_crops)
    )
;

parameter p_numberSprayPassesScenarios(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer);

p_numberSprayPassesScenarios(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer) =
    sum(halfMonth, p_datePestOpTechno(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer,halfMonth))
;

*option p_numberSprayPassesScenarios:1:4:1 display p_numberSprayPassesScenarios;

