%% Final result, cropped the boundaries calculates by taking mean and creating a mask
imShift = imcrop(imShift, [horz vert (w-2*horz) (h-2*vert)]);