

parameters 
    p_manureSupply(manAmounts,nutrients) Nutrient supply from manure 
    p_nutDevAllow(nutrients) allowed deviation as upper limit from KTBL nutrient supply for each crop
;

p_nutDevAllow("K2O") = 130;

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


*Calculation of average nutrient content of manure accumulated on farm per m3
p_nutrientSupplyFert('Manure, Farm',"N") = 
    sum(animalBranch, 
    p_animalPlaces(animalBranch) 
    * p_manureAnimalPlace(animalBranch,"Amount")
    * p_manureAnimalPlace(animalBranch,"N")
    ) 
    / sum(animalBranch, p_animalPlaces(animalBranch) * p_manureAnimalPlace(animalBranch,"Amount"))
;

p_nutrientSupplyFert('Manure, Farm',"P2O5") = 
    sum(animalBranch, 
    p_animalPlaces(animalBranch) 
    * p_manureAnimalPlace(animalBranch,"Amount")
    * p_manureAnimalPlace(animalBranch,"P2O5")
    ) 
    / sum(animalBranch, p_animalPlaces(animalBranch) * p_manureAnimalPlace(animalBranch,"Amount"))
;

p_nutrientSupplyFert('Manure, Farm',"K2O") = 
    sum(animalBranch, 
    p_animalPlaces(animalBranch) 
    * p_manureAnimalPlace(animalBranch,"Amount")
    * p_manureAnimalPlace(animalBranch,"K2O")
    ) 
    / sum(animalBranch, p_animalPlaces(animalBranch) * p_manureAnimalPlace(animalBranch,"Amount"))
;

* Calculation of nutrient supply on fields for each manure application level 
p_manureSupply(manAmounts,nutrients)
    = p_manValue(manAmounts) * p_nutrientSupplyFert('Manure, Farm',nutrients)
;

display p_nutrientSupplyFert;
display p_manureSupply;
*
*  --- Calculation of additional amounts of mineral fertilizer necessary at manure application level 0 m3 due to existence of manure application in KTBL data
*
parameters 
    p_ktbl_NutSupply(KTBL_crops,KTBL_system,KTBL_yield,nutrients) overall nutrient supply in KTBL data in kg per unit
    p_ktbl_NutSupplyNoManure(KTBL_crops,KTBL_system,KTBL_yield,nutrients) nutrient supply only from mineral fertilizer in KTBL data in kg per unit
    p_ktbl_ExcessSupplyNoManure(KTBL_crops,KTBL_system,KTBL_yield,nutrients) nutrient deficit according to KTBL data at manure level null without adjustment in kg per unit
;

p_ktbl_NutSupply(KTBL_crops,KTBL_system,KTBL_yield,nutrients) =
    sum(fertType,
    p_nutrientSupplyFert(fertType,nutrients) 
    * p_ktbl_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,fertType))
;
option p_ktbl_NutSupply:1:3:1 display p_ktbl_NutSupply;

p_ktbl_NutSupplyNoManure(KTBL_crops,KTBL_system,KTBL_yield,nutrients) =
    sum(fertType
    $ (not(sameas(fertType,"Guelle, Rind"))), 
    p_nutrientSupplyFert(fertType,nutrients) 
    * p_ktbl_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,fertType))
;

p_ktbl_ExcessSupplyNoManure(KTBL_crops,KTBL_system,KTBL_yield,nutrients) =
    p_ktbl_NutSupply(KTBL_crops,KTBL_system,KTBL_yield,nutrients)
    - p_ktbl_NutSupplyNoManure(KTBL_crops,KTBL_system,KTBL_yield,nutrients)
;

option p_ktbl_ExcessSupplyNoManure:1:3:1 display p_ktbl_ExcessSupplyNoManure;
*
*  --- Calculation of mineral fertilizer amounts at manure application level 0
*
parameter p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,fertType) amount of mineral fertilizer applied when manure application level is zero
;

p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert) 
    $ (ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield) 
    AND p_ktbl_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,pkFert))
    = p_ktbl_ExcessSupplyNoManure(KTBL_crops,KTBL_system,KTBL_yield,"P2O5") 
    / p_nutrientSupplyFert(pkFert,"P2O5")
    + p_ktbl_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
;   

p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose')
    $ (ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield))
    = (p_ktbl_ExcessSupplyNoManure(KTBL_crops,KTBL_system,KTBL_yield,"P2O5")
        / p_nutrientSupplyFert("Diammonphosphat (18 % N, 46 % P2O5), lose","P2O5"))
        $ (not(sum(pkFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert))))
    + p_ktbl_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,"Diammonphosphat (18 % N, 46 % P2O5), lose")
;

p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Kalkammonsalpeter (27 % N), lose') 
    $ (ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield))
    = (p_ktbl_ExcessSupplyNoManure(KTBL_crops,KTBL_system,KTBL_yield,"N")
    - (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose') 
        - p_ktbl_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,"Diammonphosphat (18 % N, 46 % P2O5), lose"))
        * p_nutrientSupplyFert("Diammonphosphat (18 % N, 46 % P2O5), lose","N"))
    / p_nutrientSupplyFert("Kalkammonsalpeter (27 % N), lose","N")
    + p_ktbl_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,"Kalkammonsalpeter (27 % N), lose")
;

p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,kaliFert)
    $ (ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield) 
    AND p_ktbl_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,kaliFert)
    )
    = (p_ktbl_ExcessSupplyNoManure(KTBL_crops,KTBL_system,KTBL_yield,"K2O")
    - sum(pkFert,
        (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert) 
        - p_ktbl_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,pkFert))
        * p_nutrientSupplyFert(pkFert,"K2O")))
    / p_nutrientSupplyFert(kaliFert,"K2O")
    + p_ktbl_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,kaliFert)
;

p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Kali-Duenger (60 % K2O), lose')
    $ (ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield) 
    AND not(sum(kaliFert,p_ktbl_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,kaliFert)))
    )
    = (p_ktbl_ExcessSupplyNoManure(KTBL_crops,KTBL_system,KTBL_yield,"K2O")
    - sum(pkFert,
        (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
        - p_ktbl_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,pkFert))
        * p_nutrientSupplyFert(pkFert,"K2O")))
    / p_nutrientSupplyFert('Kali-Duenger (60 % K2O), lose',"K2O")
;

option p_ktbl_minFertNoManure:1:3:1 display p_ktbl_minFertNoManure;


*
*  --- Parameter assignment reflecting amounts of fertilizer applied for different manure application levels
*
parameter p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,fertType) amount of fertilizer applied for different manure application levels
;

*
*--- Manure
*

p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,'Manure, Farm') 
    $ (ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield))
    = p_manValue(manAmounts)
;

*
*--- PK Fertilizer
*
p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,pkFert)
    $ ((ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield)) 
*parameter shall only be calculated if pk Fertilizer is used in initial situation
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert))
*parameter shall only be calculated if the P2O5 supply can be sufficiently reduced to allow the increase in manure 
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
        - p_manureSupply(manAmounts,"P2O5")
            / p_nutrientSupplyFert(pkFert,"P2O5")
*as long as P2O5 supply from DAP fertilizer can account for P2O5 reduction requirement due to higher manure application, this parameter shall be calculated
        + (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose')
            * p_nutrientSupplyFert('Diammonphosphat (18 % N, 46 % P2O5), lose',"P2O5")
            / p_nutrientSupplyFert(pkFert,"P2O5"))
        $ (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose'))
    gt 0)
* parameter shall only be calculated if the K2O supply can be sufficiently reduced to allow the increase in manure 
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
        - p_manureSupply(manAmounts,"K2O")
        / p_nutrientSupplyFert(pkFert,"K2O")
*as long as K2O supply from potassium fertilizer can account for K2O reduction requirement due to higher manure application, this parameter shall be calculated
        + (sum(kaliFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,kaliFert)
            * p_nutrientSupplyFert(kaliFert,"K2O"))
            / p_nutrientSupplyFert(pkFert,"K2O"))
        $ (sum(kaliFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,kaliFert)))
    gt 0 
*pk fertilizer still shall be used if more K2O is supplied as long as the allowed deviation from the KTBL data is not exceeded 
    - p_nutDevAllow("K2O") / p_nutrientSupplyFert(pkFert,"K2O"))
*if a potassium fertilizer is used in the initial situation, the value 
    )
*amount of pk fertilizer when no manure is spread     
    = p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
*minus amount of pk fertilizer replaced by manure 
    - p_manureSupply(manAmounts,"P2O5")
    / p_nutrientSupplyFert(pkFert,"P2O5")
;

p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,pkFert) 
    $ ((ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield)) 
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert))
* pk Fertilizer parameter shall become 0 if DAP fertilizer or potassium fertilizer is available to account for necessary P2O5 or K2O reduction due to higher manure application amounts
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
        - p_manureSupply(manAmounts,"P2O5") 
        / p_nutrientSupplyFert(pkFert,"P2O5") 
    lt 0)
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
        - p_manureSupply(manAmounts,"P2O5")
        / p_nutrientSupplyFert(pkFert,"P2O5")
*as long as P2O5 supply from DAP fertilizer can account for P2O5 reduction requirement due to higher manure application, this parameter shall be calculated
            + (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose')
                * p_nutrientSupplyFert('Diammonphosphat (18 % N, 46 % P2O5), lose',"P2O5")
                / p_nutrientSupplyFert(pkFert,"P2O5"))
            $ (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose'))
    gt 0)
*as long as K2O supply from potassium fertilizer can account for K2O reduction requirement due to higher manure application, this parameter shall be calculated
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
        - p_manureSupply(manAmounts,"K2O")
        / p_nutrientSupplyFert(pkFert,"K2O")
        + sum(kaliFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,kaliFert)
            * p_nutrientSupplyFert(kaliFert,"K2O"))
            / p_nutrientSupplyFert(pkFert,"K2O")
    gt 0)
        $ (sum(kaliFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,kaliFert)))
    )
    = 0
;

*
*--- DAP fertilizer
*
p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,'Diammonphosphat (18 % N, 46 % P2O5), lose')
    $ ((ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield))
*parameter shall only be calculated if DAP fertilizer is used in initial situation 
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose'))
*parameter shall only be calculated if amount of DAP and KAS in initial situation is still enough to be replaced by manure for N supply 
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose')
        - p_manureSupply(manAmounts,"N")
            / p_nutrientSupplyFert('Diammonphosphat (18 % N, 46 % P2O5), lose',"N")
*KAS fert might only be replaced by manure for N supply if it is used in initial situation
        + (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Kalkammonsalpeter (27 % N), lose')
            * p_nutrientSupplyFert('Kalkammonsalpeter (27 % N), lose',"N")
            / p_nutrientSupplyFert('Diammonphosphat (18 % N, 46 % P2O5), lose',"N"))
        $ (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Kalkammonsalpeter (27 % N), lose'))
    gt 0)
*parameter shall only be calculated if amount of DAP and PK fertilizer is sufficient to be replaced by manure for P2O5 supply 
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose')
        - p_manureSupply(manAmounts,"P2O5")
            / p_nutrientSupplyFert('Diammonphosphat (18 % N, 46 % P2O5), lose',"P2O5")
*PK fertilizer can only be reduced to allow for more manure supply if it is used in initial situation
        + (sum(pkFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
            * p_nutrientSupplyFert(pkFert,"P2O5"))
            / p_nutrientSupplyFert('Diammonphosphat (18 % N, 46 % P2O5), lose',"P2O5"))
        $ (sum(pkFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)))
    gt 0)
    )
    = p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose')
*amount of DAP fertilizer shall be reduced first because of P2O5 when no pk fertilizer is used anymore 
        - (p_manureSupply(manAmounts,"P2O5")
            / p_nutrientSupplyFert('Diammonphosphat (18 % N, 46 % P2O5), lose',"P2O5")
        - (sum(pkFert,
            p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
            * p_nutrientSupplyFert(pkFert,"P2O5"))
            / p_nutrientSupplyFert('Diammonphosphat (18 % N, 46 % P2O5), lose',"P2O5")))
*this calculation shall only be activated if both KAS and PK fertilizer are used in initial situation and there is still enough KAS for N supply replacement
        $ (sum(pkFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert))
        AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Kalkammonsalpeter (27 % N), lose'))
        AND (sum(pkFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
            * p_nutrientSupplyFert(pkFert,"P2O5"))
            - p_manureSupply(manAmounts,"P2O5")
        lt 0)
        AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Kalkammonsalpeter (27 % N), lose')
            - p_manureSupply(manAmounts,"N")
                / p_nutrientSupplyFert('Kalkammonsalpeter (27 % N), lose',"N") 
            + p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose')
                * p_nutrientSupplyFert('Diammonphosphat (18 % N, 46 % P2O5), lose',"N")
                / p_nutrientSupplyFert('Kalkammonsalpeter (27 % N), lose',"N")
        gt 0)
        )
*amount of DAP fertilizer shall be reduced first because of N when no KAS fertilizer is used anymore
        - (p_manureSupply(manAmounts,"N")
            + p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Kalkammonsalpeter (27 % N), lose')
                * p_nutrientSupplyFert('Kalkammonsalpeter (27 % N), lose',"N")
                / p_nutrientSupplyFert('Diammonphosphat (18 % N, 46 % P2O5), lose',"N"))
*this calculation shall only be activated if both KAS and PK fertilizer are used in initial situation and there is still enough PK fertilizer for P2O5 supply replacement
        $ (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Kalkammonsalpeter (27 % N), lose')
        AND (sum(pkFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)))
        AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Kalkammonsalpeter (27 % N), lose')
            - p_manureSupply(manAmounts,"N")
                / p_nutrientSupplyFert('Kalkammonsalpeter (27 % N), lose',"N") 
        lt 0)
        AND (sum(pkFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
            * p_nutrientSupplyFert(pkFert,"P2O5"))
            - p_manureSupply(manAmounts,"P2O5")
        gt 0)
        )
*when no PK fertilizer is used in initial situation, use of DAP has to account fully for the reduction requirement of mineral fertilizer for P2O5 supply 
        - (p_manureSupply(manAmounts,"P2O5")
            / p_nutrientSupplyFert('Diammonphosphat (18 % N, 46 % P2O5), lose',"P2O5"))
        $ (not(sum(pkFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)))
        AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Kalkammonsalpeter (27 % N), lose')
            - p_manureSupply(manAmounts,"N")
                / p_nutrientSupplyFert('Kalkammonsalpeter (27 % N), lose',"N")
        gt 0)
        )
;

*it is not necessary to add non-negative parameter assignment for DAP


*
*--- KAS Fertilizer
*
p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,'Kalkammonsalpeter (27 % N), lose')
    $ ((ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield))
*parameter shall only be calculated if KAS Fertilizer is used in initial situation
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Kalkammonsalpeter (27 % N), lose'))
*parameter shall only be calculated if amount of KAS fertilizer and DAP fertilizer is sufficient to account for increase in supply of N from manure 
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Kalkammonsalpeter (27 % N), lose')
            - p_manureSupply(manAmounts,"N")
            / p_nutrientSupplyFert('Kalkammonsalpeter (27 % N), lose',"N")
            + (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose')
                * p_nutrientSupplyFert('Diammonphosphat (18 % N, 46 % P2O5), lose',"N")
                / p_nutrientSupplyFert('Kalkammonsalpeter (27 % N), lose',"N"))
                $ (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose'))
    gt 0)
    )
*amount of KAS fertilizer when no manure is spread 
    = p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Kalkammonsalpeter (27 % N), lose') 
*minus amount of KAS fertilizer replaced by manure 
    - p_manureSupply(manAmounts,"N")
    / p_nutrientSupplyFert('Kalkammonsalpeter (27 % N), lose',"N")
*if DAP has to be changed because no pk fertilizer is available anymore or never was available, KAS has to be adapted according to the change of DAP
    + ((p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose')
        - p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,'Diammonphosphat (18 % N, 46 % P2O5), lose'))
            * p_nutrientSupplyFert('Diammonphosphat (18 % N, 46 % P2O5), lose',"N")
            / p_nutrientSupplyFert('Kalkammonsalpeter (27 % N), lose',"N"))
    $ (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose')
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose')
        - p_manureSupply(manAmounts,"P2O5")
            / p_nutrientSupplyFert('Diammonphosphat (18 % N, 46 % P2O5), lose',"P2O5")
*PK fertilizer can only be reduced to allow for more manure supply if it is used in initial situation
        + (sum(pkFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
            * p_nutrientSupplyFert(pkFert,"P2O5"))
            / p_nutrientSupplyFert('Diammonphosphat (18 % N, 46 % P2O5), lose',"P2O5"))
        $ (sum(pkFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)))
    gt 0)
    )
;

p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,'Kalkammonsalpeter (27 % N), lose')
    $ ((ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield))
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Kalkammonsalpeter (27 % N), lose'))
* KAS fertilizer parameter shall become 0 if DAP fertilizer is still available to account for necessary N reduction due to higher manure application amounts
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Kalkammonsalpeter (27 % N), lose') 
        - p_manureSupply(manAmounts,"N") 
        / p_nutrientSupplyFert('Kalkammonsalpeter (27 % N), lose',"N") 
    lt 0)
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Kalkammonsalpeter (27 % N), lose')
            - p_manureSupply(manAmounts,"N")
            / p_nutrientSupplyFert('Kalkammonsalpeter (27 % N), lose',"N")
            + (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose')
                * p_nutrientSupplyFert('Diammonphosphat (18 % N, 46 % P2O5), lose',"N")
                / p_nutrientSupplyFert('Kalkammonsalpeter (27 % N), lose',"N"))
                $ (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,'Diammonphosphat (18 % N, 46 % P2O5), lose'))
    gt 0)
    )
    = 0
;

*
*--- Potassium fertilizer
*
p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,kaliFert)
    $ ((ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield))
*parameter shall only be calculated if potassium fertilizer is used in initial situation
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,kaliFert))
*parameter shall only be calculated if amount of potassium fertilizer and pk fertilizer is sufficient to account for increase in supply of K2O from manure
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,kaliFert)
        - p_manureSupply(manAmounts,"K2O")
            / p_nutrientSupplyFert(kaliFert,"K2O")
*pk fert can only be reduced to account for increase in manure if it is used in initial situation
        + (sum(pkFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
            * p_nutrientSupplyFert(pkFert,"K2O"))
            / p_nutrientSupplyFert(kaliFert,"K2O"))
        $ (sum(pkFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)))
    gt 0)
    )
    = p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,kaliFert)
    - p_manureSupply(manAmounts,"K2O")
        / p_nutrientSupplyFert(kaliFert,"K2O")
*the potassium fertilizer shall only be reduced after the pk fertilizer is reduced (if available) according to the P2O5 reduction requirement
    + (sum(pkFert,
        (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
        - p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,pkFert))
            * p_nutrientSupplyFert(pkFert,"K2O"))
            / p_nutrientSupplyFert(kaliFert,"K2O"))
    $ (sum(pkFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)))
;

p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,kaliFert) 
    $ ((ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield))
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,kaliFert))
*amount of kali fertilizer shall become 0 if there is still enough pk fertilizer available to account for the K2O reduction from mineral fertilizer due to increase of manure 
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,kaliFert)
        - p_manureSupply(manAmounts,"K2O")
            / p_nutrientSupplyFert(kaliFert,"K2O")
*the potassium fertilizer shall only be reduced after the pk fertilizer is reduced (if available) according to the P2O5 reduction requirement
        + (sum(pkFert,
            (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
            - p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,pkFert))
                * p_nutrientSupplyFert(pkFert,"K2O"))
                / p_nutrientSupplyFert(kaliFert,"K2O"))
        $ (sum(pkFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)))
    lt 0)
    AND (p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,kaliFert)
        - p_manureSupply(manAmounts,"K2O")
            / p_nutrientSupplyFert(kaliFert,"K2O")
*pk fert can only be reduced to account for increase in manure if it is used in initial situation
        + (sum(pkFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)
            * p_nutrientSupplyFert(pkFert,"K2O"))
            / p_nutrientSupplyFert(kaliFert,"K2O"))
        $(sum(pkFert,p_ktbl_minFertNoManure(KTBL_crops,KTBL_system,KTBL_yield,pkFert)))
    gt 0)
    )
    = 0
;

*
*  --- restrict available options for amounts of mineral fertilizer potentially applied to options which deliver the same amount of nutrients 
*       compared to the initial situation (while respecting defined deviation parameters for nutrients)

parameters 
    p_nutrientSupplyNew(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,nutrients) nutrient supply with manure integration
    p_fertDiff(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,nutrients) difference in nutrient supply between initial KTBL data and manure integration
;

p_nutrientSupplyNew(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,nutrients)
    $ (ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield)
    AND (p_ktbl_NutSupply(KTBL_crops,KTBL_system,KTBL_yield,nutrients)))
    = sum(fertType,
    p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,fertType)
    * p_nutrientSupplyFert(fertType,nutrients))
;

p_fertDiff(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,nutrients)
  = p_nutrientSupplyNew(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,nutrients)
  - p_ktbl_NutSupply(KTBL_crops,KTBL_system,KTBL_yield,nutrients)
;

p_fertDiff(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,nutrients)
* only sufficiently high differences to the initial fertilization situation shall be considered
    $ (p_fertDiff(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,nutrients) lt 0.01
    AND p_fertDiff(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,nutrients) gt -0.01)
    = 0
;

p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,fertType)
*if there is a difference of nutrient supply between the initial and the new fertilization, the parameter 
*shall not be calculated    
    $ (p_fertDiff(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,"N") 
    OR p_fertDiff(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,"P2O5")
    OR (p_fertDiff(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,"K2O") gt p_nutDevAllow("K2O"))
    )
    = 0
;

option p_fertAmount:1:4:1 display p_fertAmount;
*
*  --- direct Costs for mineral fertilizer for each possible manure application level
*
parameter p_dcMinFert(KTBL_crops,KTBL_system,KTBL_yield,manAmounts) direct costs for mineral fertilizer per ha;

p_dcMinFert(KTBL_crops,KTBL_system,KTBL_yield,manAmounts) 
    $ (ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield))
    = sum(minFertEle,
    p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,minFertEle)
    * p_ktbl_fertPrice(minFertEle))
;

option p_dcMinFert:1:3:1 display p_dcMinFert;


*
*  --- variable and fix costs and time requirements for mineral fertilizer and manure for each possible manure application level
*       the approach is to divide the initial value from KTBL with the amount of fertilizer applied and multiply it with the amount applied for each manure application level

parameter p_workingStepsEleFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,fertCategory,workingStepsEle,manAmounts);

*
*--- mineral fertilizer
*   
p_workingStepsEleFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,"minFert",workingStepsEle,manAmounts)
    $ (ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield)) =
    p_ktbl_workingStepsNoPesti(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,"minFert",workingStepsEle)
    / sum(minFertEle,p_ktbl_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,minFertEle))
    * sum(minFertEle,p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,minFertEle))
;

*
*---manure
*
p_workingStepsEleFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,"manure",workingStepsEle,manAmounts)
*in the initial situation, manure was used only for the following crops (grassland and corn)
    $ ((ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield))
    AND ((sameas(KTBL_crops,'Ackergras - Anwelksilage'))
    OR (sameas(KTBL_crops,'Ackergras - Bodenheu'))
    OR (sameas(KTBL_crops,'Dauergruenland, grasbetont - Anwelksilage'))
    OR (sameas(KTBL_crops,'Dauergruenland, grasbetont - Bodenheu'))
    OR (sameas(KTBL_crops,'Mais - Corn-Cob-Mix'))
    OR (sameas(KTBL_crops,'Mais - Koernermais'))
    OR (sameas(KTBL_crops,'Mais - Silomais')))
    ) = 
    p_ktbl_workingStepsNoPesti(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,"manure",workingStepsEle)
    / p_ktbl_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,'Guelle, Rind')
    * p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,'Manure, Farm')
;

p_workingStepsEleFert(KTBL_crops,KTBL_system,KTBL_size,KTBL_yield,KTBL_mechanisation,KTBL_distance,"manure",workingStepsEle,manAmounts)
*if no manure was used in the initial situation, the data for maize is used 
    $ ((ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield))
    AND (not(sameas(KTBL_crops,'Ackergras - Anwelksilage')))
    AND (not(sameas(KTBL_crops,'Ackergras - Bodenheu')))
    AND (not(sameas(KTBL_crops,'Dauergruenland, grasbetont - Anwelksilage')))
    AND (not(sameas(KTBL_crops,'Dauergruenland, grasbetont - Bodenheu')))
    AND (not(sameas(KTBL_crops,'Mais - Corn-Cob-Mix')))
    AND (not(sameas(KTBL_crops,'Mais - Koernermais')))
    AND (not(sameas(KTBL_crops,'Mais - Silomais')))
    ) =
    p_ktbl_workingStepsNoPesti('Mais - Silomais','wendend, gezogene Saatbettbereitung, Saat',KTBL_size,'mittel, mittlerer Boden',KTBL_mechanisation,KTBL_distance,"manure",workingStepsEle)
    / p_ktbl_fertAmount('Mais - Silomais','wendend, gezogene Saatbettbereitung, Saat','mittel, mittlerer Boden','Guelle, Rind')
    * p_fertAmount(KTBL_crops,KTBL_system,KTBL_yield,manAmounts,'Manure, Farm')
;

option p_workingStepsEleFert:1:8:1 display p_workingStepsEleFert;