%This script is for determining and plotting both a measured load vs.
%deflection for a beam as well as the theoretical load vs. deflection using
%the deflection formula and the material's young's modulus

try
    len     = 5     %beam length in inches
    width   = 3/4   %beam profile width in inches
    height  = 3/16  %beam profile height in inches
    pineMod = 9     %Young's modulus for pine in GPa
    
    %generate vector of load values in pounds
    load    = 2.0:2:52.0
    
    %generate vector of measured deflection in inches
    meDef   = [.0089 .0139 .0190 .0246 .0295 .0341 .0394 .0442 .0507 ...
        .0548 .0605 .0653 .0711 .0770 .0834 .0890 .0958 .1031 .1125 ...
        .1232 .1330 .1410 .1505 .1665 .1776 .2032]

    %generate vector of theoretical load values from young's modulus and the
    %deflection calculator function
    for i=1:length(load)
        theDef(i) = calcDef(len,load(i),pineMod,width,height)
    end
        
    %plot measured and calculated deflection vs load
    figure
    a = axes
    set(a,'fontsize',18,'fontname','times')
    a = plot(load, meDef,'>-')
    set(a,'linewidth',1,'color','g','markersize',6)
    grid on
    hold on
    a = plot(load, theDef,'>-')
    set(a,'linewidth',1,'color','r','markersize',6)
    a = xlabel('Load [pounds]')
    set(a,'fontsize',18,'fontname','times')
    a = ylabel('Deflection [in.]')
    set(a,'fontsize',18,'fontname','times')
    a = title('Line Plot of Measured and Calculated Deflection Vs. Load')
    set(a,'fontsize',18,'fontname','times')
    a = legend({'Measured','Theoretical'},'Location','northwest')
    set(a,'fontsize',18,'fontname','times')
    
    %save plot as png
    print('-dpng','-r300','deflectionVsLoad.png')
    
catch ME
    ME.message
end