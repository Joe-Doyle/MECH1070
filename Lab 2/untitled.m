len     = 6.56168     %beam length in inches
width   = 1.9685   %beam profile width in inches
height  = 3.93701  %beam profile height in inches
modulus = 67     %Young's modulus for material in GPa
    
%enter vector of load values in pounds
load    = 224.809

theDef = calcDef(len,load,modulus,width,height)