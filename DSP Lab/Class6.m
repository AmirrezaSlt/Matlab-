clc
clear
close all
%% Part 1
pic1=imread('Image01.gif');
% subplot(2,1,1)
% imshow(pic1)
% subplot(2,1,2)
% imshow(pic1,[])
% Scales minimum to zero(white),and max to 255(black)
pic2=imread('Image01.jpg');
% figure
% imshow(pic2)
% figure
% histeq(pic2)
a=histeq(pic2);
% figure
% imhist(pic2)
% figure
% imhist(a)
%% Part 2 
pic3=imread('Image02.jpg');
picn=imnoise(pic3(:,:,1),'gaussian',0,0.64);
% figure
% imshow(picn)
w1=(1/9)*ones(3);
y1=imfilter(picn,w1);
% figure
% imshow(y1)
w2=(1/25)*ones(5);
y2=imfilter(picn,w2);
% figure
% imshow(y2)
picsp=imnoise(pic3(:,:,1),'salt & pepper',0.1);
figure
imshow(picsp)
ysp=imfilter(picn,w1);
% figure
% imshow(ysp)
a1=3;
b1=3;
ym=imfilter(picsp,a1,b1);
figure
imshow(ym)
ymm=medfilt2(picsp,[3,3]);
figure
imshow(ymm)
%% Part 3 
im=imread('Image03.pgm');
figure
imshow(im)
wname = 'db1';
[CA,CH,CV,CD] = dwt2(im,wname,'mode','per');
subplot(221)
imagesc(CV); title('Vertical Detail Image');
colormap gray;
subplot(222)
imagesc(CA); title('Lowpass Approximation');
subplot(223)
imagesc(CH)
subplot(224)
imagesc(CD)