function [paper, width_img] = adjustCorner(paper, gradx, grady, i, j, a, b, cannyResult, width_img)
        flag = 0;
    top = 1;
    stack{top} = [i, j];
    width = 0;
    if abs(gradx(i, j)) >= abs(grady(i, j))
%     if gradx(i, j) == 0 %gradx == 0
        if abs(gradx(i, j)) < 10 %we treat it as gradx == 0
            if grady(i, j) > 0 && i ~= a 
                for temp = (i + 1) : 1 : a
                    top = top + 1;
                    stack{top} = [temp, j];
                    if cannyResult(temp, j) < 200
%                     if gradx(temp, j) == 0 
                            if grady(temp, j) <= 0
                                paper=BresenhamDraw(paper,j,i,j,temp);
                                width = temp - i;
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
%                     else
%                         alpha = atan2(grady(temp, j), gradx(temp, j));
%                         if alpha > pi/6 && alpha < pi*5/6
%                             paper=BresenhamDraw(paper,j,i,j,temp);
%                             width = temp - i;
%                             top = top + 1;
%                             stack{top} = [temp, j];
%                             flag = 1;
%                             break;
%                         end
%                     end
                    end
                end
            elseif grady(i, j) < 0 && i ~= 1
                for temp = (i - 1) : -1 : 1 
                    top = top + 1;
                    stack{top} = [temp, j];
                    if cannyResult(temp, j) < 200
%                     if gradx(temp, j) == 0 
                            if grady(temp, j) >= 0
                                paper=BresenhamDraw(paper,j,i,j,temp);
                                width = i - temp;
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
%                     else
%                         alpha = atan2(grady(temp, j), gradx(temp, j));
%                         if alpha < -pi/6 && alpha > -pi*5/6
%                             paper=BresenhamDraw(paper,j,i,j,temp);
%                             width = i - temp;
%                             top = top + 1;
%                             stack{top} = [temp, j];
%                             flag = 1;
%                             break;
%                         end
%                     end
                    end
                end
            end
        else
            if gradx(i, j) > 0 && j ~= b
               for temp_x = (j + 1) : 1 : b
                   temp_y = round(i + (temp_x - j) * grady(i, j) / gradx(i, j)); 
                   if temp_y > a || temp_y < 1
                       break;
                   end
                   top = top + 1;
                   stack{top} = [temp_y, temp_x];
                   if cannyResult(temp_y, temp_x) < 200
                       alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y, temp_x), gradx(temp_y, temp_x))) - pi);
 %                    if alpha < pi/3
                       if alpha < pi/2
                           paper=BresenhamDraw(paper,j,i,temp_x,temp_y);
                           width = sqrt((i-temp_y)^2+(j-temp_x)^2);
                           top = top + 1;
                           stack{top} = [temp_y, temp_x];
                           flag = 1;
                           break;
                       end
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
                   if cannyResult(temp_y, temp_x) < 200
                       alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y, temp_x), gradx(temp_y, temp_x))) - pi);
 %                    if alpha < pi/3
                       if alpha < pi/2
                           paper=BresenhamDraw(paper,j,i,temp_x,temp_y);
                           width = sqrt((i-temp_y)^2+(j-temp_x)^2);
                           top = top + 1;
                           stack{top} = [temp_y, temp_x];
                           flag = 1;
                           break;
                       end
                   end
               end
            end
        end
    else
        %     if grady(i, j) == 0 %grady == 0
        if abs(grady(i, j)) < 10 %we treat it as grady == 0
            if gradx(i, j) > 0 && j ~= b
                for temp = (j + 1) : 1 : b
                    top = top + 1;
                    stack{top} = [i, temp];
                    if cannyResult(i, temp) < 200
%                     if grady(i, temp) == 0 
                            if gradx(i, temp) <= 0
                                paper=BresenhamDraw(paper,j,i,temp,i);
                                width = temp - j;
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
%                     else
%                         alpha = atan2(grady(i, temp), gradx(i, temp));
%                         if alpha > pi/6 && alpha < pi*5/6
%                             paper=BresenhamDraw(paper,j,i,temp,i);
%                             width = temp - j;
%                             top = top + 1;
%                             stack{top} = [i, temp];
%                             flag = 1;
%                             break;
%                         end
%                     end
                    end
                end
            elseif gradx(i, j) < 0 && j ~= 1
                for temp = (j - 1) : -1 : 1 
                    top = top + 1;
                    stack{top} = [i, temp];
                    if cannyResult(i, temp) < 200
%                     if grady(i, temp) == 0 
                            if grady(i, temp) >= 0
                                paper=BresenhamDraw(paper,j,i,temp,i);
                                width = j - temp;
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
%                     else
%                         alpha = atan2(grady(i, temp), gradx(i, temp));
%                         if alpha < -pi/6 && alpha > -pi*5/6
%                             paper=BresenhamDraw(paper,j,i,temp,i);
%                             width = j - temp;
%                             top = top + 1;
%                             stack{top} = [i, temp];
%                             flag = 1;
%                             break;
%                         end
%                     end
                    end
                end
            end
        else
            if grady(i, j) > 0 && i ~= a
               for temp_y = (i + 1) : 1 : a
                   temp_x = round(j + (temp_y - i) * gradx(i, j) / grady(i, j)); 
                   if temp_x > b || temp_x < 1
                       break;
                   end
                   top = top + 1;
                   stack{top} = [temp_y, temp_x];
                   if cannyResult(temp_y, temp_x) < 200
                       alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y, temp_x), gradx(temp_y, temp_x))) - pi);
 %                    if alpha < pi/3
                       if alpha < pi/2
                           paper=BresenhamDraw(paper,j,i,temp_x,temp_y);
                           width = sqrt((i-temp_y)^2+(j-temp_x)^2);
                           top = top + 1;
                           stack{top} = [temp_y, temp_x];
                           flag = 1;
                           break;
                       end
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
                   if cannyResult(temp_y, temp_x) < 200
                       alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y, temp_x), gradx(temp_y, temp_x))) - pi);
 %                    if alpha < pi/3
                       if alpha < pi/2
                           paper=BresenhamDraw(paper,j,i,temp_x,temp_y);
                           width = sqrt((i-temp_y)^2+(j-temp_x)^2);
                           top = top + 1;
                           stack{top} = [temp_y, temp_x];
                           flag = 1;
                           break;
                       end
                   end
               end
            end
        end
    end
    if flag == 1
        tot = 0;
        for temp = 1: 1: top
            temp_y = stack{temp}(1);
            temp_x = stack{temp}(2);
            tot = tot + width_img(temp_y, temp_x);
        end
        median = tot / top;
        for temp = 1: 1: top
            temp_y = stack{temp}(1);
            temp_x = stack{temp}(2);
            if width_img(temp_y, temp_x) > median
               width_img(temp_y, temp_x) = median;
            end
        end
    end
end