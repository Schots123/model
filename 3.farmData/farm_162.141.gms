set plotAttr /size, distance, soilQual, soilType/;

set cropAttr /maxShare, minShare, maxShareYieldLev/;

set curCrops(KTBL_crops) /
'Zuckerrueben' 
'Winterweizen - Backweizen' 
'Winterweizen - Korn und Stroh (thermische Nutzung)' 
'Wintergerste - Futtergerste' 
/;

set curCropGroups(allItems) /
'Winterweizen'
'Wintergerste'
'Zuckerrueben'
/;

*set cropsBreak2(curCropGroups) /
*'Zuckerrueben'
*/;

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
'Zuckerrueben'.maxShare 33.33
'Winterweizen'.maxShareYieldLev 70
'Zuckerrueben'.maxShareYieldLev 40
/;


set curPlots /
'3938079'
'4120598'
'4122536'
'3773688'
'3714896'
'4078851'
'3773687'
'3722458'
'3722443'
'3881944'
'3722470'
'4064196'
'3873432'
'3849210'
'3816283'
'4163451'
'4361887'
'4122540'
'4442580'
'3821255'
'3773701'
/;

set plots_permPast(curPlots) /
/;

parameter p_plotData(curPlots,plotAttr) /
'3938079'.size 3.55 
'4120598'.size 10.58
'4122536'.size 0.76
'3773688'.size 4.94
'3714896'.size 1.38
'4078851'.size 1.70
'3773687'.size 3.70
'3722458'.size 0.50
'3722443'.size 1.32
'3881944'.size 1.71
'3722470'.size 2.64
'4064196'.size 1.11
'3873432'.size 10.03
'3849210'.size 0.95
'3816283'.size 0.98 
'4163451'.size 7.95
'4361887'.size 1.80
'4122540'.size 6.51
'4442580'.size 1.57
'3821255'.size 0.49
'3773701'.size 0.09

'3938079'.distance 0.32
'4120598'.distance 0.15
'4122536'.distance 0.09
'3773688'.distance 0.55
'3714896'.distance 0.10
'4078851'.distance 1.14
'3773687'.distance 0.70
'3722458'.distance 1.32
'3722443'.distance 0.14
'3881944'.distance 0.17
'3722470'.distance 2.56
'4064196'.distance 1.67
'3873432'.distance 1.02
'3849210'.distance 1.16
'3816283'.distance 0.88
'4163451'.distance 1.27
'4361887'.distance 0.86
'4122540'.distance 2.65
'4442580'.distance 6.88
'3821255'.distance 3.74
'3773701'.distance 1.21

'3938079'.soilQual 80
'4120598'.soilQual 80
'4122536'.soilQual 80
'3773688'.soilQual 80
'3714896'.soilQual 80
'4078851'.soilQual 80
'3773687'.soilQual 80
'3722458'.soilQual 80
'3722443'.soilQual 80
'3881944'.soilQual 80
'3722470'.soilQual 80
'4064196'.soilQual 65
'3873432'.soilQual 80
'3849210'.soilQual 80
'3816283'.soilQual 65
'4163451'.soilQual 65
'4361887'.soilQual 65
'4122540'.soilQual 80
'4442580'.soilQual 80
'3821255'.soilQual 50
'3773701'.soilQual 80

'3938079'.soilType lehmigerSchluff
'4120598'.soilType lehmigerSchluff
'4122536'.soilType lehmigerSchluff
'3773688'.soilType lehmigerSchluff
'3714896'.soilType lehmigerSchluff
'4078851'.soilType schluffigerLehm
'3773687'.soilType lehmigerSchluff
'3722458'.soilType schluffigerLehm
'3722443'.soilType lehmigerSchluff
'3881944'.soilType lehmigerSchluff
'3722470'.soilType schluffigerLehm
'4064196'.soilType schluffigerLehm
'3873432'.soilType schluffigerLehm
'3849210'.soilType schluffigerLehm
'3816283'.soilType schluffigerLehm
'4163451'.soilType schluffigerLehm
'4361887'.soilType schluffigerLehm
'4122540'.soilType schluffigerLehm
'4442580'.soilType lehmigerSchluff
'3821255'.soilType schluffigerLehm
'3773701'.soilType schluffigerLehm
/;

set animalBranch / milkCows, fattPigs /;

parameter p_animalPlaces(animalBranch) / milkCows 0 /;