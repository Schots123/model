set plotAttr /size, distance, soilQual, soilType/;

set cropAttr /maxShare, minShare/;

set curCrops(KTBL_crops) /
'Winterweizen - Backweizen' 
'Winterweizen - Korn und Stroh (thermische Nutzung)' 
'Wintergerste - Futtergerste' 
'Winterraps' 
'Winterraps (Rapsoel)'
/;

set curCropGroups(allItems) /
'Winterweizen'
'Wintergerste'
'Winterraps'
/;

set cropsBreak2(curCropGroups) /
'Winterraps'
/;

set curCrops_curCropGroups(curCropGroups,curCrops) /
'Winterweizen'.'Winterweizen - Backweizen' YES
'Winterweizen'.'Winterweizen - Korn und Stroh (thermische Nutzung)' YES
'Wintergerste'.'Wintergerste - Futtergerste' YES
'Winterraps'.'Winterraps' YES
'Winterraps'.'Winterraps (Rapsoel)' YES
/;

set curRowCrops(curCrops);

parameter p_cropData(curCropGroups,cropAttr)  /
'Winterweizen'.maxShare 50
'Wintergerste'.maxShare 50
'Winterraps'.maxShare 50
/;

set curPlots /
'3871999'
*'4025521'
'4025498'
'3813200'
'3813202'
'3872003'
'3813199'
'4025508'
'4025514'
'3775487'
*'3872218'
*'4025500'
'4025512'
'4025507'
'3872013'
'4025497'
'3813191'
'3813198'
'4227566'
'4025505'
'4153261'
'4025523'
'4227556'
'4048407'
'3824579'
'3858737'
'4431424'
'4150587'
'3872255'
'4370868'
'3741503'
'3813190'
'3823255'
'3998351'
'3969216'
/;

set plots_permPast(curPlots)/
/;
*'4025521'
*'3872218'
*'4025500'
*/;

parameter p_plotData(curPlots,plotAttr) /
'3871999'.size 0.62
*'4025521'.size 0.30
'4025498'.size 3.07
'3813200'.size 4.03
'3813202'.size 2.40
'3872003'.size 1.70
'3813199'.size 6.72
'4025508'.size 0.47
'4025514'.size 0.88
'3775487'.size 0.58
*'3872218'.size 0.12
*'4025500'.size 1.58
'4025512'.size 1.79
'4025507'.size 6.28
'3872013'.size 2.71
'4025497'.size 2.24 
'3813191'.size 3.04
'3813198'.size 0.82
'4227566'.size 2.38
'4025505'.size 1.16
'4153261'.size 3.59
'4025523'.size 0.71
'4227556'.size 2.27
'4048407'.size 7.14
'3824579'.size 1.10
'3858737'.size 1.70
'4431424'.size 1.17
'4150587'.size 3.11
'3872255'.size 3.74
'4370868'.size 3.23
'3741503'.size 3.33
'3813190'.size 4.03
'3823255'.size 1.74
'3998351'.size 7.81
'3969216'.size 1.53

'3871999'.distance 0.28
*'4025521'.distance 0.29
'4025498'.distance 0.13
'3813200'.distance 0.36
'3813202'.distance 0.49
'3872003'.distance 0.64
'3813199'.distance 0.53
'4025508'.distance 0.25
'4025514'.distance 0.30
'3775487'.distance 0.24
*'3872218'.distance 0.35
*'4025500'.distance 0.57
'4025512'.distance 0.06
'4025507'.distance 0.26
'3872013'.distance 0.45
'4025497'.distance 0.44
'3813191'.distance 0.59
'3813198'.distance 0.18
'4227566'.distance 0.22
'4025505'.distance 0.44
'4153261'.distance 1.25
'4025523'.distance 0.46
'4227556'.distance 1.42
'4048407'.distance 2.96
'3824579'.distance 0.61
'3858737'.distance 2.29
'4431424'.distance 2.38
'4150587'.distance 4.90
'3872255'.distance 4.50
'4370868'.distance 5.32
'3741503'.distance 2.75
'3813190'.distance 0.85
'3823255'.distance 5.91
'3998351'.distance 8.05
'3969216'.distance 3.10

'3871999'.soilQual 55
*'4025521'.soilQual 42.5
'4025498'.soilQual 42.5
'3813200'.soilQual 42.5
'3813202'.soilQual 42.5
'3872003'.soilQual 55
'3813199'.soilQual 42.5
'4025508'.soilQual 42.5
'4025514'.soilQual 42.5
'3775487'.soilQual 42.5
*'3872218'.soilQual 42.5
*'4025500'.soilQual 42.5
'4025512'.soilQual 42.5
'4025507'.soilQual 42.5 
'3872013'.soilQual 42.5
'4025497'.soilQual 55
'3813191'.soilQual 42.5
'3813198'.soilQual 42.5
'4227566'.soilQual 42.5
'4025505'.soilQual 55
'4153261'.soilQual 55
'4025523'.soilQual 55
'4227556'.soilQual 55
'4048407'.soilQual 32.5
'3824579'.soilQual 55
'3858737'.soilQual 55
'4431424'.soilQual 55
'4150587'.soilQual 32.5
'3872255'.soilQual 40
'4370868'.soilQual 30
'3741503'.soilQual 32.5
'3813190'.soilQual 42.5
'3823255'.soilQual 40
'3998351'.soilQual 30
'3969216'.soilQual 40

'3871999'.soilType sandigerLehm
*'4025521'.soilType lehmigerSand
'4025498'.soilType lehmigerSand
'3813200'.soilType lehmigerSand
'3813202'.soilType lehmigerSand
'3872003'.soilType lehmigerSand 
'3813199'.soilType sandigerLehm
'4025508'.soilType lehmigerSand
'4025514'.soilType lehmigerSand
'3775487'.soilType lehmigerSand
*'3872218'.soilType lehmigerSand
*'4025500'.soilType lehmigerSand
'4025512'.soilType lehmigerSand
'4025507'.soilType lehmigerSand
'3872013'.soilType lehmigerSand
'4025497'.soilType sandigerLehm
'3813191'.soilType lehmigerSand
'3813198'.soilType lehmigerSand
'4227566'.soilType lehmigerSand
'4025505'.soilType sandigerLehm
'4153261'.soilType sandigerLehm
'4025523'.soilType sandigerLehm
'4227556'.soilType sandigerLehm
'4048407'.soilType Sand
'3824579'.soilType sandigerLehm
'3858737'.soilType sandigerLehm
'4431424'.soilType sandigerLehm
'4150587'.soilType Sand
'3872255'.soilType lehmigerSand
'4370868'.soilType Sand
'3741503'.soilType Sand
'3813190'.soilType lehmigerSand
'3823255'.soilType lehmigerSand
'3998351'.soilType Sand
'3969216'.soilType lehmigerSand
/;

set animalBranch / milkCows, fattPigs /;

parameter p_animalPlaces(animalBranch) / milkCows 0 /;