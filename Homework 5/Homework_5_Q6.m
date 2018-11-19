%This script is for calculating the deflection of a rectangular 
%cross section beam as a function of the applied load.

try
    %enter dimensions and modulus of material
    len     = 2     %beam length in inches
    width   = .03   %beam profile width in inches
    height  = .05  %beam profile height in inches
    modulus = 90     %Young's modulus for material in GPa
    
    %enter vector of load values in pounds
    load    = 0:50:10000;
    
    %generate vector of theoretical load values from young's modulus and the
    %deflection calculator function
    for i=1:length(load);
        theDef(i) = calcDef(len,load(i),modulus,width,height);
    end;
        
    %plot measured and calculated deflection vs load
    figure
    a = axes
    set(a,'fontsize',18,'fontname','times')
    a = plot(load, theDef, '-')
    set(a,'linewidth',2,'color','k','markersize',1)
    grid on
    
    hold on
    
    a = xlabel('Load [Newtons]')
    set(a,'fontsize',18,'fontname','times')
    a = ylabel('Deflection [cm]')
    set(a,'fontsize',18,'fontname','times')
    a = title('Q6 calculated Deflection Vs. Load')
    set(a,'fontsize',18,'fontname','times')
    
    %save plot as png
    print('-dpng','-r300','HW_5_Q6.png')
    
catch ME
    ME.message
end