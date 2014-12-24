clc; clear all;

t = 0;
for i = 100 : 328
    img_filename = ['trainData/', int2str(i), '.jpg'];
    image = imread(img_filename);
    gt_filename = ['trainData/', int2str(i), '_GT.txt'];
    fid = fopen(gt_filename, 'r');
    BoundingBoxes = textscan(fid, '%d %d %d %d %d %d %d %d %d %*[^\n]', 'CollectOutput', 1);
    BoundingBoxes = BoundingBoxes{1};
    fclose(fid);
    
    num = size(BoundingBoxes);
    num = num(1);
    
    for j = 1 : 1 : num
        try
            temp_img = image(BoundingBoxes(j,7):BoundingBoxes(j,9),BoundingBoxes(j,6):BoundingBoxes(j,8),1:3);
        catch
            break;
        end
        [a, b] = size(image);
        temp_1 = randint(1,1,[1 a]);
        temp_2 = randint(1,1,[1 a]);
        temp_top = min(temp_1, temp_2);
        temp_bottom = max(temp_1, temp_2);
        temp_3 = randint(1,1,[1 b/3]);
        temp_4 = randint(1,1,[1 b/3]);
        temp_left = min(temp_3, temp_4);
        temp_right = max(temp_3, temp_4);
        temp_img_not = image(temp_top:temp_bottom, temp_left:temp_right, 1:3);
        t = t + 1;
        temp_img = imresize(temp_img,[64, 64]);
        temp_img  = im2single(rgb2gray(temp_img ));
        hog = vl_hog(temp_img , 8 , 'verbose');
        hog = hog(:);
        hog = hog';
        temp_img_not = imresize(temp_img_not,[64, 64]);
        temp_img_not  = im2single(rgb2gray(temp_img_not ));
        hog_not = vl_hog(temp_img_not , 8 , 'verbose');
        hog_not = hog_not(:);
        hog_not = hog_not';
        if t == 1
            words_inst = hog;
            words_label = 1;
            words_inst = [words_inst; hog_not];
            words_label = [words_label; -1];
        else
            words_inst = [words_inst; hog];
            words_label = [words_label; 1];
            words_inst = [words_inst; hog_not];
            words_label = [words_label; -1];
        end
    end
end;
words_inst = double(words_inst);
model = svmtrain(words_label,words_inst);
save('model.mat','model');
% [predict_label, accuracy, dec_values] =svmpredict(words_label, words_inst, model); 