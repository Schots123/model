*
* --- Parameter assignment for technology comparison
*
set farmSizeSteps /
sizeStep0*sizeStep1
/;

parameter p_farmSizeFactor(farmSizeSteps);
p_farmSizeFactor(farmSizeSteps) = 50 + (ord(farmSizeSteps) -1) * 2;


*
* --- set introduction for loop in sensitivity analysis
*
set sensiAnSteps / senStep1*senStep20 /;


*
* -- scalar introduction for random parameter assignment within ranges by assuming normal distribution
*
scalar farmSizeRandom farm size variation parameter /0/;
scalar technoValueRandom SST investment costs variation parameter for sensitivity analysis /0/;
scalar algoCostsPerHaRandom SST algorithm costs imposed for the use of the SST per ha /0/;
scalar annualFeeRandom annual fee for algorithms of SST /0/;
scalar technoPestEffRandom pesticide saving variation parameter achieved with SST for sensitivity analysis /0/;
scalar technoTimeRandom SST time requirement variation parameter for sensitivity analysis /0/;
scalar technoFuelRandom SST fuel consumption variation parameter for sensitivity analysis /0/;
scalar technoRepRandom time requirement variation parameter for sensitivity analysis /0/;

*
* -- Farm size variation
*
parameter farmSizeVar placeholder for farm size variation;

farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));


*
* -- SST investment cost parameter variation
*
parameter p_saveTechnoValue(scenSprayer) parameter to reset investment costs for SST;
p_saveTechnoValue("spot6m") = 130000;
p_saveTechnoValue("spot27m") = 207000;
p_saveTechnoValue("BA_45kW") = 15000;
p_saveTechnoValue("BA_67kW") = 22700;
p_saveTechnoValue("BA_83kW") = 30300;
p_saveTechnoValue("BA_102kW") = 36600;
p_saveTechnoValue("BA_120kW") = 51100;
p_saveTechnoValue("BA_200kW") = 58100;
p_saveTechnoValue("BA_230kW") = 71100;

parameter 
    p_saveTechnoMaintenance(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) resetting maintenance adjustment according to technology value
    p_iniTechnoMaintenance(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType) maintenance costs as defined by assumption
;

p_saveTechnoMaintenance(KTBL_size,KTBL_distance,scenario,"spot6m",pestType)
 = p_technoMaintenance(KTBL_size,KTBL_distance,scenario,"spot6m",pestType) * (p_technoValue("BA_45kW") / p_technoValue("spot6m"));

p_saveTechnoMaintenance(KTBL_size,KTBL_distance,scenario,"spot27m",pestType)
 = p_technoMaintenance(KTBL_size,KTBL_distance,scenario,"spot27m",pestType) * (54300 / p_technoValue("spot27m"));

p_saveTechnoMaintenance(KTBL_size,KTBL_distance,scenario,BASprayer,pestType)
 = p_technoMaintenance(KTBL_size,KTBL_distance,scenario,BASprayer,pestType);

p_iniTechnoMaintenance(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType)
 = p_technoMaintenance(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType);



*
* -- SST pesticide saving parameter variation
*
parameter p_savePestEff(KTBL_crops,technology,scenario,pestType);
p_savePestEff(KTBL_crops,technology,scenario,pestType) = p_technoPestEff(KTBL_crops,technology,scenario,pestType);



*
* -- SST parameter variation placeholders for time requirements, fuel consumption and repair costs
*
parameter timeReqVar(scenSprayer) placeholder for SST time requirement variations;
timeReqVar(scenSprayer) = 1;

parameter fuelConsVar(scenSprayer) placeholder for SST fuel consumption variations;
fuelConsVar(scenSprayer) = 1;

parameter repairCostsVar(scenSprayer) placeholder for SST repair costs variations;
repairCostsVar(scenSprayer) = 1;