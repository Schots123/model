


parameter p_ktbl_workingStepsBroadcast(KTBL_size,KTBL_mechanisation,KTBL_distance,workingStepsEle);

*load in ktbl Data for variable and fix machine costs of pesticide application operations with broadcast technology
$Gdxin 2.ktblData/gdxFiles/KTBL_WorkingStepsBroadcast.gdx
$load p_ktbl_workingStepsBroadcast=p_ktbl_workingStepsBroadcast
option p_ktbl_workingStepsBroadcast:1:3:1 display p_ktbl_workingStepsBroadcast;

*include Crop Protection data file 
$include '4.CropProtectionData/LWK_spraySequence.gms'

positive variables
    v_dcPesti(years)
    v_varCostsPesti(years)
    v_fixCostsPesti(years)
;

equations
    e_dcPesti(years)
    e_varCostsPesti(years)
    e_fixCostsPesti(years)
;

*
*  --- Calculation of direct costs for plant protection products 
*
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
    + sum(herbProduct,p_sprayAmountHerb(curCrops,KTBL_yield,herbProduct) * p_herbCosts(herbProduct)))
    )
;

*
*  --- Calculation of variable and fix machine costs for pesticide application field operations (broadcast application)
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

e_fixCostsPesti(years)..
    v_fixCostsPesti(years) =E=
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years) * p_plotData(curPlots,'size')
    * (sum(fixCostsEle,
        p_ktbl_workingStepsBroadcast(KTBL_size,curMechan,KTBL_distance,fixCostsEle))
    * p_numberSprayPasses(curCrops,KTBL_yield))
    )
;