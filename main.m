clear all;close all;clc;

% last = 233;
last = 2;

for i = 1:last
    img_name = ['testData/img_', int2str(i), '.jpg'];
    [width_img_1, width_img_2, img_copy_1, img_copy_2, img_copy] = swt(img_name);
    width_name_1 = ['testOutput/width_', int2str(i), '_1.jpg'];
    width_name_2 = ['testOutput/width_', int2str(i), '_2.jpg'];
    copy_name_1 = ['testOutput/copy_', int2str(i), '_1.jpg'];
    copy_name_2 = ['testOutput/copy_', int2str(i), '_2.jpg'];
    copy_name = ['testOutput/copy_', int2str(i), '.jpg'];
    imwrite(width_img_1, width_name_1);
    imwrite(width_img_2, width_name_2);
    imwrite(img_copy_1, copy_name_1);
    imwrite(img_copy_2, copy_name_2);
    imwrite(img_copy, copy_name);
    fprintf('No.%d img finished\n', i);
end
% img = imread(img_name);
% imshow(img);