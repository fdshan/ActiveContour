clear all;

% Parameters (play around with different images and different parameters)
N = 500;
alpha = 5;
beta = 4;
gamma = 0.1;
kappa = 0.01;
Wline = 0.3;
Wedge = 0.7;
Wterm = 0.3;
sigma = 0.5;

% Load image
I = imread('dental.png');
if (ndims(I) == 3)
    I = rgb2gray(I);
end

% Initialize the snake
[x, y] = initializeSnake(I);
x=x';
y=y';
% Calculate external energy
I_smooth = double(imgaussfilt(I, sigma));
Eext = getExternalEnergy(I_smooth,Wline,Wedge,Wterm);

% Calculate matrix A^-1 for the iteration
Ainv = getInternalEnergyMatrix(size(x,2), alpha, beta, gamma);

% Iterate and update positions
displaySteps = floor(N/10);
for i=1:N
    % Iterate
    [x,y] = iterate(Ainv, x, y, Eext, gamma, kappa);

    % Plot intermediate result
    imshow(I); 
    hold on;
    x = x';
    y = y';
    plot([x x(1)], [y y(1)], 'r');
        
    % Display step
    if(mod(i,displaySteps)==0)
        fprintf('%d/%d iterations\n',i,N);
    end
    
    pause(0.0001)
end
 
if(displaySteps ~= N)
    fprintf('%d/%d iterations\n',N,N);
end