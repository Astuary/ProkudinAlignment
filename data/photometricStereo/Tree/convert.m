images = dir('*.png');
for i = 1: size(images)
    % Create sample filename.
    filename = images(i).name;
    [folder, baseFileName, extension] = fileparts(filename);
    % Ignore extension and replace it with .txt
    newBaseFileName = sprintf('%s.pgm', baseFileName);
    % Make sure the folder is prepended (if it has one).
    newFullFileName = fullfile(folder, newBaseFileName);
    imwrite(imread(images(i).name), newFullFileName);
end