function [x, y] = initializeSnake(I)
% Show figure
%clear all;
%f = figure;
%I = imread('circle.jpg');
imshow(I);
%[xi,yi]
[xp,yp] = getpts;
% Get initial points
P=[xp(:) yp(:)];
%add first pt to the matrix to make sure it is forms a closed loop
firstP=[xp(1) yp(1)];
xy = [P; firstP];
x1 = xy(:,1);
y1 = xy(:,2);
n = length(xy);
%use interp1
stepSize = 150;
s = 1:n;
ss = 1:1/stepSize:n;
%Interpolation, using linear interpolation
yy = interp1(s,xy,ss);
x = yy(:,1);
y = yy(:,2);
hold on;
plot(xp,yp,'o',x,y,'r-');
% Clamp points to be inside of image

end

