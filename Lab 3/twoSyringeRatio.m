try
    %com setup and initialization
    s = serial('/dev/tty.usbmodem14401')
    set(s,'BaudRate',115200)
    fopen(s)
    pause(2)
    
	% Now we start sending commands to the controller 
    % using the ?print? function 
    fprintf (s, 'G17 G20 G90 G94 G54')
    
    % The following commands simply move the motor to
    % a new x,y,z position with a feedrate = F.
    fprintf (s,'G1 x0.0917 y0.3668 F5') %split 0.4585 into whatever ratio needed
    display('All Done!!!')
    % Close the connection to the GRBL controller
    fclose(s)
catch ME
	fclose(s)
    ME.message
end
