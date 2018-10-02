try
    close all
    
    
    videoFrames = VideoReader('lab1video.m4v');
    
    NFrames = 10;
    
    for(i = 1:NFrames)
       figure
       
       currentVideoFrame = read(videoFrames, i);
       
       imshow(currentVideoFrame(:,:,:,1))
       frameNumber = i
       pause(0.2)
       
       
    end
    
    
    
    
    
    
    
catch ME
    ME.message
end