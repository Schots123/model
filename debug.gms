*
*  --- Load test include file, set WORKDIR and RANDOM
*      global variables for debugging in Atom
*

$offlisting 
*turning off the echoprint
*$offsymxref offsymlist

option
    limrow = 3,     
    limcol = 3,     
    sysout = off; 


option limrow = 1;
option limcol = 1;
option Solprint = off;

$include '2.ktblData/KTBL_inputOptions+Sets.gms'
$setglobal farmNumber 1
$include '3.farmData/typFarm_%farmNumber%.gms'
$include '5.model/fruchtfolge.gms'