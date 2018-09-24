%Load and show image
MapImage = imread('Homework_GoogleMap.png');
imshow(MapImage)

%pixel to mile calibration
%click both sides of scale
[xscale1,yscale1] = ginput(1)
[xscale2,yscale2] = ginput(1)
%calculate pixels in 5, 1 miles
FiveMilesInPixels = xscale2 - xscale1
OneMileInPixels   = FiveMilesInPixels/5;

%distance between lowell and boston in miles
%click lowell
[xLowell,yLowell] = ginput(1)
%click Boston
[xBOS,yBOS]       = ginput(1)
%change in x,y
xTravel = xLowell - xBOS;
yTravel = yLowell - yBOS;
%distance
pixDistance = sqrt(xTravel^2 + yTravel^2)
%pixels to miles
mileDistanceFlight = pixDistance/OneMileInPixels

%
[xroad,yroad] = ginput

