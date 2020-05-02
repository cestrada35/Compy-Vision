function [output, match] = template_matching_normcorr(I1, I2, threshold)
    x = size(I2, 2);
    y = size(I2, 1);
    
    shift_u = floor(y/2);
    shift_v = floor(x/2);
    
    for u = 1 + shift_u : size(I1, 2) - shift_u
       for v = 1 + shift_v : size(I1, 1) - shift_v
           
           x1 = u - shift_u;
           x2 = u + shift_u;
           y1 = v - shift_v;
           y2 = v + shift_v;
           patch = I1(y1:y2, x1:x2);
           
           % convert the patch and template to a vector
           patch = patch(:);
           I2 = I2(:);
           PPrime = patch - mean(patch);
           hPrime = I2 - mean(I2);
           PPrime = PPrime(:);
           hPrime = hPrime(:);
           PDoublePrime = PPrime ./ norm(PPrime, 2);
           hDoublePrime = hPrime ./ norm(hPrime, 2);
           
           value = PDoublePrime .* hDoublePrime;
           
           value = value(:);
           value = sum(value);
           
           output(v, u) = value;
       end
    end
   
    match = (output > threshold);
end