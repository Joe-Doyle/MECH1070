try
    close all
    clear
    
    videoFrames = VideoReader('lab1video.m4v');
    
    NFrames = 83;
    
    for(i = 3:4:NFrames)
       figure
       
       currentVideoFrame = read(videoFrames, i);
       imshow(currentVideoFrame(:,:,:,1))
       
       [x,y] = ginput(2);
       
       hold on;
       plot(x,y, 'r-o')
       
       frameNumber = i
       title(['Video Frame', num2str(frameNumber)])
       pause(0.2)
       
       Lx = x(2) - x(1);
       Ly = y(2) - y(1);
       
       theta(i) = atan2d(Ly, Lx)
       time(i) = i*1/60;
       
       pause(0.1);
end
    
    theta(theta==0) = [];
    time(time==0) = [];
    
    figure;
    a = axes
    set(a,'fontsize',18,'fontname','times')
    a = plot(time, theta,'s-')
    set(a,'linewidth',2,'color','r','markersize',6)
    grid on
    a = xlabel('Time [s]')
    set(a,'fontsize',18,'fontname','times')
    a = ylabel('Angle, [deg]')
    set(a,'fontsize',18,'fontname','times')
    
    %processing angular velocity
    for(i = 1:(length(theta)-1))
        angularVel(i) = (theta(i+1)-theta(i))/(1/60);
        timeAngVel(i) = i*(1/60)
    end
    
    figure;
    a = axes
    set(a,'fontsize',18,'fontname','times')
    a = plot(timeAngVel, angularVel,'>-')
    set(a,'linewidth',2,'color','b','markersize',6)
    grid on
    a = xlabel('Time [s]')
    set(a,'fontsize',18,'fontname','times')
    a = ylabel('Angular Velocity, [deg/s]')
    set(a,'fontsize',18,'fontname','times')
    
    %processing angular acceleration
    for(i = 1:(length(angularVel)-1))
        angularAcc(i) = (angularVel(i+1)-angularVel(i))/(1/60);
        timeAngAcc(i) = i*(1/60)
    end
    
    figure;
    a = axes
    set(a,'fontsize',18,'fontname','times')
    a = plot(timeAngAcc, angularAcc,'>-')
    set(a,'linewidth',2,'color','b','markersize',6)
    grid on
    a = xlabel('Time [s]')
    set(a,'fontsize',18,'fontname','times')
    a = ylabel('Angular Acceleration, [deg/s^2]')
    set(a,'fontsize',18,'fontname','times')
    
catch ME
    ME.message
end