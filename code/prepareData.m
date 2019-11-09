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

%% Subtracting ambience
output = imArray - ambientImage;

%% Negative values in the output matrix will be converted to zero
output(output<0) = 0;

%% To work with double datatypes [0, 1]; we must make sure that all the values are normalized with that range. Because after changing some negative values to 0, the pixel values we get will not be normalized as the range is getting changed with the lower limit getting converted to 0
output = rescale(output);