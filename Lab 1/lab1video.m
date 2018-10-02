try
    close all %close previous frames
    clear %clear variables
    
    videoFrames = VideoReader('lab1video.m4v'); %specify input video
    
    %analyzation configuration block
    inputFPS = 240;          %specify input video native fps
    analyzeEveryXFrames = 4; %specify how many frames you want to skip between analyzation frames
    analyzeXFrames = 20;     %specify how many frames you want to analyze
    startAtFrameX = 3;       %specify what frame to start at
    
    fps = inputFPS/analyzeEveryXFrames %calculate new fps from input fps and how many frames will be skipped
    NFrames = startAtFrameX+(analyzeXFrames*analyzeEveryXFrames); %calculate NFrames for the for loop
    
    %iterate through frames to analyze
    for(i = startAtFrameX:analyzeEveryXFrames:NFrames)
       figure
       currentVideoFrame = read(videoFrames, i);
       imshow(currentVideoFrame(:,:,:,1))
       
       [x,y] = ginput(2); %click points on tape to determine angle
       
       hold on;
       plot(x,y, 'r-o') %plot clicked points on frame for peace of mind
       
       frameNumber = i
       title(['Video Frame', num2str(frameNumber)])
       pause(0.2)
       
       %determine change in x and y between points
       Lx = x(2) - x(1);
       Ly = y(2) - y(1);
       
       %determine angle between points
       theta(i) = atan2d(Ly, Lx)
       time(i) = i*(1/fps);
       
       pause(0.1);
    end
    
    theta(theta==0) = []; %clear zeros from theta array if any from skipped frames
    time(time==0) = [];   %clear zeros from time array if any from skipped frames
    
    %plot angle and save as png
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
    a = title('Line Plot of Angle Vs. Time')
    set(a,'fontsize',18,'fontname','times')
    print('-dpng','-r300','angle.png')
    
    %process angular velocity
    for(i = 1:(length(theta)-1))
        angularVel(i) = (theta(i+1)-theta(i))/(1/fps);
        timeAngVel(i) = i*(1/fps)
    end
    
    %plot angular velocity and save as png
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
    a = title('Line Plot of Angular Velocity Vs. Time')
    set(a,'fontsize',18,'fontname','times')
    print('-dpng','-r300','angularVelocity.png')
    
    %process angular acceleration
    for(i = 1:(length(angularVel)-1))
        angularAcc(i) = (angularVel(i+1)-angularVel(i))/(1/fps);
        timeAngAcc(i) = i*(1/fps)
    end
    
    %plot angular acceleration and save as png
    figure;
    a = axes
    set(a,'fontsize',18,'fontname','times')
    a = plot(timeAngAcc, angularAcc,'>-')
    set(a,'linewidth',2,'color','g','markersize',6)
    grid on
    a = xlabel('Time [s]')
    set(a,'fontsize',18,'fontname','times')
    a = ylabel('Angular Acceleration, [deg/s^2]')
    set(a,'fontsize',18,'fontname','times')
    a = title('Line Plot of Angular Acceleration Vs. Time')
    set(a,'fontsize',18,'fontname','times')
    print('-dpng','-r300','angularAcceleration.png')
    
catch ME
    ME.message
end