
summaryVali("Zuckerrueben","dcPesti",technology,scenario) $ p_technology_scenario(technology,scenario) =
  sum(pestType, 
  (p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) 
  + p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
  * (1 - (p_technoPestEff("Zuckerrueben",technology,scenario,pestType))))
;

summaryVali("Winterweizen","dcPesti",technology,scenario) $ p_technology_scenario(technology,scenario) =
  sum(pestType, 
  (p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) 
  + p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
  * (1 - (p_technoPestEff("Winterweizen - Backweizen",technology,scenario,pestType))))
;



*
* --- Model validation base scenario
*
summaryVali("Zuckerrueben","labourCosts","baseline","Base") =
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
  * p_technoTimeReq("5","1","Base","BA_102kW",pestType) 
  * labPrice
  )
;

summaryVali("Winterweizen","labourCosts","baseline","Base") =
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
  * p_technoTimeReq("5","1","Base","BA_102kW",pestType) 
  * labPrice
  )
;



summaryVali("Zuckerrueben","fuelCosts","baseline","Base") =
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
  * (p_technoFuelCons("5","1","Base","BA_102KW",pestType) + p_technoFuelCons("5","1","Base","BA_102KW",pestType) * (0.03 * (3/12)))
  * newFuelPrice
  )
;

summaryVali("Winterweizen","fuelCosts","baseline","Base") =
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
  * (p_technoFuelCons("5","1","Base","BA_102KW",pestType) + p_technoFuelCons("5","1","Base","BA_102KW",pestType) * (0.03 * (3/12))) 
  * newFuelPrice
  )
;



summaryVali("Zuckerrueben","repCosts","baseline","Base") =
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
  * (p_technoMaintenance("5","1","Base","BA_102KW",pestType) + p_technoMaintenance("5","1","Base","BA_102KW",pestType) * (0.03 * (3/12))) 
  )
;

summaryVali("Winterweizen","repCosts","baseline","Base") =
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
  * (p_technoMaintenance("5","1","Base","BA_102KW",pestType) + p_technoMaintenance("5","1","Base","BA_102KW",pestType) * (0.03 * (3/12))) 
  )
;



summaryVali("Zuckerrueben","varMachCostsSprayer","baseline","Base") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
  * (p_technoMaintenance("5","1","Base","BA_102KW",pestType) + p_technoMaintenance("5","1","Base","BA_102KW",pestType) * (0.03 * (3/12)))
  ) +
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
  * (p_technoFuelCons("5","1","Base","BA_102KW",pestType) + p_technoFuelCons("5","1","Base","BA_102KW",pestType) * (0.03 * (3/12))) * newFuelPrice 
  ) +
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
  * p_technoTimeReq("5","1","Base","BA_102kW",pestType) * labPrice
  )
;

summaryVali("Winterweizen","varMachCostsSprayer","baseline","Base") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
  * (p_technoMaintenance("5","1","Base","BA_102KW",pestType) + p_technoMaintenance("5","1","Base","BA_102KW",pestType) * (0.03 * (3/12)))
  ) +
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
  * (p_technoFuelCons("5","1","Base","BA_102KW",pestType) + p_technoFuelCons("5","1","Base","BA_102KW",pestType) * (0.03 * (3/12))) * newFuelPrice 
  ) +
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
  * p_technoTimeReq("5","1","Base","BA_102kW",pestType) 
  * labPrice
  )
;



summaryVali("Zuckerrueben","fixCostsTractor","baseline","Base") = 
  (p_tractorDeprec("BA_102KW")
  + p_tractorInterest("BA_102KW")
  + p_tractorOtherCosts("BA_102KW")) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
    * p_technoTimeReq("5","1","Base","BA_102kW",pestType)) 
;

summaryVali("Winterweizen","fixCostsTractor","baseline","Base") = 
  (p_tractorDeprec("BA_102KW")
  + p_tractorInterest("BA_102KW")
  + p_tractorOtherCosts("BA_102KW")) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
    * p_technoTimeReq("5","1","Base","BA_102kW",pestType)) 
;



summaryVali("Zuckerrueben","avgAnnProf","baseline","Base") =
  p_profitPerHaNoPesti("Zuckerrueben",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Zuckerrueben","baseline","Base",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","Base","BA_102KW",pestType) * labPrice
      + (p_technoFuelCons("5","1","Base","BA_102KW",pestType) + p_technoFuelCons("5","1","Base","BA_102KW",pestType) * (3/12) * 0.03) * newFuelPrice
      + (p_technoMaintenance("5","1","Base","BA_102KW",pestType) + p_technoMaintenance("5","1","Base","BA_102KW",pestType) * (3/12) * 0.03)
      )
  )
  - (p_tractorDeprec("BA_102KW") + p_tractorInterest("BA_102KW") + p_tractorOtherCosts("BA_102KW")) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
    * p_technoTimeReq("5","1","Base","BA_102kW",pestType)) 
;

summaryVali("Winterweizen","avgAnnProf","baseline","Base") =
    p_profitPerHaNoPesti("Winterweizen - Backweizen",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Winterweizen - Backweizen","baseline","Base",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","Base","BA_102KW",pestType) * labPrice
      + p_technoFuelCons("5","1","Base","BA_102KW",pestType)  * newFuelPrice
      + p_technoFuelCons("5","1","Base","BA_102KW",pestType) * (3/12) * 0.03 * newFuelPrice
      + p_technoMaintenance("5","1","Base","BA_102KW",pestType) 
      + p_technoMaintenance("5","1","Base","BA_102KW",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("BA_102KW") + p_tractorInterest("BA_102KW") + p_tractorOtherCosts("BA_102KW")) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","baseline","Base","BA_102KW",pestType,halfMonth)
    * p_technoTimeReq("5","1","Base","BA_102kW",pestType)) 
;



*
* --- SST6m
*

*
* --- Scenario 1

* --- SSPAs
summaryVali("Zuckerrueben","varMachCostsSprayer","spot6m","FH") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH","spot6m",pestType,halfMonth)
  * (
    p_technoMaintenance("5","1","FH","spot6m",pestType) 
    + p_technoMaintenance("5","1","FH","spot6m",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH","spot6m",pestType) * newFuelPrice
    + p_technoFuelCons("5","1","FH","spot6m",pestType) * newFuelPrice * (3/12) * 0.03
    + p_technoTimeReq("5","1","FH","spot6m",pestType) * labPrice)
  )
  + sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH","BA_102KW",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH","BA_102KW",pestType) 
    + p_technoMaintenance("5","1","FH","BA_102KW",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH","BA_102KW",pestType) * newFuelPrice 
    + p_technoFuelCons("5","1","FH","BA_102KW",pestType) * newFuelPrice * (3/12) * 0.03 
    + p_technoTimeReq("5","1","FH","BA_102KW",pestType) * labPrice)
  )
;

summaryVali("Winterweizen","varMachCostsSprayer","spot6m","FH") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH","spot6m",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH","spot6m",pestType) 
  + p_technoMaintenance("5","1","FH","spot6m",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH","spot6m",pestType) * newFuelPrice
    + p_technoFuelCons("5","1","FH","spot6m",pestType) * newFuelPrice * (3/12) * 0.03
    + p_technoTimeReq("5","1","FH","spot6m",pestType) * labPrice)
  )
  + sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH","BA_102KW",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH","BA_102KW",pestType) 
    + p_technoMaintenance("5","1","FH","BA_102KW",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH","BA_102KW",pestType) * newFuelPrice 
    + p_technoFuelCons("5","1","FH","BA_102KW",pestType) * newFuelPrice * (3/12) * 0.03
    + p_technoTimeReq("5","1","FH","BA_102KW",pestType) * labPrice)
  )
;



summaryVali("Zuckerrueben","fixCostsTractor","spot6m","FH") = 
  (
    p_tractorDeprec("spot6m")
    + p_tractorInterest("spot6m")
    + p_tractorOtherCosts("spot6m")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH","spot6m",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH","spot6m",pestType)) 
  + (
    p_tractorDeprec("BA_102KW")
    + p_tractorInterest("BA_102KW")
    + p_tractorOtherCosts("BA_102KW")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH","BA_102KW",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH","BA_102KW",pestType)) 
;

summaryVali("Winterweizen","fixCostsTractor","spot6m","FH") = 
  (
    p_tractorDeprec("spot6m")
    + p_tractorInterest("spot6m")
    + p_tractorOtherCosts("spot6m")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH","spot6m",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH","spot6m",pestType)) 
  + (
    p_tractorDeprec("BA_102KW")
    + p_tractorInterest("BA_102KW")
    + p_tractorOtherCosts("BA_102KW")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH","BA_102KW",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH","BA_102KW",pestType)) 
;



summaryVali("Zuckerrueben","avgAnnProf","spot6m","FH") =
  p_profitPerHaNoPesti("Zuckerrueben",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Zuckerrueben","spot6m","FH",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH","spot6m",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH","spot6m",pestType) * labPrice
      + p_technoFuelCons("5","1","FH","spot6m",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH","spot6m",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH","spot6m",pestType) 
      + p_technoMaintenance("5","1","FH","spot6m",pestType) * (3/12) * 0.03
      )
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH","BA_102KW",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH","BA_102KW",pestType) * labPrice
      + p_technoFuelCons("5","1","FH","BA_102KW",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH","BA_102KW",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH","BA_102KW",pestType) 
      + p_technoMaintenance("5","1","FH","BA_102KW",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("spot6m") + p_tractorInterest("spot6m") + p_tractorOtherCosts("spot6m"))
  * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH","spot6m",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH","spot6m",pestType)
  ) 
  - (p_tractorDeprec("BA_102KW") + p_tractorInterest("BA_102KW") + p_tractorOtherCosts("BA_102KW"))
  * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH","BA_102KW",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH","BA_102KW",pestType)
  ) 
;


summaryVali("Winterweizen","avgAnnProf","spot6m","FH") =
    p_profitPerHaNoPesti("Winterweizen - Backweizen",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Winterweizen - Backweizen","spot6m","FH",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH","spot6m",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH","spot6m",pestType) * labPrice
      + p_technoFuelCons("5","1","FH","spot6m",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH","spot6m",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH","spot6m",pestType) 
      + p_technoMaintenance("5","1","FH","spot6m",pestType) * (3/12) * 0.03
      )
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH","BA_102KW",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH","BA_102KW",pestType) * labPrice
      + p_technoFuelCons("5","1","FH","BA_102KW",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH","BA_102KW",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH","BA_102KW",pestType) 
      + p_technoMaintenance("5","1","FH","BA_102KW",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("spot6m") + p_tractorInterest("spot6m") + p_tractorOtherCosts("spot6m"))
    * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH","spot6m",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH","spot6m",pestType)
  ) 
  - (p_tractorDeprec("BA_102KW") + p_tractorInterest("BA_102KW") + p_tractorOtherCosts("BA_102KW"))
    * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH","BA_102KW",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH","BA_102KW",pestType) 
  )
;



* --- SSPAs & BAs
summaryVali("Zuckerrueben","varMachCostsSprayer","spot6m","FH+BA") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH+BA","spot6m",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH+BA","spot6m",pestType) 
    + p_technoMaintenance("5","1","FH+BA","spot6m",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH+BA","spot6m",pestType) * newFuelPrice
    + p_technoFuelCons("5","1","FH+BA","spot6m",pestType) * newFuelPrice * (3/12) * 0.03
    + p_technoTimeReq("5","1","FH+BA","spot6m",pestType) * labPrice)
  )
;

summaryVali("Winterweizen","varMachCostsSprayer","spot6m","FH+BA") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH+BA","spot6m",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH+BA","spot6m",pestType) 
    + p_technoMaintenance("5","1","FH+BA","spot6m",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH+BA","spot6m",pestType) * newFuelPrice
    + p_technoFuelCons("5","1","FH+BA","spot6m",pestType) * newFuelPrice * (3/12) * 0.03 
    + p_technoTimeReq("5","1","FH+BA","spot6m",pestType) * labPrice)
  )
;



summaryVali("Zuckerrueben","fixCostsTractor","spot6m","FH+BA") = 
  (
    p_tractorDeprec("spot6m")
    + p_tractorInterest("spot6m")
    + p_tractorOtherCosts("spot6m")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH+BA","spot6m",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH+BA","spot6m",pestType)) 
;

summaryVali("Winterweizen","fixCostsTractor","spot6m","FH+BA") = 
  (
    p_tractorDeprec("spot6m")
    + p_tractorInterest("spot6m")
    + p_tractorOtherCosts("spot6m")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH+BA","spot6m",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH+BA","spot6m",pestType)) 
;



summaryVali("Zuckerrueben","avgAnnProf","spot6m","FH+BA") =
  p_profitPerHaNoPesti("Zuckerrueben",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Zuckerrueben","spot6m","FH+BA",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH+BA","spot6m",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH+BA","spot6m",pestType) * labPrice
      + p_technoFuelCons("5","1","FH+BA","spot6m",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH+BA","spot6m",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH+BA","spot6m",pestType) 
      + p_technoMaintenance("5","1","FH+BA","spot6m",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("spot6m") + p_tractorInterest("spot6m") + p_tractorOtherCosts("spot6m"))
  * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH+BA","spot6m",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH+BA","spot6m",pestType)
  ) 
;


summaryVali("Winterweizen","avgAnnProf","spot6m","FH+BA") =
    p_profitPerHaNoPesti("Winterweizen - Backweizen",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Winterweizen - Backweizen","spot6m","FH+BA",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH+BA","spot6m",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH+BA","spot6m",pestType) * labPrice
      + p_technoFuelCons("5","1","FH+BA","spot6m",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH+BA","spot6m",pestType) * newFuelPrice * (3/12) * 0.03 
      + p_technoMaintenance("5","1","FH+BA","spot6m",pestType) 
      + p_technoMaintenance("5","1","FH+BA","spot6m",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("spot6m") + p_tractorInterest("spot6m") + p_tractorOtherCosts("spot6m"))
    * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH+BA","spot6m",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH+BA","spot6m",pestType)
  ) 
;




*
* --- Scenario 2

* --- SSPAs
summaryVali("Zuckerrueben","varMachCostsSprayer","spot6m","FH+Bonus") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH+Bonus","spot6m",pestType,halfMonth)
  * (
    p_technoMaintenance("5","1","FH+Bonus","spot6m",pestType) 
    + p_technoMaintenance("5","1","FH+Bonus","spot6m",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH+Bonus","spot6m",pestType) * newFuelPrice
    + p_technoFuelCons("5","1","FH+Bonus","spot6m",pestType) * newFuelPrice * (3/12) * 0.03
    + p_technoTimeReq("5","1","FH+Bonus","spot6m",pestType) * labPrice)
  )
  + sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH+Bonus","BA_102KW",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH+Bonus","BA_102KW",pestType) 
    + p_technoMaintenance("5","1","FH+Bonus","BA_102KW",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH+Bonus","BA_102KW",pestType) * newFuelPrice 
    + p_technoFuelCons("5","1","FH+Bonus","BA_102KW",pestType) * newFuelPrice * (3/12) * 0.03 
    + p_technoTimeReq("5","1","FH+Bonus","BA_102KW",pestType) * labPrice)
  )
;

summaryVali("Winterweizen","varMachCostsSprayer","spot6m","FH+Bonus") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH+Bonus","spot6m",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH+Bonus","spot6m",pestType) 
  + p_technoMaintenance("5","1","FH+Bonus","spot6m",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH+Bonus","spot6m",pestType) * newFuelPrice
    + p_technoFuelCons("5","1","FH+Bonus","spot6m",pestType) * newFuelPrice * (3/12) * 0.03
    + p_technoTimeReq("5","1","FH+Bonus","spot6m",pestType) * labPrice)
  )
  + sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH+Bonus","BA_102KW",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH+Bonus","BA_102KW",pestType) 
    + p_technoMaintenance("5","1","FH+Bonus","BA_102KW",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH+Bonus","BA_102KW",pestType) * newFuelPrice 
    + p_technoFuelCons("5","1","FH+Bonus","BA_102KW",pestType) * newFuelPrice * (3/12) * 0.03
    + p_technoTimeReq("5","1","FH+Bonus","BA_102KW",pestType) * labPrice)
  )
;



summaryVali("Zuckerrueben","fixCostsTractor","spot6m","FH+Bonus") = 
  (
    p_tractorDeprec("spot6m")
    + p_tractorInterest("spot6m")
    + p_tractorOtherCosts("spot6m")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH+Bonus","spot6m",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH+Bonus","spot6m",pestType)) 
  + (
    p_tractorDeprec("BA_102KW")
    + p_tractorInterest("BA_102KW")
    + p_tractorOtherCosts("BA_102KW")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH+Bonus","BA_102KW",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH+Bonus","BA_102KW",pestType)) 
;

summaryVali("Winterweizen","fixCostsTractor","spot6m","FH+Bonus") = 
  (
    p_tractorDeprec("spot6m")
    + p_tractorInterest("spot6m")
    + p_tractorOtherCosts("spot6m")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH+Bonus","spot6m",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH+Bonus","spot6m",pestType)) 
  + (
    p_tractorDeprec("BA_102KW")
    + p_tractorInterest("BA_102KW")
    + p_tractorOtherCosts("BA_102KW")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH+Bonus","BA_102KW",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH+Bonus","BA_102KW",pestType)) 
;



summaryVali("Zuckerrueben","avgAnnProf","spot6m","FH+Bonus") =
  p_profitPerHaNoPesti("Zuckerrueben",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Zuckerrueben","spot6m","FH+Bonus",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH+Bonus","spot6m",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH+Bonus","spot6m",pestType) * labPrice
      + p_technoFuelCons("5","1","FH+Bonus","spot6m",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH+Bonus","spot6m",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH+Bonus","spot6m",pestType) 
      + p_technoMaintenance("5","1","FH+Bonus","spot6m",pestType) * (3/12) * 0.03
      )
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH+Bonus","BA_102KW",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH+Bonus","BA_102KW",pestType) * labPrice
      + p_technoFuelCons("5","1","FH+Bonus","BA_102KW",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH+Bonus","BA_102KW",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH+Bonus","BA_102KW",pestType) 
      + p_technoMaintenance("5","1","FH+Bonus","BA_102KW",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("spot6m") + p_tractorInterest("spot6m") + p_tractorOtherCosts("spot6m"))
  * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH+Bonus","spot6m",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH+Bonus","spot6m",pestType)
  ) 
  - (p_tractorDeprec("BA_102KW") + p_tractorInterest("BA_102KW") + p_tractorOtherCosts("BA_102KW"))
  * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH+Bonus","BA_102KW",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH+Bonus","BA_102KW",pestType)
  ) 
;


summaryVali("Winterweizen","avgAnnProf","spot6m","FH+Bonus") =
    p_profitPerHaNoPesti("Winterweizen - Backweizen",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Winterweizen - Backweizen","spot6m","FH+Bonus",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH+Bonus","spot6m",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH+Bonus","spot6m",pestType) * labPrice
      + p_technoFuelCons("5","1","FH+Bonus","spot6m",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH+Bonus","spot6m",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH+Bonus","spot6m",pestType) 
      + p_technoMaintenance("5","1","FH+Bonus","spot6m",pestType) * (3/12) * 0.03
      )
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH+Bonus","BA_102KW",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH+Bonus","BA_102KW",pestType) * labPrice
      + p_technoFuelCons("5","1","FH+Bonus","BA_102KW",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH+Bonus","BA_102KW",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH+Bonus","BA_102KW",pestType) 
      + p_technoMaintenance("5","1","FH+Bonus","BA_102KW",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("spot6m") + p_tractorInterest("spot6m") + p_tractorOtherCosts("spot6m"))
    * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH+Bonus","spot6m",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH+Bonus","spot6m",pestType)
  ) 
  - (p_tractorDeprec("BA_102KW") + p_tractorInterest("BA_102KW") + p_tractorOtherCosts("BA_102KW"))
    * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH+Bonus","BA_102KW",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH+Bonus","BA_102KW",pestType) 
  )
;



* --- SSPAs & BAs
summaryVali("Zuckerrueben","varMachCostsSprayer","spot6m","FH+Bonus+BA") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH+Bonus+BA","spot6m",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH+Bonus+BA","spot6m",pestType) 
    + p_technoMaintenance("5","1","FH+Bonus+BA","spot6m",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH+Bonus+BA","spot6m",pestType) * newFuelPrice
    + p_technoFuelCons("5","1","FH+Bonus+BA","spot6m",pestType) * newFuelPrice * (3/12) * 0.03
    + p_technoTimeReq("5","1","FH+Bonus+BA","spot6m",pestType) * labPrice)
  )
;

summaryVali("Winterweizen","varMachCostsSprayer","spot6m","FH+Bonus+BA") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH+Bonus+BA","spot6m",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH+Bonus+BA","spot6m",pestType) 
    + p_technoMaintenance("5","1","FH+Bonus+BA","spot6m",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH+Bonus+BA","spot6m",pestType) * newFuelPrice
    + p_technoFuelCons("5","1","FH+Bonus+BA","spot6m",pestType) * newFuelPrice * (3/12) * 0.03 
    + p_technoTimeReq("5","1","FH+Bonus+BA","spot6m",pestType) * labPrice)
  )
;



summaryVali("Zuckerrueben","fixCostsTractor","spot6m","FH+Bonus+BA") = 
  (
    p_tractorDeprec("spot6m")
    + p_tractorInterest("spot6m")
    + p_tractorOtherCosts("spot6m")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH+Bonus+BA","spot6m",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH+Bonus+BA","spot6m",pestType)) 
;

summaryVali("Winterweizen","fixCostsTractor","spot6m","FH+Bonus+BA") = 
  (
    p_tractorDeprec("spot6m")
    + p_tractorInterest("spot6m")
    + p_tractorOtherCosts("spot6m")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH+Bonus+BA","spot6m",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH+Bonus+BA","spot6m",pestType)) 
;



summaryVali("Zuckerrueben","avgAnnProf","spot6m","FH+Bonus+BA") =
  p_profitPerHaNoPesti("Zuckerrueben",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Zuckerrueben","spot6m","FH+Bonus+BA",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH+Bonus+BA","spot6m",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH+Bonus+BA","spot6m",pestType) * labPrice
      + p_technoFuelCons("5","1","FH+Bonus+BA","spot6m",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH+Bonus+BA","spot6m",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH+Bonus+BA","spot6m",pestType) 
      + p_technoMaintenance("5","1","FH+Bonus+BA","spot6m",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("spot6m") + p_tractorInterest("spot6m") + p_tractorOtherCosts("spot6m"))
  * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot6m","FH+Bonus+BA","spot6m",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH+Bonus+BA","spot6m",pestType)
  ) 
;


summaryVali("Winterweizen","avgAnnProf","spot6m","FH+Bonus+BA") =
    p_profitPerHaNoPesti("Winterweizen - Backweizen",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Winterweizen - Backweizen","spot6m","FH+Bonus+BA",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH+Bonus+BA","spot6m",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH+Bonus+BA","spot6m",pestType) * labPrice
      + p_technoFuelCons("5","1","FH+Bonus+BA","spot6m",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH+Bonus+BA","spot6m",pestType) * newFuelPrice * (3/12) * 0.03 
      + p_technoMaintenance("5","1","FH+Bonus+BA","spot6m",pestType) 
      + p_technoMaintenance("5","1","FH+Bonus+BA","spot6m",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("spot6m") + p_tractorInterest("spot6m") + p_tractorOtherCosts("spot6m"))
    * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot6m","FH+Bonus+BA","spot6m",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH+Bonus+BA","spot6m",pestType)
  ) 
;



*
* --- SST27m
*

*
* --- Scenario 1

* --- SSPAs
summaryVali("Zuckerrueben","varMachCostsSprayer","spot27m","FH") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH","spot27m",pestType,halfMonth)
  * (
    p_technoMaintenance("5","1","FH","spot27m",pestType) 
    + p_technoMaintenance("5","1","FH","spot27m",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH","spot27m",pestType) * newFuelPrice
    + p_technoFuelCons("5","1","FH","spot27m",pestType) * newFuelPrice * (3/12) * 0.03
    + p_technoTimeReq("5","1","FH","spot27m",pestType) * labPrice)
  )
  + sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH","BA_102KW",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH","BA_102KW",pestType) 
    + p_technoMaintenance("5","1","FH","BA_102KW",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH","BA_102KW",pestType) * newFuelPrice 
    + p_technoFuelCons("5","1","FH","BA_102KW",pestType) * newFuelPrice * (3/12) * 0.03 
    + p_technoTimeReq("5","1","FH","BA_102KW",pestType) * labPrice)
  )
;

summaryVali("Winterweizen","varMachCostsSprayer","spot27m","FH") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH","spot27m",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH","spot27m",pestType) 
  + p_technoMaintenance("5","1","FH","spot27m",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH","spot27m",pestType) * newFuelPrice
    + p_technoFuelCons("5","1","FH","spot27m",pestType) * newFuelPrice * (3/12) * 0.03
    + p_technoTimeReq("5","1","FH","spot27m",pestType) * labPrice)
  )
  + sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH","BA_102KW",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH","BA_102KW",pestType) 
    + p_technoMaintenance("5","1","FH","BA_102KW",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH","BA_102KW",pestType) * newFuelPrice 
    + p_technoFuelCons("5","1","FH","BA_102KW",pestType) * newFuelPrice * (3/12) * 0.03
    + p_technoTimeReq("5","1","FH","BA_102KW",pestType) * labPrice)
  )
;



summaryVali("Zuckerrueben","fixCostsTractor","spot27m","FH") = 
  (
    p_tractorDeprec("spot27m")
    + p_tractorInterest("spot27m")
    + p_tractorOtherCosts("spot27m")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH","spot27m",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH","spot27m",pestType)) 
  + (
    p_tractorDeprec("BA_102KW")
    + p_tractorInterest("BA_102KW")
    + p_tractorOtherCosts("BA_102KW")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH","BA_102KW",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH","BA_102KW",pestType)) 
;

summaryVali("Winterweizen","fixCostsTractor","spot27m","FH") = 
  (
    p_tractorDeprec("spot27m")
    + p_tractorInterest("spot27m")
    + p_tractorOtherCosts("spot27m")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH","spot27m",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH","spot27m",pestType)) 
  + (
    p_tractorDeprec("BA_102KW")
    + p_tractorInterest("BA_102KW")
    + p_tractorOtherCosts("BA_102KW")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH","BA_102KW",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH","BA_102KW",pestType)) 
;



summaryVali("Zuckerrueben","avgAnnProf","spot27m","FH") =
  p_profitPerHaNoPesti("Zuckerrueben",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Zuckerrueben","spot27m","FH",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH","spot27m",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH","spot27m",pestType) * labPrice
      + p_technoFuelCons("5","1","FH","spot27m",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH","spot27m",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH","spot27m",pestType) 
      + p_technoMaintenance("5","1","FH","spot27m",pestType) * (3/12) * 0.03
      )
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH","BA_102KW",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH","BA_102KW",pestType) * labPrice
      + p_technoFuelCons("5","1","FH","BA_102KW",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH","BA_102KW",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH","BA_102KW",pestType) 
      + p_technoMaintenance("5","1","FH","BA_102KW",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("spot27m") + p_tractorInterest("spot27m") + p_tractorOtherCosts("spot27m"))
  * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH","spot27m",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH","spot27m",pestType)
  ) 
  - (p_tractorDeprec("BA_102KW") + p_tractorInterest("BA_102KW") + p_tractorOtherCosts("BA_102KW"))
  * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH","BA_102KW",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH","BA_102KW",pestType)
  ) 
;


summaryVali("Winterweizen","avgAnnProf","spot27m","FH") =
    p_profitPerHaNoPesti("Winterweizen - Backweizen",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Winterweizen - Backweizen","spot27m","FH",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH","spot27m",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH","spot27m",pestType) * labPrice
      + p_technoFuelCons("5","1","FH","spot27m",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH","spot27m",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH","spot27m",pestType) 
      + p_technoMaintenance("5","1","FH","spot27m",pestType) * (3/12) * 0.03
      )
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH","BA_102KW",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH","BA_102KW",pestType) * labPrice
      + p_technoFuelCons("5","1","FH","BA_102KW",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH","BA_102KW",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH","BA_102KW",pestType) 
      + p_technoMaintenance("5","1","FH","BA_102KW",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("spot27m") + p_tractorInterest("spot27m") + p_tractorOtherCosts("spot27m"))
    * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH","spot27m",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH","spot27m",pestType)
  ) 
  - (p_tractorDeprec("BA_102KW") + p_tractorInterest("BA_102KW") + p_tractorOtherCosts("BA_102KW"))
    * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH","BA_102KW",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH","BA_102KW",pestType) 
  )
;



* --- SSPAs & BAs
summaryVali("Zuckerrueben","varMachCostsSprayer","spot27m","FH+BA") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH+BA","spot27m",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH+BA","spot27m",pestType) 
    + p_technoMaintenance("5","1","FH+BA","spot27m",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH+BA","spot27m",pestType) * newFuelPrice
    + p_technoFuelCons("5","1","FH+BA","spot27m",pestType) * newFuelPrice * (3/12) * 0.03
    + p_technoTimeReq("5","1","FH+BA","spot27m",pestType) * labPrice)
  )
;

summaryVali("Winterweizen","varMachCostsSprayer","spot27m","FH+BA") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH+BA","spot27m",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH+BA","spot27m",pestType) 
    + p_technoMaintenance("5","1","FH+BA","spot27m",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH+BA","spot27m",pestType) * newFuelPrice
    + p_technoFuelCons("5","1","FH+BA","spot27m",pestType) * newFuelPrice * (3/12) * 0.03 
    + p_technoTimeReq("5","1","FH+BA","spot27m",pestType) * labPrice)
  )
;



summaryVali("Zuckerrueben","fixCostsTractor","spot27m","FH+BA") = 
  (
    p_tractorDeprec("spot27m")
    + p_tractorInterest("spot27m")
    + p_tractorOtherCosts("spot27m")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH+BA","spot27m",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH+BA","spot27m",pestType)) 
;

summaryVali("Winterweizen","fixCostsTractor","spot27m","FH+BA") = 
  (
    p_tractorDeprec("spot27m")
    + p_tractorInterest("spot27m")
    + p_tractorOtherCosts("spot27m")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH+BA","spot27m",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH+BA","spot27m",pestType)) 
;



summaryVali("Zuckerrueben","avgAnnProf","spot27m","FH+BA") =
  p_profitPerHaNoPesti("Zuckerrueben",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Zuckerrueben","spot27m","FH+BA",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH+BA","spot27m",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH+BA","spot27m",pestType) * labPrice
      + p_technoFuelCons("5","1","FH+BA","spot27m",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH+BA","spot27m",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH+BA","spot27m",pestType) 
      + p_technoMaintenance("5","1","FH+BA","spot27m",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("spot27m") + p_tractorInterest("spot27m") + p_tractorOtherCosts("spot27m"))
  * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH+BA","spot27m",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH+BA","spot27m",pestType)
  ) 
;


summaryVali("Winterweizen","avgAnnProf","spot27m","FH+BA") =
    p_profitPerHaNoPesti("Winterweizen - Backweizen",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Winterweizen - Backweizen","spot27m","FH+BA",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH+BA","spot27m",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH+BA","spot27m",pestType) * labPrice
      + p_technoFuelCons("5","1","FH+BA","spot27m",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH+BA","spot27m",pestType) * newFuelPrice * (3/12) * 0.03 
      + p_technoMaintenance("5","1","FH+BA","spot27m",pestType) 
      + p_technoMaintenance("5","1","FH+BA","spot27m",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("spot27m") + p_tractorInterest("spot27m") + p_tractorOtherCosts("spot27m"))
    * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH+BA","spot27m",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH+BA","spot27m",pestType)
  ) 
;




*
* --- Scenario 2

* --- SSPAs
summaryVali("Zuckerrueben","varMachCostsSprayer","spot27m","FH+Bonus") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH+Bonus","spot27m",pestType,halfMonth)
  * (
    p_technoMaintenance("5","1","FH+Bonus","spot27m",pestType) 
    + p_technoMaintenance("5","1","FH+Bonus","spot27m",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH+Bonus","spot27m",pestType) * newFuelPrice
    + p_technoFuelCons("5","1","FH+Bonus","spot27m",pestType) * newFuelPrice * (3/12) * 0.03
    + p_technoTimeReq("5","1","FH+Bonus","spot27m",pestType) * labPrice)
  )
  + sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH+Bonus","BA_102KW",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH+Bonus","BA_102KW",pestType) 
    + p_technoMaintenance("5","1","FH+Bonus","BA_102KW",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH+Bonus","BA_102KW",pestType) * newFuelPrice 
    + p_technoFuelCons("5","1","FH+Bonus","BA_102KW",pestType) * newFuelPrice * (3/12) * 0.03 
    + p_technoTimeReq("5","1","FH+Bonus","BA_102KW",pestType) * labPrice)
  )
;

summaryVali("Winterweizen","varMachCostsSprayer","spot27m","FH+Bonus") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH+Bonus","spot27m",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH+Bonus","spot27m",pestType) 
  + p_technoMaintenance("5","1","FH+Bonus","spot27m",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH+Bonus","spot27m",pestType) * newFuelPrice
    + p_technoFuelCons("5","1","FH+Bonus","spot27m",pestType) * newFuelPrice * (3/12) * 0.03
    + p_technoTimeReq("5","1","FH+Bonus","spot27m",pestType) * labPrice)
  )
  + sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH+Bonus","BA_102KW",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH+Bonus","BA_102KW",pestType) 
    + p_technoMaintenance("5","1","FH+Bonus","BA_102KW",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH+Bonus","BA_102KW",pestType) * newFuelPrice 
    + p_technoFuelCons("5","1","FH+Bonus","BA_102KW",pestType) * newFuelPrice * (3/12) * 0.03
    + p_technoTimeReq("5","1","FH+Bonus","BA_102KW",pestType) * labPrice)
  )
;



summaryVali("Zuckerrueben","fixCostsTractor","spot27m","FH+Bonus") = 
  (
    p_tractorDeprec("spot27m")
    + p_tractorInterest("spot27m")
    + p_tractorOtherCosts("spot27m")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH+Bonus","spot27m",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH+Bonus","spot27m",pestType)) 
  + (
    p_tractorDeprec("BA_102KW")
    + p_tractorInterest("BA_102KW")
    + p_tractorOtherCosts("BA_102KW")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH+Bonus","BA_102KW",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH+Bonus","BA_102KW",pestType)) 
;

summaryVali("Winterweizen","fixCostsTractor","spot27m","FH+Bonus") = 
  (
    p_tractorDeprec("spot27m")
    + p_tractorInterest("spot27m")
    + p_tractorOtherCosts("spot27m")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH+Bonus","spot27m",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH+Bonus","spot27m",pestType)) 
  + (
    p_tractorDeprec("BA_102KW")
    + p_tractorInterest("BA_102KW")
    + p_tractorOtherCosts("BA_102KW")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH+Bonus","BA_102KW",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH+Bonus","BA_102KW",pestType)) 
;



summaryVali("Zuckerrueben","avgAnnProf","spot27m","FH+Bonus") =
  p_profitPerHaNoPesti("Zuckerrueben",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Zuckerrueben","spot27m","FH+Bonus",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH+Bonus","spot27m",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH+Bonus","spot27m",pestType) * labPrice
      + p_technoFuelCons("5","1","FH+Bonus","spot27m",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH+Bonus","spot27m",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH+Bonus","spot27m",pestType) 
      + p_technoMaintenance("5","1","FH+Bonus","spot27m",pestType) * (3/12) * 0.03
      )
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH+Bonus","BA_102KW",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH+Bonus","BA_102KW",pestType) * labPrice
      + p_technoFuelCons("5","1","FH+Bonus","BA_102KW",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH+Bonus","BA_102KW",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH+Bonus","BA_102KW",pestType) 
      + p_technoMaintenance("5","1","FH+Bonus","BA_102KW",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("spot27m") + p_tractorInterest("spot27m") + p_tractorOtherCosts("spot27m"))
  * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH+Bonus","spot27m",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH+Bonus","spot27m",pestType)
  ) 
  - (p_tractorDeprec("BA_102KW") + p_tractorInterest("BA_102KW") + p_tractorOtherCosts("BA_102KW"))
  * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH+Bonus","BA_102KW",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH+Bonus","BA_102KW",pestType)
  ) 
;


summaryVali("Winterweizen","avgAnnProf","spot27m","FH+Bonus") =
    p_profitPerHaNoPesti("Winterweizen - Backweizen",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Winterweizen - Backweizen","spot27m","FH+Bonus",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH+Bonus","spot27m",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH+Bonus","spot27m",pestType) * labPrice
      + p_technoFuelCons("5","1","FH+Bonus","spot27m",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH+Bonus","spot27m",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH+Bonus","spot27m",pestType) 
      + p_technoMaintenance("5","1","FH+Bonus","spot27m",pestType) * (3/12) * 0.03
      )
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH+Bonus","BA_102KW",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH+Bonus","BA_102KW",pestType) * labPrice
      + p_technoFuelCons("5","1","FH+Bonus","BA_102KW",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH+Bonus","BA_102KW",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH+Bonus","BA_102KW",pestType) 
      + p_technoMaintenance("5","1","FH+Bonus","BA_102KW",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("spot27m") + p_tractorInterest("spot27m") + p_tractorOtherCosts("spot27m"))
    * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH+Bonus","spot27m",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH+Bonus","spot27m",pestType)
  ) 
  - (p_tractorDeprec("BA_102KW") + p_tractorInterest("BA_102KW") + p_tractorOtherCosts("BA_102KW"))
    * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH+Bonus","BA_102KW",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH+Bonus","BA_102KW",pestType) 
  )
;



* --- SSPAs & BAs
summaryVali("Zuckerrueben","varMachCostsSprayer","spot27m","FH+Bonus+BA") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH+Bonus+BA","spot27m",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH+Bonus+BA","spot27m",pestType) 
    + p_technoMaintenance("5","1","FH+Bonus+BA","spot27m",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH+Bonus+BA","spot27m",pestType) * newFuelPrice
    + p_technoFuelCons("5","1","FH+Bonus+BA","spot27m",pestType) * newFuelPrice * (3/12) * 0.03
    + p_technoTimeReq("5","1","FH+Bonus+BA","spot27m",pestType) * labPrice)
  )
;

summaryVali("Winterweizen","varMachCostsSprayer","spot27m","FH+Bonus+BA") = 
  sum((pestType,halfMonth),
  p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH+Bonus+BA","spot27m",pestType,halfMonth)
  * (p_technoMaintenance("5","1","FH+Bonus+BA","spot27m",pestType) 
    + p_technoMaintenance("5","1","FH+Bonus+BA","spot27m",pestType) * (3/12) * 0.03
    + p_technoFuelCons("5","1","FH+Bonus+BA","spot27m",pestType) * newFuelPrice
    + p_technoFuelCons("5","1","FH+Bonus+BA","spot27m",pestType) * newFuelPrice * (3/12) * 0.03 
    + p_technoTimeReq("5","1","FH+Bonus+BA","spot27m",pestType) * labPrice)
  )
;



summaryVali("Zuckerrueben","fixCostsTractor","spot27m","FH+Bonus+BA") = 
  (
    p_tractorDeprec("spot27m")
    + p_tractorInterest("spot27m")
    + p_tractorOtherCosts("spot27m")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH+Bonus+BA","spot27m",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH+Bonus+BA","spot27m",pestType)) 
;

summaryVali("Winterweizen","fixCostsTractor","spot27m","FH+Bonus+BA") = 
  (
    p_tractorDeprec("spot27m")
    + p_tractorInterest("spot27m")
    + p_tractorOtherCosts("spot27m")
  ) 
  * sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH+Bonus+BA","spot27m",pestType,halfMonth)
    * p_technoTimeReq("5","1","FH+Bonus+BA","spot27m",pestType)) 
;



summaryVali("Zuckerrueben","avgAnnProf","spot27m","FH+Bonus+BA") =
  p_profitPerHaNoPesti("Zuckerrueben",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Zuckerrueben","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Zuckerrueben","spot27m","FH+Bonus+BA",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH+Bonus+BA","spot27m",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH+Bonus+BA","spot27m",pestType) * labPrice
      + p_technoFuelCons("5","1","FH+Bonus+BA","spot27m",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH+Bonus+BA","spot27m",pestType) * newFuelPrice * (3/12) * 0.03
      + p_technoMaintenance("5","1","FH+Bonus+BA","spot27m",pestType) 
      + p_technoMaintenance("5","1","FH+Bonus+BA","spot27m",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("spot27m") + p_tractorInterest("spot27m") + p_tractorOtherCosts("spot27m"))
  * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Zuckerrueben","hoch, mittlerer Boden","spot27m","FH+Bonus+BA","spot27m",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH+Bonus+BA","spot27m",pestType)
  ) 
;


summaryVali("Winterweizen","avgAnnProf","spot27m","FH+Bonus+BA") =
    p_profitPerHaNoPesti("Winterweizen - Backweizen",'wendend, gezogene Saatbettbereitung, Saat',"5","hoch, mittlerer Boden","102","1")
  - sum(pestType, 
    (p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) 
    + p_sprayInputCosts("Winterweizen - Backweizen","hoch, mittlerer Boden",pestType) * (3/12) * 0.03)
    * (1 - (p_technoPestEff("Winterweizen - Backweizen","spot27m","FH+Bonus+BA",pestType)))
  )
  - sum((pestType,halfMonth),
    p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH+Bonus+BA","spot27m",pestType,halfMonth)
    * (
      p_technoTimeReq("5","1","FH+Bonus+BA","spot27m",pestType) * labPrice
      + p_technoFuelCons("5","1","FH+Bonus+BA","spot27m",pestType) * newFuelPrice
      + p_technoFuelCons("5","1","FH+Bonus+BA","spot27m",pestType) * newFuelPrice * (3/12) * 0.03 
      + p_technoMaintenance("5","1","FH+Bonus+BA","spot27m",pestType) 
      + p_technoMaintenance("5","1","FH+Bonus+BA","spot27m",pestType) * (3/12) * 0.03
      )
  )
  - (p_tractorDeprec("spot27m") + p_tractorInterest("spot27m") + p_tractorOtherCosts("spot27m"))
    * sum((pestType,halfMonth),
      p_sprayerPassagesMonth("Winterweizen - Backweizen","hoch, mittlerer Boden","spot27m","FH+Bonus+BA","spot27m",pestType,halfMonth)
      * p_technoTimeReq("5","1","FH+Bonus+BA","spot27m",pestType)
  ) 
;
