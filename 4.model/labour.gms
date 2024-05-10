




positive variables
  v_labReq(years)
;

equations
  e_labReq(years)
*  e_maxLabReqMonths(months,years)
;

e_labReq(years)..
  v_labReq(years) =E=
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHa(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years) * p_plotData(curPlots,'size')
    * sum(CostsEle,
      p_timeReq(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,CostsEle,manAmounts)))
;
$ontext
          + sum(pestType
          $ (p_technoData("eff",pestType) eq 0),
            p_timeReqPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,halfMonths,pestType))
          + sum(pestType
          $ (p_technoData("eff",pestType) gt 0),
            p_technoData("fieldTime",pestType)
            * p_pestMonthlyOpFreq(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,halfMonths,pestType)))
        )
    )
;
$offtext