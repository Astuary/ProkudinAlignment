case 'row'
        %heightMap = cumsum(surfaceNormals(:,:,1), 1) + cumsum(surfaceNormals(:,:,2), 2);
        % cumulative sum of fy over rows (the second argument depicts dimension #11, which is rows)
        temp(2:h,1) = cumsum(fy(2:h,1));
        % we just copy the whole fx from 2nd column afterwards
        temp(:,2:w) = fx(:,2:w);
        % the depth map will be the cumulative sum over columns of the both previous results in matrix form
        heightMap = cumsum(temp,2);