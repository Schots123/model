

set technology /BA, spot6m, spot27m/;
alias (technology,scenSprayer);

set scenario / 
    Base BA only with BA sprayer, 
    FH SS of foliar herbicides with SST and BA of remaining pesticides with BA sprayer
    FH+BA SS of foliar herbicides and BA of remaining pesticides with SST
*    FH+F+I SS of foliar herbicides fungicides and insecticides on row crops with SST and BA of remaining pesticides with BA sprayer, 
*    FH+F+I+BA SS of foliar herbicides fungicides and insecticides on row crops and BA of remaining pesticides with SST
    /;



*parameters for fix costs
parameters
    p_technoPestEff(technology,KTBL_mechanisation,pestType) pesticide savings due to technology utilization for each type 
    p_technoValue(scenSprayer,KTBL_mechanisation)
    p_technoRemValue(scenSprayer,KTBL_mechanisation)
    p_technoLifetime(scenSprayer)
    p_technoAnnualCapac(scenSprayer,KTBL_mechanisation)
    p_technoAreaCapac(scenSprayer,KTBL_mechanisation)
*for Alternative of annualCapac
    p_technoFieldDayHours(scenSprayer)
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
p_technoRemValue(technology,KTBL_mechanisation) 
    = p_technoValue(technology,KTBL_mechanisation) * 0.2;

*pesticide efficiency block for SST
p_technoPestEff(technology,KTBL_mechanisation,"soilHerb") $ (not(sameas(technology,"BA"))) = 0;
p_technoPestEff(technology,KTBL_mechanisation,"foliarHerb") $ (not(sameas(technology,"BA"))) = 0.9;
p_technoPestEff(technology,KTBL_mechanisation,"fung") $ (not(sameas(technology,"BA"))) = 0.4;
p_technoPestEff(technology,KTBL_mechanisation,"insect") $ (not(sameas(technology,"BA"))) = 0.4;
p_technoPestEff(technology,KTBL_mechanisation,"growthReg") $ (not(sameas(technology,"BA"))) = 0;
p_technoPestEff(technology,KTBL_mechanisation,"dessic") $ (not(sameas(technology,"BA"))) = 0;

*source: makost KTBL 17.05.2024 Standartwert Spritze 
p_technoLifetime(technology) = 10;

*source: makost KTBL 17.05.2024: 1/2 * Einsatzumfang 12m Spritze
p_technoAnnualCapac("spot6m",KTBL_mechanisation) = 240;
*source: makost KTBL 17.05.2024: Arbeitsbreite 27m Spritze
p_technoAnnualCapac("spot27m",KTBL_mechanisation) = 1080;
p_technoAnnualCapac("BA","45") = 480;
p_technoAnnualCapac("BA","67") = 600;
p_technoAnnualCapac("BA","83") = 720;
p_technoAnnualCapac("BA","102") = 960;
p_technoAnnualCapac("BA","120") = 960;
p_technoAnnualCapac("BA","200") = 960;
p_technoAnnualCapac("BA","230") = 1440;

*standard KTBL procedure
p_technoAreaCapac(technology,KTBL_mechanisation) = p_technoLifetime(technology) * p_technoAnnualCapac(technology,KTBL_mechanisation);

*ALTERNATIVE FOR ANNUAL CAPAC!!
p_technoFieldDayHours("BA") = 24;
p_technoFieldDayHours("spot6m") = 24;
p_technoFieldDayHours("spot27m") = 12;
;



*
*  --- parameters for time requirements, other costs and variable costs 
*
parameters
    p_technoTimeReq(scenSprayer,KTBL_size,KTBL_mechanisation,KTBL_distance)
    p_technoFuelCons(scenSprayer,KTBL_size,KTBL_mechanisation,KTBL_distance)
    p_technoMaintenance(scenSprayer,KTBL_size,KTBL_mechanisation,KTBL_distance)
*    p_technoOtherCosts(technology,KTBL_size,KTBL_mechanisation,KTBL_distance)
;

*
*---BA technology
*
parameter p_ktbl_workingStepsBroadcast(KTBL_size,KTBL_mechanisation,KTBL_distance,workingStepsEle);

*load in ktbl Data for variable and fix machine costs of pesticide application operations with broadcast technology
$Gdxin 2.ktblData/gdxFiles/KTBL_WorkingStepsBroadcast.gdx
$load p_ktbl_workingStepsBroadcast=p_ktbl_workingStepsBroadcast
*option p_ktbl_workingStepsBroadcast:1:3:1 display p_ktbl_workingStepsBroadcast;

p_technoTimeReq("BA",KTBL_size,KTBL_mechanisation,KTBL_distance) = p_ktbl_workingStepsBroadcast(KTBL_size,KTBL_mechanisation,KTBL_distance,"time");
p_technoFuelCons("BA",KTBL_size,KTBL_mechanisation,KTBL_distance) = p_ktbl_workingStepsBroadcast(KTBL_size,KTBL_mechanisation,KTBL_distance,"fuelCons");
p_technoMaintenance("BA",KTBL_size,KTBL_mechanisation,KTBL_distance) = p_ktbl_workingStepsBroadcast(KTBL_size,KTBL_mechanisation,KTBL_distance,"maintenance");
*p_technoOtherCosts("BA",KTBL_size,KTBL_mechanisation,KTBL_distance) = p_ktbl_workingStepsBroadcast(KTBL_size,KTBL_mechanisation,KTBL_distance,"others");

*
*---SST 
*
p_technoTimeReq("spot6m",KTBL_size,KTBL_mechanisation,KTBL_distance) = p_ktbl_workingStepsBroadcast(KTBL_size,"45",KTBL_distance,"time") * 2;
*sprayer is reportedly able to spray between 2.5 and 4 ha in an hour

p_technoFuelCons("spot6m",KTBL_size,KTBL_mechanisation,KTBL_distance) = p_ktbl_workingStepsBroadcast(KTBL_size,"45",KTBL_distance,"fuelCons") * 2;

$ontext
following data is approximated from certain field operation 
p_technoFuelCons("spot6m","1",KTBL_mechanisation,"2") = 2.83;
p_technoFuelCons("spot6m","1",KTBL_mechanisation,"3") = 2.85;
p_technoFuelCons("spot6m","1",KTBL_mechanisation,"4") = 2.87;
p_technoFuelCons("spot6m","1",KTBL_mechanisation,"5") = 2.89;
p_technoFuelCons("spot6m","1",KTBL_mechanisation,"10") = 3.01;
p_technoFuelCons("spot6m","1",KTBL_mechanisation,"15") = 3.11;
p_technoFuelCons("spot6m","2",KTBL_mechanisation,"1") = 2.28;
p_technoFuelCons("spot6m","2",KTBL_mechanisation,"2") = 2.37;
p_technoFuelCons("spot6m","2",KTBL_mechanisation,"3") = 2.38;
p_technoFuelCons("spot6m","2",KTBL_mechanisation,"4") = 2.4;
p_technoFuelCons("spot6m","2",KTBL_mechanisation,"5") = 2.41;
p_technoFuelCons("spot6m","2",KTBL_mechanisation,"10") = 2.5;
p_technoFuelCons("spot6m","2",KTBL_mechanisation,"15") = 2.57;
p_technoFuelCons("spot6m","5",KTBL_mechanisation,"1") = 2.04;
p_technoFuelCons("spot6m","5",KTBL_mechanisation,"2") = 2.09;
p_technoFuelCons("spot6m","5",KTBL_mechanisation,"3") = 2.1;
p_technoFuelCons("spot6m","5",KTBL_mechanisation,"4") = 2.11;
p_technoFuelCons("spot6m","5",KTBL_mechanisation,"5") = 2.12;
p_technoFuelCons("spot6m","5",KTBL_mechanisation,"10") = 2.18;
p_technoFuelCons("spot6m","5",KTBL_mechanisation,"15") = 2.23;
p_technoFuelCons("spot6m","10",KTBL_mechanisation,"1") = 1.92;
p_technoFuelCons("spot6m","10",KTBL_mechanisation,"2") = 1.96;
p_technoFuelCons("spot6m","10",KTBL_mechanisation,"3") = 1.97;
p_technoFuelCons("spot6m","10",KTBL_mechanisation,"4") = 1.98;
p_technoFuelCons("spot6m","10",KTBL_mechanisation,"5") = 1.99;
p_technoFuelCons("spot6m","10",KTBL_mechanisation,"10") = 2.03;
p_technoFuelCons("spot6m","10",KTBL_mechanisation,"15") = 2.08;
p_technoFuelCons("spot6m","20",KTBL_mechanisation,"1") = 1.85;
p_technoFuelCons("spot6m","20",KTBL_mechanisation,"2") = 1.87;
p_technoFuelCons("spot6m","20",KTBL_mechanisation,"3") = 1.88;
p_technoFuelCons("spot6m","20",KTBL_mechanisation,"4") = 1.89;
p_technoFuelCons("spot6m","20",KTBL_mechanisation,"5") = 1.89;
p_technoFuelCons("spot6m","20",KTBL_mechanisation,"10") = 1.93;
p_technoFuelCons("spot6m","20",KTBL_mechanisation,"15") = 1.96;
p_technoFuelCons("spot6m","40",KTBL_mechanisation,"1") = 1.83;
p_technoFuelCons("spot6m","40",KTBL_mechanisation,"2") = 1.85;
p_technoFuelCons("spot6m","40",KTBL_mechanisation,"3") = 1.86;
p_technoFuelCons("spot6m","40",KTBL_mechanisation,"4") = 1.87;
p_technoFuelCons("spot6m","40",KTBL_mechanisation,"5") = 1.88;
p_technoFuelCons("spot6m","40",KTBL_mechanisation,"10") = 1.93;
p_technoFuelCons("spot6m","40",KTBL_mechanisation,"15") = 1.98;
p_technoFuelCons("spot6m","80",KTBL_mechanisation,"1") = 1.82;
p_technoFuelCons("spot6m","80",KTBL_mechanisation,"2") = 1.84;
p_technoFuelCons("spot6m","80",KTBL_mechanisation,"3") = 1.85;
p_technoFuelCons("spot6m","80",KTBL_mechanisation,"4") = 1.86;
p_technoFuelCons("spot6m","80",KTBL_mechanisation,"5") = 1.87;
p_technoFuelCons("spot6m","80",KTBL_mechanisation,"10") = 1.91;
p_technoFuelCons("spot6m","80",KTBL_mechanisation,"15") = 1.97;
$offtext


*assumption: 27m, 3.000 l; 83 kW (KTBL Feldarbeitsrechner) -> 17.05.2024, 300 l/ha
p_technoTimeReq("spot27m","1",KTBL_mechanisation,"1") = 0.27;
p_technoFuelCons("spot27m","1",KTBL_mechanisation,"1") = 1.69;
*p_technoOtherCosts("spot27m","1",KTBL_mechanisation,"1") = 0.46;
p_technoTimeReq("spot27m","1",KTBL_mechanisation,"2") = 0.28;
p_technoFuelCons("spot27m","1",KTBL_mechanisation,"2") = 1.75;
*p_technoOtherCosts("spot27m","1",KTBL_mechanisation,"2") = 0.47;
p_technoTimeReq("spot27m","1",KTBL_mechanisation,"3") = 0.28;
p_technoFuelCons("spot27m","1",KTBL_mechanisation,"3") = 1.8;
*p_technoOtherCosts("spot27m","1",KTBL_mechanisation,"3") = 0.47;
p_technoTimeReq("spot27m","1",KTBL_mechanisation,"4") = 0.29;
p_technoFuelCons("spot27m","1",KTBL_mechanisation,"4") = 1.85;
*p_technoOtherCosts("spot27m","1",KTBL_mechanisation,"4") = 0.48;
p_technoTimeReq("spot27m","1",KTBL_mechanisation,"5") = 0.3;
p_technoFuelCons("spot27m","1",KTBL_mechanisation,"5") = 1.91;
*p_technoOtherCosts("spot27m","1",KTBL_mechanisation,"5") = 0.48;
p_technoTimeReq("spot27m","1",KTBL_mechanisation,"10") = 0.33;
p_technoFuelCons("spot27m","1",KTBL_mechanisation,"10") = 2.17;
*p_technoOtherCosts("spot27m","1",KTBL_mechanisation,"10") = 0.51;
p_technoTimeReq("spot27m","1",KTBL_mechanisation,"15") = 0.36;
p_technoFuelCons("spot27m","1",KTBL_mechanisation,"15") = 2.44;
*p_technoOtherCosts("spot27m","1",KTBL_mechanisation,"15") = 0.54;
p_technoTimeReq("spot27m","2",KTBL_mechanisation,"1") = 0.19;
p_technoFuelCons("spot27m","2",KTBL_mechanisation,"1") = 1.31;
*p_technoOtherCosts("spot27m","2",KTBL_mechanisation,"1") = 0.39;
p_technoTimeReq("spot27m","2",KTBL_mechanisation,"2") = 0.2;
p_technoFuelCons("spot27m","2",KTBL_mechanisation,"2") = 1.36;
*p_technoOtherCosts("spot27m","2",KTBL_mechanisation,"2") = 0.39;
p_technoTimeReq("spot27m","2",KTBL_mechanisation,"3") = 0.21;
p_technoFuelCons("spot27m","2",KTBL_mechanisation,"3") = 1.41;
*p_technoOtherCosts("spot27m","2",KTBL_mechanisation,"3") = 0.40;
p_technoTimeReq("spot27m","2",KTBL_mechanisation,"4") = 0.21;
p_technoFuelCons("spot27m","2",KTBL_mechanisation,"4") = 1.46;
*p_technoOtherCosts("spot27m","2",KTBL_mechanisation,"4") = 0.40;
p_technoTimeReq("spot27m","2",KTBL_mechanisation,"5") = 0.22;
p_technoFuelCons("spot27m","2",KTBL_mechanisation,"5") = 1.51;
*p_technoOtherCosts("spot27m","2",KTBL_mechanisation,"5") = 0.41;
p_technoTimeReq("spot27m","2",KTBL_mechanisation,"10") = 0.25;
p_technoFuelCons("spot27m","2",KTBL_mechanisation,"10") = 1.76;
*p_technoOtherCosts("spot27m","2",KTBL_mechanisation,"10") = 0.44;
p_technoTimeReq("spot27m","2",KTBL_mechanisation,"15") = 0.28;
p_technoFuelCons("spot27m","2",KTBL_mechanisation,"15") = 2.01;
*p_technoOtherCosts("spot27m","2",KTBL_mechanisation,"15") = 0.46;
p_technoTimeReq("spot27m","5",KTBL_mechanisation,"1") = 0.14;
p_technoFuelCons("spot27m","5",KTBL_mechanisation,"1") = 1.02;
*p_technoOtherCosts("spot27m","5",KTBL_mechanisation,"1") = 0.33;
p_technoTimeReq("spot27m","5",KTBL_mechanisation,"2") = 0.14;
p_technoFuelCons("spot27m","5",KTBL_mechanisation,"2") = 1.07;
*p_technoOtherCosts("spot27m","5",KTBL_mechanisation,"2") = 0.34;
p_technoTimeReq("spot27m","5",KTBL_mechanisation,"3") = 0.15;
p_technoFuelCons("spot27m","5",KTBL_mechanisation,"3") = 1.12;
*p_technoOtherCosts("spot27m","5",KTBL_mechanisation,"3") = 0.35;
p_technoTimeReq("spot27m","5",KTBL_mechanisation,"4") = 0.16;
p_technoFuelCons("spot27m","5",KTBL_mechanisation,"4") = 1.17;
*p_technoOtherCosts("spot27m","5",KTBL_mechanisation,"4") = 0.35;
p_technoTimeReq("spot27m","5",KTBL_mechanisation,"5") = 0.16;
p_technoFuelCons("spot27m","5",KTBL_mechanisation,"5") = 1.21;
*p_technoOtherCosts("spot27m","5",KTBL_mechanisation,"5") = 0.36;
p_technoTimeReq("spot27m","5",KTBL_mechanisation,"10") = 0.19;
p_technoFuelCons("spot27m","5",KTBL_mechanisation,"10") = 1.45;
*p_technoOtherCosts("spot27m","5",KTBL_mechanisation,"10") = 0.38;
p_technoTimeReq("spot27m","5",KTBL_mechanisation,"15") = 0.22;
p_technoFuelCons("spot27m","5",KTBL_mechanisation,"15") = 1.7;
*p_technoOtherCosts("spot27m","5",KTBL_mechanisation,"15") = 0.41;
p_technoTimeReq("spot27m","10",KTBL_mechanisation,"1") = 0.11;
p_technoFuelCons("spot27m","10",KTBL_mechanisation,"1") = 0.94;
*p_technoOtherCosts("spot27m","10",KTBL_mechanisation,"1") = 0.31;
p_technoTimeReq("spot27m","10",KTBL_mechanisation,"2") = 0.12;
p_technoFuelCons("spot27m","10",KTBL_mechanisation,"2") = 0.99;
*p_technoOtherCosts("spot27m","10",KTBL_mechanisation,"2") = 0.32;
p_technoTimeReq("spot27m","10",KTBL_mechanisation,"3") = 0.13;
p_technoFuelCons("spot27m","10",KTBL_mechanisation,"3") = 1.04;
*p_technoOtherCosts("spot27m","10",KTBL_mechanisation,"3") = 0.33;
p_technoTimeReq("spot27m","10",KTBL_mechanisation,"4") = 0.14;
p_technoFuelCons("spot27m","10",KTBL_mechanisation,"4") = 1.08;
*p_technoOtherCosts("spot27m","10",KTBL_mechanisation,"4") = 0.33;
p_technoTimeReq("spot27m","10",KTBL_mechanisation,"5") = 0.14;
p_technoFuelCons("spot27m","10",KTBL_mechanisation,"5") = 1.13;
*p_technoOtherCosts("spot27m","10",KTBL_mechanisation,"5") = 0.34;
p_technoTimeReq("spot27m","10",KTBL_mechanisation,"10") = 0.17;
p_technoFuelCons("spot27m","10",KTBL_mechanisation,"10") = 1.36;
*p_technoOtherCosts("spot27m","10",KTBL_mechanisation,"10") = 0.37;
p_technoTimeReq("spot27m","10",KTBL_mechanisation,"15") = 0.2;
p_technoFuelCons("spot27m","10",KTBL_mechanisation,"15") = 1.61;
*p_technoOtherCosts("spot27m","10",KTBL_mechanisation,"15") = 0.39;
p_technoTimeReq("spot27m","20",KTBL_mechanisation,"1") = 0.11;
p_technoFuelCons("spot27m","20",KTBL_mechanisation,"1") = 0.97;
*p_technoOtherCosts("spot27m","20",KTBL_mechanisation,"1") = 0.31;
p_technoTimeReq("spot27m","20",KTBL_mechanisation,"2") = 0.12;
p_technoFuelCons("spot27m","20",KTBL_mechanisation,"2") = 1.02;
*p_technoOtherCosts("spot27m","20",KTBL_mechanisation,"2") = 0.32;
p_technoTimeReq("spot27m","20",KTBL_mechanisation,"3") = 0.13;
p_technoFuelCons("spot27m","20",KTBL_mechanisation,"3") = 1.07;
*p_technoOtherCosts("spot27m","20",KTBL_mechanisation,"3") = 0.33;
p_technoTimeReq("spot27m","20",KTBL_mechanisation,"4") = 0.13;
p_technoFuelCons("spot27m","20",KTBL_mechanisation,"4") = 1.12;
*p_technoOtherCosts("spot27m","20",KTBL_mechanisation,"4") = 0.33;
p_technoTimeReq("spot27m","20",KTBL_mechanisation,"5") = 0.14;
p_technoFuelCons("spot27m","20",KTBL_mechanisation,"5") = 1.16;
*p_technoOtherCosts("spot27m","20",KTBL_mechanisation,"5") = 0.34;
p_technoTimeReq("spot27m","20",KTBL_mechanisation,"10") = 0.17;
p_technoFuelCons("spot27m","20",KTBL_mechanisation,"10") = 1.4;
*p_technoOtherCosts("spot27m","20",KTBL_mechanisation,"10") = 0.37;
p_technoTimeReq("spot27m","20",KTBL_mechanisation,"15") = 0.2;
p_technoFuelCons("spot27m","20",KTBL_mechanisation,"15") = 1.64;
*p_technoOtherCosts("spot27m","20",KTBL_mechanisation,"15") = 0.39;
p_technoTimeReq("spot27m","40",KTBL_mechanisation,"1") = 0.12;
p_technoFuelCons("spot27m","40",KTBL_mechanisation,"1") = 1;
*p_technoOtherCosts("spot27m","40",KTBL_mechanisation,"1") = 0.31;
p_technoTimeReq("spot27m","40",KTBL_mechanisation,"2") = 0.12;
p_technoFuelCons("spot27m","40",KTBL_mechanisation,"2") = 1.05;
*p_technoOtherCosts("spot27m","40",KTBL_mechanisation,"2") = 0.32;
p_technoTimeReq("spot27m","40",KTBL_mechanisation,"3") = 0.13;
p_technoFuelCons("spot27m","40",KTBL_mechanisation,"3") = 1.1;
*p_technoOtherCosts("spot27m","40",KTBL_mechanisation,"3") = 0.33;
p_technoTimeReq("spot27m","40",KTBL_mechanisation,"4") = 0.14;
p_technoFuelCons("spot27m","40",KTBL_mechanisation,"4") = 1.14;
*p_technoOtherCosts("spot27m","40",KTBL_mechanisation,"4") = 0.33;
p_technoTimeReq("spot27m","40",KTBL_mechanisation,"5") = 0.14;
p_technoFuelCons("spot27m","40",KTBL_mechanisation,"5") = 1.19;
*p_technoOtherCosts("spot27m","40",KTBL_mechanisation,"5") = 0.34;
p_technoTimeReq("spot27m","40",KTBL_mechanisation,"10") = 0.17;
p_technoFuelCons("spot27m","40",KTBL_mechanisation,"10") = 1.42;
*p_technoOtherCosts("spot27m","40",KTBL_mechanisation,"10") = 0.37;
p_technoTimeReq("spot27m","40",KTBL_mechanisation,"15") = 0.2;
p_technoFuelCons("spot27m","40",KTBL_mechanisation,"15") = 1.67;
*p_technoOtherCosts("spot27m","40",KTBL_mechanisation,"15") = 0.39;
p_technoTimeReq("spot27m","80",KTBL_mechanisation,"1") = 0.12;
p_technoFuelCons("spot27m","80",KTBL_mechanisation,"1") = 1.05;
*p_technoOtherCosts("spot27m","80",KTBL_mechanisation,"1") = 0.32;
p_technoTimeReq("spot27m","80",KTBL_mechanisation,"2") = 0.13;
p_technoFuelCons("spot27m","80",KTBL_mechanisation,"2") = 1.1;
*p_technoOtherCosts("spot27m","80",KTBL_mechanisation,"2") = 0.32;
p_technoTimeReq("spot27m","80",KTBL_mechanisation,"3") = 0.13;
p_technoFuelCons("spot27m","80",KTBL_mechanisation,"3") = 1.14;
*p_technoOtherCosts("spot27m","80",KTBL_mechanisation,"3") = 0.33;
p_technoTimeReq("spot27m","80",KTBL_mechanisation,"4") = 0.14;
p_technoFuelCons("spot27m","80",KTBL_mechanisation,"4") = 1.19;
*p_technoOtherCosts("spot27m","80",KTBL_mechanisation,"4") = 0.34;
p_technoTimeReq("spot27m","80",KTBL_mechanisation,"5") = 0.14;
p_technoFuelCons("spot27m","80",KTBL_mechanisation,"5") = 1.24;
*p_technoOtherCosts("spot27m","80",KTBL_mechanisation,"5") = 0.34;
p_technoTimeReq("spot27m","80",KTBL_mechanisation,"10") = 0.17;
p_technoFuelCons("spot27m","80",KTBL_mechanisation,"10") = 1.47;
*p_technoOtherCosts("spot27m","80",KTBL_mechanisation,"10") = 0.37;
p_technoTimeReq("spot27m","80",KTBL_mechanisation,"15") = 0.2;
p_technoFuelCons("spot27m","80",KTBL_mechanisation,"15") = 1.72;
*p_technoOtherCosts("spot27m","80",KTBL_mechanisation,"15") = 0.40;
p_technoMaintenance("spot27m","1",KTBL_mechanisation,"1") = 2.61;
p_technoMaintenance("spot27m","1",KTBL_mechanisation,"2") = 2.66;
p_technoMaintenance("spot27m","1",KTBL_mechanisation,"3") = 2.72;
p_technoMaintenance("spot27m","1",KTBL_mechanisation,"4") = 2.76;
p_technoMaintenance("spot27m","1",KTBL_mechanisation,"5") = 2.81;
p_technoMaintenance("spot27m","1",KTBL_mechanisation,"10") = 3.03;
p_technoMaintenance("spot27m","1",KTBL_mechanisation,"15") = 3.25;
p_technoMaintenance("spot27m","2",KTBL_mechanisation,"1") = 2.02;
p_technoMaintenance("spot27m","2",KTBL_mechanisation,"2") = 2.07;
p_technoMaintenance("spot27m","2",KTBL_mechanisation,"3") = 2.12;
p_technoMaintenance("spot27m","2",KTBL_mechanisation,"4") = 2.17;
p_technoMaintenance("spot27m","2",KTBL_mechanisation,"5") = 2.22;
p_technoMaintenance("spot27m","2",KTBL_mechanisation,"10") = 2.44;
p_technoMaintenance("spot27m","2",KTBL_mechanisation,"15") = 2.66;
p_technoMaintenance("spot27m","5",KTBL_mechanisation,"1") = 1.6;
p_technoMaintenance("spot27m","5",KTBL_mechanisation,"2") = 1.66;
p_technoMaintenance("spot27m","5",KTBL_mechanisation,"3") = 1.7;
p_technoMaintenance("spot27m","5",KTBL_mechanisation,"4") = 1.75;
p_technoMaintenance("spot27m","5",KTBL_mechanisation,"5") = 1.79;
p_technoMaintenance("spot27m","5",KTBL_mechanisation,"10") = 2.01;
p_technoMaintenance("spot27m","5",KTBL_mechanisation,"15") = 2.23;
p_technoMaintenance("spot27m","10",KTBL_mechanisation,"1") = 1.44;
p_technoMaintenance("spot27m","10",KTBL_mechanisation,"2") = 1.5;
p_technoMaintenance("spot27m","10",KTBL_mechanisation,"3") = 1.54;
p_technoMaintenance("spot27m","10",KTBL_mechanisation,"4") = 1.59;
p_technoMaintenance("spot27m","10",KTBL_mechanisation,"5") = 1.63;
p_technoMaintenance("spot27m","10",KTBL_mechanisation,"10") = 1.86;
p_technoMaintenance("spot27m","10",KTBL_mechanisation,"15") = 2.08;
p_technoMaintenance("spot27m","20",KTBL_mechanisation,"1") = 1.44;
p_technoMaintenance("spot27m","20",KTBL_mechanisation,"2") = 1.5;
p_technoMaintenance("spot27m","20",KTBL_mechanisation,"3") = 1.54;
p_technoMaintenance("spot27m","20",KTBL_mechanisation,"4") = 1.59;
p_technoMaintenance("spot27m","20",KTBL_mechanisation,"5") = 1.63;
p_technoMaintenance("spot27m","20",KTBL_mechanisation,"10") = 1.86;
p_technoMaintenance("spot27m","20",KTBL_mechanisation,"15") = 2.08;
p_technoMaintenance("spot27m","40",KTBL_mechanisation,"1") = 1.45;
p_technoMaintenance("spot27m","40",KTBL_mechanisation,"2") = 1.5;
p_technoMaintenance("spot27m","40",KTBL_mechanisation,"3") = 1.55;
p_technoMaintenance("spot27m","40",KTBL_mechanisation,"4") = 1.6;
p_technoMaintenance("spot27m","40",KTBL_mechanisation,"5") = 1.64;
p_technoMaintenance("spot27m","40",KTBL_mechanisation,"10") = 1.86;
p_technoMaintenance("spot27m","40",KTBL_mechanisation,"15") = 2.08;
p_technoMaintenance("spot27m","80",KTBL_mechanisation,"1") = 1.47;
p_technoMaintenance("spot27m","80",KTBL_mechanisation,"2") = 1.52;
p_technoMaintenance("spot27m","80",KTBL_mechanisation,"3") = 1.57;
p_technoMaintenance("spot27m","80",KTBL_mechanisation,"4") = 1.62;
p_technoMaintenance("spot27m","80",KTBL_mechanisation,"5") = 1.66;
p_technoMaintenance("spot27m","80",KTBL_mechanisation,"10") = 1.88;
p_technoMaintenance("spot27m","80",KTBL_mechanisation,"15") = 2.11;

*reason for the formula is, that the data for other costs is drawn from KTBL makost (17.05.2024)
*and it is assumed here that costs for maintenance and the other costs are proportionally higher according to the value of the technology
p_technoMaintenance("spot27m",KTBL_size,KTBL_mechanisation,KTBL_distance) = 
    p_technoMaintenance("spot27m","1",KTBL_mechanisation,"1")
    * (p_technoValue("spot27m",KTBL_mechanisation)/54300)
;

p_technoMaintenance("spot6m",KTBL_size,KTBL_mechanisation,KTBL_distance) =
    p_technoMaintenance("spot27m",KTBL_size,KTBL_mechanisation,KTBL_distance)
    * (p_technoValue("spot6m",KTBL_mechanisation) / p_technoValue("spot27m",KTBL_mechanisation))
;

$ontext
p_technoOtherCosts("spot27m",KTBL_size,KTBL_mechanisation,KTBL_distance) = 
    p_technoOtherCosts("spot27m",KTBL_size,KTBL_mechanisation,KTBL_distance)
    * (p_technoValue("spot27m")/54300)
;

p_technoOtherCosts("spot6m",KTBL_size,KTBL_mechanisation,KTBL_distance) =
    p_technoOtherCosts("spot27m",KTBL_size,KTBL_mechanisation,KTBL_distance)
    * (p_technoValue("spot6m") / p_technoValue("spot27m"))
;
$offtext

$ontext
p_technoTimeReq("spot6m",'1',KTBL_mechanisation,"1") = 0.43;
p_technoTimeReq("spot6m",'1',KTBL_mechanisation,"2") = 0.43;
p_technoTimeReq("spot6m",'1',KTBL_mechanisation,"3") = 0.44;
p_technoTimeReq("spot6m",'1',KTBL_mechanisation,"4") = 0.44;
p_technoTimeReq("spot6m",'1',KTBL_mechanisation,"5") = 0.44;
p_technoTimeReq("spot6m",'1',KTBL_mechanisation,"10") = 0.47;
p_technoTimeReq("spot6m",'1',KTBL_mechanisation,"15") = 0.49;
p_technoTimeReq("spot6m",'2',KTBL_mechanisation,"1") = 0.31;
p_technoTimeReq("spot6m",'2',KTBL_mechanisation,"2") = 0.32;
p_technoTimeReq("spot6m",'2',KTBL_mechanisation,"3") = 0.32;
p_technoTimeReq("spot6m",'2',KTBL_mechanisation,"4") = 0.32;
p_technoTimeReq("spot6m",'2',KTBL_mechanisation,"5") = 0.32;
p_technoTimeReq("spot6m",'2',KTBL_mechanisation,"10") = 0.34;
p_technoTimeReq("spot6m",'2',KTBL_mechanisation,"15") = 0.36;
p_technoTimeReq("spot6m",'5',KTBL_mechanisation,"1") = 0.24;
p_technoTimeReq("spot6m",'5',KTBL_mechanisation,"2") = ;
p_technoTimeReq("spot6m",'5',KTBL_mechanisation,"3") = ;
p_technoTimeReq("spot6m",'5',KTBL_mechanisation,"4") = ;
p_technoTimeReq("spot6m",'5',KTBL_mechanisation,"5") = ;
p_technoTimeReq("spot6m",'5',KTBL_mechanisation,"10") = ;
p_technoTimeReq("spot6m",'5',KTBL_mechanisation,"15") = ;
p_technoTimeReq("spot6m",'10',KTBL_mechanisation,"1") = ;
p_technoTimeReq("spot6m",'10',KTBL_mechanisation,"2") = ;
p_technoTimeReq("spot6m",'10',KTBL_mechanisation,"3") = ;
p_technoTimeReq("spot6m",'10',KTBL_mechanisation,"4") = ;
p_technoTimeReq("spot6m",'10',KTBL_mechanisation,"5") = ;
p_technoTimeReq("spot6m",'10',KTBL_mechanisation,"10") = ;
p_technoTimeReq("spot6m",'10',KTBL_mechanisation,"15") = ;
p_technoTimeReq("spot6m",'20',KTBL_mechanisation,"1") = ;
p_technoTimeReq("spot6m",'20',KTBL_mechanisation,"2") = ;
p_technoTimeReq("spot6m",'20',KTBL_mechanisation,"3") = ;
p_technoTimeReq("spot6m",'20',KTBL_mechanisation,"4") = ;
p_technoTimeReq("spot6m",'20',KTBL_mechanisation,"5") = ;
p_technoTimeReq("spot6m",'20',KTBL_mechanisation,"10") = ;
p_technoTimeReq("spot6m",'20',KTBL_mechanisation,"15") = ;
p_technoTimeReq("spot6m",'40',KTBL_mechanisation,"1") = ;
p_technoTimeReq("spot6m",'40',KTBL_mechanisation,"2") = ;
p_technoTimeReq("spot6m",'40',KTBL_mechanisation,"3") = ;
p_technoTimeReq("spot6m",'40',KTBL_mechanisation,"4") = ;
p_technoTimeReq("spot6m",'40',KTBL_mechanisation,"5") = ;
p_technoTimeReq("spot6m",'40',KTBL_mechanisation,"10") = ;
p_technoTimeReq("spot6m",'40',KTBL_mechanisation,"15") = ;
p_technoTimeReq("spot6m",'80',KTBL_mechanisation,"1") = ;
p_technoTimeReq("spot6m",'80',KTBL_mechanisation,"2") = ;
p_technoTimeReq("spot6m",'80',KTBL_mechanisation,"3") = ;
p_technoTimeReq("spot6m",'80',KTBL_mechanisation,"4") = ;
p_technoTimeReq("spot6m",'80',KTBL_mechanisation,"5") = ;
p_technoTimeReq("spot6m",'80',KTBL_mechanisation,"10") = ;
p_technoTimeReq("spot6m",'80',KTBL_mechanisation,"15") = ;
$offtext






$ontext
*
*  --- Set and parameter introduction for later technology evaluation
*
set technology /spot6m, spot27m, spotRobot/;
set technoAttr / value, eff, areaCapac, fieldTime, varMachCostsPestiRedFactor /;
*field time in ha/h
*
*
*
parameter p_technoProp(technology,technoAttr);

*
*  --- Technology 1: Broadcast Sprayer with flat rate application 
*




parameter p_technoEff(technology,technoAttr,pestType);
p_technoData("eff",pestType) = 0;
$offtext

*with spot27m always same number of passes as with BA
parameter p_numberSprayPassesLWKScenarios(LWK_crops,LWK_yield,technology,scenario,scenSprayer) /
*
* --- Baseline scenario
*
'Winterweizen'.'< 70 dt/ha'."BA"."Base"."BA" 4
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."BA"."Base"."BA" 6
*'Winterweizen'.'> 70 dt/ha Ackerfuchsschwanz, Weidelgrasstand.'."BA"."Base"."BA" 7
'Wintergerste'.'< 70 dt/ha'."BA"."Base"."BA" 4
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."BA"."Base"."BA" 5
*'Wintergerste'.'> 70 dt/ha Ackerfuchsschwanz, Weidelgrasstand.'."BA"."Base"."BA" 5
'Winterroggen & Triticale'.'> 60 dt/ha'."BA"."Base"."BA" 5
'Winterroggen & Triticale'.'< 60 dt/ha'."BA"."Base"."BA" 4
'Raps'.'alle Ertragsklassen'."BA"."Base"."BA" 5
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."BA"."Base"."BA" 12
'Zuckerrüben'.'alle Ertragsklassen'."BA"."Base"."BA" 6
'Mais'.'alle Ertragsklassen'."BA"."Base"."BA" 2
'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."BA"."Base"."BA" 0.5
*
* --- S-S of Foliar-active herbicides, remaining applications with BA sprayer
*
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH"."spot6m" 2
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH"."BA" 3
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH"."spot27m" 2
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH"."BA" 2
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."spot6m" 3
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."BA" 5
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m" 3
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."BA" 3
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH"."spot6m" 1
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH"."BA" 3
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH"."spot27m" 1
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH"."BA" 3
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."spot6m" 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH"."BA" 4
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."spot27m" 2
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH"."BA" 3
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH"."spot6m" 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH"."BA" 4
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH"."spot27m" 2
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH"."BA" 3
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH"."spot6m" 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH"."BA" 3
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH"."spot27m" 1
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH"."BA" 3
'Raps'.'alle Ertragsklassen'."spot6m"."FH"."spot6m" 1
'Raps'.'alle Ertragsklassen'."spot6m"."FH"."BA" 4
'Raps'.'alle Ertragsklassen'."spot27m"."FH"."spot27m" 1
'Raps'.'alle Ertragsklassen'."spot27m"."FH"."BA" 4
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH"."spot6m" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH"."BA" 12
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH"."spot27m" 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH"."BA" 11
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH"."spot6m" 3
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH"."BA" 3
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH"."spot27m" 3
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH"."BA" 3
'Mais'.'alle Ertragsklassen'."spot6m"."FH"."spot6m" 2
'Mais'.'alle Ertragsklassen'."spot27m"."FH"."spot27m" 2
'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot6m"."FH"."spot6m" 0.5
'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot6m"."FH"."BA" 0
'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot27m"."FH"."spot27m" 0.5
'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot27m"."FH"."BA" 0
*
* --- S-S of Foliar-active herbicides, all remaining applications with SST in BA
*
'Winterweizen'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m" 5
'Winterweizen'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m" 4
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m" 8
'Winterweizen'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m" 6
'Wintergerste'.'< 70 dt/ha'."spot6m"."FH+BA"."spot6m" 4
'Wintergerste'.'< 70 dt/ha'."spot27m"."FH+BA"."spot27m" 4
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m" 7
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot27m"."FH+BA"."spot27m" 5
'Winterroggen & Triticale'.'> 60 dt/ha'."spot6m"."FH+BA"."spot6m" 7
'Winterroggen & Triticale'.'> 60 dt/ha'."spot27m"."FH+BA"."spot27m" 5
'Winterroggen & Triticale'.'< 60 dt/ha'."spot6m"."FH+BA"."spot6m" 4
'Winterroggen & Triticale'.'< 60 dt/ha'."spot27m"."FH+BA"."spot27m" 4
'Raps'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m" 6
'Raps'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m" 5
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m" 13
'Speise & Industriekartoffeln'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m" 12
'Zuckerrüben'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m" 6
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m" 6
'Mais'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m" 2
'Mais'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m" 2
'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m" 0.5
'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m" 0.5
/;

*
* --- Linking LWK spray sequence data with KTBL data
*
parameter p_numberSprayPassesScenarios(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer);

p_numberSprayPassesScenarios(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer) =
    sum((LWK_crops,LWK_yield),
    p_numberSprayPassesLWKScenarios(LWK_crops,LWK_yield,technology,scenario,scenSprayer)
    * p_lwkCrops_lwkYield_ktblYield(LWK_crops,LWK_yield,KTBL_yield)
    * p_ktblCrops_lwkCrops(KTBL_crops,LWK_crops)
    )
;

option p_numberSprayPassesScenarios:1:3:2 display p_numberSprayPassesScenarios;

*
* --- Parameter definition to ensure that technologies are selected which are linked to the
*   scenario chosen
parameter p_technology_scenario(technology,scenario) /
"BA"."Base" 1
"spot6m"."FH" 1
"spot27m"."FH" 1
"spot6m"."FH+BA" 1
"spot27m"."FH+BA" 1
/;

parameter p_scenario_scenSprayer(scenario,scenSprayer) /
"Base"."BA" 1
"FH"."BA" 1
"FH"."spot6m" 1
"FH"."spot27m" 1
"FH+BA"."spot6m" 1
"FH+BA"."spot27m" 1
/;

parameter p_technology_scenario_scenSprayer(technology,scenario,scenSprayer) /
"BA"."Base"."BA" 1
"spot6m"."FH"."spot6m" 1
"spot6m"."FH"."BA" 1
"spot27m"."FH"."spot27m" 1
"spot27m"."FH"."BA" 1
"spot6m"."FH+BA"."spot6m" 1
"spot27m"."FH+BA"."spot27m" 1
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
'Wintergerste'.'> 70 dt/ha Windhalmstandort'."spot6m"."FH+BA"."spot6m"."APR2" 2
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
'Raps'.'alle Ertragsklassen'."spot6m"."FH+BA"."spot6m"."APR2" 2
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
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."BA"."MAI1" 1
*Blattherbizid 3
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."MAI2" 1
*Fungizid 1
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."BA"."JUL2" 1
*Fungizid 2
'Zuckerrüben'.'alle Ertragsklassen'."spot27m"."FH+BA"."BA"."AUG1" 1

*Blattherbizid 1
'Mais'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."APR2" 1
*Blattherbizid 2
'Mais'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."MAI1" 1

'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'."spot27m"."FH+BA"."spot27m"."AUG1" 0.5
/;

parameter p_datePestOpTechno(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer,halfMonth);

p_datePestOpTechno(KTBL_crops,KTBL_yield,technology,scenario,scenSprayer,halfMonth) =
    sum((LWK_crops,LWK_yield),
    p_datePestOpTechnoLWK_(LWK_crops,LWK_yield,technology,scenario,scenSprayer,halfMonth)
    * p_lwkCrops_lwkYield_ktblYield(LWK_crops,LWK_yield,KTBL_yield)
    * p_ktblCrops_lwkCrops(KTBL_crops,LWK_crops)
    )
;
