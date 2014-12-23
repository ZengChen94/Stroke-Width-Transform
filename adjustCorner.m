function width_img = adjustCorner(gradx, grady, i, j, a, b, cannyResult, width_img)
    flag = 0;
    top = 1;
    stack{top} = [i, j];
    
    %%
    if abs(gradx(i, j)) >= abs(grady(i, j))
        if gradx(i, j) == 0 || (grady(i, j) ~= 0 && abs(gradx(i, j)/grady(i, j))<0.2)
%         if abs(gradx(i, j)) < 10 %we treat it as gradx == 0
            if grady(i, j) > 0 && i ~= a 
                for temp = (i + 1) : 1 : a
                    top = top + 1;
                    stack{top} = [temp, j];
                    if cannyResult(temp, j) == 0
                        if grady(temp, j) <= 0
                            top = top + 1;
                            stack{top} = [temp, j];
                            flag = 1;
                            break;
                        end
                    end
                    if temp > 1
                        if cannyResult(temp-1, j) == 0
                            if grady(temp-1, j) <= 0
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if j > 1
                        if cannyResult(temp, j-1) == 0
                            if grady(temp, j-1) <= 0
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp < a
                        if cannyResult(temp+1, j) == 0
                            if grady(temp+1, j) <= 0
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if j < b
                        if cannyResult(temp, j+1) == 0
                            if grady(temp, j+1) <= 0
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp > 1 && j > 1
                        if cannyResult(temp-1, j-1) == 0
                            if grady(temp-1, j-1) <= 0
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp < a && j < b
                        if cannyResult(temp+1, j+1) == 0
                            if grady(temp+1, j+1) <= 0
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp > 1 && j < b
                        if cannyResult(temp-1, j+1) == 0
                            if grady(temp-1, j+1) <= 0
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp < a && j > 1
                        if cannyResult(temp+1, j-1) == 0
                            if grady(temp+1, j-1) <= 0
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
                        end
                    end
                end
            elseif grady(i, j) < 0 && i ~= 1
                for temp = (i - 1) : -1 : 1 
                    top = top + 1;
                    stack{top} = [temp, j];
                    if cannyResult(temp, j) == 0
                        if grady(temp, j) >= 0
                            top = top + 1;
                            stack{top} = [temp, j];
                            flag = 1;
                            break;
                        end
                    end
                    if temp > 1
                        if cannyResult(temp-1, j) == 0
                            if grady(temp-1, j) >= 0
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if j > 1
                        if cannyResult(temp, j-1) == 0
                            if grady(temp, j-1) >= 0
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp < a
                        if cannyResult(temp+1, j) == 0
                            if grady(temp+1, j) >= 0
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if j < b
                        if cannyResult(temp, j+1) == 0
                            if grady(temp, j+1) >= 0
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp > 1 && j > 1
                        if cannyResult(temp-1, j-1) == 0
                            if grady(temp-1, j-1) >= 0
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp < a && j < b
                        if cannyResult(temp+1, j+1) == 0
                            if grady(temp+1, j+1) >= 0
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp > 1 && j < b
                        if cannyResult(temp-1, j+1) == 0
                            if grady(temp-1, j+1) >= 0
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp < a && j > 1
                        if cannyResult(temp+1, j-1) == 0
                            if grady(temp+1, j-1) >= 0
                                top = top + 1;
                                stack{top} = [temp, j];
                                flag = 1;
                                break;
                            end
                        end
                    end
                end
            end
        end %%
        if gradx(i, j) ~= 0%%
            if gradx(i, j) > 0 && j ~= b
               for temp_x = (j + 1) : 1 : b
                   temp_y = round(i + (temp_x - j) * grady(i, j) / gradx(i, j)); 
                   if temp_y > a || temp_y < 1
                       break;
                   end
                   top = top + 1;
                   stack{top} = [temp_y, temp_x];
                   if cannyResult(temp_y, temp_x) == 0
                       alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y, temp_x), gradx(temp_y, temp_x))) - pi);
                       if alpha < pi/2
                           top = top + 1;
                           stack{top} = [temp_y, temp_x];
                           flag = 1;
                           break;
                       end
                   end
                   if temp_y > 1
                       if cannyResult(temp_y-1, temp_x) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y-1, temp_x), gradx(temp_y-1, temp_x))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_y < a
                       if cannyResult(temp_y+1, temp_x) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y+1, temp_x), gradx(temp_y+1, temp_x))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x > 1
                       if cannyResult(temp_y, temp_x-1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y, temp_x-1), gradx(temp_y, temp_x-1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x < b
                       if cannyResult(temp_y, temp_x+1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y, temp_x+1), gradx(temp_y, temp_x+1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x > 1 && temp_y >1
                       if cannyResult(temp_y-1, temp_x-1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y-1, temp_x-1), gradx(temp_y-1, temp_x-1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x <b && temp_y <a
                       if cannyResult(temp_y+1, temp_x+1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y+1, temp_x+1), gradx(temp_y+1, temp_x+1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x >1 && temp_y <a
                       if cannyResult(temp_y+1, temp_x-1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y+1, temp_x-1), gradx(temp_y+1, temp_x-1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x <b && temp_y >1
                       if cannyResult(temp_y-1, temp_x+1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y-1, temp_x+1), gradx(temp_y-1, temp_x+1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
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
                   if cannyResult(temp_y, temp_x) == 0
                       alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y, temp_x), gradx(temp_y, temp_x))) - pi);
                       if alpha < pi/2
                           top = top + 1;
                           stack{top} = [temp_y, temp_x];
                           flag = 1;
                           break;
                       end
                   end
                   if temp_y > 1
                       if cannyResult(temp_y-1, temp_x) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y-1, temp_x), gradx(temp_y-1, temp_x))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_y < a
                       if cannyResult(temp_y+1, temp_x) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y+1, temp_x), gradx(temp_y+1, temp_x))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x > 1
                       if cannyResult(temp_y, temp_x-1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y, temp_x-1), gradx(temp_y, temp_x-1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x < b
                       if cannyResult(temp_y, temp_x+1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y, temp_x+1), gradx(temp_y, temp_x+1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x > 1 && temp_y >1
                       if cannyResult(temp_y-1, temp_x-1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y-1, temp_x-1), gradx(temp_y-1, temp_x-1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x <b && temp_y <a
                       if cannyResult(temp_y+1, temp_x+1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y+1, temp_x+1), gradx(temp_y+1, temp_x+1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x >1 && temp_y <a
                       if cannyResult(temp_y+1, temp_x-1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y+1, temp_x-1), gradx(temp_y+1, temp_x-1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x <b && temp_y >1
                       if cannyResult(temp_y-1, temp_x+1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y-1, temp_x+1), gradx(temp_y-1, temp_x+1))) - pi);
                           if alpha < pi/2
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
%%
    else 
        if gradx(i, j) == 0 || (grady(i, j) ~= 0 && abs(gradx(i, j)/grady(i, j))<0.2)
%         if abs(grady(i, j)) < 10 %we treat it as grady == 0
            if gradx(i, j) > 0 && j ~= b
                for temp = (j + 1) : 1 : b
                    top = top + 1;
                    stack{top} = [i, temp];
                    if cannyResult(i, temp) == 0
                        if gradx(i, temp) <= 0
                            top = top + 1;
                            stack{top} = [i, temp];
                            flag = 1;
                            break;
                        end
                    end
                    if temp > 1
                        if cannyResult(i, temp-1) == 0
                            if grady(i, temp-1) <= 0
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if i > 1
                        if cannyResult(i-1, temp) == 0
                            if grady(i-1, temp) <= 0
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp < b
                        if cannyResult(i, temp+1) == 0
                            if grady(i, temp+1) <= 0
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if i < a
                        if cannyResult(i+1, temp) == 0
                            if grady(i+1, temp) <= 0
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp > 1 && i > 1
                        if cannyResult(i-1, temp-1) == 0
                            if grady(i-1, temp-1) <= 0
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if i < a && temp < b
                        if cannyResult(i+1, temp+1) == 0
                            if grady(i+1, temp+1) <= 0
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp > 1 && i < a
                        if cannyResult(i+1, temp-1) == 0
                            if grady(i+1, temp-1) <= 0
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp < b && i > 1
                        if cannyResult(i-1, temp+1) == 0
                            if grady(i-1, temp+1) <= 0
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
                        end
                    end
                end
            elseif gradx(i, j) < 0 && j ~= 1
                for temp = (j - 1) : -1 : 1 
                    top = top + 1;
                    stack{top} = [i, temp];
                    
                    if cannyResult(i, temp) == 0
                        if grady(i, temp) >= 0
                            top = top + 1;
                            stack{top} = [i, temp];
                            flag = 1;
                            break;
                        end
                    end
                    if temp > 1
                        if cannyResult(i, temp-1) == 0
                            if grady(i, temp-1) >= 0
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if i > 1
                        if cannyResult(i-1, temp) == 0
                            if grady(i-1, temp) >= 0
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp < b
                        if cannyResult(i, temp+1) == 0
                            if grady(i, temp+1) >= 0
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if i < a
                        if cannyResult(i+1, temp) == 0
                            if grady(i+1, temp) >= 0
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp > 1 && i > 1
                        if cannyResult(i-1, temp-1) == 0
                            if grady(i-1, temp-1) >= 0
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if i < a && temp < b
                        if cannyResult(i+1, temp+1) == 0
                            if grady(i+1, temp+1) >= 0
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp > 1 && i < a
                        if cannyResult(i+1, temp-1) == 0
                            if grady(i+1, temp-1) >= 0
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
                        end
                    end
                    if temp < b && i > 1
                        if cannyResult(i-1, temp+1) == 0
                            if grady(i-1, temp+1) >= 0
                                top = top + 1;
                                stack{top} = [i, temp];
                                flag = 1;
                                break;
                            end
                        end
                    end
                end
            end
        end
%         elseif grady(i, j) ~= 0
        if grady(i, j) ~= 0
            if grady(i, j) > 0 && i ~= a
               for temp_y = (i + 1) : 1 : a
                   temp_x = round(j + (temp_y - i) * gradx(i, j) / grady(i, j)); 
                   if temp_x > b || temp_x < 1
                       break;
                   end
                   top = top + 1;
                   stack{top} = [temp_y, temp_x];
                   if cannyResult(temp_y, temp_x) == 0
                       alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y, temp_x), gradx(temp_y, temp_x))) - pi);
 %                    if alpha < pi/2
                       if alpha < pi/2
                           top = top + 1;
                           stack{top} = [temp_y, temp_x];
                           flag = 1;
                           break;
                       end
                   end
                   if temp_y > 1
                       if cannyResult(temp_y-1, temp_x) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y-1, temp_x), gradx(temp_y-1, temp_x))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_y < a
                       if cannyResult(temp_y+1, temp_x) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y+1, temp_x), gradx(temp_y+1, temp_x))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x > 1
                       if cannyResult(temp_y, temp_x-1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y, temp_x-1), gradx(temp_y, temp_x-1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x < b
                       if cannyResult(temp_y, temp_x+1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y, temp_x+1), gradx(temp_y, temp_x+1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x > 1 && temp_y >1
                       if cannyResult(temp_y-1, temp_x-1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y-1, temp_x-1), gradx(temp_y-1, temp_x-1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x <b && temp_y <a
                       if cannyResult(temp_y+1, temp_x+1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y+1, temp_x+1), gradx(temp_y+1, temp_x+1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x >1 && temp_y <a
                       if cannyResult(temp_y+1, temp_x-1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y+1, temp_x-1), gradx(temp_y+1, temp_x-1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x <b && temp_y >1
                       if cannyResult(temp_y-1, temp_x+1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y-1, temp_x+1), gradx(temp_y-1, temp_x+1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
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
                   if cannyResult(temp_y, temp_x) == 0
                       alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y, temp_x), gradx(temp_y, temp_x))) - pi);
                       if alpha < pi/2
                           top = top + 1;
                           stack{top} = [temp_y, temp_x];
                           flag = 1;
                           break;
                       end
                   end
                   if temp_y > 1
                       if cannyResult(temp_y-1, temp_x) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y-1, temp_x), gradx(temp_y-1, temp_x))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_y < a
                       if cannyResult(temp_y+1, temp_x) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y+1, temp_x), gradx(temp_y+1, temp_x))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x > 1
                       if cannyResult(temp_y, temp_x-1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y, temp_x-1), gradx(temp_y, temp_x-1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x < b
                       if cannyResult(temp_y, temp_x+1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y, temp_x+1), gradx(temp_y, temp_x+1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x > 1 && temp_y >1
                       if cannyResult(temp_y-1, temp_x-1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y-1, temp_x-1), gradx(temp_y-1, temp_x-1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x <b && temp_y <a
                       if cannyResult(temp_y+1, temp_x+1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y+1, temp_x+1), gradx(temp_y+1, temp_x+1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x >1 && temp_y <a
                       if cannyResult(temp_y+1, temp_x-1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y+1, temp_x-1), gradx(temp_y+1, temp_x-1))) - pi);
                           if alpha < pi/2
                               top = top + 1;
                               stack{top} = [temp_y, temp_x];
                               flag = 1;
                               break;
                           end
                       end
                   end
                   if temp_x <b && temp_y >1
                       if cannyResult(temp_y-1, temp_x+1) == 0
                           alpha = abs(abs(atan2(grady(i, j), gradx(i, j)) - atan2(grady(temp_y-1, temp_x+1), gradx(temp_y-1, temp_x+1))) - pi);
                           if alpha < pi/2
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