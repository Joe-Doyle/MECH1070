try
    %Serial setup
    a = arduino('/dev/tty.usbmodem14401','Uno')
    t = serial('/dev/tty.usbmodem3595310','BaudRate',57600)
    fopen(t)
    
    %global variables
    threshold = 7
    
    %read initial temps for reference
    initHomeTemp    = normTemp((readVoltage(a,'A0') * (1023 / 5)), 5)
    initAmbiTemp    = normTemp((readVoltage(a,'A1') * (1023 / 5)), 5)
    initGreenTemp   = normTemp((readVoltage(a,'A2') * (1023 / 5)), 5)
    
    %arduino motor direction
    writeDigitalPin(a,'D2',0);
    
    for n = 1:100
        %get loop temps
        homeTemp    = normTemp((readVoltage(a,'A0') * (1023 / 5)), 5)
        ambiTemp    = normTemp((readVoltage(a,'A1') * (1023 / 5)), 5)
        greenTemp   = normTemp((readVoltage(a,'A2') * (1023 / 5)), 5)
        
        %check loop temps vs init temps to see if above threshold
        if homeTemp  > (initHomeTemp + threshold)  homeHot  = true, else homeHot  = false, end
        if greenTemp > (initGreenTemp + threshold) greenHot = true, else greenHot = false, end
        
        if greenHot writePWMVoltage(a,'D3',5), else writePWMVoltage(a,'D3',0), end
        
        %graph temps for visual reference
        bar([homeTemp ambiTemp greenTemp homeHot greenHot])
        linkdata on
        pause(.25);
        
    end
    
    clear
    fclose(instrfind)
    close
    
catch ME
    ME.message
    clear
    close
    fclose(instrfind)
end