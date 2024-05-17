
$include '%WORKDIR%fruchtfolge.gms'

*supervision intensity for robots as fraction of field time 

p_technoData("areaCapac",pestType) = 7200;
* in ha/lifetime
p_technoData("eff","herb") = 50;
*reduction factor of herbicides needed to sustain yields
*    "eff"."fung" 50
p_technoData("varMachCostsPestiRedFactor","herb") = 1;
*varMachCostsPestiRedFactor is a factor by which the variable machine Costs (fuel + maintenance costs of machine) are higher/lower for the technology compared to the baseline technology 
*    "varMachCostsPestiRedFactor"."fung" 1
p_technoData("fieldTime",pestType) = 0.05;
*field time reflects hours per hectare necessary    
;

scalar  p_technoValue monetary value of technology;

*
* --- Calculation of farm profit without specific pesticide application costs influenced by new technology
*
parameters 
    p_ktbl_dcPestiTechRed(curCrops,KTBL_system,KTBL_yield) direct costs for pesticides which are reduced 
    p_ktbl_varMachCostsPestiReduced(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    p_ktbl_fixMachCostsPestiReduced(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    p_ktbl_profitPerHaNoPest(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    p_cropCapac(KTBL_crops,KTBL_system,KTBL_yield,pestType) amount of ha for each crop potentially grown the technology could spray in its lifetime
    p_deprecTechno(curCrops,KTBL_system,KTBL_yield,pestType) depreciation of technology per ha and for each crop potentially grown seperately
;

p_ktbl_dcPestiTechRed(curCrops,KTBL_system,KTBL_yield)
    $ (ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield))
    = sum(pestType
        $ (p_technoData("eff",pestType)),
           p_ktbl_dcPesti(curCrops, KTBL_system, KTBL_yield, pestType))
;

p_ktbl_varMachCostsPestiReduced(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    $ (ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield))
        = sum(pestType
        $ (p_technoData("eff",pestType)),
            p_ktbl_fuelConsPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,pestType) * p_newFuelPrice
            + p_ktbl_maintenancePesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,pestType))
;

p_ktbl_fixMachCostsPestiReduced(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    $ (ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield))
    = sum(pestType
        $ (p_technoData("eff",pestType)),
            p_ktbl_deprecPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,pestType)
            + p_ktbl_interestPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,pestType)
            + p_ktbl_othersPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,pestType))
;

p_ktbl_profitPerHaNoPest(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance) 
    $ (ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield))
    =
*profitPerHa from baseline solve   
    p_ktbl_profitPerHa(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
*calculate out direct costs (including interest costs) for pesticide inputs which are reduced by technology
    + p_ktbl_dcPestiTechRed(curCrops,KTBL_system,KTBL_yield)
*calculate out variable and fix machine costs for pesticide applications which are influenced by technology parameters    
    + p_ktbl_varMachCostsPestiReduced(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
    + p_ktbl_fixMachCostsPestiReduced(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
;

*
*  --- declare objective variable (overall farm profit) and equation influenced by technology parameters
*
Variables
    v_deprecTechno(years)
    v_interestTechno(years)
    v_otherCostsTechno(years)
    v_profitTechno(years)
    v_totProfitTechno
    v_objeTechno
;

equations
    e_deprecTechno(years) annual depreciation of technology based on cropping decision and farm size 
    e_interestTechno(years) interest costs of technology based on depreciation
    e_otherCostsTechno(years) other costs like machine insurance for technology based on depreciation
    e_profitTechno(years) annual farm profit with new technology
    e_totProfitTechno total profit over time horizon for farm with new technology
    e_objeTechno
;

e_deprecTechno(years)..
    v_deprecTechno(years) =E=
    sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,pestType)
    $ (curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) AND curPlots_ktblYield (curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield) AND p_pestOpFreq(curCrops,KTBL_system,KTBL_yield,'herb')),
        v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years) * p_plotData(curPlots,'size')
        * p_deprecTechno(curCrops,KTBL_system,KTBL_yield,pestType))
;

e_interestTechno(years)..
    v_interestTechno(years) =E=
    v_deprecTechno(years) * 0.3
;

e_otherCostsTechno(years)..
    v_otherCostsTechno(years) =E= 
    v_deprecTechno(years) * 0.1
;


$ontext
e_valueTechno..
    p_ValueTechno =E=
    v_totProfitTechno - p_totProfitLevelBase
;
$offtext

e_profitTechno(years)..
    v_profitTechno(years) =E=
        sum((curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
        $ (curPlots_ktblSize(curPlots,KTBL_size) AND curPlots_ktblDistance(curPlots,KTBL_distance) AND curPlots_ktblYield (curPlots,KTBL_yield) AND ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield)),   
          v_binCropPlot(curPlots,curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,years) * p_plotData(curPlots,'size')
          * (p_ktbl_profitPerHaNoPest(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance)
*pesticide calculations
*herbicide savings due to technology advantage
            - sum(pestType
            $ (p_technoData("eff",pestType) gt 0),
                p_ktbl_dcPesti(curCrops, KTBL_system, KTBL_yield, pestType)
                * ((100-p_technoData("eff",pestType))/100))
*variation of costs for maintenance and lubricants due to different technology characteristics
            - sum(pestType
            $ (p_technoData("eff",pestType) gt 0),
                (p_ktbl_fuelConsPesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,pestType) * p_newFuelPrice
                + p_ktbl_maintenancePesti(curCrops,KTBL_system,KTBL_size,KTBL_yield,curMechan,KTBL_distance,pestType))
                * p_technoData('varMachCostsPestiRedFactor',pestType))))
*variation of fixed costs due to different technology characteristics 
        - v_deprecTechno(years)
        - v_interestTechno(years)
        - v_otherCostsTechno(years)
*costs for labor 
        - v_labReq(years) * 21
;
    
e_totProfitTechno..
    v_totProfitTechno =E=
    sum(years, v_profitTechno(years))
;

e_objeTechno..
    v_objeTechno =E=
    v_totProfitTechno
    - sum((curCrops,years), v_devShares(curCrops,years) * M)
*    - (v_devEfa5 * M)
*    - (v_devEfa75 * M)
*    - (v_devEfa95 * M)
    - sum((curPlots,years), v_devOneCrop(curPlots,years) * M * 10)
*    - (sum((manType,months), v_manSlack(manType,months) * M))
*    - (v_170Slack * M)
*    - ((sum((manType,curPlots), v_170PlotSlack(curPlots))) * M)
*    - (v_20RedSlack * M)
*    - sum(years,(v_devGaec6(years) * M))
*    - sum(years,(v_devGaec7(years) * M))
*    - sum(years,(v_devGaec8(years) * M))
*$iftheni.constraints defined constraints
*    - sum((constraints,curCrops,curCrops1),
*      v_devUserShares(constraints,curCrops,curCrops1,years) * M)
*$endif.constraints
*$iftheni.labour defined p_availLabour
*    - sum(months, v_devLabour(months) * 1000)
*$endif.labour
;    

model Technology /
    e_deprecTechno
    e_interestTechno
    e_otherCostsTechno
    e_profitTechno
    e_totProfitTechno
    e_objeTechno
*crop_rotation.gms
    e_maxShares
    e_oneCropPlot
*labour.gms
    e_annLabReq
    e_labReqMonths
    e_maxLabReqMonths
/;

parameter p_totProfitLevelBase Profit in baseline to compare with results with new technology;
p_totProfitLevelBase = v_totProfit.l;

*
*  --- introducing sets for sensitivity analysis for technology parameters 
*
sets 
    valueStep /valueStep0*valueStep5/
    efficiencyStep /effStep0*effStep3/
    areaCapacStep /areaCapacStep0*areaCapacStep3/
;

p_technoData("eff","herb") = 0;
p_technoValue = 0;
p_technoData("areaCapac",pestType) = 0;

option
  p_ktbl_dcPestiTechRed:1:2:1
  p_ktbl_varMachCostsPestiReduced:1:2:4
  p_ktbl_fixMachCostsPestiReduced:1:2:4
  p_ktbl_profitPerHaNoPest:1:2:4
;

display p_ktbl_profitPerHaNoPest, p_ktbl_varMachCostsPestiReduced, p_ktbl_fixMachCostsPestiReduced, p_ktbl_dcPestiTechRed;

*
* --- initiating loop
*
loop((valueStep,efficiencyStep,areaCapacStep),
*step wise increase of technology value
    p_technoValue = 50000 + 50000 * (valueStep.pos - 1);
*step wise reduction of technology pesticide saving efficiency 
    p_technoData("eff","herb") = 45 - 10 * (efficiencyStep.pos - 1);
*step wise reduction of technology area capacity
    p_technoData("areaCapac",pestType) = 7500 - 1000 * (areaCapacStep.pos - 1);

        p_cropCapac(curCrops,KTBL_system,KTBL_yield,pestType) 
            $ (ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield) AND p_pestOpFreq(curCrops,KTBL_system,KTBL_yield,pestType) AND p_technoData("eff",pestType))
            = p_technoData('areaCapac',pestType) / p_pestOpFreq(curCrops,KTBL_system,KTBL_yield,pestType);

        p_deprecTechno(curCrops,KTBL_system,KTBL_yield,pestType) 
            $ (ktblCrops_KtblSystem_KtblYield(KTBL_crops,KTBL_system,KTBL_yield) AND p_pestOpFreq(curCrops,KTBL_system,KTBL_yield,pestType) AND p_technoData("eff",pestType))
            = (p_technoValue / p_cropCapac(curCrops,KTBL_system,KTBL_yield,pestType));
*assumption: capacity of technology is fully utilized (e.g. by sharing it with other farmers)
*depreciation costs are assigned to own farm according to required degree of technology utilization for crops grown on farm 
  
    if((ord(valueStep) eq 1 AND ord(efficiencyStep) ge 1 AND ord(areaCapacStep) ge 1),
        solve Technology using MIP maximizing v_objeTechno;
        $$batinclude '%WORKDIR%test/include/report_writing_techno.gms' valueStep efficiencyStep areaCapacStep
        else 
            if((ord(efficiencyStep) eq 1 AND ord(areaCapacStep) ge 1 AND ord(valueStep) ge 1),
            solve Technology using MIP maximizing v_objeTechno;
            $$batinclude '%WORKDIR%test/include/report_writing_techno.gms' valueStep efficiencyStep areaCapacStep
            else
                if((ord(areaCapacStep) eq 1 AND ord(valueStep) ge 1 AND ord(efficiencyStep) ge 1),
                solve Technology using MIP maximizing v_objeTechno;
                $$batinclude '%WORKDIR%test/include/report_writing_techno.gms' valueStep efficiencyStep areaCapacStep
                else
                    if((ord(valueStep) gt 1 AND ord(efficiencyStep) gt 1 AND ord(areaCapacStep) gt 1 AND v_totProfitTechno.l > p_totProfitLevelBase),
                    solve Technology using MIP maximizing v_objeTechno;
                    $$batinclude '%WORKDIR%test/include/report_writing_techno.gms' valueStep efficiencyStep areaCapacStep
                    else
                        display "maximum technology value reached";
                    );
                );
            );
    );   
);
