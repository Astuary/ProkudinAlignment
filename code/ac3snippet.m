%% Image we get after aligning three channels
imShift = cat(3, correctedGreenChannel, im(:,:,2), correctedBlueChannel);