case 'average'
        temp(2:h,1) = cumsum(fy(2:h,1));
        temp(:,2:w) = fx(:,2:w);
        
        temp1(1,2:w) = cumsum(fx(1,2:w));
        temp1(2:h,:) = fy(2:h,:);
        
        heightMap = (cumsum(temp1)+cumsum(temp,2))./2;