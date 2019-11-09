% To calculate surface normals
fx = g(i, j, 1)/g(i, j, 3); % Partial derivative of the surface with respect to x              
fy = g(i, j, 2)/g(i, j, 3); % Partial derivative of the surface with respect to y
temp = sqrt(fx^2 + fy^2 + 1); % Magnitude 
% N(x, y) = (fx, fy, 1)/sqrt(fx^2 + fy^2 + 1)
surfaceNormals(i, j, :) = [fx/temp, fy/temp, 1/temp];