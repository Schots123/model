set plotAttr /size, distance, soilQual, soilType/;

set cropAttr /maxShare, minShare, maxShareYieldLev/;

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

*set cropsBreak2(curCropGroups) /
*'Winterraps'
*/;

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
'Winterraps'.maxShare 33.33
'Winterweizen'.maxShareYieldLev 70
'Winterraps'.maxShareYieldLev 40
/;

set curPlots /
'4348166'
'4416147'
'4416146'
'4348156'
'3743882'
'4348143'
'4416148'
'4388739'
'4348167'
'4348147'
'4421009'
'4348138'
'4420997'
'4098429'
'4320887'
'4098430'
'4348144'
'4165038'
'4348164'
'4321238'
'4135103'
'4143893'
'4130665'
'4320981'
'3969986'
'4256161'
'4465159'
'4130407'
'4465264'
'4398641'
/;

set plots_permPast(curPlots)/
/;

parameter p_plotData(curPlots,plotAttr) /
'4348166'.size 0.67
'4416147'.size 3.63
'4416146'.size 4.11
'4348156'.size 3.44
'3743882'.size 2.50
'4348143'.size 0.56
'4416148'.size 0.62
'4388739'.size 2.50
'4348167'.size 0.83
'4348147'.size 1.47
'4421009'.size 2.94
'4348138'.size 2.14
'4420997'.size 1.68
'4098429'.size 2.69
'4320887'.size 1.55
'4098430'.size 2.67
'4348144'.size 2.63
'4165038'.size 6.19
'4348164'.size 1.12
'4321238'.size 5.11
'4135103'.size 3.70
'4143893'.size 0.43
'4130665'.size 1.21
'4320981'.size 2.76
'3969986'.size 1.76
'4256161'.size 8.18
'4465159'.size 3.96
'4130407'.size 5.53
'4465264'.size 1.87
'4398641'.size 0.58

'4348166'.distance 0.51
'4416147'.distance 0.23
'4416146'.distance 0.48
'4348156'.distance 0.42
'3743882'.distance 0.72
'4348143'.distance 0.61
'4416148'.distance 0.07
'4388739'.distance 0.83
'4348167'.distance 0.08
'4348147'.distance 0.41
'4421009'.distance 1.06
'4348138'.distance 0.90
'4420997'.distance 1.02
'4098429'.distance 1.58 
'4320887'.distance 1.50
'4098430'.distance 1.09
'4348144'.distance 0.88
'4165038'.distance 1.78
'4348164'.distance 0.94
'4321238'.distance 1.81
'4135103'.distance 0.79
'4143893'.distance 0.94
'4130665'.distance 0.99
'4320981'.distance 2.59
'3969986'.distance 1.69
'4256161'.distance 1.99
'4465159'.distance 1.37
'4130407'.distance 3.07
'4465264'.distance 1.43
'4398641'.distance 6.84

'4348166'.soilQual 50
'4416147'.soilQual 50
'4416146'.soilQual 50
'4348156'.soilQual 50
*'3743882'.soilQual 37.5
'3743882'.soilQual 41
*'4348143'.soilQual 37.5
'4348143'.soilQual 41
'4416148'.soilQual 50
*'4388739'.soilQual 37.5
'4388739'.soilQual 41
'4348167'.soilQual 50
'4348147'.soilQual 50
'4421009'.soilQual 42.5
'4348138'.soilQual 42.5
'4420997'.soilQual 42.5
'4098429'.soilQual 75
'4320887'.soilQual 50
'4098430'.soilQual 50
'4348144'.soilQual 70
'4165038'.soilQual 67.5
'4348164'.soilQual 50
'4321238'.soilQual 67.5
'4135103'.soilQual 50
'4143893'.soilQual 50
'4130665'.soilQual 70
*'4320981'.soilQual 25
'4320981'.soilQual 41
'3969986'.soilQual 75
'4256161'.soilQual 52.5
'4465159'.soilQual 50
'4130407'.soilQual 42.5
'4465264'.soilQual 42.5
'4398641'.soilQual 80

'4348166'.soilType lehmigerSand
'4416147'.soilType lehmigerSand
'4416146'.soilType lehmigerSand
'4348156'.soilType lehmigerSand
'3743882'.soilType lehmigerSand
'4348143'.soilType lehmigerSand
'4416148'.soilType lehmigerSand
'4388739'.soilType lehmigerSand
'4348167'.soilType lehmigerSand
'4348147'.soilType lehmigerSand
'4421009'.soilType Sand
'4348138'.soilType lehmigerSand
'4420997'.soilType lehmigerSand
'4098429'.soilType lehmigerSchluff
'4320887'.soilType lehmigerSand
'4098430'.soilType lehmigerSand
'4348144'.soilType lehmigerSchluff
'4165038'.soilType schluffigerLehm
'4348164'.soilType lehmigerSand
'4321238'.soilType schluffigerLehm
'4135103'.soilType lehmigerSand
'4143893'.soilType lehmigerSand
'4130665'.soilType lehmigerSchluff
'4320981'.soilType Sand
'3969986'.soilType lehmigerSchluff
'4256161'.soilType lehmigerSchluff
'4465159'.soilType lehmigerSand
'4130407'.soilType lehmigerSand
'4465264'.soilType Sand
'4398641'.soilType lehmigerSchluff
/;

set animalBranch / milkCows, fattPigs /;

parameter p_animalPlaces(animalBranch) / milkCows 0 /;