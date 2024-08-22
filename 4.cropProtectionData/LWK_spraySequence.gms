set LWK_crops /
'Winterweizen'
'Wintergerste'
'Winterroggen & Triticale'
'Raps'
'Speise & Industriekartoffeln'
'Zuckerrüben'
'Mais'
'Grünlandnutzung (Mähweide)'
/;

parameter p_ktblCrops_lwkCrops(KTBL_crops,LWK_crops) /
'Dauergruenland, grasbetont - Anwelksilage'.'Grünlandnutzung (Mähweide)' 1
'Dauergruenland, grasbetont - Bodenheu'.'Grünlandnutzung (Mähweide)' 1
'Mais - Corn-Cob-Mix'.'Mais' 1
'Mais - Koernermais'.'Mais' 1
'Mais - Silomais'.'Mais' 1
'Speisekartoffeln'.'Speise & Industriekartoffeln' 1
'Staerkekartoffeln'.'Speise & Industriekartoffeln' 1
'Wintergerste - Futtergerste'.'Wintergerste' 1
'Winterraps (Rapsoel)'.'Raps' 1
'Winterraps'.'Raps' 1
'Winterroggen - Korn und Stroh (thermische Nutzung)'.'Winterroggen & Triticale' 1
'Winterroggen - Mahl- und Brotroggen'.'Winterroggen & Triticale' 1
'Wintertriticale - Futtertriticale'.'Winterroggen & Triticale' 1
'Wintertriticale - Korn und Stroh (thermische Nutzung)'.'Winterroggen & Triticale' 1
'Winterweizen - Backweizen'.'Winterweizen' 1
'Winterweizen - Korn und Stroh (thermische Nutzung)'.'Winterweizen' 1
'Zuckerrueben'.'Zuckerrüben' 1
/;

set LWK_yield /
'< 70 dt/ha'
'> 70 dt/ha Windhalmstandort'
*'> 70 dt/ha Ackerfuchsschwanz, Weidelgrasstand.'
'> 60 dt/ha'
'< 60 dt/ha'
'alle Ertragsklassen'
/;

parameter p_lwkCrops_lwkYield_ktblYield(LWK_crops,LWK_yield,KTBL_yield) /
'Winterweizen'.'> 70 dt/ha Windhalmstandort'.'hoch, mittlerer Boden' 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'.'mittel, schwerer Boden' 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'.'mittel, mittlerer Boden' 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'.'mittel, leichter Boden' 1
'Winterweizen'.'< 70 dt/ha'.'niedrig, mittlerer Boden' 1
'Winterweizen'.'< 70 dt/ha'.'niedrig, leichter Boden' 1
'Wintergerste'.'> 70 dt/ha Windhalmstandort'.'hoch, mittlerer Boden' 1
'Wintergerste'.'< 70 dt/ha'.'mittel, schwerer Boden' 1
'Wintergerste'.'< 70 dt/ha'.'mittel, mittlerer Boden' 1
'Wintergerste'.'< 70 dt/ha'.'mittel, leichter Boden' 1
'Wintergerste'.'< 70 dt/ha'.'niedrig, mittlerer Boden' 1
'Wintergerste'.'< 70 dt/ha'.'niedrig, leichter Boden' 1
'Winterroggen & Triticale'.'> 60 dt/ha'.'hoch, mittlerer Boden' 1
'Winterroggen & Triticale'.'< 60 dt/ha'.'mittel, schwerer Boden' 1
'Winterroggen & Triticale'.'< 60 dt/ha'.'mittel, mittlerer Boden' 1
'Winterroggen & Triticale'.'< 60 dt/ha'.'mittel, leichter Boden' 1
'Winterroggen & Triticale'.'< 60 dt/ha'.'niedrig, mittlerer Boden' 1
'Winterroggen & Triticale'.'< 60 dt/ha'.'niedrig, leichter Boden' 1
'Raps'.'alle Ertragsklassen'.'hoch, mittlerer Boden' 1
'Raps'.'alle Ertragsklassen'.'mittel, schwerer Boden' 1
'Raps'.'alle Ertragsklassen'.'mittel, mittlerer Boden' 1
'Raps'.'alle Ertragsklassen'.'mittel, leichter Boden' 1
'Raps'.'alle Ertragsklassen'.'niedrig, mittlerer Boden' 1
'Raps'.'alle Ertragsklassen'.'niedrig, leichter Boden' 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'.'hoch, mittlerer Boden' 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'.'mittel, schwerer Boden' 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'.'mittel, mittlerer Boden' 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'.'mittel, leichter Boden' 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'.'niedrig, mittlerer Boden' 1
'Speise & Industriekartoffeln'.'alle Ertragsklassen'.'niedrig, leichter Boden' 1
'Zuckerrüben'.'alle Ertragsklassen'.'hoch, mittlerer Boden' 1
'Zuckerrüben'.'alle Ertragsklassen'.'mittel, schwerer Boden' 1
'Zuckerrüben'.'alle Ertragsklassen'.'mittel, mittlerer Boden' 1
'Zuckerrüben'.'alle Ertragsklassen'.'mittel, leichter Boden' 1
'Zuckerrüben'.'alle Ertragsklassen'.'niedrig, mittlerer Boden' 1
'Zuckerrüben'.'alle Ertragsklassen'.'niedrig, leichter Boden' 1
'Zuckerrüben'.'alle Ertragsklassen'.'sehr niedrig, leichter Boden' 1
'Mais'.'alle Ertragsklassen'.'hoch, mittlerer Boden' 1
'Mais'.'alle Ertragsklassen'.'mittel, schwerer Boden' 1
'Mais'.'alle Ertragsklassen'.'mittel, mittlerer Boden' 1
'Mais'.'alle Ertragsklassen'.'mittel, leichter Boden' 1
'Mais'.'alle Ertragsklassen'.'niedrig, mittlerer Boden' 1
'Mais'.'alle Ertragsklassen'.'niedrig, leichter Boden' 1
'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'.'hoch, mittlerer Boden' 1
'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'.'mittel, schwerer Boden' 1
'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'.'mittel, mittlerer Boden' 1
'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'.'mittel, leichter Boden' 1
'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'.'niedrig, mittlerer Boden' 1
'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'.'niedrig, leichter Boden' 1
/;

set pestType /soilHerb,foliarHerb,fung,insect,growthReg,dessic/;

set FH(pestType) /foliarHerb/;
set notFH(pestType) /soilHerb, fung, insect, growthReg, dessic/;

set FHBonus(pestType) /foliarHerb, fung, insect, growthReg/;
set notFHBonus(pestType) /soilHerb, dessic/;

set addSavings(pestType) / fung, insect, growthReg /;

set herbProduct /
'Herold SC'
'Gamit 36 AMT'
'Bandur'
'Sumimax'
'Omnera LQM'
'Lentipur'
'Carmina 640'
'Dirigent SX'
'Axial 50'
'Ariane C'
'Starane XL'
'Boxer'
'Traxos'
'Butisan Gold'
'Niantic'
'Atlantis Flex'
'Pointer Plus'
'Broadway'
'Belkar'
'Synero 30 SL'
'Select 240 EC'
'Radiamix'
'Agil S'
'Fuego'
'Targa Super'
'Sencor'
'Cato'
'Belvedere Duo'
'Goltix Titan'
'Metafol'
'Tanaris'
'Vivendi'
'Focus Ultra'
'Dash'
'Hasten'
'Lontrel 600'
'Betasana SC'
'Laudis Aspect Pack'
'MaisTer Power'
'Zintan Saphir Pack'
'Motivell forte'
'Elumis'
'Peak'
'Harmony SX'
'Ranger'
'U 46 M'
/;

set soilHerb(herbProduct) /
'Herold SC'
'Gamit 36 AMT'
'Bandur'
'Carmina 640'
'Butisan Gold'
'Boxer'
/;

set foliarHerb(herbProduct) /
*Goltix Titan und Butisan Gold wurden in Dücker et al 2022 gespottet 
*Goltix Titan ist auch Mischherbizid mit Boden und Kontaktwirkung, ein Wirkstoff hat aber nur Bodenwirkung
'Goltix Titan'
'Sumimax'
'Omnera LQM'
'Lentipur'
'Dirigent SX'
'Axial 50'
'Ariane C'
'Starane XL'
'Traxos'
'Niantic'
'Atlantis Flex'
'Pointer Plus'
'Broadway'
'Belkar'
'Synero 30 SL'
'Select 240 EC'
'Agil S'
*wirkt über Boden und Blatt aber besonders gute Unkrauterfassung im Keimblatt- bzw. erstem Laubblattstadium der Unkräuter
'Fuego'
'Targa Super'
*Sencor ist auch Bodenherbizid, ich lasse es aber mal als Kontaktherbizid durchgehen
'Sencor'
*Cato wird auch über Boden aufgenommen
'Cato'
'Belvedere Duo'
'Metafol'
'Tanaris'
'Vivendi'
'Focus Ultra'
'Dash'
'Hasten'
'Lontrel 600'
'Betasana SC'
*Laudis hat Blattwirkung, Aspect hat Bodenwirkung
'Laudis Aspect Pack'
'MaisTer Power'
'Zintan Saphir Pack'
'Motivell forte'
*Boden und Blattwirkung
'Elumis'
'Peak'
'Harmony SX'
'Ranger'
'U 46 M'
/;

parameter p_herbCosts(herbProduct) in € per l or kg without value added tax /
*Costs according to myagrar.de from 15.05.2024
*Gamit 36 AMT, Starane XL, focus ultra, belkar, dash from Avagrar
'Herold SC' 57.12
'Gamit 36 AMT' 80.4
'Bandur' 20.81
'Sumimax' 389.25
'Omnera LQM' 30.17
'Lentipur' 14.28
'Carmina 640' 15.81
'Dirigent SX' 508.96
'Axial 50' 39.93
'Ariane C' 25.98
'Starane XL' 17.46
'Boxer' 7.86
'Traxos' 39.41
'Butisan Gold' 35.67
'Niantic' 39.8
'Atlantis Flex' 44.11
'Pointer Plus' 498.03
'Broadway' 39.58
'Belkar' 132.77
'Synero 30 SL' 37.43
'Select 240 EC' 18.06
'Agil S' 22.99
'Fuego' 20.91
'Targa Super' 10.49
'Sencor' 50.97
'Cato' 123.86
'Belvedere Duo' 28.25
'Goltix Titan' 27.92
'Metafol' 17.17
'Tanaris' 47.86
'Vivendi' 34.16
'Focus Ultra' 16.13
'Dash' 8.24
'Hasten' 11
'Lontrel 600' 236.33
'Betasana SC' 12.05
'Laudis Aspect Pack' 23.72
'MaisTer Power' 42.39
'Zintan Saphir Pack' 20.13
'Motivell forte' 18.22
'Elumis' 16.36
'Peak' 727.63
'Harmony SX' 1375.44
'Ranger' 47.01
'U 46 M' 9.39
/;

parameter p_sprayAmountHerbLWK(LWK_crops,LWK_yield,herbProduct) in l or kg per ha /
*Assumption medium spray intensity 
'Winterweizen'.'< 70 dt/ha'.'Herold SC' 0.25
'Winterweizen'.'< 70 dt/ha'.'Lentipur' 1
'Winterweizen'.'< 70 dt/ha'.'Omnera LQM' 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'.'Herold SC' 0.3
'Winterweizen'.'> 70 dt/ha Windhalmstandort'.'Axial 50' 0.9 
'Winterweizen'.'> 70 dt/ha Windhalmstandort'.'Omnera LQM' 1
'Winterweizen'.'> 70 dt/ha Windhalmstandort'.'Ariane C' 1
'Wintergerste'.'< 70 dt/ha'.'Herold SC' 0.3
'Wintergerste'.'< 70 dt/ha'.'Ariane C' 0.75
'Wintergerste'.'> 70 dt/ha Windhalmstandort'.'Herold SC' 0.3
'Wintergerste'.'> 70 dt/ha Windhalmstandort'.'Axial 50' 0.9
'Wintergerste'.'> 70 dt/ha Windhalmstandort'.'Dirigent SX' 0.035
'Winterroggen & Triticale'.'< 60 dt/ha'.'Herold SC' 0.3
'Winterroggen & Triticale'.'< 60 dt/ha'.'Broadway' 0.13
'Winterroggen & Triticale'.'> 60 dt/ha'.'Herold SC' 0.3
'Winterroggen & Triticale'.'> 60 dt/ha'.'Axial 50' 0.9
'Winterroggen & Triticale'.'> 60 dt/ha'.'Pointer Plus' 0.05
'Raps'.'alle Ertragsklassen'.'Butisan Gold' 2
'Raps'.'alle Ertragsklassen'.'Agil S' 0.75
'Speise & Industriekartoffeln'.'alle Ertragsklassen'.'Boxer' 3
'Speise & Industriekartoffeln'.'alle Ertragsklassen'.'Sencor' 0.4
'Zuckerrüben'.'alle Ertragsklassen'.'Belvedere Duo' 3.75
'Zuckerrüben'.'alle Ertragsklassen'.'Goltix Titan' 4.5
'Zuckerrüben'.'alle Ertragsklassen'.'Hasten' 1.5
'Zuckerrüben'.'alle Ertragsklassen'.'Lontrel 600' 0.2
'Zuckerrüben'.'alle Ertragsklassen'.'Select 240 EC' 1.75
'Mais'.'alle Ertragsklassen'.'Zintan Saphir Pack' 3.5
'Mais'.'alle Ertragsklassen'.'Motivell forte' 0.75
'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'.'Ranger' 1
'Grünlandnutzung (Mähweide)'.'alle Ertragsklassen'.'U 46 M' 0.5
/;

parameter p_sprayInputCostsNotHerbLWK(LWK_crops,LWK_yield,pestType) /
*calculated out value added tax
'Winterweizen'.'< 70 dt/ha'.fung 66.33
'Winterweizen'.'< 70 dt/ha'.insect 7.71
'Winterweizen'.'< 70 dt/ha'.growthReg 11.77
'Winterweizen'.'> 70 dt/ha Windhalmstandort'.fung 91.18
'Winterweizen'.'> 70 dt/ha Windhalmstandort'.insect 7.71
'Winterweizen'.'> 70 dt/ha Windhalmstandort'.growthReg 18.42
'Wintergerste'.'< 70 dt/ha'.fung 43.52
'Wintergerste'.'< 70 dt/ha'.growthReg 11.29
'Wintergerste'.'> 70 dt/ha Windhalmstandort'.fung 80.02
'Wintergerste'.'> 70 dt/ha Windhalmstandort'.growthReg 22.75
'Winterroggen & Triticale'.'> 60 dt/ha'.fung 23.3
'Winterroggen & Triticale'.'> 60 dt/ha'.insect 7.71
'Winterroggen & Triticale'.'> 60 dt/ha'.growthReg 20.11
'Winterroggen & Triticale'.'< 60 dt/ha'.fung 19.28
'Winterroggen & Triticale'.'< 60 dt/ha'.growthReg 11.3
'Raps'.'alle Ertragsklassen'.insect 18.24
'Raps'.'alle Ertragsklassen'.growthReg 36.82
'Speise & Industriekartoffeln'.'alle Ertragsklassen'.fung 213.68
'Speise & Industriekartoffeln'.'alle Ertragsklassen'.insect 19
'Speise & Industriekartoffeln'.'alle Ertragsklassen'.dessic 113.77
'Zuckerrüben'.'alle Ertragsklassen'.fung 147.55
'Zuckerrüben'.'alle Ertragsklassen'.insect 25
/;

parameters
    p_sprayInputCosts(KTBL_crops,KTBL_yield,pestType)
    p_numberSprayPasses(KTBL_crops,KTBL_yield)
;

p_sprayInputCosts(KTBL_crops,KTBL_yield,pestType) = 
    sum((LWK_crops,LWK_yield),
    p_sprayInputCostsNotHerbLWK(LWK_crops,LWK_yield,pestType)
    * p_lwkCrops_lwkYield_ktblYield(LWK_crops,LWK_yield,KTBL_yield)
    * p_ktblCrops_lwkCrops(KTBL_crops,LWK_crops))
;

p_sprayInputCosts(KTBL_crops,KTBL_yield,"soilHerb") =
    sum((LWK_crops,LWK_yield,soilHerb),
    p_sprayAmountHerbLWK(LWK_crops,LWK_yield,soilHerb) * p_herbCosts(soilHerb)
    * p_lwkCrops_lwkYield_ktblYield(LWK_crops,LWK_yield,KTBL_yield)
    * p_ktblCrops_lwkCrops(KTBL_crops,LWK_crops))
;

p_sprayInputCosts(KTBL_crops,KTBL_yield,"foliarHerb") =
    sum((LWK_crops,LWK_yield,foliarHerb),
    p_sprayAmountHerbLWK(LWK_crops,LWK_yield,foliarHerb) * p_herbCosts(foliarHerb)
    * p_lwkCrops_lwkYield_ktblYield(LWK_crops,LWK_yield,KTBL_yield)
    * p_ktblCrops_lwkCrops(KTBL_crops,LWK_crops))
;
*option p_sprayInputCosts:1:2:1 display p_sprayInputCosts;

set halfMonth(measures) /
    MRZ1
    MRZ2
    APR1
    APR2
    MAI1
    MAI2
    JUN1
    JUN2
    JUL1
    JUL2
    AUG1
    AUG2
    SEP1
    SEP2
    OKT1
    OKT2
    NOV1
    NOV2
/;

*available field days for field operations including crop protection, mechanical weed control, mineral fertilizer application, seedbed preperation...
*according to Betriebsplanung Landwirtschaft 2018/2019 for climate region 6 including regions of NRW such as Kleve, Borken and Coesfeld for low soil resistance
parameter fieldDays(halfMonth) /
    MRZ1 1
    MRZ2 4
    APR1 8
    APR2 11
    MAI1 11
    MAI2 12
    JUN1 11
    JUN2 11
    JUL1 12
    JUL2 12
    AUG1 12
    AUG2 12
    SEP1 12
    SEP2 12
    OKT1 11
    OKT2 10
    NOV1 8
    NOV2 4
/;