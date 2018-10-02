try
    close all
    clear
    
    videoFrames = VideoReader('lab1video.m4v');
    
    NFrames = 83;
    
    for(i = 3:8:NFrames)
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
       time(i) = i*1/240;
       
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
    
catch ME
    ME.message
end