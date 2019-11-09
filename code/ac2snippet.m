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