*
*  --- Load include file and managing of output volume 
*      

*eliminate echo print
$offlisting 

*eliminate model listing
option
    limrow = 0,     
    limcol = 0,     
    sysout = off; 

*eliminate cross reference map
$offsymxref

*eliminate symbol list (alpabetic listing of the symbol table)
$offsymlist

*eliminate solution output
option Solprint = off;

*option profile = 3;

set years / 2024*2026 /;


scalar newFuelPrice price for fuel in euro per liter /1.15/;
scalar labPrice price for labour in euro per hour /21/;
*scalar manPrice price to export manure /15/;



$include '2.ktblData/KTBL_inputOptions+Sets.gms'
$include '4.cropProtectionData/LWK_spraySequence.gms'
$setglobal farmNumber 162.141
$include '3.farmData/farm_%farmNumber%.gms'
$include '4.cropProtectionData/technologyData.gms'
$include '5.model/fruchtfolge.gms'

Execute_Unload '6.Report/gdxFiles/ResultsSenAnNew_%farmNumber%.gdx' 
*summary
summarySenAn
;