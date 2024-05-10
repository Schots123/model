
*
*  --- in this file, the data from excel which was retrieved from the sqLite database is 
*       loaded into a .gdx file for further processing


*$call =gdxxrw 1.xlsx2gdx/Excel/KTBL_Revenue_gams.xlsx Output=KTBL_data/KTBL_Revenue.gdx 1.xlsx2gdx/txt/revenues.txt log = 1.xlsx2gdx/log/revenues.log
*$call =gdxxrw 1.xlsx2gdx/Excel/KTBL_DirectCosts_gams.xlsx Output=KTBL_data/KTBL_DirectCosts.gdx @1.xlsx2gdx/txt/directCosts.txt log = 1.xlsx2gdx/log/directCosts.log
*$call =gdxxrw 1.xlsx2gdx/Excel/KTBL_DirectCosts_gams.xlsx Output=KTBL_data/KTBL_FertAmount.gdx @1.xlsx2gdx/txt/fertAmount.txt log = 1.xlsx2gdx/log/fertAmount.log
*$call =gdxxrw 1.xlsx2gdx/Excel/KTBL_WorkingSteps_gams.xlsx Output=KTBL_data/KTBL_VarFixCosts.gdx @1.xlsx2gdx/txt/VarFixCosts.txt log = 1.xlsx2gdx/log/VarFixCosts.log
*$call =gdxxrw 1.xlsx2gdx/Excel/KTBL_WorkingSteps_gams.xlsx Output=KTBL_data/KTBL_Time.gdx @1.xlsx2gdx/txt/time.txt log = 1.xlsx2gdx/log/time.log