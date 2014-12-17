function img_copy = drawSquare(temp, img_copy)
    top = temp(1);
    right = temp(2);
    bottom = temp(3);
    left = temp(4);
    
%     fprintf('%g, %g, %g, %g', top, right, bottom, left);
    
    img_copy(top, left:right, 1) = 255;
    img_copy(top, left:right, 2) = 255;
    img_copy(top, left:right, 3) = 0;
    
    img_copy(bottom, left:right, 1) = 255;
    img_copy(bottom, left:right, 2) = 255;
    img_copy(bottom, left:right, 3) = 0;
    
    img_copy(top:bottom, left, 1) = 255;
    img_copy(top:bottom, left, 2) = 255;
    img_copy(top:bottom, left, 3) = 0;
    
    img_copy(top:bottom, right, 1) = 255;
    img_copy(top:bottom, right, 2) = 255;
    img_copy(top:bottom, right, 3) = 0;
end