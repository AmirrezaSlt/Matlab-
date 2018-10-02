clc
clear
close all
f=imread('1444076886930.png');
f=rgb2gray(f);
f=im2double(f);
figure,imshow(f,[]),title('Original Fingerprint Image');
[M,N]=size(f);
fc=zeros(size(f));
% Preprocessing Image (Centering FFT)
for m=1:M
    for n=1:N
        fc(m,n)=((-1)^(m+n))*f(m,n);
    end
end
Fc=fft2(fc);
figure,mesh(log(abs(Fc))),title('Logarithm of 2D FFT on the Center')
%% Designing Square1,square2,f1 and f2 
[M1,N1]=size([f,f;f,f]);
sq1=zeros([M1,N1]);
sq1(M1/2+1:M1,M1/2+1:M1)=1;
sq1(1:M1/2,1:M1/2)=1;
sq2=fliplr(sq1);
f2=zeros([M1,N1]);
for m=1:M1
    for n=1:N1
        if abs(n-N1/2)>abs(m-M1/2)
            f2(m,n)=1;
        end
    end
end
f1=f2';
figure
subplot(2,2,1)
imshow(sq1,[]),title('Square1')
subplot(2,2,2)
imshow(sq2,[]),title('Square2') 
subplot(2,2,3)
imshow(f1,[]),title('f1')
subplot(2,2,4)
imshow(f2,[]),title('f2')
%% Designing z1,z2,z3,z4
z1=f1.*sq1;
z2=f1.*sq2;
z3=f2.*sq1;
z4=f2.*sq2;
figure
subplot(2,2,1)
imshow(z1,[]),title('z1')
subplot(2,2,2)
imshow(z2,[]),title('z2')
subplot(2,2,3)
imshow(z3,[]),title('z3')
subplot(2,2,4)
imshow(z4,[]),title('z4')
%% Creating y1 and y2
r0=[1 1;0 1];
r1=[1 -1;0 1];
r2=[1 0;1 1];
r3=[1 0;-1 1];
y11=zeros(size(f));
y12=y11;y13=y11;y14=y11;y21=y11;y22=y11;y23=y11;y24=y11;
for m=-M1/4:M1/4-1
    for n=-N1/4:N1/4-1
        y11(m+M1/4+1,n+N1/4+1)=f1(m+M1/2+1,n+M1/2+1);
        y12(m+M1/4+1,n+N1/4+1)=f1(m-n+M1/2+1,n+M1/2+1);
        y13(m+M1/4+1,n+N1/4+1)=f1(m+M1/2+1,m+n+M1/2+1);
        y14(m+M1/4+1,n+N1/4+1)=f1(m+M1/2+1,n-m+M1/2+1);
        y21(m+M1/4+1,n+N1/4+1)=f2(m+n+M1/2+1,n+M1/2+1);
        y22(m+M1/4+1,n+N1/4+1)=f2(m-n+M1/2+1,n+M1/2+1);
        y23(m+M1/4+1,n+N1/4+1)=f2(m+M1/2+1,m+n+M1/2+1);
        y24(m+M1/4+1,n+N1/4+1)=f2(m+M1/2+1,n-m+M1/2+1);
    end
end
figure,subplot(4,2,1)
imshow(y11,[]),title('y11')
subplot(4,2,2)
imshow(y12,[]),title('y12')
subplot(4,2,3)
imshow(y13,[]),title('y13')
subplot(4,2,4)
imshow(y14,[]),title('y14')
subplot(4,2,5)
imshow(y21,[]),title('y21')
subplot(4,2,6)
imshow(y22,[]),title('y22')
subplot(4,2,7)
imshow(y23,[]),title('y23')
subplot(4,2,8)
imshow(y24,[]),title('y24')
suptitle('y filters')
% Optional : demonstration of sampling boundaries (uncomment to run)
% figure,imshow(f1,[])
% hold on 
% plot([2*M,M,0,M,2*M],[N,2*N,2*N,N,N],'r','LineWidth',3)
% figure,imshow(f1,[])
% hold on 
% plot([2*M,M,0,M,2*M],[N/2,3/2*N,3*N/2,N/2,N/2],'r','LineWidth',3
%% 8 Final Fan Filters
ff1=y11.*sq2(M1/4+1:M1/4+M1/2,M1/4+1:M1/4+M1/2);
ff2=y12.*sq1(M1/4+1:M1/4+M1/2,M1/4+1:M1/4+M1/2);
ff3=y13.*z4(M1/4+1:M1/4+M1/2,M1/4+1:M1/4+M1/2);
ff4=y14.*z3(M1/4+1:M1/4+M1/2,M1/4+1:M1/4+M1/2);
ff5=y21.*z2(M1/4+1:M1/4+M1/2,M1/4+1:M1/4+M1/2);
ff6=y22.*z1(M1/4+1:M1/4+M1/2,M1/4+1:M1/4+M1/2);
ff7=y23.*sq2(M1/4+1:M1/4+M1/2,M1/4+1:M1/4+M1/2);
ff8=y24.*sq1(M1/4+1:M1/4+M1/2,M1/4+1:M1/4+M1/2);
figure,subplot(4,2,1)
imshow(ff1,[])
subplot(4,2,2)
imshow(ff2,[])
subplot(4,2,3)
imshow(ff3,[])
subplot(4,2,4)
imshow(ff4,[])
subplot(4,2,5)
imshow(ff5,[])
subplot(4,2,6)
imshow(ff6,[])
subplot(4,2,7)
imshow(ff7,[])
subplot(4,2,8)
imshow(ff8,[])
suptitle('Fan Filters')
%% Applying Fan Filters
o1=Fc.*ff1;
o1=ifft2(o1);
o2=Fc.*ff2;
o2=ifft2(o2);
o3=Fc.*ff3;
o3=ifft2(o3);
o4=Fc.*ff4;
o4=ifft2(o4);
o5=Fc.*ff5;
o5=ifft2(o5);
o6=Fc.*ff6;
o6=ifft2(o6);
o7=Fc.*ff7;
o7=ifft2(o7);
o8=Fc.*ff8;
o8=ifft2(o8);
for m=1:M
    for n=1:N
        o1(m,n)=((-1)^(m+n))*o1(m,n);
        o2(m,n)=((-1)^(m+n))*o2(m,n);
        o3(m,n)=((-1)^(m+n))*o3(m,n);
        o4(m,n)=((-1)^(m+n))*o4(m,n);
        o5(m,n)=((-1)^(m+n))*o5(m,n);
        o6(m,n)=((-1)^(m+n))*o6(m,n);
        o7(m,n)=((-1)^(m+n))*o7(m,n);
        o8(m,n)=((-1)^(m+n))*o8(m,n);
    end
end
figure,imshow(o1,[])
figure,imshow(o2,[])
figure,imshow(o3,[])
figure,imshow(o4,[])
figure,imshow(o5,[])
figure,imshow(o6,[])
figure,imshow(o7,[])
figure,imshow(o8,[])
%% Fusing the Output Image 
o(:,:,1)=o1;
o(:,:,2)=o2;
o(:,:,3)=o3;
o(:,:,4)=o4;
o(:,:,5)=o5;
o(:,:,6)=o6;
o(:,:,7)=o7;
o(:,:,8)=o8;
L=17;
Ws=2*L+1;
am=0;
output=zeros(size(f));
for i=1+L:Ws:M-L
    for j=1+L:Ws:N-L
        for k=1:8
            a=std2(o(i-L:i+L,j-L:j+L,k));
            if a>am;output(i-L:i+L,j-L:j+L)=o(i-L:i+L,j-L:j+L,k);end
            am=max(am,a);
        end
        am=0;
    end
end
figure,imshow(output,[]),title('Fan Filter Final Output')