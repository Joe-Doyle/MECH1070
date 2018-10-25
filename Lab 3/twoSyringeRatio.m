try
    %system config block
    red     = 80        %percent of red solution
    blu     = 20        %percent of blue solution
    totDist = 0.4585    %total distance one syringe needs to be displaced for the desired volume
    
    %set up serial
    s = serial('/dev/tty.usbmodem14401')
    set(s,'BaudRate',115200)
    fopen(s)
    pause(2)
    
	%G-Code setup
    fprintf (s, 'G17 G20 G90 G94 G54')
    
    %calculate relative movement of the axis for the desired percentages
    redMove = red/100*totDist
    bluMove = blu/100*totDist   
    
    %create G-Code string
    CNCMotion = ['G1 x', num2str(redMove),' y', num2str(bluMove), ' F10']
    
    %print G-Code string to controller
    fprintf (s,CNCMotion) 
    
    % Close the connection to the controller
    fclose(s)
catch ME
	fclose(s)
    ME.message
end
