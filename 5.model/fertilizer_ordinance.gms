

parameter p_manureAnimalPlace(animalBranch,man_attr);

*assumptions from KTBL Wirtschaftsdüngerrechner (24.05.2024)
p_manureAnimalPlace("milkCows","Amount") = 18.4;
p_manureAnimalPlace("milkCows","N") = 5.2;
p_manureAnimalPlace("milkCows","P2O5") = 2.4;
p_manureAnimalPlace("milkCows","K2O") = 6.8;

p_manureAnimalPlace("fattPigs","Amount") = 1;
p_manureAnimalPlace("fattPigs","N") = 8.4;
p_manureAnimalPlace("fattPigs","P2O5") = 4.3;
p_manureAnimalPlace("fattPigs","K2O") = 5.7;


scalar farmManureAmount Amount of manure accrued on farm annually;
farmManureAmount = sum(animalBranch, p_animalPlaces(animalBranch) * p_manureAnimalPlace(animalBranch,"Amount"));

parameter p_manureSupply(manAmounts,nutrients) Nutrient supply from manure;
p_manureSupply(manAmounts,nutrients) = p_manValue(manAmounts) * p_nutrientSupplyFert('Manure, Farm',nutrients);

positive variables
  v_manureUse(years) Use of manure on farm as fertilizer
  v_manExports(years) Farm exports of manure 
  v_170Slack(years)
;

Equations
  e_manureUse(years)
  e_man_balance(years) ensures that manure produced on the farm is either applied or sold 
  e_170_avg(years) 
;

e_manureUse(years)..
  v_manureUse(years)
  =E=
  sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
      $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
      ),
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
    * p_plotData(curPlots,"size") * sizeFactor
    * p_manValue(manAmounts))
;

e_man_balance(years)..
    v_manureUse(years) + v_manExports(years)
    =E= farmManureAmount
;

*for plots not in red areas, the N supply from manure is not allowed to exceed 170 kg on average
  e_170_avg(years)..
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
      ),
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years)
    * p_plotData(curPlots,"size") * sizeFactor
    * p_manureSupply(manAmounts,"N"))
    /p_totLand 
    =L= 170 + v_170Slack(years)
;