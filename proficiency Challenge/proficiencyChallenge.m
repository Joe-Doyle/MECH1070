try
    %set up serial
    s = serial('/dev/tty.usbmodem3595310')
    set(s,'BaudRate',115200)
    fopen(s)
    
    %open image
    MapImage = imread('Scale_Load.jpg');
    imshow(MapImage)
    hold on;
    
    %pixel to inch calibration and zeroing
    %click 0" line then +1" line
    [xscale1,yscale1] = ginput(1)
    plot(xscale1,yscale1,'g+')
    [xscale2,yscale2] = ginput(1)
    plot(xscale2,yscale2,'g+')
    ppi     = xscale2 - xscale1
    zero    = xscale1
    relpos  = 0
    
    %configure CNC controller box
    fprintf (s, 'G17 G20 G90 G94 G54')
    
    %loop 15 times to allow 15 position clicks on image
    for i = 1:15
        xmove = 0
        %click on scale to acquire point to move
        [xpos,ypos] = ginput(1)
    
        %scale point to vector from 0
        xmove = xpos - zero
        xmove = xmove/ppi
    
        %limit movement to +2"
        if (xmove > 2); xmove = 2; end;
    
        %limit movement to -2"
        if(xmove < -2); xmove = -2; end;
    
        %account for automatic absolute positioning
        relpos = relpos + xmove
        
        %create G code string
        CNCMotion = ['G1 x', num2str(relpos),' F10']
        
        %print G code string to axis control box
        fprintf (s,CNCMotion)
    end
    
    %close image and serial port
    close
    fclose(s)
catch ME
    fclose(s)
    ME.message
end