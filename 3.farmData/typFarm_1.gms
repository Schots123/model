
set plotAttr /size, distance, soilQual, soilType/;

set cropAttr /maxShare /;

set curCrops(KTBL_crops) /
'Mais - Silomais'
'Staerkekartoffeln'
'Winterweizen - Backweizen'
'Wintergerste - Futtergerste'
'Brache'
/;

parameter p_cropData(curCrops,cropAttr)  /
'Mais - Silomais'.maxShare 50
'Staerkekartoffeln'.maxShare 20
'Winterweizen - Backweizen'.maxShare 33.33
'Wintergerste - Futtergerste'.maxShare 33.33
/;

set curPlots /
'027a3aaa-a6a4-4cd1-872a-a9efdef39369'
'119f0d98-ec65-4752-802f-3cb0ca4d205f'
'2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'
'2d64e2d8-1909-4abf-9c42-71041141645a'
'2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'
'558f9729-9f85-4837-ad21-033762c4ba5d'
'5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'
'62ffe0b8-d621-436b-a76a-1f44235178e0'
'9dc87df6-5113-40c7-9d16-b27f2485faaa'
'9f7e7bdf-919e-450c-ab20-1998696397a3'
'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'
'aa5973e8-2392-4ca2-a485-7d8e834ded31'
'af3d2471-1e40-4c82-b332-0147a237b3dd'
'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'
'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'
'c3ab0ff2-328b-4f60-8520-a7d2b3607133'
$ontext
'9ce07e77-2a1c-484d-8e74-678cd1d30f5f'
'cc74cf23-840a-4016-a5b6-144b4d228489'
'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'
'dc298ebb-1b27-411a-8024-af0623f621c5'
$offtext
/;

set plots_permPast(curPlots) /
/;

acronyms 
    Lehm, schluffigTonigerLehm, Ton, tonigerLehm, 
    lehmigerSand, lehmigerSchluff, sandigerLehm, schluffigerLehm,
    sandigerSchluff, Sand, starkSandigerLehm;

parameter p_plotData(curPlots,plotAttr) /
'027a3aaa-a6a4-4cd1-872a-a9efdef39369'.size 4.8
'027a3aaa-a6a4-4cd1-872a-a9efdef39369'.distance 0.24
'027a3aaa-a6a4-4cd1-872a-a9efdef39369'.soilQual 45   
'027a3aaa-a6a4-4cd1-872a-a9efdef39369'.soilType schluffigerLehm
'119f0d98-ec65-4752-802f-3cb0ca4d205f'.size 2.63
'119f0d98-ec65-4752-802f-3cb0ca4d205f'.distance 0.26
'119f0d98-ec65-4752-802f-3cb0ca4d205f'.soilQual 45
'119f0d98-ec65-4752-802f-3cb0ca4d205f'.soilType schluffigerLehm
'2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.size 1
'2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.distance 0.13
'2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.soilQual 45
'2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.soilType schluffigerLehm
'2d64e2d8-1909-4abf-9c42-71041141645a'.size 6.24
'2d64e2d8-1909-4abf-9c42-71041141645a'.distance 1
'2d64e2d8-1909-4abf-9c42-71041141645a'.soilQual 45
'2d64e2d8-1909-4abf-9c42-71041141645a'.soilType schluffigerLehm
'2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.size 2
'2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.distance 0.12
'2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.soilQual 45
'2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.soilType schluffigerLehm
'558f9729-9f85-4837-ad21-033762c4ba5d'.size 0.65
'558f9729-9f85-4837-ad21-033762c4ba5d'.distance 0.12
'558f9729-9f85-4837-ad21-033762c4ba5d'.soilQual 45
'558f9729-9f85-4837-ad21-033762c4ba5d'.soilType schluffigerLehm
'5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.size 0.88
'5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.distance 0.06
'5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.soilQual 45
'5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.soilType schluffigerLehm
'62ffe0b8-d621-436b-a76a-1f44235178e0'.size 5.8
'62ffe0b8-d621-436b-a76a-1f44235178e0'.distance 0.3
'62ffe0b8-d621-436b-a76a-1f44235178e0'.soilQual 45
'62ffe0b8-d621-436b-a76a-1f44235178e0'.soilType schluffigerLehm
'9dc87df6-5113-40c7-9d16-b27f2485faaa'.size 10.31
'9dc87df6-5113-40c7-9d16-b27f2485faaa'.distance 1.11
'9dc87df6-5113-40c7-9d16-b27f2485faaa'.soilQual 62.5
'9dc87df6-5113-40c7-9d16-b27f2485faaa'.soilType sandigerLehm
'9f7e7bdf-919e-450c-ab20-1998696397a3'.size 3.42
'9f7e7bdf-919e-450c-ab20-1998696397a3'.distance 0.53
'9f7e7bdf-919e-450c-ab20-1998696397a3'.soilQual 45
'9f7e7bdf-919e-450c-ab20-1998696397a3'.soilType schluffigerLehm
'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.size 0.64
'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.distance 0.67
'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.soilQual 45
'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.soilType schluffigerLehm
'aa5973e8-2392-4ca2-a485-7d8e834ded31'.size 7
'aa5973e8-2392-4ca2-a485-7d8e834ded31'.distance 0.89
'aa5973e8-2392-4ca2-a485-7d8e834ded31'.soilQual 45
'aa5973e8-2392-4ca2-a485-7d8e834ded31'.soilType schluffigerLehm
'af3d2471-1e40-4c82-b332-0147a237b3dd'.size 12.5
'af3d2471-1e40-4c82-b332-0147a237b3dd'.distance 1.78
'af3d2471-1e40-4c82-b332-0147a237b3dd'.soilQual 45
'af3d2471-1e40-4c82-b332-0147a237b3dd'.soilType schluffigerLehm
'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.size 2.6
'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.distance 1.2
'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.soilQual 45
'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.soilType sandigerLehm
'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.size 0.62
'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.distance 1.3
'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.soilQual 45
'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.soilType sandigerLehm
'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.size 0.0552
'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.distance 1.34
'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.soilQual 45
'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.soilType sandigerLehm
$ontext
'9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.size 5.87
'9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.distance 0.3
'9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.soilQual 45
'9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.soilType 'schluffiger Lehm'
'cc74cf23-840a-4016-a5b6-144b4d228489'.size 6.38
'cc74cf23-840a-4016-a5b6-144b4d228489'.distance 1.9
'cc74cf23-840a-4016-a5b6-144b4d228489'.soilQual
'cc74cf23-840a-4016-a5b6-144b4d228489'.soilType
'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.size 9.02
'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.distance 1.2
'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.soilQual
'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.soilType
'dc298ebb-1b27-411a-8024-af0623f621c5'.size 3.57
'dc298ebb-1b27-411a-8024-af0623f621c5'.distance 1.4
'dc298ebb-1b27-411a-8024-af0623f621c5'.soilQual
'dc298ebb-1b27-411a-8024-af0623f621c5'.soilType
$offtext
/;

set curMechan(KTBL_mechanisation) / '102' /;

*alias (cropGroup,cropGroup1);

*
*  --- The following declarations are already important for the farm individual KTBL data calculations stored 
*       in ktblResults_%farmNumber%.gdx

parameter p_manure(man_attr) /
"Amount" 3000
"N" 7.3
"P2O5" 2.7
"K2O" 3.7
"minUsagePercent" 60
/;

p_nutrientSupplyFert('Manure, Farm',"N") = p_manure("N") * (p_manure("minUsagePercent")/100);
p_nutrientSupplyFert('Manure, Farm',"P2O5") = p_manure("P2O5") * (p_manure("minUsagePercent")/100);
p_nutrientSupplyFert('Manure, Farm',"K2O") = p_manure("K2O") * (p_manure("minUsagePercent")/100);

scalar p_newFuelPrice price for fuel in euro per liter /1/;

scalar labPrice price for labour in euro per hour /21/;