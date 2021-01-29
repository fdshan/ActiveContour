function [Eext] = getExternalEnergy(I,Wline,Wedge,Wterm)
%Wline = 0.5;
%Wedge = 1.0;
%Wterm = 0.5;
%I_smooth = imread('circle.jpg');
%I = double(imgaussfilt(I_smooth, sigma));
% Eline, intensity of image, the image itself
Eline = I;

% Eedge 
[Gx,Gy] = imgradient(I);
Eedge = -1*sqrt((Gx.*Gx + Gy.*Gy));
% Eterm, using conv function
% first derivative
% f'(x)=f(x+1)-f(x)   f'(y)=f(y+1)-f(y)
mx = [-1 1];
my = [-1;1];
Ix = conv2(I,mx,'same');
Iy = conv2(I,my,'same');
Ix2 = Ix.*Ix;
Iy2 = Iy.*Iy;

% second derivative
% fxx=f'(x+1)-f'(x)=f(x+2)-f(x+1)-f(x+1)+f(x)=f(x+2)-2f(x+1)+f(x)
% fyy=f'(y+1)-f'(y)=f(y+2)-f(y+1)-f(y+1)+f(y)=f(y+2)-2f(y+1)+f(y)
% fxy=f(x+1,y+1)-f(x+1,y)-f(x,y+1)+f(x,y)
mxx = [1 -2 1];
myy = [1;-2;1];
mxy = [1 -1;-1 1];
Ixx = conv2(I,myy,'same');
Iyy = conv2(I,myy,'same');
Ixy = conv2(I,mxy,'same');

% calculate Eterm
Eterm = (Iyy.*Ix.*Ix - 2.*Ixy.*Ix.*Iy + Ixx.*Iy.*Iy)./((1 + Ix.*Ix + Iy.*Iy).^1.5);

% Eext
Eext = Wline * Eline + Wedge * Eedge + Wterm * Eterm;
%fprintf('Eext=%d',Eext);
end

