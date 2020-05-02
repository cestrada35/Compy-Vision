img = im2double(imread('flowers.jpg'));

frequency_map = fftshift(fft2(img));
figure, imagesc(log(abs(frequency_map)+ 1)), colormap jet;

