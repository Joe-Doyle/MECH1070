try
    %Serial setup
    a = arduino('/dev/tty.usbmodem14401','Uno')
    t = serial('/dev/tty.usbmodem3595310','BaudRate',57600)
    fopen(t)
    %s = serial('/dev/tty.usbmodem3595310','BaudRate',115200)
    %fopen(s)
    
    %global variables
    threshold = 7
    openVal   = .025
    
    %read initial temps for reference
    initHomeTemp    = normTemp((readVoltage(a,'A0') * (1023 / 5)), 5)
    initAmbiTemp    = normTemp((readVoltage(a,'A1') * (1023 / 5)), 5)
    initGreenTemp   = normTemp((readVoltage(a,'A2') * (1023 / 5)), 5)
    
    %configure CNC controller box
    %fprintf (s, 'G17 G20 G90 G94 G54')
    
    for n = 1:300
        %get loop temps
        homeTemp    = normTemp((readVoltage(a,'A0') * (1023 / 5)), 5)
        ambiTemp    = normTemp((readVoltage(a,'A1') * (1023 / 5)), 5)
        greenTemp   = normTemp((readVoltage(a,'A2') * (1023 / 5)), 5)
        
        %check loop temps vs init temps to see if above threshold
        if homeTemp  > (initHomeTemp + threshold),  homeHot  = true, else, homeHot  = false, end
        if greenTemp > (initGreenTemp + threshold), greenHot = true, else, greenHot = false, end
        
        %if greenhouse hot and home cold, turn on fan from greenhouse to home
        if greenHot && ~homeHot
            writeDigitalPin(a,'D2',0)
            writePWMVoltage(a,'D3',5)
        else
            writePWMVoltage(a,'D3',0)
        end
        
        %if greenhouse cold and home hot, turn on fan from home to greenhouse
        if ~greenHot && homeHot
            writeDigitalPin(a,'D2',1);
            writePWMVoltage(a,'D3',5)
        else
            writePWMVoltage(a,'D3',0)
        end
        
        %if greenhouse hot and home hot, open greenhouse roof
        if greenHot && homeHot
            %CNCMotion = ['G1 x', num2str(openVal),' F.5']
        else
            %CNCMotion = ['G1 x0 F.5']
        end
        
        %graph temps for visual reference
        bar([homeTemp ambiTemp greenTemp homeHot greenHot])
        ylim([0 100])
        linkdata on
        %pause(.25);
        
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