

% read image, convert to double, save as img
img = im2double(imread('lena.jpg'));

%----1) Implement seperate frequency----
%%different file

%----2) use r=0.1, save as lenalow.1 and LenaHigh.1----
ratio = 0.1;

[low_pass_img, high_pass_img] = separate_frequency(img, ratio);
imwrite(low_pass_img, 'lena_low_0.1.jpg');
imwrite(high_pass_img + 0.5, 'lena_high_0.1.jpg');


%----3) use r=0.2, save as lenalow.2 and LenaHigh.2----
ratio = 0.2;

[low_pass_img, high_pass_img] = separate_frequency(img, ratio);
imwrite(low_pass_img, 'lena_low_0.2.jpg');
imwrite(high_pass_img + 0.5, 'lena_high_0.2.jpg');


%----4) implement hybrid_image.m----
%%separate file


%----5) use any ratio and save as hybrid1.jpg----
image1 = 'marilyn.jpg';
image2 = 'einstein.jpg';
img1 = im2double(imread(image1));
img2 = im2double(imread(image2));

ratio = 0.25;
hy_img1 = hybrid_image(img1, img2, ratio);
imwrite(hy_img1, 'hybrid_1.jpg');

%----6) use any ratio and save as hybrid1.jpg----
ratio2 = 0.1;
hy_img2 = hybrid_image(img1, img2, ratio2);
imwrite(hy_img2, 'hybrid_2.jpg');

