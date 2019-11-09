function [albedoImage, surfaceNormals] = photometricStereo(imArray, lightDirs)
% PHOTOMETRICSTEREO compute intrinsic image decomposition from images
%   [ALBEDOIMAGE, SURFACENORMALS] = PHOTOMETRICSTEREO(IMARRAY, LIGHTDIRS)
%   comptutes the ALBEDOIMAGE and SURFACENORMALS from an array of images
%   with their lighting directions. The surface is assumed to be perfectly
%   lambertian so that the measured intensity is proportional to the albedo
%   times the dot product between the surface normal and lighting
%   direction. The lights are assumed to be of unit intensity.
%
%   Input:
%       IMARRAY - [h w n] array of images, i.e., n images of size [h w]
%       LIGHTDIRS - [n 3] array of unit normals for the light directions
%
%   Output:
%        ALBEDOIMAGE - [h w] image specifying albedos
%        SURFACENORMALS - [h w 3] array of unit normals for each pixel
%
% Author: Subhransu Maji
%
% Acknowledgement: Based on a similar homework by Lana Lazebnik


%%% implement this %% 
[h, w, n] = size(imArray);
g = zeros(h,w,3);                                               % g(x, y) = rho(x, y)*N(x, y) or p(x, y)*N(x, y). The unknown
p = zeros(h,w);                                                 % rho. Albedo.
surfaceNormals = zeros(h,w,3);                                  % Surface Normal

% Loop through all pixels of the image
for i = 1:h
    for j = 1:w
        I = imArray(i, j, 1:n);                                 % Got a particular pixel at (i, j) from all the images
        I = I(:);                                               % Converted into a n x 1 column vector 
        g(i,j,:) = I\lightDirs;                                 % Calculated g of I(column matrix of pixel values) = V(light directions) * g
        p(i,j) = sqrt(g(i,j,1)^2 + g(i,j,2)^2 + g(i,j,3)^2);    % Calculated the magnitude of g to get the albedo pixel values p(x, y) = |g(x, y)|
        
        % To calculate surface normals
        fx = g(i, j, 1)/g(i, j, 3);                             % Partial derivative of the surface with respect to x              
        fy = g(i, j, 2)/g(i, j, 3);                             % Partial derivative of the surface with respect to y
        temp = sqrt(fx^2 + fy^2 + 1);                           % Magnitude 
        surfaceNormals(i, j, :) = [fx/temp, fy/temp, 1/temp];                % N(x, y) = (fx, fy, 1)/sqrt(fx^2 + fy^2 + 1)
    end
end
% Now we got albedo and surface normal for each pixel in image

%% Debugging  
% figure;
% imshow(g(:,:,1));
% figure;
% imshow(g(:,:,2));
% figure;
% imshow(g(:,:,3));
% figure;
% imshow(g);
% figure;
% imshow(imcomplement(rescale(p)));

%% Albedo Image
albedoImage = imcomplement(rescale(p));                         % Some pixel values will be out of [0, 1] because of matrix divisions. Rescale them to [0, 1]. The result will be inverted, complement the values.
% for i = 1:h
%     for j = 1:w
%         %N(i, j, :) = g(i, j, :)/albedoImage(i, j);
%     end
% end
                                                                         
%%
% figure;
% imshow(N(:,:,1));
% class(N(:,:,1));
% figure;
% imshow(N(:,:,2));
% figure;
% imshow(N(:,:,3));
% figure;
% imshow(N);
