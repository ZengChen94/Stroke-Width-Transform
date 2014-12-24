function [width_img_1, width_img_2, img_copy_1, img_copy_2, img_copy] = swt(img_name)
    %grey = mapminmax(width_img_1, 0, 1);归一化
    %%
    img = imread(img_name);
    img_copy_1 = img;
    img_copy_2 = img;
    img_copy = img;
    img = rgb2gray(img); % 转化为灰色图像
    [a, b] = size(img);
    a = round(520 / b * a);
    b = 520;
    img = imresize(img, [a b]);
    img_copy_1 = imresize(img_copy_1, [a b]);
    img_copy_2 = imresize(img_copy_2, [a b]);
    img_copy = imresize(img_copy, [a b]);
    cannyResult = edge(img, 'canny'); % 调用canny函数 
    for i = 1 : 1 : a
        for j = 1 : 1 : b
            if cannyResult(i, j) == 1
                cannyResult(i, j) = 0;
            else
                cannyResult(i, j) = 1;
            end
        end
    end

    [a, b] = size(img); %height:a; width:b
    width_img_1 = zeros(a, b); %record width(swt)
    width_img_2 = zeros(a, b);
    grouping_img_1 = ones(a, b);%grouping
    grouping_img_2 = ones(a, b);
    block_img_1 = ones(a, b, 3);%show blocks
    block_img_2 = ones(a, b, 3);

    [gradx, grady]=gradient(double(img));
    %%
    %getWidth
    for i = 1 : 1 : a
        for j = 1 : 1 : b
            if cannyResult(i, j) == 0 %找到boundary edge
                width_img_1 = getWidth(gradx, grady, i, j, a, b, cannyResult, width_img_1);
            end
        end
    end
    for i = 1 : 1 : a
        for j = 1 : 1 : b
            if cannyResult(i, j) == 0
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
    arrayTop = 0;
    tot = 0;
    for i = 1 : 1 : num1
        temp = square1{i};
        tot = tot + (temp(3)-temp(1))*(temp(2)-temp(4));
    end
    median = tot / num1;
    for i = 1 : 1 : num1
        temp = square1{i};
        if (temp(3)-temp(1))*(temp(2)-temp(4)) > median / 10 && (temp(3)-temp(1))*(temp(2)-temp(4)) < a*b/2
            img_copy_1 = drawSquare(temp, img_copy_1);
            arrayTop = arrayTop + 1;
            square_array{arrayTop} = temp;
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
        if (temp(3)-temp(1))*(temp(2)-temp(4)) > median / 10 && (temp(3)-temp(1))*(temp(2)-temp(4)) < a*b/2
            img_copy_2 = drawSquare(temp, img_copy_2);
            arrayTop = arrayTop + 1;
            square_array{arrayTop} = temp;
        end
    end

    %%
    % subplot(1, 2, 1);
    % % imshow(grouping_img_1, []);
    % imshow(img_copy_1,[]);
    % title('img1');
    % subplot(1, 2, 2);
    % % imshow(grouping_img_2, []);
    % imshow(img_copy_2,[]);
    % title('img2');

    %%
    %filter the words out
    load model;
    whether_words = zeros(1, arrayTop);
    for i = 1 : 1 : arrayTop
        temp = square_array{i};
        top = temp(1);
        right = temp(2);
        bottom = temp(3);
        left = temp(4);
        temp_img = img_copy(top:bottom,left:right,1:3);
        temp_img = imresize(temp_img,[64, 64]);
        temp_img  = im2single(rgb2gray(temp_img ));
        hog = vl_hog(temp_img , 8 , 'verbose');
        hog = hog(:);
        if i == 1
            words_inst = hog';
            words_label = 1;
        else
            words_inst = [words_inst; hog'];
            words_label = [words_label; 1];
        end
    end
    [predict_label, accuracy, dec_values] =svmpredict(double(words_label), double(words_inst), model); 
    %%
    %gather words into phrase
    [final_array, num, result] = finalArray(square_array, arrayTop, predict_label);
    %%
    %draw out out the result
    for i = 1 : 1 : num
        img_copy = drawSquare(final_array{i}, img_copy);
    end

%     imshow(img_copy, []);

%     run('vl_setup');
end
