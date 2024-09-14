
*
*  --- in this file, the data from excel which was retrieved from the sqLite database is 
*       loaded into a .gdx file for further processing


$call =gdxxrw 1.xlsx2gdx/Excel/KTBL_Revenue_gams.xlsx Output=2.ktblData/gdxFiles/KTBL_Revenue.gdx 1.xlsx2gdx/txt/revenues.txt log = 1.xlsx2gdx/log/revenues.log
$call =gdxxrw 1.xlsx2gdx/Excel/KTBL_DirectCosts_gams.xlsx Output=2.ktblData/gdxFiles/KTBL_DirectCosts.gdx @1.xlsx2gdx/txt/directCosts.txt log = 1.xlsx2gdx/log/directCosts.log
$call =gdxxrw 1.xlsx2gdx/Excel/KTBL_DirectCosts_gams.xlsx Output=2.ktblData/gdxFiles/KTBL_FertAmount.gdx @1.xlsx2gdx/txt/fertAmount.txt log = 1.xlsx2gdx/log/fertAmount.log
$call =gdxxrw 1.xlsx2gdx/Excel/KTBL_WorkingStepsNoPesti_gams.xlsx Output=2.ktblData/gdxFiles/KTBL_WorkingStepsNoPesti.gdx @1.xlsx2gdx/txt/workingStepsNoPesti.txt log = 1.xlsx2gdx/log/workingStepsNoPesti.log
$call =gdxxrw 1.xlsx2gdx/Excel/KTBL_WorkingStepsPesti_gams.xlsx Output=2.ktblData/gdxFiles/KTBL_WorkingStepsBroadcast.gdx @1.xlsx2gdx/txt/workingStepsBroadcast.txt log = 1.xlsx2gdx/log/workingStepsBroadcast.log