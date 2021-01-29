function [newX, newY] = iterate(Ainv, x, y, Eext, gamma, kappa)

% Get fx and fy
% external force is the derivative of Eext
[fx,fy] = gradient(Eext);
% Iterate
% use interp2() function for bilinear interpolation
% Vq=interp2(V,Xq,Yq)
x = x';
y = y';
newX = Ainv * (gamma * x + kappa * interp2(fx,x,y));
newY = Ainv * (gamma * y + kappa * interp2(fy,x,y));

% Clamp to image size

end

