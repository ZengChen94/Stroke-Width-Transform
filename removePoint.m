function result_img = removePoint(result_img, grouping_img, i, j)
    cnt = 0;
    if grouping_img(i, j+1) == 0
        cnt = cnt + 1;
    end
    if grouping_img(i, j-1) == 0
        cnt = cnt + 1;
    end
    if grouping_img(i+1, j) == 0
        cnt = cnt + 1;
    end
    if grouping_img(i-1, j) == 0
        cnt = cnt + 1;
    end
    if grouping_img(i+1, j+1) == 0
        cnt = cnt + 1;
    end
    if grouping_img(i-1, j+1) == 0
        cnt = cnt + 1;
    end
    if grouping_img(i+1, j-1) == 0
        cnt = cnt + 1;
    end
    if grouping_img(i-1, j-1) == 0
        cnt = cnt + 1;
    end
    if cnt <= 2
        result_img(i, j) = 1;
    end
end