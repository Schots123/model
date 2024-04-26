






set plotAttr /size, distance, soil/;
set cropAttr /maxShare /;


set curCrops(KTBL_crops) /
'Mais - Silomais'
'Staerkekartoffeln'
'Winterweizen - Backweizen'
'Wintergerste - Futtergerste'
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

set plots_permPast(curPlots) /
/;

parameter p_plotData(curPlots,plotAttr) /
'027a3aaa-a6a4-4cd1-872a-a9efdef39369'.size 3.64
'027a3aaa-a6a4-4cd1-872a-a9efdef39369'.distance 1.4
*'027a3aaa-a6a4-4cd1-872a-a9efdef39369'.soil 
'119f0d98-ec65-4752-802f-3cb0ca4d205f'.size 8.62
'119f0d98-ec65-4752-802f-3cb0ca4d205f'.distance 6.3
*'119f0d98-ec65-4752-802f-3cb0ca4d205f'.soil
'2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.size 1.93
'2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.distance 2.6
*'2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.soil
'2d64e2d8-1909-4abf-9c42-71041141645a'.size 3.31
'2d64e2d8-1909-4abf-9c42-71041141645a'.distance 3.4
*'2d64e2d8-1909-4abf-9c42-71041141645a'.soil
'2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.size 4.76
'2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.distance 1.8
*'2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.soil
'558f9729-9f85-4837-ad21-033762c4ba5d'.size 6.46
'558f9729-9f85-4837-ad21-033762c4ba5d'.distance 0.5
*'558f9729-9f85-4837-ad21-033762c4ba5d'.soil
'5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.size 2.74
'5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.distance 0.9
*'5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.soil
'62ffe0b8-d621-436b-a76a-1f44235178e0'.size 7.81
'62ffe0b8-d621-436b-a76a-1f44235178e0'.distance 1.3
*'62ffe0b8-d621-436b-a76a-1f44235178e0'.soil
'9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.size 5.87
'9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.distance 9.4
*'9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.soil
'9dc87df6-5113-40c7-9d16-b27f2485faaa'.size 4.72
'9dc87df6-5113-40c7-9d16-b27f2485faaa'.distance 12.5
*'9dc87df6-5113-40c7-9d16-b27f2485faaa'.soil
'9f7e7bdf-919e-450c-ab20-1998696397a3'.size 2.34
'9f7e7bdf-919e-450c-ab20-1998696397a3'.distance 5.2
*'9f7e7bdf-919e-450c-ab20-1998696397a3'.soil
'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.size 1.98
'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.distance 2.7
*'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.soil
'aa5973e8-2392-4ca2-a485-7d8e834ded31'.size 4.28
'aa5973e8-2392-4ca2-a485-7d8e834ded31'.distance 1.9
*'aa5973e8-2392-4ca2-a485-7d8e834ded31'.soil
'af3d2471-1e40-4c82-b332-0147a237b3dd'.size 1.37
'af3d2471-1e40-4c82-b332-0147a237b3dd'.distance 1.2
*'af3d2471-1e40-4c82-b332-0147a237b3dd'.soil
'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.size 4.17
'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.distance 0.4
*'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.soil
'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.size 6.49
'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.distance 0.2
*'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.soil
'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.size 8.95
'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.distance 0.1
*'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.soil
'cc74cf23-840a-4016-a5b6-144b4d228489'.size 6.38
'cc74cf23-840a-4016-a5b6-144b4d228489'.distance 1.9
*'cc74cf23-840a-4016-a5b6-144b4d228489'.soil
'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.size 9.02
'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.distance 1.2
*'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.soil
'dc298ebb-1b27-411a-8024-af0623f621c5'.size 3.57
'dc298ebb-1b27-411a-8024-af0623f621c5'.distance 1.4
*'dc298ebb-1b27-411a-8024-af0623f621c5'.soil
/;

set curPlots_ktblYield (curPlots,KTBL_yield) /
'027a3aaa-a6a4-4cd1-872a-a9efdef39369'.'hoch, mittlerer Boden' YES
'119f0d98-ec65-4752-802f-3cb0ca4d205f'.'hoch, leichter Boden' YES
'2bf8c74f-0fd1-4b51-bb5e-4a8bf6a7eac8'.'niedrig, mittlerer Boden' YES
'2d64e2d8-1909-4abf-9c42-71041141645a'.'hoch, mittlerer Boden' YES
'2e6ab89a-ddf1-40a6-8c02-14d0bd7e93c8'.'mittel, mittlerer Boden' YES
'558f9729-9f85-4837-ad21-033762c4ba5d'.'mittel, mittlerer Boden' YES
'5d9c7dc1-513c-4d3b-bc72-83b9e25ace52'.'niedrig, mittlerer Boden' YES
'62ffe0b8-d621-436b-a76a-1f44235178e0'.'mittel, mittlerer Boden' YES
'9ce07e77-2a1c-484d-8e74-678cd1d30f5f'.'mittel, mittlerer Boden' YES
'9dc87df6-5113-40c7-9d16-b27f2485faaa'.'mittel, mittlerer Boden' YES
'9f7e7bdf-919e-450c-ab20-1998696397a3'.'niedrig, mittlerer Boden' YES
'a9d0ecf3-e61c-486c-90b3-bb1baab35b4d'.'hoch, mittlerer Boden' YES
'aa5973e8-2392-4ca2-a485-7d8e834ded31'.'mittel, mittlerer Boden' YES
'af3d2471-1e40-4c82-b332-0147a237b3dd'.'mittel, mittlerer Boden' YES
'b54a00ad-8fe1-4d1d-8c8c-fbab6a371204'.'niedrig, mittlerer Boden' YES 
'bc06dfd4-8f54-4b13-a796-2e634cabdc9d'.'niedrig, mittlerer Boden' YES
'c3ab0ff2-328b-4f60-8520-a7d2b3607133'.'hoch, mittlerer Boden' YES
'cc74cf23-840a-4016-a5b6-144b4d228489'.'hoch, leichter Boden' YES
'ce0201fd-3cd5-4c6f-8755-5a6a0ebd9556'.'mittel, mittlerer Boden' YES
'dc298ebb-1b27-411a-8024-af0623f621c5'.'mittel, mittlerer Boden' YES
/;

set curMechan(KTBL_mechanisation) / '102' /;