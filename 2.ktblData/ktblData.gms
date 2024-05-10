


$include '2.ktblData/KTBL_inputOptions+Sets.gms'
$setglobal farmNumber 1
$include '3.farmData/typFarm_%farmNumber%.gms'

*
*  --- Reading parameter values from gdx files into model
*

parameters
    p_ktbl_revenue(KTBL_crops,KTBL_system,KTBL_yield,KTBL_figure,reveCat)
    p_ktbl_directCostsNoFert(KTBL_crops,KTBL_system,KTBL_yield,CostsEle)
    p_ktbl_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,fertType)
    p_ktbl_varFixCostsNoPesti(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,CostsEle,CostsType) KTBL data for fuel consumption & variable machine costs without fuel consumption & fix machine costs
    p_ktbl_timeReq(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,CostsEle)
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

*load in data for variable and fix costs for each crop
$Gdxin 2.ktblData/gdxFiles/KTBL_VarFixCosts.gdx
$load p_ktbl_varFixCostsNoPesti=p_ktbl_varfixCosts
$gdxin
option p_ktbl_varFixCostsNoPesti:1:6:2 display p_ktbl_varFixCostsNoPesti;

*load in time requirement data for module labour.gms
$Gdxin 2.ktblData/gdxFiles/KTBL_time.gdx
$load p_ktbl_timeReq=p_ktbl_timeReq 
$gdxin
option p_ktbl_timeReq:1:6:1 display p_ktbl_timeReq;


$include '2.ktblData/fertilization.gms'

*
*  --- Calculation of Profit parameter for each potential crop management option 
*
parameters
    p_revenue(KTBL_crops,KTBL_system,KTBL_yield) revenues per ha for selling harvested crops 
    p_directCosts(KTBL_crops,KTBL_system,KTBL_yield,manAmounts) Direct Costs for each manure application level
    p_directCostsInt(KTBL_crops,KTBL_system,KTBL_yield,manAmounts) interest costs for inputs
    p_varCostsNewFuel(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    p_varCostsNewFuelInt(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    p_fixCosts(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    p_profitPerHa(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
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
    $ (sum(fertCategory,p_varFixCostsFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,fertCategory,"varCostsNoFuel",manAmounts)))
    = p_ktbl_varFixCostsNoPesti(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,"rest","FuelCons") * p_newFuelPrice
    + p_ktbl_varFixCostsNoPesti(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,"rest","varCostsNoFuel")
*Costs for each manure application level (file:fertilization.gms)
    + sum(fertCategory,
        p_varFixCostsFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,fertCategory,"FuelCons",manAmounts) * p_newFuelPrice
        + p_varFixCostsFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,fertCategory,"varCostsNoFuel",manAmounts))
;

option p_varCostsNewFuel:1:6:1 display p_varCostsNewFuel;


p_varCostsNewFuelInt(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    = p_varCostsNewFuel(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts) * (3/12) * 0.03
;

*
*---Fix machine costs
*
p_fixCosts(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    $ (sum(fertCategory,p_varFixCostsFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,fertCategory,"fixCosts",manAmounts)))
    = p_ktbl_varFixCostsNoPesti(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,"rest","fixCosts")
    + sum(fertCategory,p_varFixCostsFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,fertCategory,"fixCosts",manAmounts))
;

option p_fixCosts:1:6:1 display p_fixCosts;

*
*---Profit per ha without labor costs
*
p_profitPerHa(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    $ (sum(fertCategory,p_varFixCostsFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,fertCategory,"fixCosts",manAmounts)))
    = round(
    (p_revenue(KTBL_crops,KTBL_system,KTBL_yield)
    - p_directCosts(KTBL_crops,KTBL_system,KTBL_yield,manAmounts)
    - p_directCostsInt(KTBL_crops,KTBL_system,KTBL_yield,manAmounts)
    - p_varCostsNewFuel(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    - p_varCostsNewFuelInt(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts)
    - p_fixCosts(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,manAmounts))
    ,2)
;

option p_profitPerHa:1:6:1 display p_profitPerHa;


*
*  --- load profit and time parameter calculations into gdx file
*
Execute_Unload '3.farmData/gdxFiles/ktblResults_%farmNumber%.gdx',  p_profitPerHa, p_timeReq;
