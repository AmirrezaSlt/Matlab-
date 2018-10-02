clc
clear
close all
%% Part 1 
ii=imread('image04.png');
i=im2double(ii);
imshow(i)
h=fspecial('motion',15,20);
y=imfilter(i,h);
imshow(y)
y1=imfilter(i,h,'circular');
figure
imshow(y1)
r=deconvwnr(y1,h,0.00001);
figure
imshow(r)
yn=imnoise(y1(:,:,1),'gaussian',0,0.064);
figure 
imshow(yn)
rn=deconvwnr(yn,h,0.2);
figure
imshow(rn)
%% Part 2 
ji=imread('glass.tif');
j=im2double(ji);
% figure,imshow(j)
u=fftshift(fft2(j));
um=log(1+abs(u));
% figure,imagesc(um)
up=angle(u);
% figure,imagesc(up)
LPu=FFT_LP_2D(j,0.1*pi,1);
figure,imshow(LPu)
j1=downsample(j,4);
j2=downsample(j1',4);
j2=j2';
imshow(j2)