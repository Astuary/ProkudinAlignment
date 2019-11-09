function [imShift, predShift] = alignChannels(im, maxShift)
% ALIGNCHANNELS align channels in an image.
%   [IMSHIFT, PREDSHIFT] = ALIGNCHANNELS(IM, MAXSHIFT) aligns the channels in an
%   NxMx3 image IM. The first channel is fixed and the remaining channels
%   are aligned to it within the maximum displacement range of MAXSHIFT (in
%   both directions). The code returns the aligned image IMSHIFT after
%   performing this alignment. The optimal shifts are returned as in
%   PREDSHIFT a 2x2 array. PREDSHIFT(1,:) is the shifts  in I (the first) 
%   and J (the second) dimension of the second channel, and PREDSHIFT(2,:)
%   are the same for the third channel.
%
% This code is part of:
%
%   CMPSCI 670: Computer Vision, Fall 2016
%   University of Massachusetts, Amherst
%   Instructor: Subhransu Maji
%
%   Homework 1: Color images
%   Author: Subhransu Maji


% Sanity check
assert(size(im,3) == 3);
assert(all(maxShift > 0));

% Dummy implementation (replace this with your own)
predShift = zeros(2, 2);

padding = floor([.2*size(im, 2), .2*size(im, 1), .6*size(im, 2), .6*size(im, 1)]);
im_crop = imcrop(im, padding);

min = 999999;
redChannel = im_crop(:,:,1);                                 %fix it
greenChannel = im_crop(:,:,2);                           
blueChannel = im_crop(:,:,3);

%%Match Red and Green Channels
for i = -maxShift(1):maxShift(1)
    for j = -maxShift(1):maxShift(1)
        temp = circshift(greenChannel, [i, j]);
        error = sum(sum((redChannel-temp).^2));
        if min > error
            min = error;
            predShift(1,1) = -i;
            predShift(1,2) = -j;
            correctedGreenChannel = circshift(im(:,:,2), [i, j]);
        end
    end
end

min = 999999;
%%Match Red and Blue Channels
for i = -maxShift(2):maxShift(2)
    for j = -maxShift(2):maxShift(2)
        temp = circshift(blueChannel, [i, j]);
        error = sum(sum((redChannel-temp).^2));
        if min > error
            min = error;
            predShift(2,1) = -i;
            predShift(2,2) = -j;
            correctedBlueChannel = circshift(im(:,:,3), [i, j]);
        end
    end
end

imShift = cat(3, im(:,:,1), correctedGreenChannel, correctedBlueChannel);