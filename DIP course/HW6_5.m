clc
clear
close all
f=imread('Monkman_MABKS_D30112.jpg');
f=im2double(f);
fr=f(:,:,1);
fg=f(:,:,2);
fb=f(:,:,3);
figure,imshow(f,[]),title('Original Image')
l=2.5;
tt1=fr.^l;
tt2=fg.^l;
tt3=fb.^l;
gtt(:,:,1)=tt1;
gtt(:,:,2)=tt2;
gtt(:,:,3)=tt3;
figure,imshow(gtt,[]),title('Tonal Transform Result');
lr1=2;
lr2=0.9;
lg1=3;
lg2=0.8;
lb1=2.1;
lb2=1;
ttr=fr.^lr1;
ttr=(ttr).^(lr2);
ttg=fg.^lg1;
ttg=(ttg).^(lg2);
ttb=fb.^lb1;
ttb=(ttb).^(lb2);
g=zeros(size(f));
g(:,:,1)=ttr;
g(:,:,2)=ttg;
g(:,:,3)=ttb;
g=g-min(g(:));
g=g./max(g(:));
figure,imshow(g,[]),title('Modified Image')