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
redChannel = im_crop(:,:,1);                                 
greenChannel = im_crop(:,:,2);  %fixed
blueChannel = im_crop(:,:,3);

%%Match Red and Green Channels
for i = -maxShift(1):maxShift(1)
    for j = -maxShift(1):maxShift(1)
        temp = circshift(redChannel, [i, j]);
        error = sum(sum((greenChannel-temp).^2));
        if min > error
            min = error;
            predShift(1,1) = -i;
            predShift(1,2) = -j;
            correctedGreenChannel = circshift(im(:,:,1), [i, j]);
        end
    end
end

min = 999999;
%%Match Green and Blue Channels
for i = -maxShift(2):maxShift(2)
    for j = -maxShift(2):maxShift(2)
        temp = circshift(blueChannel, [i, j]);
        error = sum(sum((greenChannel-temp).^2));
        if min > error
            min = error;
            predShift(2,1) = -i;
            predShift(2,2) = -j;
            correctedBlueChannel = circshift(im(:,:,3), [i, j]);
        end
    end
end

imShift = cat(3, correctedGreenChannel, im(:,:,2), correctedBlueChannel);

h = size(imShift,1);
w = size(imShift,2);
c = size(imShift,3);
c_img = imShift(1:floor(h/10), 1:floor(w/10), :);

vert = 0;
horz = 0;

for i = 1:c
    % Find edges
    temp = edge(c_img(:,:,i), 'canny', 0.1);
    
    % Find mean value and mask the values.
    vert_avg = mean(temp, 1);
    horz_avg = mean(temp, 2);
    threshold_1 = 3*mean(horz_avg);
    threshold_2 = 3*mean(vert_avg);
    vert_mask = vert_avg > threshold_2;
    horz_mask = horz_avg > threshold_1;
    
    % Find last values
    last_vert = find(vert_mask, 1, 'last');
    last_horz = find(horz_mask, 1, 'last');
    
    if last_vert > vert
        vert = last_vert;
    end
    if last_horz > horz
        horz = last_horz;
    end
end

imShift = imcrop(imShift, [horz vert (w-2*horz) (h-2*vert)]);