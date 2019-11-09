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
        %%% implement this %%%
        temp(1,2:w) = cumsum(fx(1,2:w),2);
        temp(2:h,:) = fy(2:h,:);
        heightMap = cumsum(temp);
        
    case 'row'
        %%% implement this %%%
        %heightMap = cumsum(surfaceNormals(:,:,1), 1) + cumsum(surfaceNormals(:,:,2), 2);
        temp(2:h,1) = cumsum(fy(2:h,1));
        temp(:,2:w) = fx(:,2:w);
        heightMap = cumsum(temp,2);
        
    case 'average'
        %%% implement this %%%
        temp(2:h,1) = cumsum(fy(2:h,1));
        temp(:,2:w) = fx(:,2:w);
        
        temp1(1,2:w) = cumsum(fx(1,2:w));
        temp1(2:h,:) = fy(2:h,:);
        
        heightMap = (cumsum(temp1)+cumsum(temp,2))./2;
        
    case 'random'
        %%% implement this %%%
        heightMap(2:h,1) = ysum(2:h,1);
        heightMap(1,2:w) = xsum(1,2:w);
        
        for i = 2:h
            for j = 1:w
                t = 0;
                k = 0;
                
                for p = 1:i-1
                    if j-p >= 1
                        t = t+ysum(1+p)+xsum(1+p,j-p)+ysum(i,j-p)-ysum(1+p,j-p)+xsum(i,j)-xsum(i,j-p);
                        k= k+1;
                    end
                end
                
                if i==2 || i== h || p == i 
                    t = t+ysum(i,1)+xsum(i,j);
                    k = k+1;
                end
                
                heightMap(i,j) = t/k;
            end
        end
end

