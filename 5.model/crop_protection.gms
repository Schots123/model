


parameter p_ktbl_workingStepsBroadcast(KTBL_size,KTBL_mechanisation,KTBL_distance,workingStepsEle);

*load in ktbl Data for variable and fix machine costs of pesticide application operations with broadcast technology
$Gdxin 2.ktblData/gdxFiles/KTBL_WorkingStepsBroadcast.gdx
$load p_ktbl_workingStepsBroadcast=p_ktbl_workingStepsBroadcast
*option p_ktbl_workingStepsBroadcast:1:3:1 display p_ktbl_workingStepsBroadcast;

*include Crop Protection data file 
$include '4.CropProtectionData/LWK_spraySequence.gms'
$include '4.CropProtectionData/broadcastData.gms'





*
*  ---- 1. Part: Calculations for broadcast sprayer
*

positive variables
    v_dcPesti(years)
    v_varCostsPesti(years)
    v_deprecPesti(years)
    v_interestPesti(years)
    v_fixCostsPesti(years)
;

integer variables 
    v_numberSprayer
;

equations
    e_dcPesti(years)
    e_varCostsPesti(years)
    e_SprayerBroadcast
    e_deprecBroadcastTime(years)
    e_deprecBroadcastHa(years)
    e_interestBroadcast(years)
    e_fixCostsPesti(years)
;

*
*  --- Calculation of direct costs for plant protection products (broadcast application)
*
scalar pestCostFactor reflecting multiplactor for pesticide tax integration /1/;

e_dcPesti(years)..
    v_dcPesti(years) =E=
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),    
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years) * p_plotData(curPlots,'size')
    * (sum(pestType,p_sprayInputCostsNotHerb(curCrops,KTBL_yield,pestType))
    + sum(herbProduct,p_sprayAmountHerb(curCrops,KTBL_yield,herbProduct) * p_herbCosts(herbProduct))) * pestCostFactor
    )
;

*
*  --- Calculation of variable machine costs for pesticide application field operations (broadcast application)
*
e_varCostsPesti(years)..
    v_varCostsPesti(years) =E=
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years) * p_plotData(curPlots,'size')
    * (sum(varCostsEle,
        p_ktbl_workingStepsBroadcast(KTBL_size,curMechan,KTBL_distance,varCostsEle))
        - p_ktbl_workingStepsBroadcast(KTBL_size,curMechan,KTBL_distance,"fuelCons") * ktblFuelPrice
        + p_ktbl_workingStepsBroadcast(KTBL_size,curMechan,KTBL_distance,"fuelCons") * newFuelPrice)
    * p_numberSprayPasses(curCrops,KTBL_yield)
    )
;

*
*  --- Calculation of fix machine costs for pesticide application field operations (broadcast application)
*

e_SprayerBroadcast..
*the sum over curMechan is only for being conform with the algebraic language -> curMechan consists always only of 1 item defined in 3.farmData typFarm_1.gms
    v_numberSprayer * sum(curMechan,p_broadcastAnnualCapac(curMechan)) =G=
*the annual capacity of all sprayers used combined has to be high enough for the combined hectares to be sprayed on the farm
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),    
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years) 
    * p_plotData(curPlots,'size')
    * p_numberSprayPasses(curCrops,KTBL_yield)
    ) / card(years)
;

e_deprecBroadcastTime(years)..
    v_deprecPesti(years) =G=
*if the machine(s) is/are depreciated according to its/their lifetime, the depreciation in the specific year is the annual value loss per sprayer times the number of sprayers required
    v_numberSprayer 
    * (sum(curMechan,
        p_broadcastValue(curMechan) - p_broadcastRemValue(curMechan)) 
    / p_lifetimeBroadcast)
;

e_deprecBroadcastHa(years)..
    v_deprecPesti(years) =G=
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ), 
*the first part of the right hand side of the equation calculates the overall amount of hectares on which the sprayer has to be used 
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years) 
    * p_plotData(curPlots,'size')
    * p_numberSprayPasses(curCrops,KTBL_yield)
*if the machine(s) is/are depreciated according to its/their use, the depreciation in the specific year is equal to the value loss divided by its overall use capacity 
    * (p_broadcastValue(curMechan) - p_broadcastRemValue(curMechan))
        / p_broadcastAreaCapac(curMechan)
    )
;

e_interestBroadcast(years)..
*Kalkulatorische Zinsen nach Restwertmethode 
    v_interestPesti(years) =E=
    (sum(curMechan,
        p_broadcastValue(curMechan) - p_broadcastRemValue(curMechan)) 
    /2) * 0.03
    * v_numberSprayer
;

e_fixCostsPesti(years)..
    v_fixCostsPesti(years) =E=
    v_deprecPesti(years)
    + v_interestPesti(years)
    + sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ), 
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years) 
        * p_plotData(curPlots,'size')
        * p_numberSprayPasses(curCrops,KTBL_yield)
        * p_ktbl_workingStepsBroadcast(KTBL_size,curMechan,KTBL_distance,"others")
    )
;











*
*  --- 2. Part: Technology Integration and equations to calulate associated direct costs and variable and 
*       fix machine costs for spot sprayers 

$include '4.cropProtectionData/technologyData.gms'

parameter p_pestEff(pestType);

equation e_dcPestiTechno(years);

*
*  --- Calculation of direct costs for plant protection products 
*
e_dcPestiTechno(years)..
    v_dcPesti(years) =E=
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),    
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years) * p_plotData(curPlots,'size')
    * (
        p_sprayInputCostsNotHerb(curCrops,KTBL_yield,"fung") * pestCostFactor * (1-p_pestEff("fung"))
        + p_sprayInputCostsNotHerb(curCrops,KTBL_yield,"insect") * pestCostFactor * (1-p_pestEff("insect"))
        + p_sprayInputCostsNotHerb(curCrops,KTBL_yield,"growthReg") * pestCostFactor * (1-p_pestEff("growthReg"))
        + p_sprayInputCostsNotHerb(curCrops,KTBL_yield,"dessic") * pestCostFactor * (1-p_pestEff("dessic"))
        + sum(preHerb,p_sprayAmountHerb(curCrops,KTBL_yield,preHerb) * p_herbCosts(preHerb) * pestCostFactor) * (1-p_pestEff("preHerb"))
        + sum(postHerb,p_sprayAmountHerb(curCrops,KTBL_yield,postHerb) * p_herbCosts(postHerb)* pestCostFactor) * (1-p_pestEff("postHerb"))
    ))
;

*
*  --- Depreciation calculations of technologies 
*
parameters
*these parameters are placeholders for the defined parameters for each technology in 4.cropProtectionData/technologyData.gms
    p_value
    p_remValue
    p_lifetime
    p_areaCapac
    p_annualCapac
    p_OtherCosts(KTBL_size,curMechan,KTBL_distance)
    p_fuelConsPesti(KTBL_size,curMechan,KTBL_distance)
    p_maintenance(KTBL_size,curMechan,KTBL_distance)
;

equations 
    e_SprayerTechno
    e_deprecTechnoTime(years)
    e_deprecTechnoHa(years)
    e_interestTechno(years)
    e_otherCostsTechno(years)
    e_fixCostsPestiTechno(years)
    e_varCostsPestiTechno(years)
;

$ontext
the number of technology machines necessary has to be high enough so that their combined annual capacity is higher
than the average of hectares sprayed each year 
$offtext
e_SprayerTechno..
*p_annualCapac is only placeholder for p_technoAnnualCapac defined in 4.cropProtection/technologyData.gms
    v_numberSprayer * p_annualCapac =G=
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),    
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years) 
    * p_plotData(curPlots,'size')
    * p_numberSprayPasses(curCrops,KTBL_yield)
    ) / card(years)
;

*at least one machine has to be in the inventory of the farm

e_deprecTechnoTime(years)..
    v_deprecPesti(years) =G=
    v_numberSprayer 
*p_value and p_remValue are only placeholders for p_technoValue and p_technoRemValue defined in 4.cropProtection/technologyData.gms
*p_lifetime is only placeholder for p_technoLifetime defined in 4.cropProtection/technologyData.gms
    * ((p_value-p_remValue) / p_lifetime)
;

e_deprecTechnoHa(years)..
    v_deprecPesti(years) =G=
*p_value and p_remValue are only placeholders for p_technoValue and p_technoRemValue defined in 4.cropProtection/technologyData.gms
*p_areaCapac is only placeholder for p_technoAreaCapac defined in 4.cropProtection/technologyData.gms
    ((p_value-p_remValue) / p_areaCapac)
    * sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),    
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years) 
    * p_plotData(curPlots,'size')
    * p_numberSprayPasses(curCrops,KTBL_yield)
    )
;

e_interestTechno(years)..
*Kalkulatorische Zinsen nach Restwertmethode 
*im durchschnitt sind p_value+remValue/2 (in €) gebunden 
    v_interestPesti(years) =E=
*p_value and p_remValue are only placeholders for p_technoValue and p_technoRemValue defined in 4.cropProtection/technologyData.gms
    ((p_value+p_remValue)/2 * 0.03) * v_numberSprayer
;

e_fixCostsPestiTechno(years)..
    v_fixCostsPesti(years) =E=
    v_deprecPesti(years) 
    + v_interestPesti(years)
*p_otherCosts is only placeholder for p_technoOtherCosts defined in 4.cropProtection/technologyData.gms
    + sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),    
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years) 
    * p_plotData(curPlots,'size')
    * p_OtherCosts(KTBL_size,curMechan,KTBL_distance)
    )
;

e_varCostsPestiTechno(years)..
    v_varCostsPesti(years)  =E= 
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),    
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years) 
    * p_plotData(curPlots,'size')
*p_fuelConsPesti is only placeholder for p_technoFuelCons defined in 4.cropProtection/technologyData.gms
    * (p_fuelConsPesti(KTBL_size,curMechan,KTBL_distance) + p_maintenance(KTBL_size,curMechan,KTBL_distance))
    )
;