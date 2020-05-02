
% read image, convert to double, save as img
img = im2double(imread('lena.jpg'));

%H = [1, 2, 1; 0, 0, 0; -1, -2, -1]; % horizontal edge 
%H = [1, 0, -1; 2, 0, -2; 1, 0, -1]; % vertical edge

%----1) Implement Sobel Filter file using Hy filter----
Hy = [1,2,1; 0,0,0; -1,-2,-1];
img_sobel1 = sobel_filter(img, Hy);
%figure, imshow(img_sobel1);
imwrite(img_sobel1, 'sobel_y.jpg');

%----2) Implement Sobel Filter file using Hx filter----
Hx = [-1,0,1; -2,0,2; -1,0,1];
img_sobel2 = sobel_filter(img, Hx);
%figure, imshow(img_sobel2);
imwrite(img_sobel2, 'sobel_x.jpg');

%----3) use column filter first then row for HY1----
Hy1 = [1,1,1; 0,0,0; -1,-1,-1];
Hy2 = [1,2,1];
[rows, cols] = size(img);
I2 = zeros(rows+2, cols+2);
I2(1+1:rows+1, 1+1:cols+1) = img;
output = zeros(rows+2, cols+2);
output2 = zeros(rows,cols);
for i = 1:rows
    for j=1:cols
        output(i, j:j+2) = sum(Hy1.*I2(i:i+2, j:j+2), 1); 
        output2(i,j) = sum(Hy2.*output(i, j:j+2));
    end
end
%figure, imshow(output);
imwrite(output, 'sobel_cr.jpg');

%----4) use row filter first then column for HY1----
Hy3 = [1,2,1; 1,2,1; 1,2,1];
Hy4 = [1,0,-1];
[rows, cols] = size(img);
I3 = zeros(rows+2, cols+2);
I3(1+1:rows+1, 1+1:cols+1) = img;
output3 = zeros(rows+2, cols+2);
output4 = zeros(rows,cols);
for i = 1:rows
    for j=1:cols
        output3(i:i+2,j) = sum(Hy3.*I3(i:i+2, j:j+2), 2); 
        output4(i,j) = sum(Hy4.*output3(i:i+2));
    end
end
%figure, imshow(output3);
imwrite(output3, 'sobel_rc.jpg');
