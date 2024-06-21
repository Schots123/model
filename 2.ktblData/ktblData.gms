*
*  --- Here, the data retrieved from KTBL is manipulated to obtain a farm profit parameter which does depend on the level of manure applied as 
*        a substitute for mineral fertilizer

scalar newFuelPrice price for fuel in euro per liter /1/;
scalar labPrice price for labour in euro per hour /21/

$include '2.ktblData/KTBL_inputOptions+Sets.gms'
$setglobal farmNumber 1
$include '3.farmData/typFarm_%farmNumber%.gms'

*
*  --- Reading values from gdx files into model
*
parameters
    p_ktbl_revenue(KTBL_crops,KTBL_system,KTBL_yield,KTBL_figure,reveCat)
    p_ktbl_directCostsNoFert(KTBL_crops,KTBL_system,KTBL_yield,CostsEle)
    p_ktbl_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,fertType)
    p_ktbl_workingStepsNoPesti(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,CostsEle,workingStepsEle) KTBL data for fuel consumption & variable machine costs without fuel consumption & fix machine costs
    p_ktbl_workingStepsPesti(KTBL_size,KTBL_mechanisation,KTBL_distance,workingStepsEle)
;

*load in revenue data 
$Gdxin 2.ktblData/gdxFiles/KTBL_Revenue.gdx
$load p_ktbl_revenue=p_ktbl_revenue
$gdxin
option p_ktbl_revenue:1:4:1 display p_ktbl_revenue;

*load in direct costs for crops 
$Gdxin 2.ktblData/gdxFiles/KTBL_DirectCosts.gdx
$load p_ktbl_directCostsNoFert=p_ktbl_directCostsNoFert
$gdxin
option p_ktbl_directCostsNoFert:1:3:1 display p_ktbl_directCostsNoFert;

*load in amounts of fertilizer used for each crop in initial situation
$Gdxin 2.ktblData/gdxFiles/KTBL_FertAmount.gdx
$load p_ktbl_fertAmount=p_ktbl_fertAmount
$gdxin
option p_ktbl_fertAmount:1:3:1 display p_ktbl_fertAmount;

*load in costs data and time requirement for all but pesticide application operations
$Gdxin 2.ktblData/gdxFiles/KTBL_WorkingStepsNoPesti.gdx
$load p_ktbl_workingStepsNoPesti=p_ktbl_workingStepsNoPesti
$gdxin
option p_ktbl_workingStepsNoPesti:1:6:2 display p_ktbl_workingStepsNoPesti;

$include '2.ktblData/fertilization.gms'

*
*  --- Calculation of Profit parameter for each potential crop management option without pesticide application operations 
*
parameters
    p_revenue(KTBL_crops,KTBL_system,KTBL_yield) revenues per ha for selling harvested crops 
    p_directCosts(KTBL_crops,KTBL_system,KTBL_yield,manAmounts) Direct Costs for each manure application level
    p_directCostsInt(KTBL_crops,KTBL_system,KTBL_yield,manAmounts) interest costs for inputs
    p_varCostsNewFuel(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    p_varCostsNewFuelInt(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    p_fixCosts(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    p_profitPerHaNoPesti(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
;

*
*---Revenue
*
p_revenue(KTBL_crops,KTBL_system,KTBL_yield)
    = sum(KTBL_figure,
    p_ktbl_revenue(KTBL_crops,KTBL_system,KTBL_yield,KTBL_figure,"amount")
    * p_ktbl_revenue(KTBL_crops,KTBL_system,KTBL_yield,KTBL_figure,"price"))
;
option p_revenue:1:2:1 display p_revenue;

*
*---DirectCosts
*
p_directCosts(KTBL_crops,KTBL_system,KTBL_yield,manAmounts)
    $ (p_dcMinFert(KTBL_crops,KTBL_system,KTBL_yield,manAmounts)) 
    = p_dcMinFert(KTBL_crops,KTBL_system,KTBL_yield,manAmounts) 
    + p_ktbl_directCostsNoFert(KTBL_crops,KTBL_system,KTBL_yield,"rest")
;

option p_directCosts:1:3:1 display p_directCosts;

p_directCostsInt(KTBL_crops,KTBL_system,KTBL_yield,manAmounts)
    = p_directCosts(KTBL_crops,KTBL_system,KTBL_yield,manAmounts) * (3/12) * 0.03
;

*
*Variable Machine Costs
*
p_varCostsNewFuel(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    $ (sum(fertCategory,p_workingStepsEleFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,fertCategory,"maintenance",manAmounts)))
    = sum(varCostsEle,
        p_ktbl_workingStepsNoPesti(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,"rest",varCostsEle))
*calculating out costs for fuel at old price level 
    + p_ktbl_workingStepsNoPesti(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,"rest","fuelCons") * newFuelPrice
    - p_ktbl_workingStepsNoPesti(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,"rest","fuelCons") * ktblFuelPrice
*Costs for each manure application level (file:fertilization.gms)
    + sum((fertCategory,varCostsEle),
        p_workingStepsEleFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,fertCategory,varCostsEle,manAmounts)
    )
    + sum(fertCategory,p_workingStepsEleFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,fertCategory,"FuelCons",manAmounts) * newFuelPrice)
    - sum(fertCategory,p_workingStepsEleFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,fertCategory,"FuelCons",manAmounts) * ktblFuelPrice)
;

option p_varCostsNewFuel:1:6:1 display p_varCostsNewFuel;


p_varCostsNewFuelInt(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    = p_varCostsNewFuel(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts) * (3/12) * 0.03
;

option p_varCostsNewFuelInt:1:6:1 display p_varCostsNewFuelInt;
*
*---Fix machine costs
*
p_fixCosts(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    $ (sum(fertCategory,p_workingStepsEleFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,fertCategory,"deprec",manAmounts)))
    = sum(fixCostsEle,
        p_ktbl_workingStepsNoPesti(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,"rest",fixCostsEle))
    + sum((fertCategory,fixCostsEle),
        p_workingStepsEleFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,fertCategory,fixCostsEle,manAmounts))
;

option p_fixCosts:1:6:1 display p_fixCosts;

*
*---Profit per ha without labor costs and pesticide application operations 
*
p_profitPerHaNoPesti(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    $ (sum(fertType,p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,fertType)))
    = round(
    (p_revenue(KTBL_crops,KTBL_system,KTBL_yield)
    - p_directCosts(KTBL_crops,KTBL_system,KTBL_yield,manAmounts)
    - p_directCostsInt(KTBL_crops,KTBL_system,KTBL_yield,manAmounts)
    - p_varCostsNewFuel(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    - p_varCostsNewFuelInt(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    - p_fixCosts(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts))
    - p_ktbl_workingStepsNoPesti(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,"rest","time") * labPrice
    - sum(fertCategory,
        p_workingStepsEleFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,fertCategory,"time",manAmounts)) * labPrice
    ,3)
;

option p_profitPerHaNoPesti:1:6:1 display p_profitPerHaNoPesti;

*
*  --- load profit and time parameter calculations into gdx file
*
Execute_Unload '3.farmData/gdxFiles/ktblResults_%farmNumber%.gdx',  p_profitPerHaNoPesti;