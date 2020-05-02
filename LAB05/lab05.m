img = im2double(imread('lena.jpg'));

sigma = 2.0;
hsize = 7;
scale = 5;

% Gaussian Pyramid implementaion
I = img;
for s = 1: scale
    
    % Gaussian filter
    g = fspecial('gaussian', hsize, sigma);
    img_gaussian = imfilter(I, g);
    imwrite(img_gaussian, sprintf('Gaussian_scale%d.jpg', s));
    
    % Down-sampling
    I = imresize(I,0.5);
    
end

% Laplacian Pyramid implementation

I = img;

for s = 1:scale
    % Gaussian
    g = fspecial('gaussian', hsize, sigma);
    img_gaussian = imfilter(I, g);
    
    img_laplacian = I - img_gaussian;
    imwrite(img_laplacian + 0.5, sprintf('Laplacian_scale%d.jpg', s));
    
    % Down-sampling
    I = imresize(I,0.5);
end

% Template Matching

% SSD

img_einstein1 = im2double(imread('einstein1.jpg'));
img_einstein2 = im2double(imread('einstein2.jpg'));
img_template = im2double(imread('template.jpg'));

threshold = 25;
[output, match] = template_matching_SSD(img_einstein1, img_template, threshold);

imwrite(output ./ max(output(:)), 'einstein1_ssd_output.jpg');
imwrite(match, 'einstein1_ssd_match.jpg');

threshold = 36;
[output, match] = template_matching_SSD(img_einstein2, img_template, threshold);

imwrite(output ./ max(output(:)), 'einstein2_ssd_output.jpg');
imwrite(match, 'einstein2_ssd_match.jpg');

% Normm

threshold = 0.5;
[output, match] = template_matching_normcorr(img_einstein1, img_template, threshold);

imwrite(output ./ max(output(:)), 'einstein1_normcorr_output.jpg');
imwrite(match, 'einstein1_normcorr_match.jpg');

threshold = 0.5;
[output, match] = template_matching_normcorr(img_einstein2, img_template, threshold);

imwrite(output ./ max(output(:)), 'einstein2_normcorr_output.jpg');
imwrite(match, 'einstein2_normcorr_match.jpg');