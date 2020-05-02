
function [low_pass_img, high_pass_img] = separate_frequency(img, ratio)

%fft
frequency_map=fft2(img);

%shift the frequency map
frequency_map_shifted = fftshift(frequency_map);

    y1 = floor((size(img, 1))/2) - floor(ratio * ((size(img, 1))/2));
    y2 = floor((size(img, 1))/2) + floor(ratio * ((size(img, 1))/2));
    x1 = floor((size(img, 2))/2) - floor(ratio * ((size(img, 2))/2));
    x2 = floor((size(img, 2))/2) + floor(ratio * ((size(img, 2))/2));

%compute low-frequency mask
mask = zeros(size(img));
mask(y1:y2, x1:x2,:) = 1;
    
%separate low and high frequency maps
 low_frequency_map_shifted = frequency_map_shifted .* mask;
 high_frequency_map_shifted = frequency_map_shifted .* (1 - mask);

%shift frequency maps back
low_frequency_map = ifftshift(low_frequency_map_shifted);
high_frequency_map = ifftshift(high_frequency_map_shifted);

%apply inverst fft

    low_pass_img = real(ifft2(low_frequency_map)); 
    high_pass_img = real(ifft2(high_frequency_map)); 
end


