*
*  --- Load test include file, set WORKDIR and RANDOM
*      global variables for debugging in Atom
*
*$ontext
*$offlisting 
*turning off the echoprint
$offsymxref offsymlist

option
    limrow = 3,     
    limcol = 3,     
    sysout = off; 
*$offtext

option limrow = 20;
option limcol = 20;    
$include 'test/include/KTBL_data.gms'
$include 'test/include/typical_farm.gms'
$SETGLOBAL WORKDIR './'
*$SETGLOBAL RANDOM 'debug.json'
$include 'technology.gms'
execute.async 'redLstSize debug.lst l=true';
