function img_merged = hybrid_image(img1, img2, ratio)
    [lf1, hf1] = separate_frequency(img1, ratio);
    [lf2, hf2] = separate_frequency(img2, ratio);
    img_merged = lf2 + hf1;
    
end
