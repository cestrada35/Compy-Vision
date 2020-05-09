
img1 = im2double(imread('frame10.png'));
img2 = im2double(imread('frame11.png'));

window_size = 95;
k = 4; 

w = floor(window_size/2);
shift = w + 10;


%convert
I1 = rgb2gray(img1);
I2 = rgb2gray(img2);

%grads
Ix_m = imfilter(I1, [1 -1;  1 -1], 'replicate');
Iy_m = imfilter(I1, [1  1; -1 -1], 'replicate');
It_m = imfilter(I1, ones(2), 'replicate') - imfilter(I2, ones(2), 'replicate');


%optical flow
u = zeros(size(I1)); u_next = zeros(size(I1));
v = zeros(size(I1)); v_next = zeros(size(I1));

for t = 1:k
    for i = 1 + shift : size(Ix_m, 1) - shift
        for j = 1 + shift : size(Ix_m, 2) - shift

            % extract Ix, Iy, It from local window
           Ix = Ix_m(i-w : i+w, j - w : j+w);
           Iy = Iy_m(i-w : i+w, j - w : j+w);
           i2 = floor(i + v(i, j));
           j2 = floor(j + u(i, j));
           temp1 = I1(i - w : i + w, j - w : j + w);
           temp2 = I2(i2 - w : i2 + w, j2 - w : j2 + w);
           It = temp1 - temp2;
           
            
            % convert Ix, Iy, It to vectors
            Ix = Ix(:);
            Iy = Iy(:);
            It = It(:);
            
            
            % construct matrix A and vector b
            A = [Ix, Iy];
            b = -It;
            x = A \ b;
            
            u_next(i, j) = x(1);
            v_next(i, j) = x(2);

        end
    end
    % update flow
    u = u + u_next;
    v = v + v_next;
end

plot_flow(img2, u, v);
figure,imshow(img2);