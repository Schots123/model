*
* --- Parameter assignment for technology comparison
*
set farmSizeSteps /
sizeStep1*sizeStep175
/;

$ontext
set Base_farmSizeStep(farmSizeSteps) /Base0*Base4/;
set SST6m_FH_farmSizeStep(farmSizeSteps) /SST6m_FH0*SST6m_FH4/;
set SST27m_FH_farmSizeStep(farmSizeSteps) /SST27m_FH0*SST27m_FH4/;
set SST6m_FHBonus_farmSizeStep(farmSizeSteps) /SST6m_FHBonus0*SST6m_FHBonus4/;
set SST27m_FHBonus_farmSizeStep(farmSizeSteps) /SST27m_FHBonus0*SST27m_FHBonus4/;
$offtext

parameter p_farmSizeFactor(farmSizeSteps);
p_farmSizeFactor(farmSizeSteps) = 50 + (ord(farmSizeSteps) -1) * 2;
$ontext
p_farmSizeFactor(SST6m_FH_farmSizeStep) = 50 + (ord(SST6m_FH_farmSizeStep) -1) * 100;
p_farmSizeFactor(SST27m_FH_farmSizeStep) = 50 + (ord(SST27m_FH_farmSizeStep) -1) * 100;
p_farmSizeFactor(SST6m_FHBonus_farmSizeStep) = 50 + (ord(SST6m_FHBonus_farmSizeStep) -1) * 100;
p_farmSizeFactor(SST27m_FHBonus_farmSizeStep) = 50 + (ord(SST27m_FHBonus_farmSizeStep) -1) * 100;
$offtext


*
* --- Parameter assignment for sensitivity analysis
*
set sensiAnSteps / senStep1*senStep60 /;

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

parameter p_saveTechnoMaintenance(KTBL_size,KTBL_distance,scenario,scenSprayer,pestType);

p_saveTechnoMaintenance(KTBL_size,KTBL_distance,scenario,"spot6m",pestType)
 = p_technoMaintenance(KTBL_size,KTBL_distance,scenario,"spot6m",pestType);

p_saveTechnoMaintenance(KTBL_size,KTBL_distance,scenario,"spot27m",pestType)
 = p_technoMaintenance(KTBL_size,KTBL_distance,scenario,"spot27m",pestType);

p_saveTechnoMaintenance(KTBL_size,KTBL_distance,scenario,BASprayer,pestType)
 = p_technoMaintenance(KTBL_size,KTBL_distance,scenario,BASprayer,pestType);


*
* -- SST pesticide saving parameter variation
*
parameter p_savePestEff(KTBL_crops,technology,scenario,pestType);
p_savePestEff(KTBL_crops,technology,scenario,pestType) = p_technoPestEff(KTBL_crops,technology,scenario,pestType);


*
* -- SST parameter variation placeholders for time requirements, fuel consumption and repair costs
*
parameter timeReqVar(scenSprayer) placeholder for SST time requirement variations /set.BASprayer 1, "spot6m" 1, "spot27m" 1/;

parameter fuelConsVar(scenSprayer) placeholder for SST fuel consumption variations /set.BASprayer 1, "spot6m" 1, "spot27m" 1/;

parameter repairCostsVar(scenSprayer) placeholder for SST repair costs variations /set.BASprayer 1, "spot6m" 1, "spot27m" 1/;