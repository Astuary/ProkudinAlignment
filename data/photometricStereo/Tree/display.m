images = dir('TreeA*.pgm');

figure;
for i = 1:64
    I= imread(images(i).name);
    subplot(4, 16, i);
    imshow(I);
end