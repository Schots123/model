*
*  --- Load test include file, set WORKDIR and RANDOM
*      global variables for debugging in Atom
*
$include 'test/include/farm5.gms'
$SETGLOBAL WORKDIR './'
$SETGLOBAL RANDOM 'debug.json'
$include 'fruchtfolge.gms'
