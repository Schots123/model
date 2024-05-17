




positive variables
  v_labReq(years)
;

equations
  e_labReq(years)
  e_labReqTechno(years)
;

e_labReq(years)..
  v_labReq(years) =E=
  sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  $ (
    curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
    AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
    AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
  ),
  v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years) * p_plotData(curPlots,'size')
  * (p_timeReq(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
*Consideration of time requirements for broadcast pesticide application operation
  + p_ktbl_workingStepsBroadcast(KTBL_size,curMechan,KTBL_distance,"time") * p_numberSprayPasses(curCrops,KTBL_yield))
  )
;

parameter p_technologyTimeReq(KTBL_size,curMechan,KTBL_distance);

e_labReqTechno(years)..
  v_labReq(years) =E=
  sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    $ (
      curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) 
      AND curPlots_ktblYield(curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(curCrops,KTBL_system,KTBL_yield)
      AND p_profitPerHaNoPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
    ),
    v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts,years) * p_plotData(curPlots,'size')
    * (p_timeReq(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,manAmounts)
*p_technologyTimeReq(KTBL_size,curMechan,KTBL_distance) only serves as an placeholder for the technology loop     
    + p_technologyTimeReq(KTBL_size,curMechan,KTBL_distance) * p_numberSprayPasses(curCrops,KTBL_yield))
  )
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