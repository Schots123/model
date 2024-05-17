

set technology /spot6m, spot27m/;

*parameters for fix costs
parameters
    p_technoPestEff(technology,pestType) pesticide savings due to technology utilization for each type 
    p_technoValue(technology) / spot6m 130000, spot27m 207000/
    p_technoRemValue(technology)
    p_technoLifetime(technology)
    p_technoAreaCapac(technology)
    p_technoAnnualCapac(technology)
;

p_technoPestEff("spot6m","preHerb") = 0;
p_technoPestEff(technology,"postHerb") = 0.9;
p_technoPestEff("spot6m","fung") = 0;
p_technoPestEff("spot6m","insect") = 0;
p_technoPestEff("spot6m","growthReg") = 0;
p_technoPestEff("spot6m","haulmDest") = 0;

*source: makost KTBL 17.05.2024 Standartwert Spritze 
p_technoLifetime("spot6m") = 10;
p_technoLifetime("spot27m") = 10;

*source: makost KTBL 17.05.2024 1/2 * Einsatzumfang 12m Spritze
p_technoAnnualCapac("spot6m") = 240;
*source: makost KTBL 17.05.2024 Arbeitsbreite 27m Spritze
p_technoAnnualCapac("spot27m") = 1080;

*standard KTBL procedure
p_technoAreaCapac(technology) = p_technoLifetime(technology) * p_technoAnnualCapac(technology);

*standard ktbl procedure
p_technoRemValue(technology) = p_technoValue(technology) * 0.2;

*
*  --- parameters for time requirements, other costs and variable costs 
*
parameters
    p_technoTimeReq(technology,KTBL_size,curMechan,KTBL_distance)
    p_technoFuelCons(technology,KTBL_size,curMechan,KTBL_distance)
    p_technoMaintenance(technology,KTBL_size,curMechan,KTBL_distance)
    p_technoOtherCosts(technology,KTBL_size,curMechan,KTBL_distance)
;

p_technoTimeReq("spot6m",KTBL_size,curMechan,KTBL_distance) = 0.25;
*sprayer is reportedly able to spray between 2.5 and 4 ha in an hour


p_technoFuelCons("spot6m","1",curMechan,"1") = 2.71;
p_technoFuelCons("spot6m","1",curMechan,"2") = 2.83;
p_technoFuelCons("spot6m","1",curMechan,"3") = 2.85;
p_technoFuelCons("spot6m","1",curMechan,"4") = 2.87;
p_technoFuelCons("spot6m","1",curMechan,"5") = 2.89;
p_technoFuelCons("spot6m","1",curMechan,"10") = 3.01;
p_technoFuelCons("spot6m","1",curMechan,"15") = 3.11;
p_technoFuelCons("spot6m","2",curMechan,"1") = 2.28;
p_technoFuelCons("spot6m","2",curMechan,"2") = 2.37;
p_technoFuelCons("spot6m","2",curMechan,"3") = 2.38;
p_technoFuelCons("spot6m","2",curMechan,"4") = 2.4;
p_technoFuelCons("spot6m","2",curMechan,"5") = 2.41;
p_technoFuelCons("spot6m","2",curMechan,"10") = 2.5;
p_technoFuelCons("spot6m","2",curMechan,"15") = 2.57;
p_technoFuelCons("spot6m","5",curMechan,"1") = 2.04;
p_technoFuelCons("spot6m","5",curMechan,"2") = 2.09;
p_technoFuelCons("spot6m","5",curMechan,"3") = 2.1;
p_technoFuelCons("spot6m","5",curMechan,"4") = 2.11;
p_technoFuelCons("spot6m","5",curMechan,"5") = 2.12;
p_technoFuelCons("spot6m","5",curMechan,"10") = 2.18;
p_technoFuelCons("spot6m","5",curMechan,"15") = 2.23;
p_technoFuelCons("spot6m","10",curMechan,"1") = 1.92;
p_technoFuelCons("spot6m","10",curMechan,"2") = 1.96;
p_technoFuelCons("spot6m","10",curMechan,"3") = 1.97;
p_technoFuelCons("spot6m","10",curMechan,"4") = 1.98;
p_technoFuelCons("spot6m","10",curMechan,"5") = 1.99;
p_technoFuelCons("spot6m","10",curMechan,"10") = 2.03;
p_technoFuelCons("spot6m","10",curMechan,"15") = 2.08;
p_technoFuelCons("spot6m","20",curMechan,"1") = 1.85;
p_technoFuelCons("spot6m","20",curMechan,"2") = 1.87;
p_technoFuelCons("spot6m","20",curMechan,"3") = 1.88;
p_technoFuelCons("spot6m","20",curMechan,"4") = 1.89;
p_technoFuelCons("spot6m","20",curMechan,"5") = 1.89;
p_technoFuelCons("spot6m","20",curMechan,"10") = 1.93;
p_technoFuelCons("spot6m","20",curMechan,"15") = 1.96;
p_technoFuelCons("spot6m","40",curMechan,"1") = 1.83;
p_technoFuelCons("spot6m","40",curMechan,"2") = 1.85;
p_technoFuelCons("spot6m","40",curMechan,"3") = 1.86;
p_technoFuelCons("spot6m","40",curMechan,"4") = 1.87;
p_technoFuelCons("spot6m","40",curMechan,"5") = 1.88;
p_technoFuelCons("spot6m","40",curMechan,"10") = 1.93;
p_technoFuelCons("spot6m","40",curMechan,"15") = 1.98;
p_technoFuelCons("spot6m","80",curMechan,"1") = 1.82;
p_technoFuelCons("spot6m","80",curMechan,"2") = 1.84;
p_technoFuelCons("spot6m","80",curMechan,"3") = 1.85;
p_technoFuelCons("spot6m","80",curMechan,"4") = 1.86;
p_technoFuelCons("spot6m","80",curMechan,"5") = 1.87;
p_technoFuelCons("spot6m","80",curMechan,"10") = 1.91;
p_technoFuelCons("spot6m","80",curMechan,"15") = 1.97;

*assumption: 27m, 3.000 l; 83 kW (KTBL Feldarbeitsrechner) -> 17.05.2024, 300 l/ha
p_technoTimeReq("spot27m","1",curMechan,"1") = 0.27;
p_technoFuelCons("spot27m","1",curMechan,"1") = 1.69;
p_technoOtherCosts("spot27m","1",curMechan,"1") = 0.46;
p_technoTimeReq("spot27m","1",curMechan,"2") = 0.28;
p_technoFuelCons("spot27m","1",curMechan,"2") = 1.75;
p_technoOtherCosts("spot27m","1",curMechan,"2") = 0.47;
p_technoTimeReq("spot27m","1",curMechan,"3") = 0.28;
p_technoFuelCons("spot27m","1",curMechan,"3") = 1.8;
p_technoOtherCosts("spot27m","1",curMechan,"3") = 0.47;
p_technoTimeReq("spot27m","1",curMechan,"4") = 0.29;
p_technoFuelCons("spot27m","1",curMechan,"4") = 1.85;
p_technoOtherCosts("spot27m","1",curMechan,"4") = 0.48;
p_technoTimeReq("spot27m","1",curMechan,"5") = 0.3;
p_technoFuelCons("spot27m","1",curMechan,"5") = 1.91;
p_technoOtherCosts("spot27m","1",curMechan,"5") = 0.48;
p_technoTimeReq("spot27m","1",curMechan,"10") = 0.33;
p_technoFuelCons("spot27m","1",curMechan,"10") = 2.17;
p_technoOtherCosts("spot27m","1",curMechan,"10") = 0.51;
p_technoTimeReq("spot27m","1",curMechan,"15") = 0.36;
p_technoFuelCons("spot27m","1",curMechan,"15") = 2.44;
p_technoOtherCosts("spot27m","1",curMechan,"15") = 0.54;
p_technoTimeReq("spot27m","2",curMechan,"1") = 0.19;
p_technoFuelCons("spot27m","2",curMechan,"1") = 1.31;
p_technoOtherCosts("spot27m","2",curMechan,"1") = 0.39;
p_technoTimeReq("spot27m","2",curMechan,"2") = 0.2;
p_technoFuelCons("spot27m","2",curMechan,"2") = 1.36;
p_technoOtherCosts("spot27m","2",curMechan,"2") = 0.39;
p_technoTimeReq("spot27m","2",curMechan,"3") = 0.21;
p_technoFuelCons("spot27m","2",curMechan,"3") = 1.41;
p_technoOtherCosts("spot27m","2",curMechan,"3") = 0.40;
p_technoTimeReq("spot27m","2",curMechan,"4") = 0.21;
p_technoFuelCons("spot27m","2",curMechan,"4") = 1.46;
p_technoOtherCosts("spot27m","2",curMechan,"4") = 0.40;
p_technoTimeReq("spot27m","2",curMechan,"5") = 0.22;
p_technoFuelCons("spot27m","2",curMechan,"5") = 1.51;
p_technoOtherCosts("spot27m","2",curMechan,"5") = 0.41;
p_technoTimeReq("spot27m","2",curMechan,"10") = 0.25;
p_technoFuelCons("spot27m","2",curMechan,"10") = 1.76;
p_technoOtherCosts("spot27m","2",curMechan,"10") = 0.44;
p_technoTimeReq("spot27m","2",curMechan,"15") = 0.28;
p_technoFuelCons("spot27m","2",curMechan,"15") = 2.01;
p_technoOtherCosts("spot27m","2",curMechan,"15") = 0.46;
p_technoTimeReq("spot27m","5",curMechan,"1") = 0.14;
p_technoFuelCons("spot27m","5",curMechan,"1") = 1.02;
p_technoOtherCosts("spot27m","5",curMechan,"1") = 0.33;
p_technoTimeReq("spot27m","5",curMechan,"2") = 0.14;
p_technoFuelCons("spot27m","5",curMechan,"2") = 1.07;
p_technoOtherCosts("spot27m","5",curMechan,"2") = 0.34;
p_technoTimeReq("spot27m","5",curMechan,"3") = 0.15;
p_technoFuelCons("spot27m","5",curMechan,"3") = 1.12;
p_technoOtherCosts("spot27m","5",curMechan,"3") = 0.35;
p_technoTimeReq("spot27m","5",curMechan,"4") = 0.16;
p_technoFuelCons("spot27m","5",curMechan,"4") = 1.17;
p_technoOtherCosts("spot27m","5",curMechan,"4") = 0.35;
p_technoTimeReq("spot27m","5",curMechan,"5") = 0.16;
p_technoFuelCons("spot27m","5",curMechan,"5") = 1.21;
p_technoOtherCosts("spot27m","5",curMechan,"5") = 0.36;
p_technoTimeReq("spot27m","5",curMechan,"10") = 0.19;
p_technoFuelCons("spot27m","5",curMechan,"10") = 1.45;
p_technoOtherCosts("spot27m","5",curMechan,"10") = 0.38;
p_technoTimeReq("spot27m","5",curMechan,"15") = 0.22;
p_technoFuelCons("spot27m","5",curMechan,"15") = 1.7;
p_technoOtherCosts("spot27m","5",curMechan,"15") = 0.41;
p_technoTimeReq("spot27m","10",curMechan,"1") = 0.11;
p_technoFuelCons("spot27m","10",curMechan,"1") = 0.94;
p_technoOtherCosts("spot27m","10",curMechan,"1") = 0.31;
p_technoTimeReq("spot27m","10",curMechan,"2") = 0.12;
p_technoFuelCons("spot27m","10",curMechan,"2") = 0.99;
p_technoOtherCosts("spot27m","10",curMechan,"2") = 0.32;
p_technoTimeReq("spot27m","10",curMechan,"3") = 0.13;
p_technoFuelCons("spot27m","10",curMechan,"3") = 1.04;
p_technoOtherCosts("spot27m","10",curMechan,"3") = 0.33;
p_technoTimeReq("spot27m","10",curMechan,"4") = 0.14;
p_technoFuelCons("spot27m","10",curMechan,"4") = 1.08;
p_technoOtherCosts("spot27m","10",curMechan,"4") = 0.33;
p_technoTimeReq("spot27m","10",curMechan,"5") = 0.14;
p_technoFuelCons("spot27m","10",curMechan,"5") = 1.13;
p_technoOtherCosts("spot27m","10",curMechan,"5") = 0.34;
p_technoTimeReq("spot27m","10",curMechan,"10") = 0.17;
p_technoFuelCons("spot27m","10",curMechan,"10") = 1.36;
p_technoOtherCosts("spot27m","10",curMechan,"10") = 0.37;
p_technoTimeReq("spot27m","10",curMechan,"15") = 0.2;
p_technoFuelCons("spot27m","10",curMechan,"15") = 1.61;
p_technoOtherCosts("spot27m","10",curMechan,"15") = 0.39;
p_technoTimeReq("spot27m","20",curMechan,"1") = 0.11;
p_technoFuelCons("spot27m","20",curMechan,"1") = 0.97;
p_technoOtherCosts("spot27m","20",curMechan,"1") = 0.31;
p_technoTimeReq("spot27m","20",curMechan,"2") = 0.12;
p_technoFuelCons("spot27m","20",curMechan,"2") = 1.02;
p_technoOtherCosts("spot27m","20",curMechan,"2") = 0.32;
p_technoTimeReq("spot27m","20",curMechan,"3") = 0.13;
p_technoFuelCons("spot27m","20",curMechan,"3") = 1.07;
p_technoOtherCosts("spot27m","20",curMechan,"3") = 0.33;
p_technoTimeReq("spot27m","20",curMechan,"4") = 0.13;
p_technoFuelCons("spot27m","20",curMechan,"4") = 1.12;
p_technoOtherCosts("spot27m","20",curMechan,"4") = 0.33;
p_technoTimeReq("spot27m","20",curMechan,"5") = 0.14;
p_technoFuelCons("spot27m","20",curMechan,"5") = 1.16;
p_technoOtherCosts("spot27m","20",curMechan,"5") = 0.34;
p_technoTimeReq("spot27m","20",curMechan,"10") = 0.17;
p_technoFuelCons("spot27m","20",curMechan,"10") = 1.4;
p_technoOtherCosts("spot27m","20",curMechan,"10") = 0.37;
p_technoTimeReq("spot27m","20",curMechan,"15") = 0.2;
p_technoFuelCons("spot27m","20",curMechan,"15") = 1.64;
p_technoOtherCosts("spot27m","20",curMechan,"15") = 0.39;
p_technoTimeReq("spot27m","40",curMechan,"1") = 0.12;
p_technoFuelCons("spot27m","40",curMechan,"1") = 1;
p_technoOtherCosts("spot27m","40",curMechan,"1") = 0.31;
p_technoTimeReq("spot27m","40",curMechan,"2") = 0.12;
p_technoFuelCons("spot27m","40",curMechan,"2") = 1.05;
p_technoOtherCosts("spot27m","40",curMechan,"2") = 0.32;
p_technoTimeReq("spot27m","40",curMechan,"3") = 0.13;
p_technoFuelCons("spot27m","40",curMechan,"3") = 1.1;
p_technoOtherCosts("spot27m","40",curMechan,"3") = 0.33;
p_technoTimeReq("spot27m","40",curMechan,"4") = 0.14;
p_technoFuelCons("spot27m","40",curMechan,"4") = 1.14;
p_technoOtherCosts("spot27m","40",curMechan,"4") = 0.33;
p_technoTimeReq("spot27m","40",curMechan,"5") = 0.14;
p_technoFuelCons("spot27m","40",curMechan,"5") = 1.19;
p_technoOtherCosts("spot27m","40",curMechan,"5") = 0.34;
p_technoTimeReq("spot27m","40",curMechan,"10") = 0.17;
p_technoFuelCons("spot27m","40",curMechan,"10") = 1.42;
p_technoOtherCosts("spot27m","40",curMechan,"10") = 0.37;
p_technoTimeReq("spot27m","40",curMechan,"15") = 0.2;
p_technoFuelCons("spot27m","40",curMechan,"15") = 1.67;
p_technoOtherCosts("spot27m","40",curMechan,"15") = 0.39;
p_technoTimeReq("spot27m","80",curMechan,"1") = 0.12;
p_technoFuelCons("spot27m","80",curMechan,"1") = 1.05;
p_technoOtherCosts("spot27m","80",curMechan,"1") = 0.32;
p_technoTimeReq("spot27m","80",curMechan,"2") = 0.13;
p_technoFuelCons("spot27m","80",curMechan,"2") = 1.1;
p_technoOtherCosts("spot27m","80",curMechan,"2") = 0.32;
p_technoTimeReq("spot27m","80",curMechan,"3") = 0.13;
p_technoFuelCons("spot27m","80",curMechan,"3") = 1.14;
p_technoOtherCosts("spot27m","80",curMechan,"3") = 0.33;
p_technoTimeReq("spot27m","80",curMechan,"4") = 0.14;
p_technoFuelCons("spot27m","80",curMechan,"4") = 1.19;
p_technoOtherCosts("spot27m","80",curMechan,"4") = 0.34;
p_technoTimeReq("spot27m","80",curMechan,"5") = 0.14;
p_technoFuelCons("spot27m","80",curMechan,"5") = 1.24;
p_technoOtherCosts("spot27m","80",curMechan,"5") = 0.34;
p_technoTimeReq("spot27m","80",curMechan,"10") = 0.17;
p_technoFuelCons("spot27m","80",curMechan,"10") = 1.47;
p_technoOtherCosts("spot27m","80",curMechan,"10") = 0.37;
p_technoTimeReq("spot27m","80",curMechan,"15") = 0.2;
p_technoFuelCons("spot27m","80",curMechan,"15") = 1.72;
p_technoOtherCosts("spot27m","80",curMechan,"15") = 0.40;

p_technoOtherCosts("spot27m",KTBL_size,curMechan,KTBL_distance) = 
    p_technoOtherCosts("spot27m",KTBL_size,curMechan,KTBL_distance)
    * (p_technoValue("spot27m")/54300)
;
*reason for the formula is, that the data for other costs is drawn from KTBL makost (17.05.2024)
*and it is assumed here that the other costs are proportionally higher according to the value of the technology

p_technoOtherCosts("spot6m",KTBL_size,curMechan,KTBL_distance) =
    p_technoOtherCosts("spot27m",KTBL_size,curMechan,KTBL_distance)
    / p_technoValue("spot27m") 
    * p_technoValue("spot6m") 
;

p_technoMaintenance("spot27m","1",curMechan,"1") = 2.61;
p_technoMaintenance("spot27m","1",curMechan,"2") = 2.66;
p_technoMaintenance("spot27m","1",curMechan,"3") = 2.72;
p_technoMaintenance("spot27m","1",curMechan,"4") = 2.76;
p_technoMaintenance("spot27m","1",curMechan,"5") = 2.81;
p_technoMaintenance("spot27m","1",curMechan,"10") = 3.03;
p_technoMaintenance("spot27m","1",curMechan,"15") = 3.25;
p_technoMaintenance("spot27m","2",curMechan,"1") = 2.02;
p_technoMaintenance("spot27m","2",curMechan,"2") = 2.07;
p_technoMaintenance("spot27m","2",curMechan,"3") = 2.12;
p_technoMaintenance("spot27m","2",curMechan,"4") = 2.17;
p_technoMaintenance("spot27m","2",curMechan,"5") = 2.22;
p_technoMaintenance("spot27m","2",curMechan,"10") = 2.44;
p_technoMaintenance("spot27m","2",curMechan,"15") = 2.66;
p_technoMaintenance("spot27m","5",curMechan,"1") = 1.6;
p_technoMaintenance("spot27m","5",curMechan,"2") = 1.66;
p_technoMaintenance("spot27m","5",curMechan,"3") = 1.7;
p_technoMaintenance("spot27m","5",curMechan,"4") = 1.75;
p_technoMaintenance("spot27m","5",curMechan,"5") = 1.79;
p_technoMaintenance("spot27m","5",curMechan,"10") = 2.01;
p_technoMaintenance("spot27m","5",curMechan,"15") = 2.23;
p_technoMaintenance("spot27m","10",curMechan,"1") = 1.44;
p_technoMaintenance("spot27m","10",curMechan,"2") = 1.5;
p_technoMaintenance("spot27m","10",curMechan,"3") = 1.54;
p_technoMaintenance("spot27m","10",curMechan,"4") = 1.59;
p_technoMaintenance("spot27m","10",curMechan,"5") = 1.63;
p_technoMaintenance("spot27m","10",curMechan,"10") = 1.86;
p_technoMaintenance("spot27m","10",curMechan,"15") = 2.08;
p_technoMaintenance("spot27m","20",curMechan,"1") = 1.44;
p_technoMaintenance("spot27m","20",curMechan,"2") = 1.5;
p_technoMaintenance("spot27m","20",curMechan,"3") = 1.54;
p_technoMaintenance("spot27m","20",curMechan,"4") = 1.59;
p_technoMaintenance("spot27m","20",curMechan,"5") = 1.63;
p_technoMaintenance("spot27m","20",curMechan,"10") = 1.86;
p_technoMaintenance("spot27m","20",curMechan,"15") = 2.08;
p_technoMaintenance("spot27m","40",curMechan,"1") = 1.45;
p_technoMaintenance("spot27m","40",curMechan,"2") = 1.5;
p_technoMaintenance("spot27m","40",curMechan,"3") = 1.55;
p_technoMaintenance("spot27m","40",curMechan,"4") = 1.6;
p_technoMaintenance("spot27m","40",curMechan,"5") = 1.64;
p_technoMaintenance("spot27m","40",curMechan,"10") = 1.86;
p_technoMaintenance("spot27m","40",curMechan,"15") = 2.08;
p_technoMaintenance("spot27m","80",curMechan,"1") = 1.47;
p_technoMaintenance("spot27m","80",curMechan,"2") = 1.52;
p_technoMaintenance("spot27m","80",curMechan,"3") = 1.57;
p_technoMaintenance("spot27m","80",curMechan,"4") = 1.62;
p_technoMaintenance("spot27m","80",curMechan,"5") = 1.66;
p_technoMaintenance("spot27m","80",curMechan,"10") = 1.88;
p_technoMaintenance("spot27m","80",curMechan,"15") = 2.11;

p_technoMaintenance("spot27m",KTBL_size,curMechan,KTBL_distance) = 
    p_technoMaintenance("spot27m","1",curMechan,"1")
    * (p_technoValue("spot27m")/54300)
;

$ontext
p_technoTimeReq("spot6m",'1',curMechan,"1") = 0.43;
p_technoTimeReq("spot6m",'1',curMechan,"2") = 0.43;
p_technoTimeReq("spot6m",'1',curMechan,"3") = 0.44;
p_technoTimeReq("spot6m",'1',curMechan,"4") = 0.44;
p_technoTimeReq("spot6m",'1',curMechan,"5") = 0.44;
p_technoTimeReq("spot6m",'1',curMechan,"10") = 0.47;
p_technoTimeReq("spot6m",'1',curMechan,"15") = 0.49;
p_technoTimeReq("spot6m",'2',curMechan,"1") = 0.31;
p_technoTimeReq("spot6m",'2',curMechan,"2") = 0.32;
p_technoTimeReq("spot6m",'2',curMechan,"3") = 0.32;
p_technoTimeReq("spot6m",'2',curMechan,"4") = 0.32;
p_technoTimeReq("spot6m",'2',curMechan,"5") = 0.32;
p_technoTimeReq("spot6m",'2',curMechan,"10") = 0.34;
p_technoTimeReq("spot6m",'2',curMechan,"15") = 0.36;
p_technoTimeReq("spot6m",'5',curMechan,"1") = 0.24;
p_technoTimeReq("spot6m",'5',curMechan,"2") = ;
p_technoTimeReq("spot6m",'5',curMechan,"3") = ;
p_technoTimeReq("spot6m",'5',curMechan,"4") = ;
p_technoTimeReq("spot6m",'5',curMechan,"5") = ;
p_technoTimeReq("spot6m",'5',curMechan,"10") = ;
p_technoTimeReq("spot6m",'5',curMechan,"15") = ;
p_technoTimeReq("spot6m",'10',curMechan,"1") = ;
p_technoTimeReq("spot6m",'10',curMechan,"2") = ;
p_technoTimeReq("spot6m",'10',curMechan,"3") = ;
p_technoTimeReq("spot6m",'10',curMechan,"4") = ;
p_technoTimeReq("spot6m",'10',curMechan,"5") = ;
p_technoTimeReq("spot6m",'10',curMechan,"10") = ;
p_technoTimeReq("spot6m",'10',curMechan,"15") = ;
p_technoTimeReq("spot6m",'20',curMechan,"1") = ;
p_technoTimeReq("spot6m",'20',curMechan,"2") = ;
p_technoTimeReq("spot6m",'20',curMechan,"3") = ;
p_technoTimeReq("spot6m",'20',curMechan,"4") = ;
p_technoTimeReq("spot6m",'20',curMechan,"5") = ;
p_technoTimeReq("spot6m",'20',curMechan,"10") = ;
p_technoTimeReq("spot6m",'20',curMechan,"15") = ;
p_technoTimeReq("spot6m",'40',curMechan,"1") = ;
p_technoTimeReq("spot6m",'40',curMechan,"2") = ;
p_technoTimeReq("spot6m",'40',curMechan,"3") = ;
p_technoTimeReq("spot6m",'40',curMechan,"4") = ;
p_technoTimeReq("spot6m",'40',curMechan,"5") = ;
p_technoTimeReq("spot6m",'40',curMechan,"10") = ;
p_technoTimeReq("spot6m",'40',curMechan,"15") = ;
p_technoTimeReq("spot6m",'80',curMechan,"1") = ;
p_technoTimeReq("spot6m",'80',curMechan,"2") = ;
p_technoTimeReq("spot6m",'80',curMechan,"3") = ;
p_technoTimeReq("spot6m",'80',curMechan,"4") = ;
p_technoTimeReq("spot6m",'80',curMechan,"5") = ;
p_technoTimeReq("spot6m",'80',curMechan,"10") = ;
p_technoTimeReq("spot6m",'80',curMechan,"15") = ;
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
