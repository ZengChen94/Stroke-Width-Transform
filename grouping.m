function [grouping_img, square, num, block_img] = grouping(width_img, grouping_img, a, b)
    vis = zeros(a, b);
    num = 0;
    for i = 1 : 1 : a
        for j = 1 : 1 : b
            flag = 0;
            if vis(i, j) == 0 && width_img(i, j) ~= 0
               vis(i, j) = 1;
               top = 1; %堆栈顶
               stack{top} = [i j]; %将第一个节点入栈
               left = j;
               right = j;
               top_top = i;
               bottom = i;
               color = [randi(2)-1, randi(2)-1, randi(2)-1];
               while color(1) == 0 && color(2) == 0 && color(3) == 0
                   color = [randi(2)-1, randi(2)-1, randi(2)-1];
               end
               while top~=0
                   try 
                       temp = stack{top};
                   catch
%                        break;
                   end
%                    temp = stack{top};
                   temp_y = temp(1);
                   temp_x = temp(2);
                   top = top - 1;
                   if temp_x < left
                       left = temp_x;
                   end
                   if temp_x > right
                       right = temp_x;
                   end
                   if temp_y < top_top
                       top_top = temp_y;
                   end
                   if temp_y > bottom
                       bottom = temp_y;
                   end
                   if flag == 1
                       block_img(temp_y, temp_x, 1) = color(1)*255;
                       block_img(temp_y, temp_x, 2) = color(2)*255;
                       block_img(temp_y, temp_x, 3) = color(3)*255;
                   end
                   if temp_y + 1 <= a 
                       if vis(temp_y+1, temp_x) == 0 && width_img(temp_y+1, temp_x) ~= 0
                           if width_img(temp_y+1, temp_x) < 3 * width_img(temp_y, temp_x) && width_img(temp_y+1, temp_x) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y + 1, temp_x];
                               vis(temp_y + 1, temp_x) = 1;
                               grouping_img(temp_y + 1, temp_x) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y - 1 >= 1 
                       if vis(temp_y-1, temp_x) == 0 && width_img(temp_y-1, temp_x) ~= 0
                           if width_img(temp_y-1, temp_x) < 3 * width_img(temp_y, temp_x) && width_img(temp_y-1, temp_x) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y - 1, temp_x];
                               vis(temp_y - 1, temp_x) = 1;
                               grouping_img(temp_y - 1, temp_x) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_x + 1 <= b 
                       if vis(temp_y, temp_x+1) == 0 && width_img(temp_y, temp_x+1) ~= 0
                           if width_img(temp_y, temp_x+1) < 3 * width_img(temp_y, temp_x) && width_img(temp_y, temp_x+1) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y, temp_x + 1];
                               vis(temp_y, temp_x + 1) = 1;
                               grouping_img(temp_y, temp_x + 1) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_x - 1 >= 1 
                       if vis(temp_y, temp_x-1) == 0 && width_img(temp_y, temp_x-1) ~= 0
                           if width_img(temp_y, temp_x-1) < 3 * width_img(temp_y, temp_x) && width_img(temp_y, temp_x-1) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y, temp_x - 1];
                               vis(temp_y, temp_x - 1) = 1;
                               grouping_img(temp_y, temp_x - 1) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y + 1 <= a && temp_x + 1 <= b 
                       if vis(temp_y+1, temp_x+1) == 0 && width_img(temp_y+1, temp_x+1)~= 0
                           if width_img(temp_y+1, temp_x+1) < 3 * width_img(temp_y, temp_x) && width_img(temp_y+1, temp_x+1) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y + 1, temp_x + 1];
                               vis(temp_y + 1, temp_x + 1) = 1;
                               grouping_img(temp_y + 1, temp_x + 1) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y + 1 <= a && temp_x - 1 >= 1 
                       if vis(temp_y+1, temp_x-1) == 0 && width_img(temp_y+1, temp_x-1) ~= 0
                           if width_img(temp_y+1, temp_x-1) < 3 * width_img(temp_y, temp_x) && width_img(temp_y+1, temp_x-1) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y + 1, temp_x - 1];
                               vis(temp_y + 1, temp_x - 1) = 1;
                               grouping_img(temp_y + 1, temp_x - 1) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y - 1 >= 1 && temp_x + 1 <= b 
                       if vis(temp_y-1, temp_x+1) == 0 && width_img(temp_y-1, temp_x+1) ~= 0
                           if width_img(temp_y-1, temp_x+1) < 3 * width_img(temp_y, temp_x) && width_img(temp_y-1, temp_x+1) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y - 1, temp_x + 1];
                               vis(temp_y - 1, temp_x + 1) = 1;
                               grouping_img(temp_y - 1, temp_x + 1) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y - 1 >= 1 && temp_x - 1 >= 1 
                       if vis(temp_y-1, temp_x-1) == 0 && width_img(temp_y-1, temp_x-1) ~= 0
                           if width_img(temp_y-1, temp_x-1) < 3 * width_img(temp_y, temp_x) && width_img(temp_y-1, temp_x-1) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y - 1, temp_x - 1];
                               vis(temp_y - 1, temp_x - 1) = 1;
                               grouping_img(temp_y - 1, temp_x - 1) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   
                   if temp_y - 2 >= 1 && temp_x - 2 >= 1 
                       if vis(temp_y-2, temp_x-2) == 0 && width_img(temp_y-2, temp_x-2) ~= 0
                           if width_img(temp_y-2, temp_x-2) < 3 * width_img(temp_y, temp_x) && width_img(temp_y-2, temp_x-2) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y - 2, temp_x - 2];
                               vis(temp_y - 2, temp_x - 2) = 1;
                               grouping_img(temp_y - 2, temp_x - 2) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y - 2 >= 1 && temp_x - 1 >= 1 
                       if vis(temp_y-2, temp_x-1) == 0 && width_img(temp_y-2, temp_x-1) ~= 0
                           if width_img(temp_y-2, temp_x-1) < 3 * width_img(temp_y, temp_x) && width_img(temp_y-2, temp_x-1) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y - 2, temp_x - 1];
                               vis(temp_y - 2, temp_x - 1) = 1;
                               grouping_img(temp_y - 2, temp_x - 1) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y - 2 >= 1 
                       if vis(temp_y-2, temp_x) == 0 && width_img(temp_y-2, temp_x) ~= 0
                           if width_img(temp_y-2, temp_x) < 3 * width_img(temp_y, temp_x) && width_img(temp_y-2, temp_x) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y - 2, temp_x];
                               vis(temp_y - 2, temp_x) = 1;
                               grouping_img(temp_y - 2, temp_x) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y - 2 >= 1 && temp_x + 1 <= b
                       if vis(temp_y-2, temp_x+1) == 0 && width_img(temp_y-2, temp_x+1)~=0
                           if width_img(temp_y-2, temp_x+1) < 3 * width_img(temp_y, temp_x) && width_img(temp_y-2, temp_x+1) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y - 2, temp_x + 1];
                               vis(temp_y - 2, temp_x + 1) = 1;
                               grouping_img(temp_y - 2, temp_x + 1) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y - 2 >= 1 && temp_x + 2 <= b 
                       if vis(temp_y-2, temp_x+2) == 0 && width_img(temp_y-2, temp_x+2) ~= 0
                           if width_img(temp_y-2, temp_x+2) < 3 * width_img(temp_y, temp_x) && width_img(temp_y-2, temp_x+2) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y - 2, temp_x + 2];
                               vis(temp_y - 2, temp_x + 2) = 1;
                               grouping_img(temp_y - 2, temp_x + 2) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y - 1 >= 1 && temp_x - 2 >= 1 
                       if vis(temp_y-1, temp_x-2) == 0 && width_img(temp_y-1, temp_x-2)~=0
                           if width_img(temp_y-1, temp_x-2) < 3 * width_img(temp_y, temp_x) && width_img(temp_y-1, temp_x-2) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y - 1, temp_x - 2];
                               vis(temp_y - 1, temp_x - 2) = 1;
                               grouping_img(temp_y - 1, temp_x - 2) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_x - 2 >= 1 
                       if vis(temp_y, temp_x-2) == 0 && width_img(temp_y, temp_x-2)~=0
                           if width_img(temp_y, temp_x-2) < 3 * width_img(temp_y, temp_x) && width_img(temp_y, temp_x-2) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y, temp_x - 2];
                               vis(temp_y , temp_x - 2) = 1;
                               grouping_img(temp_y, temp_x - 2) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y + 1 <= a && temp_x - 2 >= 1 
                       if vis(temp_y+1, temp_x-2) == 0 && width_img(temp_y+1, temp_x-2) ~= 0
                           if width_img(temp_y+1, temp_x-2) < 3 * width_img(temp_y, temp_x) && width_img(temp_y+1, temp_x-2) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y + 1, temp_x - 2];
                               vis(temp_y + 1, temp_x - 2) = 1;
                               grouping_img(temp_y + 1, temp_x - 2) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y - 1 >= 1 && temp_x + 2 <= b 
                       if vis(temp_y-1, temp_x+2) == 0 && width_img(temp_y-1, temp_x+2) ~= 0
                           if width_img(temp_y-1, temp_x+2) < 3 * width_img(temp_y, temp_x) && width_img(temp_y-1, temp_x+2) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y - 1, temp_x + 2];
                               vis(temp_y - 1, temp_x + 2) = 1;
                               grouping_img(temp_y - 1, temp_x + 2) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_x + 2 <= b 
                       if vis(temp_y, temp_x+2) == 0 && width_img(temp_y, temp_x+2)~=0
                           if width_img(temp_y, temp_x+2) < 3 * width_img(temp_y, temp_x) && width_img(temp_y, temp_x+2) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y, temp_x + 2];
                               vis(temp_y, temp_x + 2) = 1;
                               grouping_img(temp_y, temp_x + 2) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y + 1 <= a && temp_x + 2 <= b 
                       if vis(temp_y+1, temp_x+2) == 0 && width_img(temp_y+1, temp_x+2)~=0
                           if width_img(temp_y+1, temp_x+2) < 3 * width_img(temp_y, temp_x) && width_img(temp_y+1, temp_x+2) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y + 1, temp_x + 2];
                               vis(temp_y + 1, temp_x + 2) = 1;
                               grouping_img(temp_y + 1, temp_x + 2) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y + 2 <= a && temp_x - 2 >= 1 
                       if vis(temp_y+2, temp_x-2) == 0 && width_img(temp_y+2, temp_x-2)~=0
                           if width_img(temp_y+2, temp_x-2) < 3 * width_img(temp_y, temp_x) && width_img(temp_y+2, temp_x-2) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y + 2, temp_x - 2];
                               vis(temp_y + 2, temp_x - 2) = 1;
                               grouping_img(temp_y + 2, temp_x - 2) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y + 2 <= a && temp_x - 1 >= 1 
                       if vis(temp_y+2, temp_x-1) == 0 && width_img(temp_y+2, temp_x-1) ~= 0
                           if width_img(temp_y+2, temp_x-1) < 3 * width_img(temp_y, temp_x) && width_img(temp_y+2, temp_x-1) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y + 2, temp_x - 1];
                               vis(temp_y + 2, temp_x - 1) = 1;
                               grouping_img(temp_y + 2, temp_x - 1) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y + 2 <= a 
                       if vis(temp_y+2, temp_x) == 0 && width_img(temp_y+2, temp_x)~=0
                           if width_img(temp_y+2, temp_x) < 3 * width_img(temp_y, temp_x) && width_img(temp_y+2, temp_x) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y + 2, temp_x];
                               vis(temp_y + 2, temp_x) = 1;
                               grouping_img(temp_y + 2, temp_x) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y + 2 <= a && temp_x + 1 <= b 
                       if vis(temp_y+2, temp_x+1) == 0 && width_img(temp_y+2, temp_x+1)~=0
                           if width_img(temp_y+2, temp_x+1) < 3 * width_img(temp_y, temp_x) && width_img(temp_y+2, temp_x+1) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y + 2, temp_x + 1];
                               vis(temp_y + 2, temp_x + 1) = 1;
                               grouping_img(temp_y + 2, temp_x + 1) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
                   if temp_y + 2 <= a && temp_x + 2 <= b 
                       if vis(temp_y+2, temp_x+2) == 0 && width_img(temp_y+2, temp_x+2)~=0
                           if width_img(temp_y+2, temp_x+2) < 3 * width_img(temp_y, temp_x) && width_img(temp_y+2, temp_x+2) > width_img(temp_y, temp_x) / 3
                               top = top + 1;
                               stack{top} = [temp_y + 2, temp_x + 2];
                               vis(temp_y + 2, temp_x + 2) = 1;
                               grouping_img(temp_y + 2, temp_x + 2) = 0;
                               grouping_img(temp_y, temp_x) = 0;
                               flag = 1;
                           end
                       end
                   end
               end
               if bottom ~= top_top && left ~= right
                   num = num+1;
                   square{num} = [top_top, right, bottom, left];
               end
            end
        end
    end
end