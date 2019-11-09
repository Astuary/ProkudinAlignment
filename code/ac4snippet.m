h = size(imShift,1);    %height
w = size(imShift,2);    %width
c = size(imShift,3);    %channels
c_img = imShift(1:floor(h/10), 1:floor(w/10), :);

vert = 0;
horz = 0;

% For all 3 channels
for i = 1:c
    % Find edges
    temp = edge(c_img(:,:,i), 'canny', 0.1);    %Detect edges
    
    % Find mean value and mask the values.
    vert_avg = mean(temp, 1);      %find the average of vertical boundaries
    horz_avg = mean(temp, 2);      %find the average of horizontal boundaries
    threshold_1 = 3*mean(horz_avg); % got horizontal threshold
    threshold_2 = 3*mean(vert_avg); % got vertical threshold
    % only consider the pixels which are higher valued than vertical threshold
    vert_mask = vert_avg > threshold_2; 
    % only consider the pixels which are higher valued than horizontal threshold
    horz_mask = horz_avg > threshold_1;
    
    % Find last values
    last_vert = find(vert_mask, 1, 'last');
    last_horz = find(horz_mask, 1, 'last');
    
    if last_vert > vert
        vert = last_vert;
    end
    if last_horz > horz
        horz = last_horz;
    end
end