*
* --- In this file, sets and parameter values for the farm size and profitability factor variations as well as for conditionals are introduced
*
set farmSizeSteps /
sizeStep0*sizeStep175
/;

parameter p_farmSizeFactor(farmSizeSteps);
p_farmSizeFactor(farmSizeSteps) = 50 + (ord(farmSizeSteps) -1) * 2;


*
* --- set introduction for loop(s) in sensitivity analysis
*
set sensiAnSteps / senStep0*senStep1000 /;

set farmSizeStep3D /farmsizeStep0*farmSizeStep35/;
set valueStep3D /valueStep1*valueStep5/;
set pestCostStep3D /pestCostStep1*pestCostStep7/;
set algoCostStep3D /algoCostStep1*algoCostStep7/;
set annFeeStep3D /annFeeStep1*annFeeStep7/;


parameter p_farmSizeStep(farmSizeStep3D);
p_farmSizeStep(farmSizeStep3D) = 50 + (ord(farmSizeStep3D) -1) * 10;

parameter p_valueStep(valueStep3D) /
    valueStep1 50
    valueStep2 75
    valueStep3 100
    valueStep4 125
    valueStep5 150
/;

parameter p_pestCostStep(pestCostStep3D) /
    pestCostStep1 100
    pestCostStep2 150
    pestCostStep3 200
    pestCostStep4 250
    pestCostStep5 300
    pestCostStep6 350
    pestCostStep7 400
/;

parameter p_algoCostStep(algoCostStep3D) /
    algoCostStep1 0
    algoCostStep2 2
    algoCostStep3 4
    algoCostStep4 6
    algoCostStep5 8
    algoCostStep6 10
    algoCostStep7 12
/;

parameter p_annFeeStep(annFeeStep3D) /
    annFeeStep1 0
    annFeeStep2 2500
    annFeeStep3 5000
    annFeeStep4 7500
    annFeeStep5 10000
    annFeeStep6 12500
    annFeeStep7 15000
/;

set loopComb3DpestCost(valueStep3D,pestCostStep3D,farmSizeStep3D) /
    "valueStep1"."pestCostStep1".set.farmSizeStep3D YES
    "valueStep1"."pestCostStep2".set.farmSizeStep3D YES
    "valueStep1"."pestCostStep3".set.farmSizeStep3D YES
    "valueStep1"."pestCostStep4".set.farmSizeStep3D YES
    "valueStep1"."pestCostStep5".set.farmSizeStep3D YES
    "valueStep1"."pestCostStep6".set.farmSizeStep3D YES
    "valueStep1"."pestCostStep7".set.farmSizeStep3D YES
    "valueStep2"."pestCostStep1".set.farmSizeStep3D YES
    "valueStep2"."pestCostStep2".set.farmSizeStep3D YES
    "valueStep2"."pestCostStep3".set.farmSizeStep3D YES
    "valueStep2"."pestCostStep4".set.farmSizeStep3D YES
    "valueStep2"."pestCostStep5".set.farmSizeStep3D YES
    "valueStep2"."pestCostStep6".set.farmSizeStep3D YES
    "valueStep2"."pestCostStep7".set.farmSizeStep3D YES
    "valueStep3"."pestCostStep1".set.farmSizeStep3D YES
    "valueStep3"."pestCostStep2".set.farmSizeStep3D YES
    "valueStep3"."pestCostStep3".set.farmSizeStep3D YES
    "valueStep3"."pestCostStep4".set.farmSizeStep3D YES
    "valueStep3"."pestCostStep5".set.farmSizeStep3D YES
    "valueStep3"."pestCostStep6".set.farmSizeStep3D YES
    "valueStep3"."pestCostStep7".set.farmSizeStep3D YES
    "valueStep4"."pestCostStep1".set.farmSizeStep3D YES
    "valueStep4"."pestCostStep2".set.farmSizeStep3D YES
    "valueStep4"."pestCostStep3".set.farmSizeStep3D YES
    "valueStep4"."pestCostStep4".set.farmSizeStep3D YES
    "valueStep4"."pestCostStep5".set.farmSizeStep3D YES
    "valueStep4"."pestCostStep6".set.farmSizeStep3D YES
    "valueStep4"."pestCostStep7".set.farmSizeStep3D YES
    "valueStep5"."pestCostStep1".set.farmSizeStep3D YES
    "valueStep5"."pestCostStep2".set.farmSizeStep3D YES
    "valueStep5"."pestCostStep3".set.farmSizeStep3D YES
    "valueStep5"."pestCostStep4".set.farmSizeStep3D YES
    "valueStep5"."pestCostStep5".set.farmSizeStep3D YES
    "valueStep5"."pestCostStep6".set.farmSizeStep3D YES
    "valueStep5"."pestCostStep7".set.farmSizeStep3D YES
/;

set loopComb3DannFee(valueStep3D,annFeeStep3D,farmSizeStep3D) /
    "valueStep1"."annFeeStep1".set.farmSizeStep3D YES
    "valueStep1"."annFeeStep2".set.farmSizeStep3D YES
    "valueStep1"."annFeeStep3".set.farmSizeStep3D YES
    "valueStep1"."annFeeStep4".set.farmSizeStep3D YES
    "valueStep1"."annFeeStep5".set.farmSizeStep3D YES
    "valueStep1"."annFeeStep6".set.farmSizeStep3D YES
    "valueStep1"."annFeeStep7".set.farmSizeStep3D YES
    "valueStep2"."annFeeStep1".set.farmSizeStep3D YES
    "valueStep2"."annFeeStep2".set.farmSizeStep3D YES
    "valueStep2"."annFeeStep3".set.farmSizeStep3D YES
    "valueStep2"."annFeeStep4".set.farmSizeStep3D YES
    "valueStep2"."annFeeStep5".set.farmSizeStep3D YES
    "valueStep2"."annFeeStep6".set.farmSizeStep3D YES
    "valueStep2"."annFeeStep7".set.farmSizeStep3D YES
    "valueStep3"."annFeeStep1".set.farmSizeStep3D YES
    "valueStep3"."annFeeStep2".set.farmSizeStep3D YES
    "valueStep3"."annFeeStep3".set.farmSizeStep3D YES
    "valueStep3"."annFeeStep4".set.farmSizeStep3D YES
    "valueStep3"."annFeeStep5".set.farmSizeStep3D YES
    "valueStep3"."annFeeStep6".set.farmSizeStep3D YES
    "valueStep3"."annFeeStep7".set.farmSizeStep3D YES
    "valueStep4"."annFeeStep1".set.farmSizeStep3D YES
    "valueStep4"."annFeeStep2".set.farmSizeStep3D YES
    "valueStep4"."annFeeStep3".set.farmSizeStep3D YES
    "valueStep4"."annFeeStep4".set.farmSizeStep3D YES
    "valueStep4"."annFeeStep5".set.farmSizeStep3D YES
    "valueStep4"."annFeeStep6".set.farmSizeStep3D YES
    "valueStep4"."annFeeStep7".set.farmSizeStep3D YES
    "valueStep5"."annFeeStep1".set.farmSizeStep3D YES
    "valueStep5"."annFeeStep2".set.farmSizeStep3D YES
    "valueStep5"."annFeeStep3".set.farmSizeStep3D YES
    "valueStep5"."annFeeStep4".set.farmSizeStep3D YES
    "valueStep5"."annFeeStep5".set.farmSizeStep3D YES
    "valueStep5"."annFeeStep6".set.farmSizeStep3D YES
    "valueStep5"."annFeeStep7".set.farmSizeStep3D YES
/;

set loopComb3DalgoCost(valueStep3D,algoCostStep3D,farmSizeStep3D) /
    "valueStep1"."algoCostStep1".set.farmSizeStep3D YES
    "valueStep1"."algoCostStep2".set.farmSizeStep3D YES
    "valueStep1"."algoCostStep3".set.farmSizeStep3D YES
    "valueStep1"."algoCostStep4".set.farmSizeStep3D YES
    "valueStep1"."algoCostStep5".set.farmSizeStep3D YES
    "valueStep1"."algoCostStep6".set.farmSizeStep3D YES
    "valueStep1"."algoCostStep7".set.farmSizeStep3D YES
    "valueStep2"."algoCostStep1".set.farmSizeStep3D YES
    "valueStep2"."algoCostStep2".set.farmSizeStep3D YES
    "valueStep2"."algoCostStep3".set.farmSizeStep3D YES
    "valueStep2"."algoCostStep4".set.farmSizeStep3D YES
    "valueStep2"."algoCostStep5".set.farmSizeStep3D YES
    "valueStep2"."algoCostStep6".set.farmSizeStep3D YES
    "valueStep2"."algoCostStep7".set.farmSizeStep3D YES
    "valueStep3"."algoCostStep1".set.farmSizeStep3D YES
    "valueStep3"."algoCostStep2".set.farmSizeStep3D YES
    "valueStep3"."algoCostStep3".set.farmSizeStep3D YES
    "valueStep3"."algoCostStep4".set.farmSizeStep3D YES
    "valueStep3"."algoCostStep5".set.farmSizeStep3D YES
    "valueStep3"."algoCostStep6".set.farmSizeStep3D YES
    "valueStep3"."algoCostStep7".set.farmSizeStep3D YES
    "valueStep4"."algoCostStep1".set.farmSizeStep3D YES
    "valueStep4"."algoCostStep2".set.farmSizeStep3D YES
    "valueStep4"."algoCostStep3".set.farmSizeStep3D YES
    "valueStep4"."algoCostStep4".set.farmSizeStep3D YES
    "valueStep4"."algoCostStep5".set.farmSizeStep3D YES
    "valueStep4"."algoCostStep6".set.farmSizeStep3D YES
    "valueStep4"."algoCostStep7".set.farmSizeStep3D YES
    "valueStep5"."algoCostStep1".set.farmSizeStep3D YES
    "valueStep5"."algoCostStep2".set.farmSizeStep3D YES
    "valueStep5"."algoCostStep3".set.farmSizeStep3D YES
    "valueStep5"."algoCostStep4".set.farmSizeStep3D YES
    "valueStep5"."algoCostStep5".set.farmSizeStep3D YES
    "valueStep5"."algoCostStep6".set.farmSizeStep3D YES
    "valueStep5"."algoCostStep7".set.farmSizeStep3D YES
/;

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
scalar pestPriceRandom pesticide price variation parameter for sensitivity analysis /0/;
scalar passageRandom Number of passages variation parameter for sensitivity analysis /0/;

*
* -- Farm size variation
*
parameter farmSizeVar placeholder for farm size variation;

farmSizeVar = 50 / sum(curPlots, p_plotData(curPlots,"size"));


*
* -- SST pesticide saving parameter variation
*
parameter p_savePestEff(KTBL_crops,technology,scenario,pestType);
p_savePestEff(KTBL_crops,technology,scenario,pestType) = p_technoPestEff(KTBL_crops,technology,scenario,pestType);



*
* -- SST parameter variation placeholders for SST acquisition costs, pesticide prices, SSPA time requirements, SSPA fuel consumption, SST repair costs, SSPA savings and SSPA sprayer passages
*
parameter technoValueVar(scenSprayer) placeholder for SST acquisition cost variations;
technoValueVar(scenSprayer) = 1;

parameter timeReqVar(technology,scenario,scenSprayer,pestType) placeholder for SST time requirement variations;
timeReqVar(technology,scenario,scenSprayer,pestType) = 1;

parameter fuelConsVar(technology,scenario,scenSprayer,pestType) placeholder for SST fuel consumption variations;
fuelConsVar(technology,scenario,scenSprayer,pestType) = 1;

parameter repairCostsVar(scenSprayer) placeholder for SST repair costs variations;
repairCostsVar(scenSprayer) = 1;

parameter pestPriceVar placeholder for pesticide price variations;
pestPriceVar = 1;

parameter passageVar(technology,scenario,pestType) placeholder for sprayer passage variation of SST scenarios;
passageVar(technology,scenario,pestType) = 1;