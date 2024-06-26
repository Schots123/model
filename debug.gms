*
*  --- Load test include file, set WORKDIR and RANDOM
*      global variables for debugging in Atom
*

*turning off the echoprint
$offlisting 

*$offsymxref offsymlist

option
    limrow = 3,     
    limcol = 3,     
    sysout = off; 


option limrow = 0;
option limcol = 0;

option Solprint = off;

set years / 2024*2026 /;
scalar newFuelPrice price for fuel in euro per liter /1/;
scalar labPrice price for labour in euro per hour /21/;
scalar manPrice price to export manure /15/;
scalar sizeFactor /3/;

$include '2.ktblData/KTBL_inputOptions+Sets.gms'
$include '4.cropProtectionData/LWK_spraySequence.gms'
$setglobal farmNumber 1
$include '3.farmData/typFarm_%farmNumber%.gms'
$include '4.cropProtectionData/technologyData.gms'
$include '5.model/fruchtfolge.gms'