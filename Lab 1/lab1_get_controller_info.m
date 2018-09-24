try
        % First we will setup a serial port
        % associated with the controller
        % Note: on a mac, the com ports may look
        % like USBmodems, e.g.: /dev/tty.usbmodem1421
        s = serial('/dev/tty.usbmodem1461')
    
        % Next we will setup the port communication speed
        % This may require some trial and error, but
        % 115200 appears to be a good value (9600 may
        % work too)
        set(s,'BaudRate',115200)
    
        % Now we actually open the serial port
        fopen(s)
    
        % We tell matlab to pause/wait for 2 seconds to % make sure the controller connects to the
        % computer
        pause(2)
    
        % Send the command ?$$? to the GRBL controller.
        % This command provides the default settings of
        % the controller. This includes the motor
        % calibration.
        fprintf (s, '$$');
    
        % print the result to the screen. To do this, we
        % scan the port for the feedback.
        for (i=1:33)
            out = fscanf(s)
        end
    
        % Close the connection to the GRBL controller
        fclose(s)
catch ME
    fclose(s)
    ME.message
end
