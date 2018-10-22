try
    %Measured data
    inches = [19/8 5/2 39/16 19/8 21/8 19/8 5/2 5/2 19/8 39/16 19/8]
    rotations = [1/20 2/20 3/20 4/20 5/20 6/20 7/20 8/20 9/20 10/20 11/20]

    %plot raw measured data
    a = plot(rotations, inches,'s-')
    set(a,'linewidth',2,'color','r','markersize',6)
    hold on
    
    %plot line of best fit
    Fit = polyfit(rotations,inches,1);
    xFit = linspace(rotations(1),rotations(11),100)
    yFit = polyval(Fit, xFit)
    a = plot(xFit,yFit)
    set(a,'linewidth',2,'color','g','markersize',6)
    
    %format plot and add labels/legend
    grid on
    axis([1/20 11/20 2 3])
    a = ylabel('Liquid Displacement Distance [in.]')
    set(a,'fontsize',18,'fontname','times')
    a = xlabel('Syringe Displacement Distance [in.]')
    set(a,'fontsize',18,'fontname','times')
    a = title('Line Plot of Syringe Displacement Vs Liquid Displacement')
    set(a,'fontsize',18,'fontname','times')
    a = legend({'Measured Displacement','Best Fit Displacement'},'Location','northwest')
    set(a,'fontsize',18,'fontname','times')
    
    %save plot as png
    print('-dpng','-r300','syringeCompressionVsLiquidDisplacement.png')
    
catch ME
    ME.message
end
