clear all
close all
image = imread('nasa.jpg');
f = rgb2gray(image);
f = imresize(f,0.3);
figure, imshow(f), title('Original Image');
f = double(f);

%Gamma Correction
gamma = 2.5;
gamma_correction = round((255)^(1-gamma) * f.^gamma);
figure, imshow(uint8(gamma_correction)), title(['gamma correction with gamma = ',num2str(gamma)]);

%Achive Histogram of original image
[M,N] = size(f);
orig_hist = zeros(256,1);
for m = 1:M
    for n = 1:N
        r = f(m,n);
        orig_hist(r+1) = orig_hist(r+1) + 1;
    end
end
figure, plot(orig_hist), title('Original Histogram');
orig_hist = orig_hist / (M*N);

%Achive cumulative distribution funvtion (CDF) of original image
CDF = zeros(256,1);
CDF(1) = orig_hist(1);
for i = 2:256
    CDF(i) = CDF(i-1) + orig_hist(i);
end
figure, plot(CDF), title('Image CDF');

%Histogram Equalization
for m = 1:M
    for n = 1:N
        r = f(m,n);
        hist_equ(m,n) = CDF(r+1);
    end
end
figure, imshow(hist_equ), title('image enhanced with Histogram Equalization');

%Achive Histogram of Equalized Image
equalizied_histogram = zeros(256,1);
hist_equ = round(hist_equ * 255);
for m = 1:M
    for n = 1:N
        r = hist_equ(m,n);
        equalizied_histogram(r+1) = equalizied_histogram(r+1) + 1;
    end
end
figure, plot(equalizied_histogram), title('Histogram Equalization');

%Bi-Histogram Equalization
mu = round(sum(orig_hist .* [1:256]')); %mean of histogram
CDF1(1) = orig_hist(1); %CDF of first part of Histogram
for i = 2:mu
    CDF1(i) = CDF(i-1) + orig_hist(i);
end
CDF1 = CDF1 / sum(orig_hist(1:mu));

CDF2(1) = orig_hist(mu+1); %CDF of second part of Histogram
for i = mu+2 : 256
    CDF2(i - mu) = CDF2(i - mu - 1) + orig_hist(i);
end
CDF2 = CDF2 / sum(orig_hist(mu+1:256));
figure, subplot(1,2,1), plot(CDF1), title('CDF1');
subplot(1,2,2), plot([mu+1:256],CDF2), title('CDF2');

%Total CDF of Bi-Histogram method
CDF(1:mu) = CDF1;
CDF(mu+1:256) = CDF2(1:256-mu) + 1;
CDF = CDF / 2;
figure, plot(CDF), title('image CDF with Bi-Histogram Equalization');

for m = 1:M
    for n = 1:N
        r = f(m,n);
        bihist_equ(m,n) = CDF(r+1);
    end
end
figure, imshow(bihist_equ), title('image enhanced with Bi-Histogram Equalization');

%Local Histogram Equalization
L = 30; % width of window is (2*L + 1)

%Padding the image (Mirror Padding)
f_padded(1:L , L+1:L+N) = f(1:L , :);
f_padded((M+L+1):(M+2*L) , L+1:L+N) = f((M-L+1):M , :);
f_padded(L+1:L+M , 1:L) = f(: , 1:L);
f_padded(L+1:L+M , (N+L+1):(N+2*L)) = f(: , (N-L+1):N);
f_padded(L+1:M+L , L+1:N+L) = f;

for m = L+1:M+L
    for n = L+1:N+L
        window = f_padded(m-L:m+L , n-L:n+L);
        w_hist = zeros(256,1);
        for i = 1:2*L+1
            for j = 1:2*L+1
                r = window(i,j);
                w_hist(r+1) = w_hist(r+1)+1;
            end
        end
        w_hist = w_hist / (2*L+1)^2;
        r = f_padded(m,n);
        CDF_r = sum(w_hist(1:r+1));
        local_hist_equ(m-L,n-L) = CDF_r;
    end
end
figure, imshow(local_hist_equ); title(['Image enhanced by Local Histogram Equalization with W = ', num2str(2*L+1)]);