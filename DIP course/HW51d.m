%%%% In the Name of GOD %%%%
%%%% Imgage Processing-HW5
%%%% MohammadReza Jabbari(9601035)-Ali Mahdiyeh(9536644)
clc
clear
close all
format compact

image = imread('WineGlass.jpg');
g = rgb2gray(image);
g = imresize(g,0.6);
[M,N] = size(g);
h = imhist(g);   % Calculate histogram of Image
g = im2double(g); % Scale intensities in [0-1]

figure (1); imshow(g,[]); title(['Original Image - Size = [' num2str(M) ',' num2str(N) ']'])
%%%% Plot Histogram
t=0:255;
figure (2); plot(t,h,'-','linewidth',2); title('Histogram of Image ');
xlabel('Intensity'); ylabel('Number of Pixel'); xlim([0 255])
fig = gcf;
set(fig.Children,'FontName','Times','FontSize',20);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
%% Adding Noise 
f = g + (0.4*rand(M,N));
figure (2); imshow(f,[]); title('Noisy Image')
fig = gcf;
set(fig.Children,'FontName','Times','FontSize',20);
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
%% Calculate FFT of noisy Image
F = fft2(f);
F1 = fftshift(F);

figure (3); mesh(log10(abs(F1)));title(' noisy image')
figure (4); imagesc(log10(abs(F1))); colormap(gray); title('noisy image');

noise = (0.4*rand(M,N));
F_noise = fft2(noise);
F_noise1 = fftshift(F_noise);

figure (25); mesh(log10(abs(F_noise1)));title(' only noise')
figure (20); imagesc(log10(abs(F_noise1))); colormap(gray); title('only noise');

%% Removing DC Components 
% abs_F1 = abs(F1);
% [row,col] = find(abs(F1) == max(abs_F1(:)));
% H = abs_F1 >= 0.02*max(abs_F1(:));
% figure (5); imshow(H); title('Determine Variance of LPF')
% % 
% % sigma_x = 1;
% % sigma_y = 2;
% % k = 1e4;
% % for m=1:M
% %     for n=1:N
% %         H_LPF(m,n) = k*(exp(-((m-row).^2)/(2*sigma_x^2))).*(exp(-((n-col).^2)/(2*sigma_y^2)));
% %     end
% % end
% H_LPF = ones(M,N);
% for u=1:M
%     for v=1:N
%         D = sqrt(((u-(M/2))^2)+((v-(N/2))^2));
%         if D <= 4
%             H_LPF(u,v) = 0;
%         end
%     end
% end
% figure (6); mesh(H_LPF); title('LPF to Remove DC Component')
% Q = F1.*H_LPF;
% q = real(ifft2(ifftshift(Q)));
% figure (7); imshow(q,[]); title('Image its DC Components is Removed')
% figure (8); mesh(abs(Q));
% %% Denoising
% sigma_x = 0.5;
% sigma_y = 0.1;
% k = 0;
% theta = [0 pi/2];
% for k=1
%     for m=1:M
%         for n=1:N
%             x = (m-M/2)*cos(theta(k))-(n-N/2)*sin(theta(k));
%             y = (m-M/2)*sin(theta(k))+(n-N/2)*cos(theta(k));
%             H(m,n,k) = (1/(2*pi*sigma_x*sigma_y))*exp(-((sigma_x^2)*x^2)/2)*exp(-((sigma_y^2)*y^2)/2);
%         end
%     end
% end
% H1=H(:,:,1);
% H2 = H(:,:,2);
% H_norm = (H-min(H(:)))./(max(H)-min(H(:)));
% H_norm = 1-H_norm;
% figure (9); mesh(H(:,:,1)); title('LPF to Remove DC Component X')
% figure (10); mesh(H(:,:,2)); title('LPF to Remove DC Component Y')
% FF = H_norm(:,:,1).*F1;  % two nothch filter
% FF = H_norm(:,:,2).*FF;  % two notch filter
% ff = real(ifft2(ifftshift(FF)));
% figure (7); imshow(ff,[]); title('Image its DC Components is Removed')
% %%
G = fft2(g);
G1 = fftshift(G);

figure (10); mesh(log10(abs(G1)));title(' Spatial (3D) Magnitude Spectrum')
figure (11); imagesc(log10(abs(G1))); colormap(gray); title('2D Magnitude Spectrum');
%% Denoising
sigma_x = 0.025;
sigma_y = 0.015;
theta = 0
for m=1:M
    for n=1:N
        x = (m-M/2)*cos(theta)-(n-N/2)*sin(theta);
        y = (m-M/2)*sin(theta)+(n-N/2)*cos(theta);
        H(m,n) = exp(-((sigma_x^2)*x^2)/2)*exp(-((sigma_y^2)*y^2)/2);
    end
end

H_norm = (H-min(H(:)))./(max(H(:))-min(H(:)));
% H_norm = 1-H_norm;
figure (9); mesh(H_norm); title('LPF to Remove DC Component X')
% figure (10); mesh(H(:,:,2)); title('LPF to Remove DC Component Y')
FF = H_norm.*F1;  % two nothch filter
% FF = H_norm(:,:,2).*FF;  % two notch filter
ff = real(ifft2(ifftshift(FF)));
figure (7); imshow(ff,[]); title('Reduced Noise')