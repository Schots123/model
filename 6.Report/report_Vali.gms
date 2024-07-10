summaryVali("Mais","dcPesti",technology,scenario) $ p_technology_scenario(technology,scenario) = 
  sum(pestType, 
  p_sprayInputCosts("Mais - Silomais","hoch, mittlerer Boden",pestType) 
  * (1 - (p_technoPestEff("Mais - Silomais",technology,scenario,pestType))))
;

summaryVali("Zuckerrueben","dcPesti",technology,scenario) $ p_technology_scenario(technology,scenario) =
  sum(pestType, 
  p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) 
  * (1 - (p_technoPestEff("Zuckerrueben",technology,scenario,pestType))))
;


summaryVali("Winterweizen","dcPesti",technology,scenario) $ p_technology_scenario(technology,scenario) =
  sum(pestType, 
  p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) 
  * (1 - (p_technoPestEff("Winterweizen - Backweizen",technology,scenario,pestType))))
;



summaryVali("Mais","labourCosts",technology,scenario) =
  sum(pestType,
  p_numberSprayPassesScenarios("Mais - Silomais","hoch, mittlerer Boden",technology,scenario,"BA_102KW",pestType)
  * p_technoTimeReq("5","1",scenario,"BA_102kW",pestType) 
  * labPrice
  * timeReqVar("BA_102KW")
  )
;

summaryVali("Zuckerrueben","labourCosts",technology,scenario) =
  sum(pestType,
  p_numberSprayPassesScenarios("Zuckerrueben","hoch, mittlerer Boden",technology,scenario,"BA_102KW",pestType)
  * p_technoTimeReq("5","1",scenario,"BA_102kW",pestType) 
  * labPrice
  * timeReqVar("BA_102KW")
  )
;

summaryVali("Winterweizen","labourCosts",technology,scenario) =
  sum(pestType,
  p_numberSprayPassesScenarios("Winterweizen - Backweizen","hoch, mittlerer Boden",technology,scenario,"BA_102KW",pestType)
  * p_technoTimeReq("5","1",scenario,"BA_102kW",pestType) 
  * labPrice
  * timeReqVar("BA_102KW")
  )
;


$ontext
summaryVali("Mais - Silomais","otherCosts",technology,scenario) =
  sum((scenSprayer,pestType),
  p_numberSprayPassesScenarios("Mais - Silomais","hoch, mittlerer Boden",technology,scenario,scenSprayer,pestType)
  * p_technoOtherCosts("5","102","1",scenario,scenSprayer,pestType)
  )
;

summaryVali("Zuckerrueben","otherCosts",technology,scenario) =
  sum((scenSprayer,pestType),
  p_numberSprayPassesScenarios("Zuckerrueben","hoch, mittlerer Boden",technology,scenario,scenSprayer,pestType)
  * p_technoOtherCosts("5","102","1",scenario,scenSprayer,pestType)
  )
;

summaryVali("Winterweizen - Backweizen","otherCosts",technology,scenario) =
  sum((scenSprayer,pestType),
  p_numberSprayPassesScenarios("Winterweizen - Backweizen","hoch, mittlerer Boden",technology,scenario,scenSprayer,pestType)
  * p_technoOtherCosts("5","102","1",scenario,scenSprayer,pestType)
  )
;
$offtext


summaryVali("Mais","fuelCosts",technology,scenario) =
  sum(pestType,
  p_numberSprayPassesScenarios("Mais - Silomais","hoch, mittlerer Boden",technology,scenario,"BA_102KW",pestType)
  * p_technoFuelCons("5","1",scenario,"BA_102KW",pestType) * newFuelPrice
  )
;

summaryVali("Zuckerrueben","fuelCosts",technology,scenario) =
  sum(pestType,
  p_numberSprayPassesScenarios("Zuckerrueben","hoch, mittlerer Boden",technology,scenario,"BA_102KW",pestType)
  * p_technoFuelCons("5","1",scenario,"BA_102KW",pestType) * newFuelPrice
  )
;

summaryVali("Winterweizen","fuelCosts",technology,scenario) =
  sum(pestType,
  p_numberSprayPassesScenarios("Winterweizen - Backweizen","hoch, mittlerer Boden",technology,scenario,"BA_102KW",pestType)
  * p_technoFuelCons("5","1",scenario,"BA_102KW",pestType) * newFuelPrice
  )
;



summaryVali("Mais","repCosts",technology,scenario) =
  sum(pestType,
  p_numberSprayPassesScenarios("Mais - Silomais","hoch, mittlerer Boden",technology,scenario,"BA_102KW",pestType)
  * p_technoMaintenance("5","1",scenario,"BA_102KW",pestType)
  )
;

summaryVali("Zuckerrueben","repCosts",technology,scenario) =
  sum(pestType,
  p_numberSprayPassesScenarios("Zuckerrueben","hoch, mittlerer Boden",technology,scenario,"BA_102KW",pestType)
  * p_technoMaintenance("5","1",scenario,"BA_102KW",pestType)
  )
;

summaryVali("Winterweizen","repCosts",technology,scenario) =
  sum(pestType,
  p_numberSprayPassesScenarios("Winterweizen - Backweizen","hoch, mittlerer Boden",technology,scenario,"BA_102KW",pestType)
  * p_technoMaintenance("5","1",scenario,"BA_102KW",pestType)
  )
;



summaryVali("Mais","avgAnnProf",technology,scenario) = 
  p_profitPerHaNoPesti("Mais - Silomais",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    p_sprayInputCosts("Mais - Silomais","hoch, mittlerer Boden",pestType) 
    * (1 - (p_technoPestEff("Mais - Silomais",technology,scenario,pestType)))
  )
  - sum(pestType, 
    p_numberSprayPassesScenarios("Mais - Silomais","hoch, mittlerer Boden",technology,scenario,"BA_102KW",pestType)
    * (
      p_technoTimeReq("5","1",scenario,"BA_102KW",pestType) * labPrice * timeReqVar("BA_102KW")
      + p_technoFuelCons("5","1",scenario,"BA_102KW",pestType) * newFuelPrice
      + p_technoMaintenance("5","1",scenario,"BA_102KW",pestType)
      )
  )
;

summaryVali("Zuckerrueben","avgAnnProf",technology,scenario) =
  p_profitPerHaNoPesti("Zuckerrueben",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) 
    * (1 - (p_technoPestEff("Zuckerrueben",technology,scenario,pestType)))
  )
  - sum(pestType, 
    p_numberSprayPassesScenarios("Zuckerrueben","hoch, mittlerer Boden",technology,scenario,"BA_102KW",pestType)
    * (
      p_technoTimeReq("5","1",scenario,"BA_102KW",pestType) * labPrice * timeReqVar("BA_102KW")
      + p_technoFuelCons("5","1",scenario,"BA_102KW",pestType) * newFuelPrice
      + p_technoMaintenance("5","1",scenario,"BA_102KW",pestType)
      )
  )
;

summaryVali("Winterweizen","avgAnnProf",technology,scenario) =
    p_profitPerHaNoPesti("Winterweizen - Backweizen",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) 
    * (1 - (p_technoPestEff("Winterweizen - Backweizen",technology,scenario,pestType)))
  )
  - sum(pestType, 
    p_numberSprayPassesScenarios("Winterweizen - Backweizen","hoch, mittlerer Boden",technology,scenario,"BA_102KW",pestType)
    * (
      p_technoTimeReq("5","1",scenario,"BA_102KW",pestType) * labPrice * timeReqVar("BA_102KW")
      + p_technoFuelCons("5","1",scenario,"BA_102KW",pestType) * newFuelPrice
      + p_technoMaintenance("5","1",scenario,"BA_102KW",pestType)
      )
  )
;