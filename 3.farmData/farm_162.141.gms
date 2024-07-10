set plotAttr /size, distance, soilQual, soilType/;

set cropAttr /maxShare, minShare/;

set curCrops(KTBL_crops) /
'Zuckerrueben' 
'Winterweizen - Backweizen' 
'Winterweizen - Korn und Stroh (thermische Nutzung)' 
'Wintergerste - Futtergerste' 
/;

set cropsBreak2(curCrops) /
'Zuckerrueben'
/;

set curCropGroups(allItems) /
'Winterweizen'
'Wintergerste'
'Zuckerrueben'
/;

set curCrops_curCropGroups(curCropGroups,curCrops) /
'Winterweizen'.'Winterweizen - Backweizen' YES
'Winterweizen'.'Winterweizen - Korn und Stroh (thermische Nutzung)' YES
'Wintergerste'.'Wintergerste - Futtergerste' YES
'Zuckerrueben'.'Zuckerrueben' YES
/;

set curRowCrops(curCrops) /
'Zuckerrueben'
/;

parameter p_cropData(curCropGroups,cropAttr)  /
'Winterweizen'.maxShare 50
'Wintergerste'.maxShare 50
'Zuckerrueben'.maxShare 50
'Zuckerrueben'.minShare 20
/;


set curPlots /
'4161733'
'3882193'
'4365192'
'4186235'
'4365187'
*'4001270'
*'4140543'
*'4140502'
'4186237'
'4365190'
'4162098'
'4324482'
'4186206'
'4427550'
'4186204'
'4163825'
'4186230'
'3882187'
'3733275'
'4402735'
'3773497'
'4107825'
'3911318'
'3911321'
'4162092'
'4317191'
'4402704'
'4444559'
/;

set plots_permPast(curPlots)//;
$ontext
set plots_permPast(curPlots) /
'4001270'
'4140543'
'4140502'
/;
$offtext

parameter p_plotData(curPlots,plotAttr) /
'4161733'.size 5.80
'3882193'.size 3.12
'4365192'.size 0.11
'4186235'.size 5.00
'4365187'.size 1.83
*'4001270'.size 1.70
*'4140543'.size 0.79
*'4140502'.size 0.35
'4186237'.size 3.27
'4365190'.size 0.14
'4162098'.size 1.68
'4324482'.size 2.23
'4186206'.size 1.79
'4427550'.size 2.04
'4186204'.size 5.83
'4163825'.size 2.02
'4186230'.size 6.23
'3882187'.size 1.62
'3733275'.size 3.48
'4402735'.size 2.49
'3773497'.size 5.23
'4107825'.size 1.64
'3911318'.size 1.88
'3911321'.size 1.80
'4162092'.size 2.98
'4317191'.size 4.37
'4402704'.size 0.44
'4444559'.size 0.10

'4161733'.distance 0.28
'3882193'.distance 0.18
'4365192'.distance 0.06
'4186235'.distance 0.13
'4365187'.distance 0.14
*'4001270'.distance 6.94
*'4140543'.distance 10.75
*'4140502'.distance 11.36
'4186237'.distance 0.37
'4365190'.distance 0.03
'4162098'.distance 0.90
'4324482'.distance 1.15
'4186206'.distance 0.68
'4427550'.distance 0.84
'4186204'.distance 0.79
'4163825'.distance 1.08
'4186230'.distance 0.35
'3882187'.distance 0.95
'3733275'.distance 0.56
'4402735'.distance 0.99
'3773497'.distance 1.40
'4107825'.distance 0.24
'3911318'.distance 0.40
'3911321'.distance 0.80
'4162092'.distance 1.52
'4317191'.distance 2.10
'4402704'.distance 1.06
'4444559'.distance 0.07

'4161733'.soilQual 65
'3882193'.soilQual 65
'4365192'.soilQual 50
'4186235'.soilQual 65
'4365187'.soilQual 50
*'4001270'.soilQual 40
*'4140543'.soilQual 40
*'4140502'.soilQual 45
'4186237'.soilQual 50
'4365190'.soilQual 50
'4162098'.soilQual 50
'4324482'.soilQual 50
'4186206'.soilQual 50
'4427550'.soilQual 50
'4186204'.soilQual 50
'4163825'.soilQual 50
'4186230'.soilQual 50
'3882187'.soilQual 50
'3733275'.soilQual 50
'4402735'.soilQual 50
'3773497'.soilQual 67.5
'4107825'.soilQual 65
'3911318'.soilQual 65
'3911321'.soilQual 65
'4162092'.soilQual 80
'4317191'.soilQual 80
'4402704'.soilQual 67.5
'4444559'.soilQual 50

'4161733'.soilType schluffigerLehm
'3882193'.soilType schluffigerLehm
'4365192'.soilType schluffigerLehm
'4186235'.soilType schluffigerLehm
'4365187'.soilType schluffigerLehm
*'4001270'.soilType schluffigerLehm
*'4140543'.soilType schluffigerLehm
*'4140502'.soilType schluffigerLehm
'4186237'.soilType schluffigerLehm
'4365190'.soilType schluffigerLehm
'4162098'.soilType schluffigerLehm
'4324482'.soilType schluffigerLehm
'4186206'.soilType schluffigerLehm
'4427550'.soilType schluffigerLehm
'4186204'.soilType schluffigerLehm
'4163825'.soilType schluffigerLehm
'4186230'.soilType schluffigerLehm
'3882187'.soilType schluffigerLehm
'3733275'.soilType schluffigerLehm
'4402735'.soilType schluffigerLehm
'3773497'.soilType schluffigerLehm
'4107825'.soilType schluffigerLehm
'3911318'.soilType schluffigerLehm
'3911321'.soilType schluffigerLehm
'4162092'.soilType schluffigerLehm
'4317191'.soilType schluffigerLehm
'4402704'.soilType schluffigerLehm
'4444559'.soilType schluffigerLehm
/;

set animalBranch / milkCows, fattPigs /;

parameter p_animalPlaces(animalBranch) / milkCows 0 /;