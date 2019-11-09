
images = dir('A*.png');
for i = 1:64

    filePath = 'C:\Users\Panchal''s\Pictures\Screenshots\Tree';

    image = imread(fullfile(filePath, images(i).name));
    %figure;
    imwrite(imcrop(image, [355, 218, 348, 685]), sprintf('Tree%s',images(i).name));
    
end

image = imread(fullfile(filePath, '_Ambient.png'));
imwrite(imcrop(image, [355, 218, 348, 685]), sprintf('Tree%s','_Ambient.png'));