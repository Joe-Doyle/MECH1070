try
    %Serial setup
    a = arduino('/dev/tty.usbmodem14101','Uno')
    t = serial('/dev/tty.usbmodem3595310','BaudRate',57600)
    fopen(t)
    t.Terminator = ''
    s = serial('/dev/tty.usbmodem14501','BaudRate',115200)
    fopen(s)
    
    %global variables
    threshold = 5
    openVal   = .25
    
    %read initial temps for reference
    initHomeTemp    = normTemp((readVoltage(a,'A0') * (1023 / 5)), 5)
    initAmbiTemp    = normTemp((readVoltage(a,'A1') * (1023 / 5)), 5)
    initGreenTemp   = normTemp((readVoltage(a,'A2') * (1023 / 5)), 5)
    
    %configure CNC controller box
    fprintf (s, 'G17 G20 G90 G94 G54')
    
    for n = 1:1000
        %get loop temps
        homeTemp    = normTemp((readVoltage(a,'A0') * (1023 / 5)), 5)
        ambiTemp    = normTemp((readVoltage(a,'A1') * (1023 / 5)), 5)
        greenTemp   = normTemp((readVoltage(a,'A2') * (1023 / 5)), 5)
        
        %check loop temps vs init temps to see if above threshold
        if homeTemp  > (initHomeTemp + threshold),  homeHot  = true, else, homeHot  = false, end
        if greenTemp > (initGreenTemp + threshold), greenHot = true, else, greenHot = false, end
        
        %if greenhouse hot and home cold, turn on fan from greenhouse to home
        % turn greenhouse leds orange
        if greenHot && ~homeHot
            writeDigitalPin(a,'D2',0)
            writePWMVoltage(a,'D3',5)
            fprintf(t, 'g')
        else
            writePWMVoltage(a,'D3',0)
        end
        
        %if greenhouse cold and home hot, turn on fan from home to greenhouse
        % turn home led strip orange
        if ~greenHot && homeHot
            writeDigitalPin(a,'D2',1);
            writePWMVoltage(a,'D3',5)
            fprintf(t, 'h')
        else
            writePWMVoltage(a,'D3',0)
        end
        
        %if greenhouse hot and home hot, open greenhouse roof
        % turn both led strips orange
        if greenHot && homeHot
            CNCMotion = ['G1 x', num2str(openVal),' F3']
            fprintf(t, 'b')
        else
            CNCMotion = ['G1 x0 F3']
        end
        
        %
        fprintf (s,CNCMotion)
        
        %if greenhouse is cold and home cold, turn all leds blue
        if ~greenHot && ~homeHot
            fprintf(t, 'n')
        end
        
        %graph temps for visual reference
        bar([homeTemp ambiTemp greenTemp homeHot greenHot])
        ylim([0 100])
        linkdata on
    end
    
    clear
    close
    fclose(instrfind)
    
catch ME
    ME.message
    clear
    close
    fclose(instrfind)
end