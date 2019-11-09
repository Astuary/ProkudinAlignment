case 'column'
        % cumulative sum of fx over columns (the second argument depicts dimension #2, which is columns)
        temp(1,2:w) = cumsum(fx(1,2:w),2);
        % we just copy the whole fy from 2nd row afterwards
        temp(2:h,:) = fy(2:h,:);
        % the depth map will be the cumulative sum over rows of the both previous results shown in matrix form
        heightMap = cumsum(temp);