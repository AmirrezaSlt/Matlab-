%% Loading Image and extracting histogram
clc
clear
close all
f=imread('normal_CT.jpg');
[M,N]=size(f);
h=imhist(f);
p=h./numel(f);
figure,imshow(f,[]),title('Original Image')
figure,plot(h),title('Image Histogram')
%% Binarization Using Otsu
for T=1:254
    p1=sum(p(1:T+1));
    p2=sum(p(T+2:256));
    u1=[0:T]*((h(1:T+1))/(sum(h(1:T+1))));
    u2=[T+1:255]*((h(T+2:256))/(sum(h(T+2:256))));
    zigma1=(([0:T]-u1).^2)*((h(1:T+1))/(sum(h(1:T+1))));
    zigma2=(([T+1:255]-u2).^2)*((h(T+2:256))/(sum(h(T+2:256))));
    epsilon(T)=(zigma1*sum(p(1:T+1)))+(zigma2*sum(p(T+2:256)));
end
T_new=find(epsilon==min(epsilon));
for m=1:M
    for n=1:N
         g2(m,n) =f(m,n)>=T_new;
    end
end
figure,imshow(g2,[]),title(['Binary Image Using Otsu Method with Threshold= ',num2str(T_new)])
g2=~g2;
figure,imshow(g2,[]),title(['Reverse of the Binary Image Using Otsu Method with Threshold= ',num2str(T_new)])
%% Labeling and Segmentation 
[L,num]=bwlabel(g2,4);
figure,mesh(L),title('Labeled Image')
im=zeros(size(g2));
for m=1:M
    for n=1:N
         if L(m,n)==5;im(m,n)=g2(m,n); end
    end
end
figure,imshow(im,[]),title('Output of Label= 5 in Image')
% Image Segmentation
f=255.*im2double(f);
f_new=f.*im;
figure,imshow(f_new,[]),title('Segmented Image')
%% Pseudo Coloring by Quantized Colors
x=0:0.0156:4-0.0156;
y=ceil(x);
figure;subplot(2,1,1);
p=plot(x,y);
set(p,'Color','blue','LineWidth',2);axis([0 4 0 5]);
set(gca,'YTickLabel',{'0','C1','C2','C3','C4','C5'});
set(gca,'XTickLabel',{'0','32','64','96','128','160','192','224','256'});
xlabel('Intensity level');ylabel('Colers (R,G,B)');
title('Quantized colers for R & G & B','FontWeight','bold');
x=0:255;
B=(-1/255)*x+1;
subplot(2,1,2);p=plot(x,B);
set(p,'Color','blue','LineWidth',2);axis([0 1 0 257])
title('linear function for R & G & B','FontWeight','bold');
R=(1/255)*x;
hold on ;p=plot(x,R);
set(p,'Color','red','LineWidth',2);axis([0 1 0 257])
G=(-1/128)*abs(x-128)+1;
hold on ;p=plot(x,G);
set(p,'Color','green','LineWidth',2);axis([0 257 0 1])
legend('B','R','G');
xlabel('Gray image Intensity level');ylabel('Colers intensity');
r=zeros(M,N);g=zeros(M,N);b=zeros(M,N);
for m=1:M
    for n=1:N
        if f_new(m,n)<=64
            r(m,n)=0;
            g(m,n)=0;
            b(m,n)=50/256;
        elseif f_new(m,n)>64&&f_new(m,n)<=128
            r(m,n)=0;
            g(m,n)=150/256;
            b(m,n)=50/256;
        elseif f_new(m,n)>128&&f_new(m,n)<=192
            r(m,n)=150/256;
            g(m,n)=20/256;
            b(m,n)=0;
        elseif f_new(m,n)>192&&f_new(m,n)<=256
            r(m,n)=200/256;
            g(m,n)=0;
            b(m,n)=0;
        end
    end
end
g_new(:,:,1)=r(:,:);
g_new(:,:,2)=g(:,:);
g_new(:,:,3)=b(:,:);
figure,imshow(g_new,[]),title('Pseudo Colored by 4 Quantized Colors')
%% Pseudo colering image by color functions
for m=1:M
    for n=1:N
        B1(m,n)=(-1/255)*f_new(m,n)+1;
        R1(m,n)=(1/255)*f_new(m,n);
        G1(m,n)=(-1/128)*abs(f_new(m,n)-128)+1;
    end
end
g_new(:,:,1)=R1;
g_new(:,:,2)=G1;
g_new(:,:,3)=B1;
figure,imshow(g_new,[]),title('Pseudo Colered by Linear Function for R & G & B')