function [final_array, num, result] = finalArray(square_array, arrayTop, predict_label)
    num = 0;
    for i = 1 : 1 : arrayTop
        result(i) = i;
    end
    for i = 1 : 1 : arrayTop
        for j = i : 1 : arrayTop
            temp_1 = square_array{i};
            temp_2 = square_array{j};
            if abs(temp_1(1)-temp_2(1)) < 10 || abs(temp_1(3)-temp_2(3)) < 10
                result(j) = result(i);
            end
        end
    end
    vis = zeros(arrayTop);
    
    for i = 1 : 1: arrayTop
        top = square_array{i}(1);
        right = square_array{i}(2);
        bottom = square_array{i}(3);
        left = square_array{i}(4);
        if vis(result(i)) == 0 && predict_label(i) == 1
            vis(result(i)) = 1;
            for j = i : 1 : arrayTop
                if result(j) == result(i) && predict_label(i) == 1
                    if square_array{j}(1) < top
                        top = square_array{j}(1);
                    end
                    if square_array{j}(2) > right
                        right = square_array{j}(2);
                    end
                    if square_array{j}(3) > bottom
                        bottom = square_array{j}(3);
                    end
                    if square_array{j}(4) < left
                        left = square_array{j}(4);
                    end
                end
            end
            temp = [top, right, bottom, left];
            num = num + 1;
            final_array{num} = temp;
        end
        
    end
end