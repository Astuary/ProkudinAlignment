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