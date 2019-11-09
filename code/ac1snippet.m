%% Crop the image so we don't consider boundary differences, since they will be under artifact effect
padding = floor([.2*size(im, 2), .2*size(im, 1), .6*size(im, 2), .6*size(im, 1)]);
im_crop = imcrop(im, padding);