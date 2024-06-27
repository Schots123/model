*
*  --- Load test include file, set WORKDIR and RANDOM
*      global variables for debugging in Atom
*

*turning off the echoprint
$offlisting 

$offsymxref offsymlist

option
    limrow = 0,     
    limcol = 0,     
    sysout = off; 


option Solprint = off;

*option profile = 3;

set years / 2024*2026 /;


scalar newFuelPrice price for fuel in euro per liter /1/;
scalar labPrice price for labour in euro per hour /21/;
scalar manPrice price to export manure /15/;



$include '2.ktblData/KTBL_inputOptions+Sets.gms'
$include '4.cropProtectionData/LWK_spraySequence.gms'
$setglobal farmNumber 1
$include '3.farmData/typFarm_%farmNumber%.gms'
$include '4.cropProtectionData/technologyData.gms'
$include '5.model/fruchtfolge.gms'