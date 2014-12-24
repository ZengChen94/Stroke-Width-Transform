I = grouping_img_2;
figure,imshow(I),hold on;%show the original image
title('The original image.');
rotI = I; % convert to intensity image
BW = edge(rotI,'canny'); % extract edges
[H,T,R] = hough(BW,'RhoResolution',0.5,'ThetaResolution',0.5);%hough transfer
figure,imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit'),hold on;
xlabel('\theta'), ylabel('\rho');
axis on, axis normal,hold on;
P = houghpeaks(H,10,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');
% Find lines and plot them
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
figure, imshow(rotI), hold on;
title('The lines that have been found');
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');

   %Plot beginnings and ends of lines
   %plot(xy(1,1),xy(1,2),'x','LineWidth',1,'Color','yellow');
   %plot(xy(2,1),xy(2,2),'x','LineWidth',1,'Color','red');

   % Determine the endpoints of the longest line segment 
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
       max_len = len;
       xy_long = xy;
   end
end
% highlight the longest line segment
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',1,'Color','cyan');