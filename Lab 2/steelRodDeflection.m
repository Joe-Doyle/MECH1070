%This script is for determining and plotting a theoretical load on the
%single cnc axis when the block is centered, assuming no support from
%threaded rod

try
    len     = 15+(15/16)%rod length in inches
    width   = 0.375     %rod profile width in inches
    numRod  = 2         %number of rods supporting load
    steelMod= 200       %Young's modulus for steel in GPa
    
    %converting the area of n cylindrical rods to width and height
    area    = pi*((width/2)^2)*numRod
    width   = sqrt(area)
    height  = sqrt(area)
    
    %generate vector of load values in pounds
    load    = 0:2:70

    %generate vector of theoretical load values from young's modulus and the
    %deflection calculator function
    for i=1:length(load)
        theDef(i) = calcDef(len,load(i),steelMod,width,height)
    end
        
    %plot calculated deflection vs load
    figure
    a = axes
    set(a,'fontsize',18,'fontname','times')
    grid on
    a = plot(load, theDef,'>-')
    set(a,'linewidth',1,'color','r','markersize',6)
    a = xlabel('Load [pounds]')
    set(a,'fontsize',18,'fontname','times')
    a = ylabel('Deflection [in.]')
    set(a,'fontsize',18,'fontname','times')
    a = title('Line Plot of Calculated Deflection Vs. Load on Axis')
    set(a,'fontsize',18,'fontname','times')
    
    %save plot as png
    print('-dpng','-r300','deflectionVsLoadAxis.png')
    
catch ME
    ME.message
end