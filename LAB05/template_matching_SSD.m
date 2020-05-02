function [output, match] = template_matching_SSD(I1, I2, threshold)
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
           
           % SSD
           value = (I2 - patch).^2;
           value = value(:);
           value = sum(value);
           
           output(v, u) = value;
       end
    end
   
    match = (output < threshold);
end