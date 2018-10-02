clc;
clear;
close all;
f=imread('bloodcells1.jpg');
f=rgb2gray(f);
[M,N]=size(f);
h=imhist(f);   
p=h/(M*N); 
figure,imshow(f,[]); title('Original Image');
figure,plot(h),title('Image Histogram')
T=128;
for m=1:M
    for n=1:N
        g(m,n)=f(m,n)>=T;
    end 
end
figure;imshow(g,[]);title('Predefined T=128');
for iter=1:50
    p1=h(1:T+1,1)/sum(h(1:T+1,1));
    u1=[0:T]*p1;
    p2=h(T+2:256,1)/sum(h(T+2:256,1));
    u2=[T+1:255]*p2;
    T_new(iter+1)=(u1+u2)/2;
    T=T_new(iter+1);
end
for m=1:M
    for n=1:N
        g1(m,n)=f(m,n)>=T;
    end 
end
t1=1:51;
figure,imshow(g1); title(['Adaptive Threshold T=',num2str(T)]);
for T=1:254
    p1=sum(p(1:T+1));
    p2=sum(p(T+2:256));
    u1=[0:T]*((h(1:T+1))/(sum(h(1:T+1))));
    u2 = [T+1:255]*((h(T+2:256))/(sum(h(T+2:256))));
    zigma1=(([0:T]-u1).^2)*((h(1:T+1))/(sum(h(1:T+1))));
    zigma2=(([T+1:255]-u2).^2)*((h(T+2:256))/(sum(h(T+2:256))));
    epsilon(T)=(zigma1*sum(p(1:T+1)))+(zigma2*sum(p(T+2:256)));
end 
T2=find(epsilon==min(epsilon));
for m=1:M
    for n=1:N
        g2(m,n)=f(m,n)>= T2;
    end 
end
figure,imshow(g2),title(['Otsu T=',num2str(T2)])
w=31;
k=0.2;
fp=padarray(f,[(w-1)/2 (w-1)/2],'symmetric','both');
for m=(1+(w-1)/2):M+2
    for n=(1+(w-1)/2):N+2
        fw=fp(m-(w-1)/2:m+(w-1)/2,n-(w-1)/2:n+(w-1)/2);
        wstd=std2(fw);
        wm=mean2(fw);
        T(m-(w-1)/2,n-(w-1)/2)=wm-(k*wstd);
        g3(m-(w-1)/2,n-(w-1)/2)=fp(m,n)>=T(m-(w-1)/2,n-(w-1)/2);
    end 
end
figure,imshow(g3,[]),title('Niblack')
w=51;
k=0.1;
fp=padarray(f,[(w-1)/2 (w-1)/2],'symmetric','both');
fstd=128;
for m=(1+(w-1)/2):M+2
    for n=(1+(w-1)/2):N+2
        fw=fp(m-(w-1)/2:m+(w-1)/2,n-(w-1)/2:n+(w-1)/2);
        wstd=std2(fw);
        wm=mean2(fw);
        T(m-(w-1)/2,n-(w-1)/2)=wm*(1-k*(1-(wstd/fstd)));
        g4(m-(w-1)/2,n-(w-1)/2)=fp(m,n) >= T(m-(w-1)/2,n-(w-1)/2);
    end 
end
figure,imshow(g4,[]),title('Sauvola')