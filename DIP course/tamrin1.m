clc
clear 
close all

M=400;
N=400;
sq1=zeros(M,N);
sq1(M/2+1:M,M/2+1:M)=1;
sq1(1:M/2,1:M/2)=1;
figure(1);
subplot(2,2,1)
imshow(sq1);title('sqr 1');

sq2=zeros(M,N);
sq2(1:M/2,M/2+1:M)=1;
sq2(M/2+1:M,1:M/2)=1;
subplot(2,2,2)
imshow(sq2);title('sqr 2');

tri1=zeros(M,N);
% for m=1:M
%     if m<=M/2
%         tri1(m,m:(M+1)-m)=1;
%     end
%     if m >M/2
%         tri1(m,(M+1)-m:m)=1;
%     end
% end
for m=1:M
    for n=1:N
        tri1(m,n)= abs(m-M/2) > abs(n-N/2) ;
    end
end
subplot(2,2,3)
imshow(tri1);title('tri 1');
for m=1:M
    for n=1:N
        tri2(m,n)= abs(m-M/2) < abs(n-N/2) ;
    end
end
subplot(2,2,4)
% tri2=double(tri2);
imshow(tri2);title('tri 2');

z1=sq1.*tri1;
z2=sq2.*tri1;
z3=sq1.*tri2;
z4=sq2.*tri2;

figure(2);
subplot(2,2,1);
imshow(z1);title('z1');
subplot(2,2,2);
imshow(z2);title('z2');
subplot(2,2,3);
imshow(z3);title('z3');
subplot(2,2,4);
imshow(z4);title('z4');


for x=-M/4:M/4-1
    for y=-N/4:N/4-1
        y11(x+M/4+1,y+N/4+1)=tri1(x+y+M/2+1,y+N/2+1);
        y12(x+M/4+1,y+N/4+1)=tri1(x-y+M/2+1,y+N/2+1);
        y13(x+M/4+1,y+N/4+1)=tri1(x+M/2+1,x+y+N/2+1);
        y14(x+M/4+1,y+N/4+1)=tri1(x+M/2+1,y-x+N/2+1);
    end
end
figure(3);
subplot(2,2,1);
imshow(y11);title('y11');
subplot(2,2,2);
imshow(y12);title('y12');
subplot(2,2,3);
imshow(y13);title('y13');
subplot(2,2,4);
imshow(y14);title('y14');


for x=-M/4:M/4-1
    for y=-N/4:N/4-1
        y21(x+M/4+1,y+N/4+1)=tri2(x+y+M/2+1,y+N/2+1);
        y22(x+M/4+1,y+N/4+1)=tri2(x-y+M/2+1,y+N/2+1);
        y23(x+M/4+1,y+N/4+1)=tri2(x+M/2+1,x+y+N/2+1);
        y24(x+M/4+1,y+N/4+1)=tri2(x+M/2+1,y-x+N/2+1);
    end
end
figure(4);
subplot(2,2,1);
imshow(y21);title('y21');
subplot(2,2,2);
imshow(y22);title('y22');
subplot(2,2,3);
imshow(y23);title('y23');
subplot(2,2,4);
imshow(y24);title('y24');


f1=y11.*sq2(M/4+1:M/4+M/2,M/4+1:M/4+M/2);
f2=y12.*sq1(M/4+1:M/4+M/2,M/4+1:M/4+M/2);
f3=y13.*z4(M/4+1:M/4+M/2,M/4+1:M/4+M/2);
f4=y14.*z3(M/4+1:M/4+M/2,M/4+1:M/4+M/2);
f5=y21.*z2(M/4+1:M/4+M/2,M/4+1:M/4+M/2);
f6=y22.*z1(M/4+1:M/4+M/2,M/4+1:M/4+M/2);
f7=y23.*sq2(M/4+1:M/4+M/2,M/4+1:M/4+M/2);
f8=y24.*sq1(M/4+1:M/4+M/2,M/4+1:M/4+M/2);
figure(5);
subplot(2,4,1);
imshow(f2);title('f2');
subplot(2,4,2);
imshow(f1);title('f1');
subplot(2,4,3);
imshow(f5);title('f5');
subplot(2,4,4);
imshow(f3);title('f3');
subplot(2,4,5);
imshow(f7);title('f7');
subplot(2,4,6);
imshow(f8);title('f8');
subplot(2,4,7);
imshow(f4);title('f4');
subplot(2,4,8);
imshow(f6);title('f6');
% 

%%%% finger %%%%
close all
f=imread('download1.jpg');
f=rgb2gray(f);
f=imresize(f,[M/2,N/2]);
figure(6);
imshow(f)
[p,q]=size(f);
for m=1:p
    for n=1:q
        g(m,n)=(-1)^(m+n)*f(m,n);
    end
end
%% Filtered  Image in Frequency
F=fft2(g);
[M,N]=size(F);
FF=zeros(M,N,8);
FF(:,:,1)=F.*f1;
FF(:,:,2)=F.*f2;
FF(:,:,3)=F.*f3;
FF(:,:,4)=F.*f4;
FF(:,:,5)=F.*f5;
FF(:,:,6)=F.*f6;
FF(:,:,7)=F.*f7;
FF(:,:,8)=F.*f8;

%% filtered Image
ff=zeros(M,N,8);

for i=1:8
%       FF(:,:,i)=fftshift(FF(:,:,i));
    ff(:,:,i)=ifft2(FF(:,:,i));
    figure,imshow(ff(:,:,i), []);
    
end
%% Optimized Image

L=16;

W=2*L + 1 ; % window size
fff=padarray(ff,[L L],'symmetric');
fff=real(fff);
image=zeros(M,N);
for m=1:M
    for n=1:N
        sig=zeros(1,8);
        for ii=1:8
            sig(ii)=std2( fff( m:m+2*L , n:n+2*L , ii) );
        end
        y=find( sig==max(sig) );
        
        image(m,n)=fff(m+L, n+L ,y );
    end
end
figure,imshow(image,[])
title(strcat('L=',num2str(L)));


    
