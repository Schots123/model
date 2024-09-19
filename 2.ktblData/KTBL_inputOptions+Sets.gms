*
*  --- Introduction of elementary sets for the model 
*
set allItems /
landAv,
landUsedAvg,
'Winterweizen',
'Wintergerste',
'Zuckerrueben',
'Winterraps',
'Mais', 
baseline,
BA_45kW, 
BA_67kW, 
BA_83kW, 
BA_102kW, 
BA_120kW, 
BA_200kW, 
BA_230kW,
spot6m,
spot27m,
farmProfNoPest
avgAnnFarmProf,
diCostsPesti, 
fuelCostsSprayer, 
repCostsSprayer, 
labCostsSprayer, 
deprecSprayer, 
interestSprayer, 
otherCostsSprayer, 
varCostsSprayer, 
fixCostsSprayer,
modelVali,
*items for sensitivity analysis
'%SSTValue'
'%pestiSav'
'%timeReq'
'%fuelCons'
'%repCosts'
'%algCosts'
'%anFee'
'%pestCosts'
'%numPassages'
/;


set measures /
  amount, capUtiliz, repurchDur, avgAnnProf, dcPesti, fuelCosts, repCosts, labourCosts, deprecSprayer, interestSprayer, otherCostsSprayer, varMachCostsSprayer, fixCostsTractor,
  MRZ1, MRZ2, APR1, APR2, MAI1, MAI2, JUN1, JUN2, JUL1, JUL2, AUG1, AUG2, SEP1, SEP2, OKT1, OKT2, NOV1, NOV2 
/;


set KTBL_crops /
'Ackergras - Anwelksilage'
'Ackergras - Bodenheu'
'Dauergruenland, grasbetont - Anwelksilage'
'Dauergruenland, grasbetont - Bodenheu'
'Mais - Corn-Cob-Mix' 
'Mais - Koernermais' 
'Mais - Silomais' 
'Speisekartoffeln' 
'Staerkekartoffeln' 
'Wintergerste - Futtergerste' 
'Winterraps (Rapsoel)'
'Winterraps' 
'Winterroggen - Korn und Stroh (thermische Nutzung)' 
'Winterroggen - Mahl- und Brotroggen' 
'Wintertriticale - Futtertriticale' 
'Wintertriticale - Korn und Stroh (thermische Nutzung)' 
'Winterweizen - Backweizen' 
'Winterweizen - Korn und Stroh (thermische Nutzung)' 
'Zuckerrueben' 
/;

set KTBL_rowCrops(KTBL_crops) /
'Mais - Corn-Cob-Mix' 
'Mais - Koernermais' 
'Mais - Silomais' 
'Speisekartoffeln' 
'Staerkekartoffeln' 
'Zuckerrueben'
/;

set KTBL_nonRowCrops(KTBL_crops) /
'Ackergras - Anwelksilage'
'Ackergras - Bodenheu'
'Dauergruenland, grasbetont - Anwelksilage'
'Dauergruenland, grasbetont - Bodenheu'
'Wintergerste - Futtergerste' 
'Winterraps (Rapsoel)'
'Winterraps' 
'Winterroggen - Korn und Stroh (thermische Nutzung)' 
'Winterroggen - Mahl- und Brotroggen' 
'Wintertriticale - Futtertriticale' 
'Wintertriticale - Korn und Stroh (thermische Nutzung)' 
'Winterweizen - Backweizen' 
'Winterweizen - Korn und Stroh (thermische Nutzung)'
/;

set KTBL_system /
'Ballen'
'Haecksler'
'Ladewagen'
'nichtwendend, Kreiseleggen, Saat'
'wendend, gezogene Saatbettbereitung, Saat'
'nichtwendend, Kreiseleggen, Legen'
'wendend, beregnet, gezogene Saatbettbereitung'
'wendend, gezogene Saatbettbereitung, Legen'
'wendend, separierte Beete'
'wendend, steinig, gezogene Saatbettbereitung'
'Direktsaat'
'nichtwendend, Kreiseleggensaat'
/;

set KTBL_yield /
'hoch, mittlerer Boden'
'hoch, leichter Boden'
'mittel, schwerer Boden'
'mittel, mittlerer Boden'
'mittel, leichter Boden'
'niedrig, mittlerer Boden'
'niedrig, leichter Boden'
'sehr niedrig, leichter Boden'
/;

set KTBL_yieldLev /
'hoch'
'mittel'
'niedrig'
'sehr niedrig'
/;

set KTBL_yieldGroup(KTBL_yield,KTBL_yieldLev) /
'hoch, mittlerer Boden'.'hoch' YES
'hoch, leichter Boden'.'hoch' YES
'mittel, schwerer Boden'.'mittel' YES
'mittel, mittlerer Boden'.'mittel' YES
'mittel, leichter Boden'.'mittel' YES
'niedrig, mittlerer Boden'.'niedrig' YES
'niedrig, leichter Boden'.'niedrig' YES
'sehr niedrig, leichter Boden'.'sehr niedrig' YES
/;

parameter p_yieldGroup(KTBL_yield,KTBL_yieldLev) /
'hoch, mittlerer Boden'.'hoch' 1
'hoch, leichter Boden'.'hoch' 1
'mittel, schwerer Boden'.'mittel' 1
'mittel, mittlerer Boden'.'mittel' 1
'mittel, leichter Boden'.'mittel' 1
'niedrig, mittlerer Boden'.'niedrig' 1
'niedrig, leichter Boden'.'niedrig' 1
'sehr niedrig, leichter Boden'.'sehr niedrig' 1
/;

set ktblCrops_KtblYield(KTBL_crops,KTBL_yield) /
'Ackergras - Anwelksilage'.'hoch, mittlerer Boden' YES 
'Ackergras - Anwelksilage'.'mittel, mittlerer Boden' YES 
'Ackergras - Anwelksilage'.'niedrig, mittlerer Boden' YES 
'Ackergras - Bodenheu'.'hoch, mittlerer Boden' YES 
'Ackergras - Bodenheu'.'mittel, leichter Boden' YES 
'Ackergras - Bodenheu'.'mittel, mittlerer Boden' YES 
'Ackergras - Bodenheu'.'mittel, schwerer Boden' YES 
'Ackergras - Bodenheu'.'niedrig, leichter Boden' YES 
'Dauergruenland, grasbetont - Anwelksilage'.'hoch, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Anwelksilage'.'mittel, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Anwelksilage'.'niedrig, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Bodenheu'.'hoch, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Bodenheu'.'mittel, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Bodenheu'.'niedrig, mittlerer Boden' YES 
'Mais - Corn-Cob-Mix'.'hoch, mittlerer Boden' YES 
'Mais - Corn-Cob-Mix'.'mittel, leichter Boden' YES 
'Mais - Corn-Cob-Mix'.'mittel, mittlerer Boden' YES 
'Mais - Corn-Cob-Mix'.'mittel, schwerer Boden' YES 
'Mais - Corn-Cob-Mix'.'niedrig, leichter Boden' YES 
'Mais - Koernermais'.'hoch, mittlerer Boden' YES 
'Mais - Koernermais'.'mittel, leichter Boden' YES 
'Mais - Koernermais'.'mittel, mittlerer Boden' YES 
'Mais - Koernermais'.'mittel, schwerer Boden' YES 
'Mais - Koernermais'.'niedrig, leichter Boden' YES 
'Mais - Koernermais'.'niedrig, mittlerer Boden' YES 
'Mais - Silomais'.'hoch, mittlerer Boden' YES 
'Mais - Silomais'.'mittel, leichter Boden' YES 
'Mais - Silomais'.'mittel, mittlerer Boden' YES 
'Mais - Silomais'.'mittel, schwerer Boden' YES 
'Mais - Silomais'.'niedrig, leichter Boden' YES 
'Mais - Silomais'.'niedrig, mittlerer Boden' YES 
'Speisekartoffeln'.'hoch, mittlerer Boden' YES 
'Speisekartoffeln'.'mittel, leichter Boden' YES 
'Speisekartoffeln'.'mittel, mittlerer Boden' YES 
'Speisekartoffeln'.'mittel, schwerer Boden' YES 
'Speisekartoffeln'.'niedrig, leichter Boden' YES 
'Speisekartoffeln'.'niedrig, mittlerer Boden' YES 
'Staerkekartoffeln'.'hoch, mittlerer Boden' YES 
'Staerkekartoffeln'.'mittel, leichter Boden' YES 
'Staerkekartoffeln'.'mittel, mittlerer Boden' YES 
'Staerkekartoffeln'.'mittel, schwerer Boden' YES 
'Staerkekartoffeln'.'niedrig, leichter Boden' YES 
'Wintergerste - Futtergerste'.'hoch, mittlerer Boden' YES 
'Wintergerste - Futtergerste'.'mittel, leichter Boden' YES 
'Wintergerste - Futtergerste'.'mittel, mittlerer Boden' YES 
'Wintergerste - Futtergerste'.'mittel, schwerer Boden' YES 
'Wintergerste - Futtergerste'.'niedrig, leichter Boden' YES 
'Wintergerste - Futtergerste'.'niedrig, mittlerer Boden' YES 
'Winterraps (Rapsoel)'.'hoch, mittlerer Boden' YES 
'Winterraps (Rapsoel)'.'mittel, mittlerer Boden' YES 
'Winterraps (Rapsoel)'.'niedrig, leichter Boden' YES 
'Winterraps'.'hoch, mittlerer Boden' YES 
'Winterraps'.'mittel, leichter Boden' YES 
'Winterraps'.'mittel, mittlerer Boden' YES 
'Winterraps'.'mittel, schwerer Boden' YES 
'Winterraps'.'niedrig, leichter Boden' YES 
'Winterraps'.'niedrig, mittlerer Boden' YES 
'Winterroggen - Korn und Stroh (thermische Nutzung)'.'hoch, mittlerer Boden' YES 
'Winterroggen - Korn und Stroh (thermische Nutzung)'.'mittel, mittlerer Boden' YES 
'Winterroggen - Korn und Stroh (thermische Nutzung)'.'niedrig, leichter Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'hoch, mittlerer Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'mittel, leichter Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'mittel, mittlerer Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'mittel, schwerer Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'niedrig, leichter Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'niedrig, mittlerer Boden' YES 
'Wintertriticale - Futtertriticale'.'hoch, mittlerer Boden' YES 
'Wintertriticale - Futtertriticale'.'mittel, leichter Boden' YES 
'Wintertriticale - Futtertriticale'.'mittel, mittlerer Boden' YES 
'Wintertriticale - Futtertriticale'.'mittel, schwerer Boden' YES 
'Wintertriticale - Futtertriticale'.'niedrig, leichter Boden' YES 
'Wintertriticale - Futtertriticale'.'niedrig, mittlerer Boden' YES 
'Wintertriticale - Korn und Stroh (thermische Nutzung)'.'hoch, mittlerer Boden' YES 
'Wintertriticale - Korn und Stroh (thermische Nutzung)'.'mittel, mittlerer Boden' YES 
'Wintertriticale - Korn und Stroh (thermische Nutzung)'.'niedrig, leichter Boden' YES 
'Winterweizen - Backweizen'.'hoch, mittlerer Boden' YES 
'Winterweizen - Backweizen'.'mittel, leichter Boden' YES 
'Winterweizen - Backweizen'.'mittel, mittlerer Boden' YES 
'Winterweizen - Backweizen'.'mittel, schwerer Boden' YES 
'Winterweizen - Backweizen'.'niedrig, leichter Boden' YES 
'Winterweizen - Backweizen'.'niedrig, mittlerer Boden' YES 
'Winterweizen - Korn und Stroh (thermische Nutzung)'.'hoch, mittlerer Boden' YES 
'Winterweizen - Korn und Stroh (thermische Nutzung)'.'mittel, mittlerer Boden' YES 
'Winterweizen - Korn und Stroh (thermische Nutzung)'.'niedrig, leichter Boden' YES 
'Zuckerrueben'.'hoch, mittlerer Boden' YES 
'Zuckerrueben'.'mittel, leichter Boden' YES 
'Zuckerrueben'.'mittel, mittlerer Boden' YES 
'Zuckerrueben'.'mittel, schwerer Boden' YES 
'Zuckerrueben'.'niedrig, leichter Boden' YES 
'Zuckerrueben'.'niedrig, mittlerer Boden' YES 
'Zuckerrueben'.'sehr niedrig, leichter Boden' YES 
/;


set ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield) /
'Ackergras - Anwelksilage'.'Ballen'.'hoch, mittlerer Boden' YES 
'Ackergras - Anwelksilage'.'Ballen'.'mittel, mittlerer Boden' YES 
'Ackergras - Anwelksilage'.'Ballen'.'niedrig, mittlerer Boden' YES 
'Ackergras - Anwelksilage'.'Haecksler'.'hoch, mittlerer Boden' YES 
'Ackergras - Anwelksilage'.'Haecksler'.'mittel, mittlerer Boden' YES 
'Ackergras - Anwelksilage'.'Haecksler'.'niedrig, mittlerer Boden' YES 
'Ackergras - Anwelksilage'.'Ladewagen'.'hoch, mittlerer Boden' YES 
'Ackergras - Anwelksilage'.'Ladewagen'.'mittel, mittlerer Boden' YES 
'Ackergras - Anwelksilage'.'Ladewagen'.'niedrig, mittlerer Boden' YES 
'Ackergras - Bodenheu'.'Ballen'.'hoch, mittlerer Boden' YES 
'Ackergras - Bodenheu'.'Ballen'.'mittel, leichter Boden' YES 
'Ackergras - Bodenheu'.'Ballen'.'mittel, mittlerer Boden' YES 
'Ackergras - Bodenheu'.'Ballen'.'mittel, schwerer Boden' YES 
'Ackergras - Bodenheu'.'Ballen'.'niedrig, leichter Boden' YES 
'Ackergras - Bodenheu'.'Ladewagen'.'hoch, mittlerer Boden' YES 
'Ackergras - Bodenheu'.'Ladewagen'.'mittel, leichter Boden' YES 
'Ackergras - Bodenheu'.'Ladewagen'.'mittel, mittlerer Boden' YES 
'Ackergras - Bodenheu'.'Ladewagen'.'mittel, schwerer Boden' YES 
'Ackergras - Bodenheu'.'Ladewagen'.'niedrig, leichter Boden' YES 
'Dauergruenland, grasbetont - Anwelksilage'.'Ballen'.'hoch, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Anwelksilage'.'Ballen'.'mittel, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Anwelksilage'.'Ballen'.'niedrig, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Anwelksilage'.'Haecksler'.'hoch, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Anwelksilage'.'Haecksler'.'mittel, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Anwelksilage'.'Haecksler'.'niedrig, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Anwelksilage'.'Ladewagen'.'hoch, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Anwelksilage'.'Ladewagen'.'mittel, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Anwelksilage'.'Ladewagen'.'niedrig, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Bodenheu'.'Ballen'.'hoch, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Bodenheu'.'Ballen'.'mittel, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Bodenheu'.'Ballen'.'niedrig, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Bodenheu'.'Ladewagen'.'hoch, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Bodenheu'.'Ladewagen'.'mittel, mittlerer Boden' YES 
'Dauergruenland, grasbetont - Bodenheu'.'Ladewagen'.'niedrig, mittlerer Boden' YES 
'Mais - Corn-Cob-Mix'.'nichtwendend, Kreiseleggen, Saat'.'hoch, mittlerer Boden' YES 
'Mais - Corn-Cob-Mix'.'nichtwendend, Kreiseleggen, Saat'.'mittel, leichter Boden' YES 
'Mais - Corn-Cob-Mix'.'nichtwendend, Kreiseleggen, Saat'.'mittel, mittlerer Boden' YES 
'Mais - Corn-Cob-Mix'.'nichtwendend, Kreiseleggen, Saat'.'mittel, schwerer Boden' YES 
'Mais - Corn-Cob-Mix'.'nichtwendend, Kreiseleggen, Saat'.'niedrig, leichter Boden' YES 
'Mais - Corn-Cob-Mix'.'wendend, gezogene Saatbettbereitung, Saat'.'hoch, mittlerer Boden' YES 
'Mais - Corn-Cob-Mix'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, leichter Boden' YES 
'Mais - Corn-Cob-Mix'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, mittlerer Boden' YES 
'Mais - Corn-Cob-Mix'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, schwerer Boden' YES 
'Mais - Corn-Cob-Mix'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, leichter Boden' YES 
'Mais - Koernermais'.'nichtwendend, Kreiseleggen, Saat'.'hoch, mittlerer Boden' YES 
'Mais - Koernermais'.'nichtwendend, Kreiseleggen, Saat'.'mittel, leichter Boden' YES 
'Mais - Koernermais'.'nichtwendend, Kreiseleggen, Saat'.'mittel, mittlerer Boden' YES 
'Mais - Koernermais'.'nichtwendend, Kreiseleggen, Saat'.'mittel, schwerer Boden' YES 
'Mais - Koernermais'.'nichtwendend, Kreiseleggen, Saat'.'niedrig, leichter Boden' YES 
'Mais - Koernermais'.'nichtwendend, Kreiseleggen, Saat'.'niedrig, mittlerer Boden' YES 
'Mais - Koernermais'.'wendend, gezogene Saatbettbereitung, Saat'.'hoch, mittlerer Boden' YES 
'Mais - Koernermais'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, leichter Boden' YES 
'Mais - Koernermais'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, mittlerer Boden' YES 
'Mais - Koernermais'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, schwerer Boden' YES 
'Mais - Koernermais'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, leichter Boden' YES 
'Mais - Koernermais'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, mittlerer Boden' YES 
'Mais - Silomais'.'nichtwendend, Kreiseleggen, Saat'.'hoch, mittlerer Boden' YES 
'Mais - Silomais'.'nichtwendend, Kreiseleggen, Saat'.'mittel, leichter Boden' YES 
'Mais - Silomais'.'nichtwendend, Kreiseleggen, Saat'.'mittel, mittlerer Boden' YES 
'Mais - Silomais'.'nichtwendend, Kreiseleggen, Saat'.'mittel, schwerer Boden' YES 
'Mais - Silomais'.'nichtwendend, Kreiseleggen, Saat'.'niedrig, leichter Boden' YES 
'Mais - Silomais'.'nichtwendend, Kreiseleggen, Saat'.'niedrig, mittlerer Boden' YES 
'Mais - Silomais'.'wendend, gezogene Saatbettbereitung, Saat'.'hoch, mittlerer Boden' YES 
'Mais - Silomais'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, leichter Boden' YES 
'Mais - Silomais'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, mittlerer Boden' YES 
'Mais - Silomais'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, schwerer Boden' YES 
'Mais - Silomais'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, leichter Boden' YES 
'Mais - Silomais'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, mittlerer Boden' YES 
'Speisekartoffeln'.'nichtwendend, Kreiseleggen, Legen'.'hoch, mittlerer Boden' YES 
'Speisekartoffeln'.'nichtwendend, Kreiseleggen, Legen'.'mittel, leichter Boden' YES 
'Speisekartoffeln'.'nichtwendend, Kreiseleggen, Legen'.'mittel, mittlerer Boden' YES 
'Speisekartoffeln'.'nichtwendend, Kreiseleggen, Legen'.'mittel, schwerer Boden' YES 
'Speisekartoffeln'.'nichtwendend, Kreiseleggen, Legen'.'niedrig, leichter Boden' YES 
'Speisekartoffeln'.'wendend, beregnet, gezogene Saatbettbereitung'.'mittel, leichter Boden' YES 
'Speisekartoffeln'.'wendend, gezogene Saatbettbereitung, Legen'.'hoch, mittlerer Boden' YES 
'Speisekartoffeln'.'wendend, gezogene Saatbettbereitung, Legen'.'mittel, leichter Boden' YES 
'Speisekartoffeln'.'wendend, gezogene Saatbettbereitung, Legen'.'mittel, mittlerer Boden' YES 
'Speisekartoffeln'.'wendend, gezogene Saatbettbereitung, Legen'.'mittel, schwerer Boden' YES 
'Speisekartoffeln'.'wendend, gezogene Saatbettbereitung, Legen'.'niedrig, leichter Boden' YES 
'Speisekartoffeln'.'wendend, gezogene Saatbettbereitung, Legen'.'niedrig, mittlerer Boden' YES 
'Speisekartoffeln'.'wendend, separierte Beete'.'mittel, mittlerer Boden' YES 
'Speisekartoffeln'.'wendend, steinig, gezogene Saatbettbereitung'.'mittel, leichter Boden' YES 
'Staerkekartoffeln'.'nichtwendend, Kreiseleggen, Legen'.'hoch, mittlerer Boden' YES 
'Staerkekartoffeln'.'nichtwendend, Kreiseleggen, Legen'.'mittel, leichter Boden' YES 
'Staerkekartoffeln'.'nichtwendend, Kreiseleggen, Legen'.'mittel, mittlerer Boden' YES 
'Staerkekartoffeln'.'nichtwendend, Kreiseleggen, Legen'.'mittel, schwerer Boden' YES 
'Staerkekartoffeln'.'nichtwendend, Kreiseleggen, Legen'.'niedrig, leichter Boden' YES 
'Staerkekartoffeln'.'wendend, gezogene Saatbettbereitung, Legen'.'hoch, mittlerer Boden' YES 
'Staerkekartoffeln'.'wendend, gezogene Saatbettbereitung, Legen'.'mittel, leichter Boden' YES 
'Staerkekartoffeln'.'wendend, gezogene Saatbettbereitung, Legen'.'mittel, mittlerer Boden' YES 
'Staerkekartoffeln'.'wendend, gezogene Saatbettbereitung, Legen'.'mittel, schwerer Boden' YES 
'Staerkekartoffeln'.'wendend, gezogene Saatbettbereitung, Legen'.'niedrig, leichter Boden' YES 
'Wintergerste - Futtergerste'.'Direktsaat'.'hoch, mittlerer Boden' YES 
'Wintergerste - Futtergerste'.'Direktsaat'.'mittel, leichter Boden' YES 
'Wintergerste - Futtergerste'.'Direktsaat'.'mittel, mittlerer Boden' YES 
'Wintergerste - Futtergerste'.'Direktsaat'.'mittel, schwerer Boden' YES 
'Wintergerste - Futtergerste'.'Direktsaat'.'niedrig, leichter Boden' YES 
'Wintergerste - Futtergerste'.'nichtwendend, Kreiseleggensaat'.'hoch, mittlerer Boden' YES 
'Wintergerste - Futtergerste'.'nichtwendend, Kreiseleggensaat'.'mittel, leichter Boden' YES 
'Wintergerste - Futtergerste'.'nichtwendend, Kreiseleggensaat'.'mittel, mittlerer Boden' YES 
'Wintergerste - Futtergerste'.'nichtwendend, Kreiseleggensaat'.'mittel, schwerer Boden' YES 
'Wintergerste - Futtergerste'.'nichtwendend, Kreiseleggensaat'.'niedrig, leichter Boden' YES 
'Wintergerste - Futtergerste'.'nichtwendend, Kreiseleggensaat'.'niedrig, mittlerer Boden' YES 
'Wintergerste - Futtergerste'.'wendend, gezogene Saatbettbereitung, Saat'.'hoch, mittlerer Boden' YES 
'Wintergerste - Futtergerste'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, leichter Boden' YES 
'Wintergerste - Futtergerste'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, mittlerer Boden' YES 
'Wintergerste - Futtergerste'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, schwerer Boden' YES 
'Wintergerste - Futtergerste'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, leichter Boden' YES 
'Wintergerste - Futtergerste'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, mittlerer Boden' YES 
'Winterraps (Rapsoel)'.'nichtwendend, Kreiseleggensaat'.'hoch, mittlerer Boden' YES 
'Winterraps (Rapsoel)'.'nichtwendend, Kreiseleggensaat'.'mittel, mittlerer Boden' YES 
'Winterraps (Rapsoel)'.'nichtwendend, Kreiseleggensaat'.'niedrig, leichter Boden' YES 
'Winterraps (Rapsoel)'.'wendend, gezogene Saatbettbereitung, Saat'.'hoch, mittlerer Boden' YES 
'Winterraps (Rapsoel)'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, mittlerer Boden' YES 
'Winterraps (Rapsoel)'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, leichter Boden' YES 
'Winterraps'.'Direktsaat'.'hoch, mittlerer Boden' YES 
'Winterraps'.'Direktsaat'.'mittel, leichter Boden' YES 
'Winterraps'.'Direktsaat'.'mittel, mittlerer Boden' YES 
'Winterraps'.'Direktsaat'.'mittel, schwerer Boden' YES 
'Winterraps'.'Direktsaat'.'niedrig, leichter Boden' YES 
'Winterraps'.'nichtwendend, Kreiseleggensaat'.'hoch, mittlerer Boden' YES 
'Winterraps'.'nichtwendend, Kreiseleggensaat'.'mittel, leichter Boden' YES 
'Winterraps'.'nichtwendend, Kreiseleggensaat'.'mittel, mittlerer Boden' YES 
'Winterraps'.'nichtwendend, Kreiseleggensaat'.'mittel, schwerer Boden' YES 
'Winterraps'.'nichtwendend, Kreiseleggensaat'.'niedrig, leichter Boden' YES 
'Winterraps'.'nichtwendend, Kreiseleggensaat'.'niedrig, mittlerer Boden' YES 
'Winterraps'.'wendend, gezogene Saatbettbereitung, Saat'.'hoch, mittlerer Boden' YES 
'Winterraps'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, leichter Boden' YES 
'Winterraps'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, mittlerer Boden' YES 
'Winterraps'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, schwerer Boden' YES 
'Winterraps'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, leichter Boden' YES 
'Winterraps'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, mittlerer Boden' YES 
'Winterroggen - Korn und Stroh (thermische Nutzung)'.'nichtwendend, Kreiseleggensaat'.'hoch, mittlerer Boden' YES 
'Winterroggen - Korn und Stroh (thermische Nutzung)'.'nichtwendend, Kreiseleggensaat'.'mittel, mittlerer Boden' YES 
'Winterroggen - Korn und Stroh (thermische Nutzung)'.'nichtwendend, Kreiseleggensaat'.'niedrig, leichter Boden' YES 
'Winterroggen - Korn und Stroh (thermische Nutzung)'.'wendend, gezogene Saatbettbereitung, Saat'.'hoch, mittlerer Boden' YES 
'Winterroggen - Korn und Stroh (thermische Nutzung)'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, mittlerer Boden' YES 
'Winterroggen - Korn und Stroh (thermische Nutzung)'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, leichter Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'Direktsaat'.'hoch, mittlerer Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'Direktsaat'.'mittel, leichter Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'Direktsaat'.'mittel, mittlerer Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'Direktsaat'.'mittel, schwerer Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'Direktsaat'.'niedrig, leichter Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'nichtwendend, Kreiseleggensaat'.'hoch, mittlerer Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'nichtwendend, Kreiseleggensaat'.'mittel, leichter Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'nichtwendend, Kreiseleggensaat'.'mittel, mittlerer Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'nichtwendend, Kreiseleggensaat'.'mittel, schwerer Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'nichtwendend, Kreiseleggensaat'.'niedrig, leichter Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'nichtwendend, Kreiseleggensaat'.'niedrig, mittlerer Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'wendend, gezogene Saatbettbereitung, Saat'.'hoch, mittlerer Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, leichter Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, mittlerer Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, schwerer Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, leichter Boden' YES 
'Winterroggen - Mahl- und Brotroggen'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, mittlerer Boden' YES 
'Wintertriticale - Futtertriticale'.'Direktsaat'.'hoch, mittlerer Boden' YES 
'Wintertriticale - Futtertriticale'.'Direktsaat'.'mittel, leichter Boden' YES 
'Wintertriticale - Futtertriticale'.'Direktsaat'.'mittel, mittlerer Boden' YES 
'Wintertriticale - Futtertriticale'.'Direktsaat'.'mittel, schwerer Boden' YES 
'Wintertriticale - Futtertriticale'.'Direktsaat'.'niedrig, leichter Boden' YES 
'Wintertriticale - Futtertriticale'.'nichtwendend, Kreiseleggensaat'.'hoch, mittlerer Boden' YES 
'Wintertriticale - Futtertriticale'.'nichtwendend, Kreiseleggensaat'.'mittel, leichter Boden' YES 
'Wintertriticale - Futtertriticale'.'nichtwendend, Kreiseleggensaat'.'mittel, mittlerer Boden' YES 
'Wintertriticale - Futtertriticale'.'nichtwendend, Kreiseleggensaat'.'mittel, schwerer Boden' YES 
'Wintertriticale - Futtertriticale'.'nichtwendend, Kreiseleggensaat'.'niedrig, leichter Boden' YES 
'Wintertriticale - Futtertriticale'.'wendend, gezogene Saatbettbereitung, Saat'.'hoch, mittlerer Boden' YES 
'Wintertriticale - Futtertriticale'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, leichter Boden' YES 
'Wintertriticale - Futtertriticale'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, mittlerer Boden' YES 
'Wintertriticale - Futtertriticale'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, schwerer Boden' YES 
'Wintertriticale - Futtertriticale'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, leichter Boden' YES 
'Wintertriticale - Futtertriticale'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, mittlerer Boden' YES 
'Wintertriticale - Korn und Stroh (thermische Nutzung)'.'nichtwendend, Kreiseleggensaat'.'hoch, mittlerer Boden' YES 
'Wintertriticale - Korn und Stroh (thermische Nutzung)'.'nichtwendend, Kreiseleggensaat'.'mittel, mittlerer Boden' YES 
'Wintertriticale - Korn und Stroh (thermische Nutzung)'.'nichtwendend, Kreiseleggensaat'.'niedrig, leichter Boden' YES 
'Wintertriticale - Korn und Stroh (thermische Nutzung)'.'wendend, gezogene Saatbettbereitung, Saat'.'hoch, mittlerer Boden' YES 
'Wintertriticale - Korn und Stroh (thermische Nutzung)'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, mittlerer Boden' YES 
'Wintertriticale - Korn und Stroh (thermische Nutzung)'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, leichter Boden' YES 
'Winterweizen - Backweizen'.'Direktsaat'.'hoch, mittlerer Boden' YES 
'Winterweizen - Backweizen'.'Direktsaat'.'mittel, leichter Boden' YES 
'Winterweizen - Backweizen'.'Direktsaat'.'mittel, mittlerer Boden' YES 
'Winterweizen - Backweizen'.'Direktsaat'.'mittel, schwerer Boden' YES 
'Winterweizen - Backweizen'.'Direktsaat'.'niedrig, leichter Boden' YES 
'Winterweizen - Backweizen'.'nichtwendend, Kreiseleggensaat'.'hoch, mittlerer Boden' YES 
'Winterweizen - Backweizen'.'nichtwendend, Kreiseleggensaat'.'mittel, leichter Boden' YES 
'Winterweizen - Backweizen'.'nichtwendend, Kreiseleggensaat'.'mittel, mittlerer Boden' YES 
'Winterweizen - Backweizen'.'nichtwendend, Kreiseleggensaat'.'mittel, schwerer Boden' YES 
'Winterweizen - Backweizen'.'nichtwendend, Kreiseleggensaat'.'niedrig, leichter Boden' YES 
'Winterweizen - Backweizen'.'nichtwendend, Kreiseleggensaat'.'niedrig, mittlerer Boden' YES 
'Winterweizen - Backweizen'.'wendend, gezogene Saatbettbereitung, Saat'.'hoch, mittlerer Boden' YES 
'Winterweizen - Backweizen'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, leichter Boden' YES 
'Winterweizen - Backweizen'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, mittlerer Boden' YES 
'Winterweizen - Backweizen'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, schwerer Boden' YES 
'Winterweizen - Backweizen'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, leichter Boden' YES 
'Winterweizen - Backweizen'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, mittlerer Boden' YES 
'Winterweizen - Korn und Stroh (thermische Nutzung)'.'nichtwendend, Kreiseleggensaat'.'hoch, mittlerer Boden' YES 
'Winterweizen - Korn und Stroh (thermische Nutzung)'.'nichtwendend, Kreiseleggensaat'.'mittel, mittlerer Boden' YES 
'Winterweizen - Korn und Stroh (thermische Nutzung)'.'nichtwendend, Kreiseleggensaat'.'niedrig, leichter Boden' YES 
'Winterweizen - Korn und Stroh (thermische Nutzung)'.'wendend, gezogene Saatbettbereitung, Saat'.'hoch, mittlerer Boden' YES 
'Winterweizen - Korn und Stroh (thermische Nutzung)'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, mittlerer Boden' YES 
'Winterweizen - Korn und Stroh (thermische Nutzung)'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, leichter Boden' YES 
'Zuckerrueben'.'nichtwendend, Kreiseleggen, Saat'.'hoch, mittlerer Boden' YES 
'Zuckerrueben'.'nichtwendend, Kreiseleggen, Saat'.'mittel, leichter Boden' YES 
'Zuckerrueben'.'nichtwendend, Kreiseleggen, Saat'.'mittel, mittlerer Boden' YES 
'Zuckerrueben'.'nichtwendend, Kreiseleggen, Saat'.'mittel, schwerer Boden' YES 
'Zuckerrueben'.'nichtwendend, Kreiseleggen, Saat'.'niedrig, leichter Boden' YES 
'Zuckerrueben'.'wendend, gezogene Saatbettbereitung, Saat'.'hoch, mittlerer Boden' YES 
'Zuckerrueben'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, leichter Boden' YES 
'Zuckerrueben'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, mittlerer Boden' YES 
'Zuckerrueben'.'wendend, gezogene Saatbettbereitung, Saat'.'mittel, schwerer Boden' YES 
'Zuckerrueben'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, leichter Boden' YES 
'Zuckerrueben'.'wendend, gezogene Saatbettbereitung, Saat'.'niedrig, mittlerer Boden' YES 
'Zuckerrueben'.'wendend, gezogene Saatbettbereitung, Saat'.'sehr niedrig, leichter Boden' YES 
/;

set KTBL_figure /
'Weidelgrassilage, 1. Schnitt'
'Weidelgrassilage, 2. Schnitt ff.'
'Bodenheu, grasbetont, 2. Schnitt ff.'
'Bodenheu, grasbetont, 1. Schnitt'
'Grassilage, grasbetont, angewelkt, 1. Schnitt'
'Grassilage, grasbetont, angewelkt, 2. Schnitt ff.'
'Wiesenheu, grasbetont, 1. Schnitt, vor der Bluete'
'Wiesenheu, grasbetont, 2. Schnitt ff., 4-6 Wochen'
'CCM, abgesetzt aus Silo'
'Koernermais, 86 % TM'
'Maissilage, Ende der Teigreife'
'Speisekartoffeln'
'Staerkekartoffeln'
'Wintergerste'
'Energie Winterraps'
'Winterraps'
'Roggen'
'Stroh, Quaderballen 1,2*0,9*2,2 m'
'Mahl- und Brotroggen'
'Wintertriticale'
'Backweizen'
'Futterweizen'
'Zuckerrueben'
/;

set manAmounts application levels of manure allowed in model /
'0', '10', '15', '20', '25', '30', '35', '40', '50', '60', '70', '80'
/;

set KTBL_size /
'1'
'2'
'5'
'10'
'20'
'40'
'80'
/;

set KTBL_distance /
'1'
'2'
'3'
'4'
'5'
'10'
'15'
/;

set KTBL_mechanisation /
'45'
'67'
'83'
'102'
'120'
'200'
'230'
/;

acronyms
    Lehm, schluffigTonigerLehm, Ton, tonigerLehm, 
    lehmigerSand, lehmigerSchluff, sandigerLehm, schluffigerLehm,
    sandigerSchluff, Sand, starkSandigerLehm;
  
scalar ktblFuelPrice /0.8/;

set fertType fertilizer applied for crop fertilization in KTBL data /
  'Guelle, Rind', 
  'Kalkammonsalpeter (27 % N), lose', 
  'Diammonphosphat (18 % N, 46 % P2O5), lose', 
  'PK-Duenger (12 % P2O5, 24 % K2O), lose', 
  'PK-Duenger (16 % P2O5, 16 % K2O), lose', 
  'PK-Duenger (18 % P2O5, 10 % K2O), lose',
  'Kali-Duenger (60 % K2O), lose', 
  'Kali-Magnesia (30 % K2O, 10 % MgO), lose'
  'Manure, Farm'
/;

set minFertEle(fertType) mineral fertilizer applied for crop fertilization in KTBL data /
  'Kalkammonsalpeter (27 % N), lose', 
  'Diammonphosphat (18 % N, 46 % P2O5), lose', 
  'PK-Duenger (12 % P2O5, 24 % K2O), lose', 
  'PK-Duenger (16 % P2O5, 16 % K2O), lose', 
  'PK-Duenger (18 % P2O5, 10 % K2O), lose',
  'Kali-Duenger (60 % K2O), lose', 
  'Kali-Magnesia (30 % K2O, 10 % MgO), lose'
/;

parameter p_manValue(manAmounts) /'0' 0, '10' 10, '15' 15, '20' 20, '25' 25, '30' 30, '35' 35, '40' 40, '50' 50, '60' 60, '70' 70, '80' 80/;

set pkFert(fertType) pk fertilizer applied for crop fertilization in KTBL data /
  'PK-Duenger (12 % P2O5, 24 % K2O), lose', 
  'PK-Duenger (16 % P2O5, 16 % K2O), lose', 
  'PK-Duenger (18 % P2O5, 10 % K2O), lose'
/;

set kaliFert(fertType) potassium fertilizer applied for crop fertilization in KTBL data /
  'Kali-Duenger (60 % K2O), lose', 
  'Kali-Magnesia (30 % K2O, 10 % MgO), lose'
/;

set fertCategory type of fertilizer used either mineral fertilizer or manure 
    /minFert,manure
/;

set nutrients /N,P2O5,K2O/;

set man_attr /Amount, N, P2O5, K2O, minNUsagePercent/;



parameter p_ktbl_fertPrice(fertType) /
'Kalkammonsalpeter (27 % N), lose' 0.23
'Guelle, Rind' 0
'Kali-Duenger (60 % K2O), lose' 0.31
'Kali-Magnesia (30 % K2O, 10 % MgO), lose' 0.38
'Diammonphosphat (18 % N, 46 % P2O5), lose' 0.42
'PK-Duenger (16 % P2O5, 16 % K2O), lose' 0.21
'PK-Duenger (12 % P2O5, 24 % K2O), lose' 0.22
'PK-Duenger (18 % P2O5, 10 % K2O), lose' 0.2 
/;

table p_nutrientSupplyFert(fertType,nutrients) Nutrient supply per unit of fertilizer used in KTBL data 
                                                N              P2O5         K2O
'Kalkammonsalpeter (27 % N), lose'              0.27            0           0
'Guelle, Rind'                                  4.3             1.7         5.2
'Kali-Duenger (60 % K2O), lose'                 0               0           0.6
'Kali-Magnesia (30 % K2O, 10 % MgO), lose'      0               0           0.3
'Diammonphosphat (18 % N, 46 % P2O5), lose'     0.18            0.46        0   
'PK-Duenger (16 % P2O5, 16 % K2O), lose'        0               0.16        0.16
'PK-Duenger (12 % P2O5, 24 % K2O), lose'        0               0.12        0.24
'PK-Duenger (18 % P2O5, 10 % K2O), lose'        0               0.18        0.1;

set reveCat /amount, price/;

set CostsEle /set.fertCategory,rest/;

set workingStepsEle /time, fuelCons, deprec, interest, others, maintenance, lubricants, services/;
set varCostsEle(workingStepsEle) /maintenance, lubricants, services/;
set fixCostsEle(workingStepsEle) /deprec, interest, others/;

set CostsType /varCosts,fixCosts/;

set mainCropGroup /
  'Gras'
  'Zea (Mais)'
  'Solanum tuberosum (Kartoffel)'
  'Hordeum (Gerste)'
  'Raps (Brassica napus)'
  'Secale (Roggen)'
  'x Triticale'
  'Triticum (Weizen)'
  'Beta (Rüben)'
/;

set mainCropGroupExempt(mainCropGroup) /
  'Gras'
  'Secale (Roggen)'
/;

set cropCropGroup(KTBL_crops,mainCropGroup) /
'Ackergras - Anwelksilage'.'Gras' YES
'Ackergras - Bodenheu'.'Gras' YES
'Mais - Corn-Cob-Mix'.'Zea (Mais)' YES
'Mais - Koernermais'.'Zea (Mais)' YES
'Mais - Silomais'.'Zea (Mais)' YES
'Speisekartoffeln'.'Solanum tuberosum (Kartoffel)' YES
'Staerkekartoffeln'.'Solanum tuberosum (Kartoffel)' YES
'Wintergerste - Futtergerste'.'Hordeum (Gerste)' YES
'Winterraps (Rapsoel)'.'Raps (Brassica napus)' YES
'Winterraps'.'Raps (Brassica napus)' YES
'Winterroggen - Korn und Stroh (thermische Nutzung)'.'Secale (Roggen)' YES
'Winterroggen - Mahl- und Brotroggen'.'Secale (Roggen)' YES
'Wintertriticale - Futtertriticale'.'x Triticale' YES
'Wintertriticale - Korn und Stroh (thermische Nutzung)'.'x Triticale' YES
'Winterweizen - Backweizen'.'Triticum (Weizen)' YES
'Winterweizen - Korn und Stroh (thermische Nutzung)'.'Triticum (Weizen)' YES
'Zuckerrueben'.'Beta (Rüben)' YES
/;