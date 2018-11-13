try
    a = arduino('/dev/tty.usbmodem14501','Uno')
    writeDigitalPin(a,'D2',1);
    writePWMDutyCycle(a,'D3',1);
    
    pause(5)
    
    clear
    
catch ME
    ME.message
    clear
end