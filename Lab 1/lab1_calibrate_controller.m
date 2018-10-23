try
        s = serial('/dev/tty.usbmodem14401')
        set(s,'BaudRate',115200)
        fopen(s)
        % Set the new values of the parameters
        fprintf (s, '$100 = 157.480')
        pause(1)
        fprintf (s, '$101 = 157.480')
        pause(1)
        fprintf (s, '$102 = 157.480')
        pause(1)
        % Set the new values of the parameters
        fprintf (s, '$120 = 15.748')
        pause(1)
        fprintf (s, '$121 = 15.748')
        pause(1)
        fprintf (s, '$122 = 15.748')
        pause(1)
        % Close the connection to the GRBL controller
        fclose(s)
catch ME
    fclose(s)
    ME.message
end

