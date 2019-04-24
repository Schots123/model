module.exports = "*-------------------------------\n* Fruchtfolge\n*\n* A spatial crop rotation model\n* serving as a base for the\n* Fruchtfolge web application\n* (c) Christoph Pahmeyer, 2019\n*-------------------------------\n*\n*  --- initiate global parameters for Greening evaluation\n*\nscalar  p_totLand;\nscalar  p_totArabLand;\nscalar  p_totGreenLand;\np_totLand = sum(curPlots, p_plotData(curPlots,\"size\"));\np_totArabLand = sum(curPlots $ (not plots_permPast(curPlots)), p_plotData(curPlots,\"size\"));\np_totGreenLand = p_totLand - p_totArabLand;\nalias (cropGroup,cropGroup1);\nalias (curCrops,curCrops1);\nscalar M / 99999 /;\n*\n*  --- declare objective variable and equation\n*\nVariables\n  v_obje\n  v_totGM\n;\nPositive Variables\n  v_devShares(curCrops)\n  v_devEfa5\n  v_devEfa75\n  v_devEfa95\n$iftheni.constraints defined constraints\n  v_devUserShares(constraints,curCrops,curCrops)\n$endif.constraints\n  v_devOneCrop(curPlots)\n$iftheni.labour defined p_availLabour\n  v_devLabour(months)\n$endif.labour\n;\nBinary Variables\n  v_binCropPlot(curCrops,curPlots)\n  v_binCatchCrop(curCrops,curPlots)\n;\nEquations\n  e_obje\n  e_totGM\n;\n*\n*  --- include model\n*\nEquations\r\n    e_oneCatchCropPlot(curPlots)\r\n    e_catchCropEqBinCrop(curCrops,curPlots)\r\n;\r\n\r\n*\r\n*  --- ensure that only one catch crop is grown on a plot\r\n*\r\ne_oneCatchCropPlot(curPlots)..\r\n  sum(curCrops, v_binCatchCrop(curCrops,curPlots))\r\n  =L= 1\r\n;\r\n\r\n*\r\n*  --- ensure that catch crop option matches actually grown crop\r\n*\r\ne_catchCropEqBinCrop(curCrops,curPlots)..\r\n  v_binCatchCrop(curCrops,curPlots) =L= v_binCropPlot(curCrops,curPlots)\r\n;\r\n*\r\n* --- Only allow growing of catch crops if the succeeding crop is a summer\r\n*     sown crop. This way, Greening compatible catch crops should\r\n*     be ensured\r\n*\r\nv_binCatchCrop.up(curCrops,curPlots) = 0;\r\n\r\nv_binCatchCrop.up(curCrops,curPlots)\r\n  $ crops_summer(curCrops) = 1;\r\n\r\n* Also, forbid growing of catch crops if the previously grown crop\r\n* is harvested too late (e.g. not after sugar beets or maize)\r\nv_binCatchCrop.up(curCrops,curPlots)\r\n  $ sum((curCrops1,years,curYear)\r\n    $ (sameas(years,curYear)\r\n    $ sum(cropGroup\r\n      $ (crops_cropGroup(curCrops1,cropGroup)\r\n      $ plots_years_cropGroup(curPlots,years - 1,cropGroup)),1)\r\n    $ (not crops_catchCrop(curCrops1))\r\n    ),1) = 0;\r\n\r\n*\r\n* --- Disallow catch crops to be grown on permanent pastures\r\n*\r\nv_binCatchCrop.up(curCrops,curPlots) $ plots_permPast(curPlots) = 0;\r\n\r\n*\r\n* --- Calculate costs of growing a catch crop on a plot\r\n*     Source: Own regression made from KTBL - Leistungs- Kostenrechner data\r\n*             Based on crop \"Zwischenfrucht Senf\"\r\n*\r\nParameter p_costCatchCrop(curPlots);\r\np_costCatchCrop(curPlots) =\r\n    0.2850553506 * p_plotData(curPlots,'distance')\r\n  - 0.6666666667 * p_plotData(curPlots,'size')\r\n  + 113\r\n;\r\n\r\n*\r\n*  --- Source: Own regression made from KTBL - Verfahrensrechner Pflanze data\r\n*              Based on crop \"Zwischenfrucht Senf\"\r\n*\r\nset catchCropMonths(halfMonths) /'AUG2','SEP1','SEP2','FEB2'/;\r\nParameter p_timeReqCatchCrop(curPlots,halfMonths);\r\n\r\np_timeReqCatchCrop(curPlots,catchCropMonths)\r\n  = (0.04827586207 * p_plotData(curPlots,'distance')\r\n  - 0.1 * p_plotData(curPlots,'size')\r\n  + 4.191724138)\r\n  / card(catchCropMonths)\r\n;\r\nEquations\r\n  e_maxShares(curCrops)\r\n  e_oneCropPlot(curPlots)\r\n$iftheni.constraints defined constraints\r\n  e_minimumShares(constraints,curCrops,curCrops1)\r\n  e_maximumShares(constraints,curCrops,curCrops1) \r\n$endif.constraints\r\n;\r\n\r\n*\r\n*  --- each crop cannot exceed the maximum allowed share specified by the users\r\n*      crop rotational settings\r\n*\r\ne_maxShares(curCrops) $ p_cropData(curCrops,\"maxShare\")..\r\n  sum(curPlots, \r\n    v_binCropPlot(curCrops,curPlots)\r\n    * p_plotData(curPlots,\"size\")\r\n  )\r\n  =L= \r\n    (p_totArabLand * p_cropData(curCrops,\"maxShare\") / 100)\r\n    + v_devShares(curCrops)\r\n;\r\n\r\n*\r\n*  --- ensure that only one crop is grown on a plot\r\n*\r\ne_oneCropPlot(curPlots)..\r\n  sum(curCrops, v_binCropPlot(curCrops,curPlots))\r\n  + v_devOneCrop(curPlots)\r\n  =E= 1\r\n;\r\n\r\n*\r\n*  --- prohibit growing a crop on a plot when there is no gross margin present\r\n*\r\nv_binCropPlot.up(curCrops,curPlots) $ (not p_grossMarginData(curPlots,curCrops)) = 0;\r\n\r\n*\r\n*  --- root crops can obly be grown on root crop capable plots\r\n*\r\nv_binCropPlot.up(curCrops,curPlots) \r\n  $ (crops_rootCrop(curCrops) \r\n  $ (not plots_rootCropCap(curPlots))) = 0;\r\n\r\n*\r\n*  --- when a cropping factor of 0 is given for a previous crop - crop combination\r\n*      the crop can't be grown\r\n*  \r\nv_binCropPlot.up(curCrops,curPlots)\r\n  $ sum((years,curYear,curCrops1) \r\n  $ ((not sameas(curCrops1,'')) \r\n  $ sameas(years,curYear)\r\n  $ sum((cropGroup) $ (crops_cropGroup(curCrops,cropGroup) \r\n    $ plots_years_cropGroup(curPlots,years - 1,cropGroup)), 1)\r\n  $ (not p_croppingFactor(curCrops1,curCrops))),1) = 0;\r\n\r\n*\r\n*  --- when a plot is permanent pasture, it has to be used in the same way as in the previous year\r\n*\r\nv_binCropPlot.lo(curCrops,curPlots)\r\n  $ (plots_permPast(curPlots)\r\n  $ sum((years,curYear) \r\n     $ (sameas(years,curYear) \r\n     $ sum((cropGroup) \r\n      $ (crops_cropGroup(curCrops,cropGroup) \r\n      $ plots_years_cropGroup(curPlots,years - 1,cropGroup)),\r\n      1)),\r\n    1)) \r\n  = 1;\r\n*\r\n*  --- allow permanent pasture crops only on permanent pastures\r\n*  \r\nv_binCropPlot.up(curCrops,curPlots)\r\n  $ ((not plots_permPast(curPlots))\r\n  $ (sum(permPastCrops $ sameas(curCrops,permPastCrops),1)))\r\n  = 0;\r\n*\r\n*  --- Enter user specified constraints into the model, \r\n*\r\n$iftheni.constraints defined constraints\r\ne_minimumShares(constraints,curCrops,curCrops1) \r\n       $ (p_constraint(constraints,curCrops,curCrops1) \r\n       $ (not (constraints_lt(constraints,'lt'))))..\r\n  sum(curPlots, v_binCropPlot(curCrops,curPlots) * p_plotData(curPlots,'size') + \r\n    v_binCropPlot(curCrops1,curPlots) * p_plotData(curPlots,'size'))\r\n    + v_devUserShares(constraints,curCrops,curCrops1)\r\n    =G= p_constraint(constraints,curCrops,curCrops1) \r\n;  \r\n\r\ne_maximumShares(constraints,curCrops,curCrops1) \r\n       $ (p_constraint(constraints,curCrops,curCrops1) \r\n       $ (constraints_lt(constraints,'lt')))..\r\n  sum(curPlots, v_binCropPlot(curCrops,curPlots) * p_plotData(curPlots,'size') + \r\n    v_binCropPlot(curCrops1,curPlots) * p_plotData(curPlots,'size'))\r\n    =L= \r\n    p_constraint(constraints,curCrops,curCrops1)\r\n    + v_devUserShares(constraints,curCrops,curCrops1)\r\n;  \r\n$endif.constraints\r\nEquations\r\n  e_efa\r\n  e_75diversification(cropGroup)\r\n  e_95diversification(cropGroup,cropGroup1)\r\n;\r\n\r\n* Only activate ecological focus area equation if arable land is greater than 15ha\r\ne_efa $ (p_totArabLand >= 15)..\r\n  sum((curPlots,curCrops),\r\n      v_binCropPlot(curCrops,curPlots)\r\n      * p_plotData(curPlots,\"size\")\r\n      * p_cropData(curCrops,\"efaFactor\")\r\n      + v_binCatchCrop(curCrops,curPlots)\r\n      * p_plotData(curPlots,\"size\")\r\n  )\r\n  + v_devEfa5\r\n  =G= \r\n  p_totArabLand * 0.05\r\n;\r\n\r\n\r\n* Only activate 75% diversifaction rule if arable land is greater than 10ha\r\ne_75diversification(cropGroup) $ (p_totArabLand >= 10)..\r\n  sum((curPlots,curCrops) $ crops_cropGroup(curCrops,cropGroup),\r\n      v_binCropPlot(curCrops,curPlots)\r\n      * p_plotData(curPlots,\"size\")\r\n  )\r\n  =L= \r\n  p_totArabLand * 0.75\r\n  + v_devEfa75\r\n  \r\n;\r\n\r\n* Only activate 95% diversifaction rule if arable land is greater than 30ha\r\ne_95diversification(cropGroup,cropGroup1)\r\n  $ ((p_totArabLand >= 30)\r\n  $ (not sameas(cropGroup,cropGroup1)))..\r\n  sum((curPlots,curCrops) $ crops_cropGroup(curCrops,cropGroup),\r\n    v_binCropPlot(curCrops,curPlots)\r\n    * p_plotData(curPlots,\"size\")\r\n  )\r\n  +\r\n  sum((curPlots,curCrops) $ crops_cropGroup(curCrops,cropGroup1),\r\n    v_binCropPlot(curCrops,curPlots)\r\n    * p_plotData(curPlots,\"size\")\r\n  )\r\n  =L= \r\n  p_totArabLand * 0.95\r\n  + v_devEfa95\r\n;\r\n*\r\n*  --- Only account for labour constraints when parameter is defined\r\n*\r\n$iftheni.labour defined p_availLabour\r\nEquations\r\n  e_maxLabour(months)\r\n*  e_maxFieldWorkDays(months)\r\n;\r\n\r\ne_maxLabour(months)..\r\n  sum((curPlots,curCrops,halfMonths) $ months_halfMonths(months,halfMonths),\r\n  v_binCropPlot(curCrops,curPlots) * p_plotData(curPlots,'size')\r\n  * p_laborReq(curCrops,halfMonths)\r\n  + v_binCatchCrop(curCrops,curPlots) * p_plotData(curPlots,'size')\r\n  * p_timeReqCatchCrop(curPlots,halfMonths)\r\n  )\r\n  =L= \r\n  p_availLabour(months)\r\n  + v_devLabour(months)\r\n;\r\n\r\n*\r\n*  --- we assume a maximum of 14h of work per day\r\n*\r\n$ontext\r\ne_maxFieldWorkDays(months)..\r\n  sum((curPlots,curCrops,halfMonths) $ months_halfMonths(months,halfMonths),\r\n  v_binCropPlot(curCrops,curPlots)\r\n  * p_tractorReq(crops,halfMonths)\r\n  =L= p_availFieldWorkDays(months) * p_availTractHours(month)\r\n;\r\n$offtext\r\n\r\n$endif.labour\r\n*\n*  --- calculate overall gross margin for the planning year\n*\ne_totGM..\n  v_totGM =E=\n    sum((curPlots,curCrops),\n    v_binCropPlot(curCrops,curPlots)\n    * p_grossMarginData(curPlots,curCrops)\n    - v_binCatchCrop(curCrops,curPlots)\n    * p_plotData(curPlots,'size')\n    * p_costCatchCrop(curPlots));\ne_obje..\n  v_obje =E=\n    v_totGM\n    - sum(curCrops, v_devShares(curCrops) * M)\n    - (v_devEfa5 * M)\n    - (v_devEfa75 * M)\n    - (v_devEfa95 * M)\n    - sum(curPlots, v_devOneCrop(curPlots) * M * 10)\n$iftheni.constraints defined constraints\n    - sum((constraints,curCrops,curCrops1),\n      v_devUserShares(constraints,curCrops,curCrops1) * M)\n$endif.constraints\n$iftheni.labour defined p_availLabour\n    - sum(months, v_devLabour(months) * 1000)\n$endif.labour\n;\n*\n*  --- define upper bounds for slack variables\n*\nv_devShares.up(curCrops) = p_totArabLand;\nv_devEfa5.up = p_totArabLand * 0.05;\nv_devEfa75.up = p_totArabLand * 0.25;\nv_devEfa95.up = p_totArabLand;\nv_devOneCrop.up(curPlots) = 1;\n$iftheni.constraints defined constraints\n  v_devUserShares.up(constraints,curCrops,curCrops1) = p_totArabLand;\n$endif.constraints\n$iftheni.labour defined p_availLabour\n  v_devLabour.up(months) = 15000;\n$endif.labour\noption optCR=0;\nmodel Fruchtfolge /\n  e_obje\n  e_totGM\n  e_oneCatchCropPlot\n  e_catchCropEqBinCrop\n  e_maxShares\n  e_oneCropPlot\n$iftheni.constraints defined constraints\n  e_minimumShares\n  e_maximumShares\n$endif.constraints\n  e_efa\n  e_75diversification\n  e_95diversification\n$iftheni.labour defined p_availLabour\n  e_maxLabour\n$endif.labour\n/;\n*Fruchtfolge.limrow = 1000;\n*Fruchtfolge.limcol = 1000;\nsolve Fruchtfolge using MIP maximizing v_obje;\nset fullMonths /\r\n  'Januar'\r\n  'Februar'\r\n  'März'\r\n  'April'\r\n  'Mai'\r\n  'Juni'\r\n  'Juli'\r\n  'August'\r\n  'September'\r\n  'Oktober'\r\n  'November'\r\n  'Dezember'\r\n/;\r\nscalar \r\n  warningsCount\r\n  curWarning\r\n;\r\nwarningsCount = sum(curCrops $ v_devShares.l(curCrops), 1)\r\n                 + 1 $ v_devEfa5.l \r\n                 + 1 $ v_devEfa75.l \r\n                 + 1 $ v_devEfa95.l\r\n                 + sum(curPlots $ v_devOneCrop.l(curPlots), 1)\r\n                 $$iftheni.constraints defined constraints\r\n                   + sum((constraints,curCrops,curCrops1) $ v_devUserShares.l(constraints,curCrops,curCrops1), 1)\r\n                 $$endif.constraints\r\n                 $$iftheni.labour defined p_availLabour\r\n                   + sum(months $ v_devLabour.l(months), 1)\r\n                 $$endif.labour\r\n;\r\ncurWarning = 0;\r\n\r\ndisplay warningsCount,curWarning;\r\nFile results / \"%random%\" /;\r\nresults.lw = 0;\r\nput results;\r\nput \"{\"\r\nput '\"model_status\":',  Fruchtfolge.modelstat, \",\" /;\r\nput '\"solver_status\":', Fruchtfolge.solvestat, \",\" /;\r\n\r\nif ( (Fruchtfolge.modelstat ne 1),\r\n    put '\"error_message\": \"Infeasible model.\"' /;\r\n  ELSE\r\n    put '\"objective\":', v_totGM.l, \",\" /;\r\n* add warnings if slack variables have non 0 levels\r\n    put '\"warnings\": [' /;\r\n\r\n    if ((sum(curCrops, v_devShares.l(curCrops)) > 0),\r\n      loop(curCrops $ v_devShares.l(curCrops),\r\n        put$(v_devShares.l(curCrops) > 0) '\"Maximaler Fruchtfolgeanteil von ', curCrops.tl, ' konnte nicht eingehalten werden.\"'/;\r\n        curWarning = curWarning + 1;\r\n        put$(curWarning < warningsCount) \",\" /;\r\n      )\r\n    );\r\n    if ((v_devEfa5.l > 0),\r\n      put '\"Konnte 5% ÖVF nicht einhalten. Prüfen, ob Sommerungen vorhanden sind, bzw. ob ZF Anbau erlaubt wurde.\"' /;\r\n      curWarning = curWarning + 1;\r\n      put$(curWarning < warningsCount) \",\" /;\r\n    );\r\n    if ((v_devEfa75.l > 0),\r\n      put '\"Konnte 75% Greening-Regel nicht einhalten\"' /;\r\n      curWarning = curWarning + 1;\r\n      put$(curWarning < warningsCount) \",\" /;\r\n    );\r\n    if ((v_devEfa95.l > 0),\r\n      put '\"Konnte 95% Greening-Regel nicht einhalten\"' /;\r\n      curWarning = curWarning + 1;\r\n      put$(curWarning < warningsCount) \",\" /;\r\n    );\r\n    if ((sum(curPlots, v_devOneCrop.l(curPlots)) > 0),\r\n      loop(curPlots $ v_devOneCrop.l(curPlots),\r\n        put$(v_devOneCrop.l(curPlots) > 0) '\"Keine mögliche Nachfrucht für ', curPlots.tl, ' mit den aktuellen Anbaupause/Nachfruchtwirkungen.\"'/;\r\n        curWarning = curWarning + 1;\r\n        put$(curWarning < warningsCount) \",\" /;\r\n      )\r\n    );\r\n    $$iftheni.constraints defined constraints\r\n      if ((sum((constraints,curCrops,curCrops1), v_devUserShares.l(constraints,curCrops,curCrops1)) > 0),\r\n        loop((constraints,curCrops,curCrops1) $ v_devUserShares.l(constraints,curCrops,curCrops1),\r\n          put$(v_devUserShares.l(constraints,curCrops,curCrops1) > 0) '\"Konnte Restriktion für ', constraints.tl, ' nicht einhalten.\"'/;\r\n          curWarning = curWarning + 1;\r\n          put$(curWarning < warningsCount) \",\" /;\r\n        ) \r\n      ); \r\n    $$endif.constraints\r\n    $$iftheni.labour defined p_availLabour\r\n      if ((sum(months, v_devLabour.l(months)) > 0),\r\n        loop((months,fullMonths) $ ( v_devLabour.l(months) $ (months.pos eq fullMonths.pos)),\r\n          put$(v_devLabour.l(months) > 0) '\"Konnte maximale Arbeitszeit für ', fullMonths.tl, ' nicht einhalten.\"'/;\r\n          curWarning = curWarning + 1;\r\n          put$(curWarning < warningsCount) \",\" /;\r\n        )\r\n      );\r\n    $$endif.labour\r\n\r\n    put '],' /; \r\n* write recommendations from optimisation to JSON file\r\n    put '\"recommendation\":', \"{\"/;\r\n    loop((curPlots),\r\n      loop(curCrops,\r\n        put$(v_binCropPlot.l(curCrops,curPlots) > 0) '\"', curPlots.tl, '\":', '\"', curCrops.tl, '\"' /\r\n      )\r\n      put$(curPlots.pos < card(curPlots)) \",\" /\r\n    );\r\n    put \"},\" /;\r\n* write catch crop recommendations from optimisation to JSON file\r\n    put '\"catchCrop\":', \"{\"/;\r\n    loop((curPlots),\r\n      put$(sum(curCrops, v_binCatchCrop.l(curCrops,curPlots)) > 0) '\"', curPlots.tl, '\":', 'true' /\r\n      put$(sum(curCrops, v_binCatchCrop.l(curCrops,curPlots)) eq 0) '\"', curPlots.tl, '\":', 'false' /\r\n      put$(curPlots.pos < card(curPlots)) \",\" /\r\n    );\r\n    put \"}\" /;\r\n);\r\n\r\nput \"}\" /;\r\nputclose;\r\n"