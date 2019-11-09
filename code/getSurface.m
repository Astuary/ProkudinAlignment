function  heightMap = getSurface(surfaceNormals, method)
% GETSURFACE computes the surface depth from normals
%   HEIGHTMAP = GETSURFACE(SURFACENORMALS, IMAGESIZE, METHOD) computes
%   HEIGHTMAP from the SURFACENORMALS using various METHODs. 
%  
% Input:
%   SURFACENORMALS: height x width x 3 array of unit surface normals
%   METHOD: the intergration method to be used
%
% Output:
%   HEIGHTMAP: height map of object

[h, w, channel] = size(surfaceNormals);
temp = zeros(h, w);
temp1 = zeros(h, w);
fx = surfaceNormals(:,:,1)./surfaceNormals(:,:,3);
fy = surfaceNormals(:,:,2)./surfaceNormals(:,:,3);
xsum = cumsum(fx,2);
ysum = cumsum(fy);

switch method
    case 'column'
        % cumulative sum of fx over columns (the second argument depicts dimension #2, which is columns)
        temp(1,2:w) = cumsum(fx(1,2:w),2);
        % we just copy the whole fy from 2nd row afterwards
        temp(2:h,:) = fy(2:h,:);
        % the depth map will be the cumulative sum over rows of the both previous results shown in matrix form
        heightMap = cumsum(temp);
        
    case 'row'
        %heightMap = cumsum(surfaceNormals(:,:,1), 1) + cumsum(surfaceNormals(:,:,2), 2);
        % cumulative sum of fy over rows (the second argument depicts dimension #11, which is rows)
        temp(2:h,1) = cumsum(fy(2:h,1));
        % we just copy the whole fx from 2nd column afterwards
        temp(:,2:w) = fx(:,2:w);
        % the depth map will be the cumulative sum over columns of the both previous results in matrix form
        heightMap = cumsum(temp,2);
        
    case 'average'
        temp(2:h,1) = cumsum(fy(2:h,1));
        temp(:,2:w) = fx(:,2:w);
        
        temp1(1,2:w) = cumsum(fx(1,2:w));
        temp1(2:h,:) = fy(2:h,:);
        
        heightMap = (cumsum(temp1)+cumsum(temp,2))./2;
        
    case 'random'
        heightMap(2:h,1) = ysum(2:h,1);
        heightMap(1,2:w) = xsum(1,2:w);
        
        for i = 2:h
            for j = 1:w
                t = 0;
                s = 0;
                
                for k = 1:i-1
                    if j-k >= 1
                        t = t+ysum(1+k)+xsum(1+k,j-k)+ysum(i,j-k)-ysum(1+k,j-k)+xsum(i,j)-xsum(i,j-k);
                        s= s+1;
                    end
                end
                
                if i==2 || i== h || k == i 
                    t = t+ysum(i,1)+xsum(i,j);
                    s = s+1;
                end
                
                heightMap(i,j) = t/s;
            end
        end
end

