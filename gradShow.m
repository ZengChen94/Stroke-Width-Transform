function gradShow_img = gradShow(gradShow_img, gradx, grady, i, j, a, b)
    top = 1;
    stack{top} = [i, j];
    width = 0;

    if abs(gradx(i, j)) >= abs(grady(i, j))
%     if gradx(i, j) == 0 %gradx == 0
         if gradx(i, j) == 0
%          if abs(gradx(i, j)) < 10
            if grady(i, j) > 0 && i ~= a 
                for temp = (i + 1) : 1 : a
                    top = top + 1;
                    stack{top} = [temp, j];
                    if top == 10
                        break;
                    end
                end
            elseif grady(i, j) < 0 && i ~= 1
                for temp = (i - 1) : -1 : 1 
                    top = top + 1;
                    stack{top} = [temp, j];
                    if top == 10
                        break;
                    end
                end
            end
        else %gradx ~= 0
            if gradx(i, j) > 0 && j ~= b
               for temp_x = (j + 1) : 1 : b
                   temp_y = round(i + (temp_x - j) * grady(i, j) / gradx(i, j)); 
                   if temp_y > a || temp_y < 1
                       break;
                   end
                   top = top + 1;
                   stack{top} = [temp_y, temp_x];
                   if top == 10
                        break;
                   end
               end
            elseif gradx(i, j) < 0 && j ~= 1
               for temp_x = (j - 1) : -1 : 1
                   temp_y = round(i + (temp_x - j) * grady(i, j) / gradx(i, j)); 
                   if temp_y > a || temp_y < 1
                       break;
                   end
                   top = top + 1;
                   stack{top} = [temp_y, temp_x];
                   if top == 10
                        break;
                   end
               end
            end
         end
    else %gradx < grady
        if grady(i, j) == 0
%         if abs(grady(i, j)) < 10
            if grady(i, j) > 0 && i ~= a 
                for temp = (i + 1) : 1 : a
                    top = top + 1;
                    stack{top} = [temp, j];
                    if top == 10
                        break;
                    end
                end
            elseif grady(i, j) < 0 && i ~= 1
                for temp = (i - 1) : -1 : 1 
                    top = top + 1;
                    stack{top} = [temp, j];
                    if top == 10
                        break;
                    end
                end
            end
        else %gradx ~= 0
            if grady(i, j) > 0 && i ~= a
               for temp_y = (i + 1) : 1 : a
                   temp_x = round(j + (temp_y - i) * gradx(i, j) / grady(i, j)); 
                   if temp_x > b || temp_x < 1
                       break;
                   end
                   top = top + 1;
                   stack{top} = [temp_y, temp_x];
                   if top == 10
                        break;
                   end
               end
            elseif grady(i, j) < 0 && i ~= 1
               for temp_y = (i - 1) : -1 : 1
                   temp_x = round(j + (temp_y - i) * gradx(i, j) / grady(i, j)); 
                   if temp_x > b || temp_x < 1
                       break;
                   end
                   top = top + 1;
                   stack{top} = [temp_y, temp_x];
                   if top == 10
                        break;
                   end
               end
            end
         end
    end
    for temp = 1: 1: top
        temp_y = stack{temp}(1);
        temp_x = stack{temp}(2);
        gradShow_img(temp_y, temp_x) = 0;
    end
end