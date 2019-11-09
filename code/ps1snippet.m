% Loop through all pixels of the image
for i = 1:h
    for j = 1:w
        % Got a particular pixel at (i, j) from all the images
        I = imArray(i, j, 1:n); 
        % Converted into a n x 1 column vector 
        I = I(:); 
        % Calculated g of I(column matrix of pixel values) = V(light directions) * g
        g(i,j,:) = I\lightDirs; 
        % Calculated the magnitude of g to get the albedo pixel values p(x, y) = |g(x, y)|
        p(i,j) = sqrt(g(i,j,1)^2 + g(i,j,2)^2 + g(i,j,3)^2); 
        
        % To calculate surface normals
        fx = g(i, j, 1)/g(i, j, 3); % Partial derivative of the surface with respect to x              
        fy = g(i, j, 2)/g(i, j, 3); % Partial derivative of the surface with respect to y
        temp = sqrt(fx^2 + fy^2 + 1); % Magnitude 
        % N(x, y) = (fx, fy, 1)/sqrt(fx^2 + fy^2 + 1)
        surfaceNormals(i, j, :) = [fx/temp, fy/temp, 1/temp]; 
    end
end
% Now we got albedo and surface normal for each pixel in image