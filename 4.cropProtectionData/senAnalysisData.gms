
parameter farmSizeVar placeholder for farm size variation /1/;

set farmSizeStep / 
    "initialSize", 
    "sizex2", 
*    "sizex4", 
*    "sizex6", 
*    "sizex8", 
    "sizex10" 
/;
parameter p_farmSizeFactor(farmSizeStep) /
    "initialSize" 1, 
    "sizex2" 2, 
*    "sizex4" 4, 
*    "sizex6" 6, 
*    "sizex8 8, 
    "sizex10" 10
/;



parameter p_saveTechnoValue(scenSprayer,KTBL_mechanisation) parameter to reset investment costs for SST;
p_saveTechnoValue("spot6m",KTBL_mechanisation) = 130000;
p_saveTechnoValue("spot27m",KTBL_mechanisation) = 207000;

set SSTvalueStep / 
    "-50%value", 
*    "-40%value", 
*    "-30%value", 
*    "-20%value", 
*    "-10%value", 
    "baseValue" 
/;
parameter p_SSTvalueStep(SSTvalueStep) / 
    "baseValue" 1, 
*    "-10%value" 0.9,
*    "-20%value" 0.8,
*    "-30%value" 0.7, 
*    "-40%value" 0.6,
    "-50%value" 0.5
/;



parameter p_effStepVar placeholder for pesticide reduction achieved with technology /0/;

set SSTeffStep /
    "initialRed", 
*    "20%lessRed",  
*    "10%lessRed", 
*    "10%moreRed", 
    "20%moreRed%"
/;
parameter p_SSTeffStep(SSTeffStep) /
    "initialRed" 0, 
*    "20%lessRed" -0.2,  
*    "10%lessRed" -0.1, 
*    "10%moreRed" 0.1, 
    "20%moreRed%" 0.2
/;