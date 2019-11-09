function output = prepareData(imArray, ambientImage)
% PREPAREDATA prepares the images for photometric stereo
%   OUTPUT = PREPAREDATA(IMARRAY, AMBIENTIMAGE)
%
%   Input:
%       IMARRAY - [h w n] image array
%       AMBIENTIMAGE - [h w] image 
%
%   Output:
%       OUTPUT - [h w n] image, suitably processed
%
% Author: Subhransu Maji
%

% Implement this %
% Step 1. Subtract the ambientImage from each image in imArray
% Step 2. Make sure no pixel is less than zero
% Step 3. Rescale the values in imarray to be between 0 and 1

%% Displaying all the images and the ambient image in the end just for
% debugging purposes
% [h w n] = size(imArray);
% figure;
% for i = 1:n
%     subplot(floor((n+10)/10),10,i); 
%     imshow(imArray(:,:,i));
% end
% 
% subplot(floor((n+10)/10),10,n+1);
% imshow(ambientImage);
%Display ends

%% Subtracting albedo
output = imArray - ambientImage;

%% Displaying the images after subtracting albedo from it
% figure;
% for i = 1:n
%     subplot(floor((n+10)/10),10,i); 
%     imshow(output(:,:,i));
% end

%% Logging into a text file just to evaluate data manually and debug
%diary my_log.txt
%imArray(:,:,1)
%ambientImage
%output(:,:,1)
%diary off;

%% Negative values in the output matrix will be converted to zero
output(output<0) = 0;

%% The output bring in uint8, won't get rescaled in floating point between 0 and 1; 
% so first convert it to double, then rescale it
output = rescale(double(output));