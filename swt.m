clear all;close all;clc;

%grey = mapminmax(width_img_1, 0, 1);归一化
%%
img = imread('pic.JPG');
% img = imread('abc.jpg'); % 读入图像
% img = imresize(img, [391, 521]);
img = rgb2gray(img); % 转化为灰色图像
[a, b] = size(img);
cannyResult = edge(img, 'canny'); % 调用canny函数 
for i = 1:1:a
    for j = 1:1:b
        if cannyResult(i, j) == 1
            cannyResult(i, j) = 0;
        else
            cannyResult(i, j) = 1;
        end
    end
end
% cannyResult = imread('cannyResult.jpg');
% cannyResult = imread('abcCanny.jpg'); 
% cannyResult = rgb2gray(cannyResult);

% thresh=[0.01,0.17]; 
% sigma=2;%定义高斯参数    
% cannyResult = edge(double(img),'canny',thresh,sigma);  

img_copy_1 = imread('pic.JPG');
img_copy_2 = imread('pic.JPG');
% img_copy_1 = imread('abc.jpg');
% img_copy_2 = imread('abc.jpg');
[a, b] = size(img); %height:a; width:b
width_img_1 = zeros(a, b); %record width(swt)
width_img_2 = zeros(a, b);
grouping_img_1 = ones(a, b);%grouping
grouping_img_2 = ones(a, b);
gradShow_img_1 = ones(a, b);%show the direction of grad
gradShow_img_2 = ones(a, b);
temp1 = zeros(a,b);%show the edge
temp2 = zeros(a,b);
result_img_1 = ones(a, b);
result_img_2 = ones(a, b);
block_img_1 = zeros(a, b, 3);%show blocks
block_img_2 = zeros(a, b, 3);
% hx = [-1 -2 -1;0 0 0 ;1 2 1]; %生产sobel垂直梯度模板
% hy = hx'; %生产sobel水平梯度模板
% gradx = filter2(hx, img, 'same');
% grady = filter2(hy, img, 'same');

[gradx, grady]=gradient(double(img));
%%
%getWidth
for i = 1 : 1 : a
    for j = 1 : 1 : b
        if cannyResult(i, j) == 0 %找到boundary edge
            temp1(i, j) = 1;
            width_img_1 = getWidth(gradx, grady, i, j, a, b, cannyResult, width_img_1);
        end
    end
end
for i = 1 : 1 : a
    for j = 1 : 1 : b
        if cannyResult(i, j) == 0
            temp2(i, j) = 1;
            width_img_2 = getWidth(-gradx, -grady, i, j, a, b, cannyResult, width_img_2);
        end
    end
end
%%
%adjustCorner
for i = 1 : 1 : a
    for j = 1 : 1 : b
        if cannyResult(i, j) == 0
            width_img_1 = adjustCorner(gradx, grady, i, j, a, b, cannyResult, width_img_1);
        end
    end
end
for i = 1 : 1 : a
    for j = 1 : 1 : b
        if cannyResult(i, j) == 0
            width_img_2 = adjustCorner(-gradx, -grady, i, j, a, b, cannyResult, width_img_2);
        end
    end
end
%%
%grouping
%square: array containing squares
%num: num of squares
[grouping_img_1, square1, num1, block_img_1] = grouping(width_img_1, grouping_img_1, a, b);
[grouping_img_2, square2, num2, block_img_2] = grouping(width_img_2, grouping_img_2, a, b);
%%
%removePoint
for i = 2 : 1 : a-1
    for j = 2 : 1 : b-1
        if grouping_img_1(i, j) == 0 
            result_img_1(i, j) = 0;
            result_img_1 = removePoint(result_img_1, grouping_img_1, i, j);
        end
    end
end

for i = 2 : 1 : a-1
    for j = 2 : 1 : b-1
        if grouping_img_2(i, j) == 0
            result_img_2(i, j) = 0;
            result_img_2 = removePoint(result_img_2, grouping_img_2, i, j);
        end
    end
end
%%
%gradShow
% for i = 1 : 1 : a
%     for j = 1 : 1 : b
%         if cannyResult(i, j) < 200
%             gradShow_img_1 = gradShow(gradShow_img_1, gradx, grady, i, j, a, b);
%         end
%     end
% end
% 
% for i = 1 : 1 : a
%     for j = 1 : 1 : b
%         if cannyResult(i, j) < 200
%             gradShow_img_2 = gradShow(gradShow_img_2, -gradx, -grady, i, j, a, b);
%         end
%     end
% end
%%
tot = 0;
for i = 1 : 1 : num1
    temp = square1{i};
    tot = tot + (temp(3)-temp(1))*(temp(2)-temp(4));
end
median = tot / num1;
for i = 1 : 1 : num1
    temp = square1{i};
    if (temp(3)-temp(1))*(temp(2)-temp(4)) > median / 10
        img_copy_1 = drawSquare(temp, img_copy_1);
    end
end

tot = 0;
for i = 1 : 1 : num2
    temp = square2{i};
    tot = tot + (temp(3)-temp(1))*(temp(2)-temp(4));
end
median = tot / num2;
for i = 1 : 1 : num2
    temp = square2{i};
    if (temp(3)-temp(1))*(temp(2)-temp(4)) > median / 10
        img_copy_2 = drawSquare(temp, img_copy_2);
    end
end

%%
subplot(1, 2, 1);
% imshow(grouping_img_1, []);
imshow(img_copy_1,[]);
title('img1');
subplot(1, 2, 2);
% imshow(grouping_img_2, []);
imshow(img_copy_2,[]);
title('img2');

run('vl_setup');
