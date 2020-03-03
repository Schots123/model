* -------------------------------
* Fruchtfolge Model - Include file
* Institute for Food an Resource Economics
* University of Bonn
* (c) Christoph Pahmeyer, 2020
* -------------------------------

* Static data
set plotAttr / size /;
set cropAttr / maxShare /;
set symbol / lt,gt /;
set months /jan,feb,mrz,apr,mai,jun,jul,aug,sep,okt,nov,dez/;
set years / 2001*2050 /;
set manAmounts /0,10,15,20,25,30,40,50,60/;
set nReduction /'0','0.1','0.2','0.3','0.4'/;
set solidAmounts /'0','10','15','20','25','30'/;
set catchCrop /true, false/;
set autumnFert /true, false/;
$onempty
$offdigit
set curYear(years) / 2019 /;
$setglobal duev2020 "true"
scalar manStorage /1500 /;
scalar manPriceSpring /12 /;
scalar manPriceAutumn /12 /;
set curPlots /
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'
 '2d64e2d8-1909-4abf-9c42-71041141645a'
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'
 '558f9729-9f85-4837-ad21-033762c4ba5d'
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'
 '62ffe0b8-d621-436b-a76a-1f44235178e0'
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'
 '9f7e7bdf-919e-450c-ab20-1998696397a3'
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'
 'af3d2471-1e40-4c82-b332-0147a237b3dd'
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'
 'cc74cf23-840a-4016-a5b6-144b4d228489'
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'
 'dc298ebb-1b27-411a-8024-af0623f621c5'
/;

parameter p_plotData(curPlots,plotAttr) /
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.size 3.64
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.size 8.62
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.size 1.93
 '2d64e2d8-1909-4abf-9c42-71041141645a'.size 3.31
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.size 4.76
 '558f9729-9f85-4837-ad21-033762c4ba5d'.size 6.46
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.size 2.74
 '62ffe0b8-d621-436b-a76a-1f44235178e0'.size 7.81
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.size 5.87
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'.size 4.72
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.size 2.34
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.size 1.98
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.size 4.28
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.size 1.37
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.size 4.17
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.size 6.49
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.size 8.95
 'cc74cf23-840a-4016-a5b6-144b4d228489'.size 6.38
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.size 9.02
 'dc298ebb-1b27-411a-8024-af0623f621c5'.size 3.57
/;

set plots_duevEndangered(curPlots) /
 '2d64e2d8-1909-4abf-9c42-71041141645a' 'YES'
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8' 'YES'
 '62ffe0b8-d621-436b-a76a-1f44235178e0' 'YES'
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f' 'YES'
 '9f7e7bdf-919e-450c-ab20-1998696397a3' 'YES'
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204' 'YES'
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133' 'YES'
 'cc74cf23-840a-4016-a5b6-144b4d228489' 'YES'
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556' 'YES'
 'dc298ebb-1b27-411a-8024-af0623f621c5' 'YES'
/;

set plots_permPast(curPlots) /

/;

set curCrops /
 ''
 'Mais - Silomais'
 'Sommerhafer - Futterhafer'
 'Sommergerste - Braugerste'
 'Wintertriticale - Futtertriticale'
 'Winterweizen - Brotweizen'
 'Zuckerrüben'
 'Winterraps'
 'Wintergerste - Futtergerste'
 'Winterroggen - Mahl- und Brotroggen'
 'Erbsen, Markerbsen'
 'Stärkekartoffeln'
/;

set cropGroup /
 ''
 'Gattung: Zea (Mais)'
 'Sommerhafer'
 'Sommergerste'
 'Wintertriticale'
 'Winterweizen'
 'Gattung: Beta (Rüben)'
 'Winterraps'
 'Wintergerste'
 'Winterroggen'
 'Gattung: Pisum (Erbse)'
 'Art: Solanum tuberosum (Kartoffel)'
/;

set crops_cropGroup(curCrops,cropGroup) /
 ''.''
 'Mais - Silomais'.'Gattung: Zea (Mais)'
 'Sommerhafer - Futterhafer'.'Sommerhafer'
 'Sommergerste - Braugerste'.'Sommergerste'
 'Wintertriticale - Futtertriticale'.'Wintertriticale'
 'Winterweizen - Brotweizen'.'Winterweizen'
 'Zuckerrüben'.'Gattung: Beta (Rüben)'
 'Winterraps'.'Winterraps'
 'Wintergerste - Futtergerste'.'Wintergerste'
 'Winterroggen - Mahl- und Brotroggen'.'Winterroggen'
 'Erbsen, Markerbsen'.'Gattung: Pisum (Erbse)'
 'Stärkekartoffeln'.'Art: Solanum tuberosum (Kartoffel)'
/;

parameter p_cropData(curCrops,cropAttr) /
'Mais - Silomais'.maxShare 50
'Sommerhafer - Futterhafer'.maxShare 25
'Sommergerste - Braugerste'.maxShare 33.33
'Wintertriticale - Futtertriticale'.maxShare 33.33
'Winterweizen - Brotweizen'.maxShare 33.33
'Zuckerrüben'.maxShare 20
'Winterraps'.maxShare 20
'Wintergerste - Futtergerste'.maxShare 33.33
'Winterroggen - Mahl- und Brotroggen'.maxShare 33.33
'Erbsen, Markerbsen'.maxShare 16.67
'Stärkekartoffeln'.maxShare 25
/;

set data_attr /
jan
feb
mrz
apr
mai
jun
jul
aug
sep
okt
nov
dez
nSum
pSum
minNAmount
minPAmount
autumnFertm3
grossMarginHa
efaFactor
fixCosts
grossMarginNoCropEff
/;

parameter p_grossMarginData(curPlots,curCrops,manAmounts,solidAmounts,nReduction,catchCrop,autumnFert,*) /
 '62ffe0b8-d621-436b-a76a-1f44235178e0'.'Mais - Silomais'.'25'.'0'.'0.2'.'false'.'false'.'feb' 3.96
 '62ffe0b8-d621-436b-a76a-1f44235178e0'.'Mais - Silomais'.'25'.'0'.'0.2'.'false'.'false'.'mrz' 5.5
 '62ffe0b8-d621-436b-a76a-1f44235178e0'.'Mais - Silomais'.'25'.'0'.'0.2'.'false'.'false'.'apr' 17.7
 '62ffe0b8-d621-436b-a76a-1f44235178e0'.'Mais - Silomais'.'25'.'0'.'0.2'.'false'.'false'.'mai' 5.73
 '62ffe0b8-d621-436b-a76a-1f44235178e0'.'Mais - Silomais'.'25'.'0'.'0.2'.'false'.'false'.'sep' 43.62
 '62ffe0b8-d621-436b-a76a-1f44235178e0'.'Mais - Silomais'.'25'.'0'.'0.2'.'false'.'false'.'okt' 14.16
 '62ffe0b8-d621-436b-a76a-1f44235178e0'.'Mais - Silomais'.'25'.'0'.'0.2'.'false'.'false'.'nSum' 99
 '62ffe0b8-d621-436b-a76a-1f44235178e0'.'Mais - Silomais'.'25'.'0'.'0.2'.'false'.'false'.'pSum' 70.56
 '62ffe0b8-d621-436b-a76a-1f44235178e0'.'Mais - Silomais'.'25'.'0'.'0.2'.'false'.'false'.'minNAmount' 42
 '62ffe0b8-d621-436b-a76a-1f44235178e0'.'Mais - Silomais'.'25'.'0'.'0.2'.'false'.'false'.'minPAmount' 26
 '62ffe0b8-d621-436b-a76a-1f44235178e0'.'Mais - Silomais'.'25'.'0'.'0.2'.'false'.'false'.'autumnFertm3' 0
 '62ffe0b8-d621-436b-a76a-1f44235178e0'.'Mais - Silomais'.'25'.'0'.'0.2'.'false'.'false'.'grossMarginHa' 740
 '62ffe0b8-d621-436b-a76a-1f44235178e0'.'Mais - Silomais'.'25'.'0'.'0.2'.'false'.'false'.'efaFactor' 0
 '62ffe0b8-d621-436b-a76a-1f44235178e0'.'Mais - Silomais'.'25'.'0'.'0.2'.'false'.'false'.'fixCosts' 534.83
 '62ffe0b8-d621-436b-a76a-1f44235178e0'.'Mais - Silomais'.'25'.'0'.'0.2'.'false'.'false'.'grossMarginNoCropEff' 438
 '2d64e2d8-1909-4abf-9c42-71041141645a'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'feb' 0.99
 '2d64e2d8-1909-4abf-9c42-71041141645a'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'mrz' 2.48
 '2d64e2d8-1909-4abf-9c42-71041141645a'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'apr' 8.07
 '2d64e2d8-1909-4abf-9c42-71041141645a'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'mai' 3.08
 '2d64e2d8-1909-4abf-9c42-71041141645a'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'sep' 18.77
 '2d64e2d8-1909-4abf-9c42-71041141645a'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'okt' 6.57
 '2d64e2d8-1909-4abf-9c42-71041141645a'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'nSum' 109
 '2d64e2d8-1909-4abf-9c42-71041141645a'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'pSum' 70.56
 '2d64e2d8-1909-4abf-9c42-71041141645a'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'minNAmount' 144
 '2d64e2d8-1909-4abf-9c42-71041141645a'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'minPAmount' 138
 '2d64e2d8-1909-4abf-9c42-71041141645a'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'autumnFertm3' 0
 '2d64e2d8-1909-4abf-9c42-71041141645a'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'grossMarginHa' 689
 '2d64e2d8-1909-4abf-9c42-71041141645a'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'efaFactor' 0
 '2d64e2d8-1909-4abf-9c42-71041141645a'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'fixCosts' 538.82
 '2d64e2d8-1909-4abf-9c42-71041141645a'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'grossMarginNoCropEff' 388
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'feb' 1.59
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'mrz' 3.5
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'apr' 11.11
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'mai' 4.1
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'sep' 26.48
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'okt' 9.13
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'nSum' 99
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'pSum' 70.56
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'minNAmount' 107
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'minPAmount' 138
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'autumnFertm3' 0
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'grossMarginHa' 616
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'efaFactor' 0
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'fixCosts' 533.56
 '2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.'Mais - Silomais'.'20'.'0'.'0.2'.'false'.'false'.'grossMarginNoCropEff' 403
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'feb' 0.72
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'mrz' 2.87
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'apr' 6.54
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'mai' 2.38
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'jun' 3.75
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'jul' 5.63
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'aug' 7.05
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'sep' 43.27
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'okt' 0.28
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'nov' 5.69
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'nSum' 99
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'pSum' 67.34
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'minNAmount' 107
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'minPAmount' 111
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'autumnFertm3' 0
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'grossMarginHa' 1444
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'efaFactor' 0
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'fixCosts' 825.95
 '9f7e7bdf-919e-450c-ab20-1998696397a3'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'grossMarginNoCropEff' 1294
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'feb' 3.73
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'mrz' 7.4
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'apr' 16.61
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'mai' 3.33
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'jun' 3.96
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'jul' 5.95
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'aug' 13.52
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'sep' 147.97
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'okt' 0.34
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'nov' 17.09
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'nSum' 109
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'pSum' 67.34
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'minNAmount' 144
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'minPAmount' 111
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'autumnFertm3' 0
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'grossMarginHa' 2158
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'efaFactor' 1
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'fixCosts' 735.89
 'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'grossMarginNoCropEff' 1392
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'feb' 4.24
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'mrz' 7.63
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'apr' 17.48
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'mai' 4.01
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'jun' 5.28
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'jul' 7.93
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'aug' 15.03
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'sep' 149.1
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'okt' 0.44
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'nov' 17.17
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'nSum' 109
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'pSum' 67.34
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'minNAmount' 144
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'minPAmount' 111
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'autumnFertm3' 0
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'grossMarginHa' 1702
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'efaFactor' 0
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'fixCosts' 748.57
 'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'false'.'false'.'grossMarginNoCropEff' 1368
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'feb' 1.83
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'mrz' 4.75
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'apr' 11.27
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'mai' 4.03
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'jun' 6.51
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'jul' 9.77
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'aug' 12.15
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'sep' 76.38
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'okt' 0.5
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'nov' 9.61
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'nSum' 109
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'pSum' 67.34
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'minNAmount' 144
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'minPAmount' 111
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'autumnFertm3' 0
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'grossMarginHa' 2036
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'efaFactor' 1
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'fixCosts' 822.73
 'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'Stärkekartoffeln'.'20'.'0'.'0.2'.'true'.'false'.'grossMarginNoCropEff' 1270
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'feb' 5.32
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'mrz' 2.33
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'apr' 9.66
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'mai' 1.62
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'jun' 4.34
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'aug' 15.63
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'sep' 13.08
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'okt' 13.54
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'nSum' 164
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'pSum' 65.6
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'minNAmount' 348
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'minPAmount' 97
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'autumnFertm3' 0
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'grossMarginHa' 913
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'efaFactor' 0
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'fixCosts' 457.13
 '9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'grossMarginNoCropEff' 639
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'feb' 6.2
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'mrz' 2.66
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'apr' 11.06
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'mai' 1.77
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'jun' 4.93
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'aug' 17.03
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'sep' 14.17
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'okt' 15.03
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'nSum' 138
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'pSum' 65.6
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'minNAmount' 252
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'minPAmount' 97
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'autumnFertm3' 0
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'grossMarginHa' 597
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'efaFactor' 0
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'fixCosts' 459.39
 'cc74cf23-840a-4016-a5b6-144b4d228489'.'Winterweizen - Brotweizen'.'20'.'0'.'0.2'.'false'.'false'.'grossMarginNoCropEff' 651
 'dc298ebb-1b27-411a-8024-af0623f621c5'.'Mais - Silomais'.'25'.'0'.'0.2'.'true'.'false'.'feb' 2.12
 'dc298ebb-1b27-411a-8024-af0623f621c5'.'Mais - Silomais'.'25'.'0'.'0.2'.'true'.'false'.'mrz' 2.75
 'dc298ebb-1b27-411a-8024-af0623f621c5'.'Mais - Silomais'.'25'.'0'.'0.2'.'true'.'false'.'apr' 11.05
 'dc298ebb-1b27-411a-8024-af0623f621c5'.'Mais - Silomais'.'25'.'0'.'0.2'.'true'.'false'.'mai' 3.79
 'dc298ebb-1b27-411a-8024-af0623f621c5'.'Mais - Silomais'.'25'.'0'.'0.2'.'true'.'false'.'sep' 24.02
 'dc298ebb-1b27-411a-8024-af0623f621c5'.'Mais - Silomais'.'25'.'0'.'0.2'.'true'.'false'.'okt' 7.52
 'dc298ebb-1b27-411a-8024-af0623f621c5'.'Mais - Silomais'.'25'.'0'.'0.2'.'true'.'false'.'nSum' 89
 'dc298ebb-1b27-411a-8024-af0623f621c5'.'Mais - Silomais'.'25'.'0'.'0.2'.'true'.'false'.'pSum' 70.56
 'dc298ebb-1b27-411a-8024-af0623f621c5'.'Mais - Silomais'.'25'.'0'.'0.2'.'true'.'false'.'minNAmount' 5
 'dc298ebb-1b27-411a-8024-af0623f621c5'.'Mais - Silomais'.'25'.'0'.'0.2'.'true'.'false'.'minPAmount' 26
 'dc298ebb-1b27-411a-8024-af0623f621c5'.'Mais - Silomais'.'25'.'0'.'0.2'.'true'.'false'.'autumnFertm3' 0
 'dc298ebb-1b27-411a-8024-af0623f621c5'.'Mais - Silomais'.'25'.'0'.'0.2'.'true'.'false'.'grossMarginHa' 540
 'dc298ebb-1b27-411a-8024-af0623f621c5'.'Mais - Silomais'.'25'.'0'.'0.2'.'true'.'false'.'efaFactor' 1
 'dc298ebb-1b27-411a-8024-af0623f621c5'.'Mais - Silomais'.'25'.'0'.'0.2'.'true'.'false'.'fixCosts' 570.77
 'dc298ebb-1b27-411a-8024-af0623f621c5'.'Mais - Silomais'.'25'.'0'.'0.2'.'true'.'false'.'grossMarginNoCropEff' 380
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'feb' 8.55
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'mrz' 15.64
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'apr' 2.73
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'mai' 4.91
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'jul' 1.02
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'aug' 4.02
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'sep' 11.65
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'okt' 16.98
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'nSum' 124
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'pSum' 68.7
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'minNAmount' 135
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'minPAmount' 10
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'autumnFertm3' 0
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'grossMarginHa' 876
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'efaFactor' 0
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'fixCosts' 379.88
 '119f0d98-ec65-4752-802f-3cb0ca4d205f'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'grossMarginNoCropEff' 693
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'feb' 3.74
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'mrz' 10.42
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'apr' 1.18
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'mai' 3.79
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'jul' 0.6
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'aug' 3.34
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'sep' 6.38
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'okt' 10.25
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'nSum' 124
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'pSum' 68.7
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'minNAmount' 135
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'minPAmount' 10
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'autumnFertm3' 0
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'grossMarginHa' 854
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'efaFactor' 0
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'fixCosts' 414.3
 'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'grossMarginNoCropEff' 671
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'.'Mais - Silomais'.'20'.'0'.'0'.'true'.'true'.'feb' 2.71
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'.'Mais - Silomais'.'20'.'0'.'0'.'true'.'true'.'mrz' 3.76
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'.'Mais - Silomais'.'20'.'0'.'0'.'true'.'true'.'apr' 15.88
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'.'Mais - Silomais'.'20'.'0'.'0'.'true'.'true'.'mai' 5.39
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'.'Mais - Silomais'.'20'.'0'.'0'.'true'.'true'.'sep' 37.32
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'.'Mais - Silomais'.'20'.'0'.'0'.'true'.'true'.'okt' 10.02
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'.'Mais - Silomais'.'20'.'0'.'0'.'true'.'true'.'nSum' 73
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'.'Mais - Silomais'.'20'.'0'.'0'.'true'.'true'.'pSum' 70.56
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'.'Mais - Silomais'.'20'.'0'.'0'.'true'.'true'.'minNAmount' 11
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'.'Mais - Silomais'.'20'.'0'.'0'.'true'.'true'.'minPAmount' 138
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'.'Mais - Silomais'.'20'.'0'.'0'.'true'.'true'.'autumnFertm3' 17.123287671232877
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'.'Mais - Silomais'.'20'.'0'.'0'.'true'.'true'.'grossMarginHa' 464
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'.'Mais - Silomais'.'20'.'0'.'0'.'true'.'true'.'efaFactor' 1
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'.'Mais - Silomais'.'20'.'0'.'0'.'true'.'true'.'fixCosts' 573.04
 '9dc87df6-5113-40c7-9d16-b27f2485faaa'.'Mais - Silomais'.'20'.'0'.'0'.'true'.'true'.'grossMarginNoCropEff' 285
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'feb' 3.57
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'mrz' 1.56
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'apr' 7.75
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'mai' 1.08
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'jun' 3.54
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'aug' 10.59
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'sep' 8.71
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'okt' 10.33
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'nSum' 184
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'pSum' 65.6
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'minNAmount' 422
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'minPAmount' 97
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'autumnFertm3' 0
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'grossMarginHa' 581
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'efaFactor' 0
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'fixCosts' 485.98
 '027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'grossMarginNoCropEff' 581
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'feb' 2
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'mrz' 0.91
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'apr' 4.65
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'mai' 0.64
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'jun' 2.12
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'aug' 5.91
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'sep' 4.83
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'okt' 6.07
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'nSum' 184
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'pSum' 65.6
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'minNAmount' 422
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'minPAmount' 97
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'autumnFertm3' 0
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'grossMarginHa' 561
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'efaFactor' 0
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'fixCosts' 505.44
 '2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'grossMarginNoCropEff' 561
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'feb' 2.07
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'mrz' 0.94
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'apr' 4.81
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'mai' 0.65
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'jun' 2.19
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'aug' 6.07
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'sep' 4.95
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'okt' 6.25
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'nSum' 204
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'pSum' 65.6
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'minNAmount' 496
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'minPAmount' 97
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'autumnFertm3' 0
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'grossMarginHa' 542
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'efaFactor' 0
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'fixCosts' 506.25
 'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'grossMarginNoCropEff' 542
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'feb' 7.06
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'mrz' 2.98
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'apr' 12.88
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'mai' 1.91
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'jun' 5.7
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'aug' 17.82
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'sep' 14.67
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'okt' 16.6
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'nSum' 194
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'pSum' 65.6
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'minNAmount' 459
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'minPAmount' 97
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'autumnFertm3' 0
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'grossMarginHa' 578
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'efaFactor' 0
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'fixCosts' 471.12
 'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'grossMarginNoCropEff' 578
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'feb' 6.19
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'mrz' 13.64
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'apr' 1.98
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'mai' 4.64
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'jul' 0.83
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'aug' 3.95
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'sep' 9.15
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'okt' 13.99
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'nSum' 124
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'pSum' 68.7
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'minNAmount' 135
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'minPAmount' 10
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'autumnFertm3' 0
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'grossMarginHa' 867
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'efaFactor' 0
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'fixCosts' 396.86
 '558f9729-9f85-4837-ad21-033762c4ba5d'.'Zuckerrüben'.'25'.'0'.'0'.'false'.'false'.'grossMarginNoCropEff' 683
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'feb' 1.52
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'mrz' 0.71
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'apr' 3.53
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'mai' 0.49
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'jun' 1.59
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'aug' 4.28
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'sep' 3.49
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'okt' 4.5
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'nSum' 204
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'pSum' 65.6
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'minNAmount' 496
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'minPAmount' 97
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'autumnFertm3' 0
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'grossMarginHa' 533
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'efaFactor' 0
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'fixCosts' 515.73
 'af3d2471-1e40-4c82-b332-0147a237b3dd'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'grossMarginNoCropEff' 533
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'feb' 2.86
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'mrz' 1.26
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'apr' 6.53
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'mai' 0.86
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'jun' 2.98
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'aug' 8.29
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'sep' 6.76
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'okt' 8.49
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'nSum' 204
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'pSum' 65.6
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'minNAmount' 496
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'minPAmount' 97
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'autumnFertm3' 0
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'grossMarginHa' 542
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'efaFactor' 0
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'fixCosts' 501.05
 '5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'Winterweizen - Brotweizen'.'20'.'0'.'0'.'false'.'false'.'grossMarginNoCropEff' 542
/;

parameter p_laborReq(curCrops,months) /

/;

set man_attr /
amount
n
p
k
minUsagePercent
/;

parameter p_manure(man_attr) /
  "amount" 3000
  "n" 7.3
  "p" 2.7
  "k" 3.7
  "minUsagePercent" 60
/;

parameter p_solid(man_attr) /

/;

