%This script is for calculating the deflection of a rectangular 
%cross section beam as a function of the applied load.

try
    %enter dimensions and modulus of material
    len     = 2     %beam length in inches
    width   = .05   %beam profile width in inches
    height  = .1  %beam profile height in inches
    modulus = 67     %Young's modulus for material in GPa
    
    %enter vector of load values in pounds
    load    = 1000;
    
    %generate vector of theoretical load values from young's modulus and the
    %deflection calculator function
    for i=1:length(height);
        theDef(i) = calcDef(len,load,modulus,width,height(i));
    end;
        
    
catch ME
    ME.message
end