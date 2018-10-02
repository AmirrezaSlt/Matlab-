 close all
clear all

f = imread('lg-image26.jpg');
f = rgb2gray(f);
% f = imresize(f, 0.3);
[M, N] = size(f);


%%%%%%%%%%%%%%%%%%%%%% Section (B) %%%%%%%%%%%%%%%%%%%%%%%%

% f_histequal = histogram_equalization(f);
% f_bihistequal = bihistogram_equalization(f);

figure(1), imshow(f, []), title('Original');
% figure(2), imshow(f_histequal, []), title('Histogram Equalization');
% figure(3), imshow(f_bihistequal, []), title('Bihistogram Equalization');


%%%%%%%%%%%%%%%%%%%%%% Section (C) %%%%%%%%%%%%%%%%%%%%%%%%

window_size =14;
L = fix(window_size/2);
f_zeropad = zeros(M+window_size, N+window_size);
f_zeropad(1+L:M+L, 1+L:N+L) = f;
window_histequal = zeros(M+window_size, N+window_size);
for m=1+L:M+L
    for n=1+L:N+L
        window = f_zeropad(m-L:m+L, n-L:n+L);
        p = histogram(window) / (M*N);
        window_cdf(1) = p(1);
        for k=2:256
            window_cdf(k) = p(k) + window_cdf(k-1);
        end
        if f_zeropad(m, n) == 0
            window_histequal(m, n) = window_cdf(1);
        else
            window_histequal(m, n) = window_cdf(f_zeropad(m, n));
        end
    end
end
f_localhistequal = window_histequal(1+L:M+L, 1+L:N+L);

figure(4), imshow(f_localhistequal, []), title('Local Histogram Equalization');