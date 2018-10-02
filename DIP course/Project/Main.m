clc
clear
close all
f=imread('1.bmp');
f=rgb2gray(f);
f=im2double(f);
f=f(23:end,:);
f=padarray(f,[(320-218)/2 0]);
figure,imshow(f,[]),title('Grey Image')
[M,N]=size(f);
F=fftshift(fft2(f));
figure,mesh(log(abs(F))),title('FFT of the Image')
%% Denoising 
% sx=0.15;
% sy=0.15;
% for m=1:M
%     for n=1:N
%         x=m-M/2;
%         y=n-N/2;
%         hd(m,n)=exp(-((sx^2)*x^2)/2)*exp(-((sy^2)*y^2)/2);
%     end
% end
% hdn=(hd-min(min(hd)))./(max(max(hd))-min(min(hd)));
% Ff=hdn.*F;
% Fd=F-Ff;
% fd=abs(ifft2(fftshift(Fd)));
% figure,mesh(log(abs(Fd))),title('FFT of the Denoised Image')
% figure,imshow(fd,[]),title('Denoised Image')
%% Working with Different Filters
close all
clc
%h1
h1=ones(size(f))/1000;
h1(:,145:175)=1;
% h1(1:M/2-15,145:175)=0;
% h1(M/2+15:end,145:175)=0;
o1=F.*h1;
g1=ifft2(fftshift(o1));
% figure,mesh(log(abs(o1))),title('h1')
% figure,imshow(g1,[]),title('h1')
% gamma=0.95;
% g1g=g1.^gamma;
% figure,imshow(g1g,[]),title('Gamma h1')
%h2
h2=ones(size(f))/1000;
slope=M/N;
for n=-N/2+1:N/2-1
   for m=M/2-round(abs(slope*n)):M/2+round(abs(slope*n))
       h2(m,n+N/2)=1;
   end
end
o2=F.*h2;
g2=ifft2(fftshift(o2));
figure,mesh(log(abs(o2))),title('h2')
% figure,imshow(g2,[]),title('h2')
gamma=0.75;
g2g=g2.^gamma;
figure,imshow(g2g,[]),title('Gamma h2')
%% Level set//////////////////////////////
f=real(g2g);
figure; imshow(f,[]);
[Dx,Dy] = gradient(f);
grad_mag = sqrt(Dx.^2 + Dy.^2);
G_M = 1+1*grad_mag;
p = 1./G_M;
p = double(p);
phi = ones(M,N);
phi(3:M-3,3:N-3)=-1;
figure;contour(phi,[0 0],'r');axis equal;
figure;mesh(phi);
% pause;
phi = double((phi>0).*(bwdist(phi<0)-0.5)-(phi<0).*(bwdist(phi>0)-0.5));
e=1.35;u=1;
for iter = 1:100
    phi = phi + e*p;
    g=zeros(M,N);
    figure(34);imshow(f,[]);hold on;
    contour(phi,[0 0],'r','LineWidth',2);
    title(['Number of iterations = ',num2str(iter)]);
    pause(0.1);
    F2(u)=getframe;
    u = u+1;
    phi(phi>0)=1;
    phi(phi<=0)=-1;
    T = phi>0;TT=phi<=0;phi=T-TT;
    phi = double((phi>0).*(bwdist(phi<0)-0.5)-(phi<0).*(bwdist(phi>0)-0.5));
    hold on
end
figure ; contour(phi,[0 0],'LineWidth',2); axis equal;
title('Level Set Active Contour','LineWidth',2); 
%% Directional Filters 
M1=2*M;
N1=2*N;
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
o1=F.*ff1;
o1=ifft2(fftshift(o1));
o2=F.*ff2;
o2=ifft2(fftshift(o2));
o3=F.*ff3;
o3=ifft2(fftshift(o3));
o4=F.*ff4;
o4=ifft2(fftshift(o4));
o5=F.*ff5;
o5=ifft2(fftshift(o5));
o6=F.*ff6;
o6=ifft2(fftshift(o6));
o7=F.*ff7;
o7=ifft2(fftshift(o7));
o8=F.*ff8;
o8=ifft2(fftshift(o8));
% figure,imshow(o1,[])
% figure,imshow(o2,[])
% figure,imshow(o3,[])
% figure,imshow(o4,[])
% figure,imshow(o5,[])
% figure,imshow(o6,[])
% figure,imshow(o7,[])
% figure,imshow(o8,[])
figure,suptitle('Fan Filter Outputs')
for t=1:8
    num=num2str(t);
    str=strcat('o',num);
    myvar=eval(str);
    subplot(4,2,t)
    imshow(myvar,[])
end
o(:,:,1)=o1;
o(:,:,2)=o2;
o(:,:,3)=o3;
o(:,:,4)=o4;
o(:,:,5)=o5;
o(:,:,6)=o6;
o(:,:,7)=o7;
o(:,:,8)=o8;
L=7;
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
%% Circle
c=zeros(3,4);
mix=zeros(6,4);
rc=[];
for r=35:3:55
    gc=circlemap(g2g,r);
    figure,imshow(gc,[]),title(num2str(r))
    [sorted,I]=sort(gc(:),'descend');
    sorted3=sorted(1:3);
    R=[r;r;r];
    for i=1:3
         rc(i,:)=[ceil(I(i)/N) mod(I(i),N)];
    end
    top3=[sorted3 R rc];
    mix=[c;top3];
    mix=sortrows(mix,'descend');
    c=mix(1:3,:);
end
figure,imshow(fd,[])
hold on 
viscircles([c(3),c(4)],c(2),'EdgeColor','r')
% Matlab Hough Transform Command
% figure,imshow(g2g,[])
% [centers,radii,metric]=imfindcircles(fd,[5 50]);
% centersStrong5=centers(1:5);
% radiiStrong5=radii(1:5);
% metricStrong5=metric(1:5);
% viscircles(centerStrong5,radiiStrong5,'EdgeColor','r')
%% Median Filter
% w=5;
% gm=avgf(g2,w);
% for i=1:4
%     gm=medf(gm,5);
% end
% figure,imshow(gm,[]),title('Median Filter Result')
%% Smoothing
% w=5;
% gs=avgf(g2,w);
% for i=1:5
%     gs=avgf(gs,5);
% end
% figure,imshow(gs,[]),title('Smoothed Image')
%% Gabor Filter
% sx=0.15;
% sy=0.25;
% c=[40,40];
% for theta=0:pi/4:2*pi-pi/4
%     t=theta./(pi/4)+1;
%     for m=1:M
%         for n=1:N
%             x=(m-M/2)*cos(theta)-(n-N/2)*sin(theta);
%             y=(m-M/2)*sin(theta)+(n-N/2)*cos(theta);
%             x=x-c(1)*cos(theta);
%             y=y-c(2)*sin(theta);
%             h(m,n,t)=exp(-((sx^2)*x^2)/2)*exp(-((sy^2)*y^2)/2);
%         end
%     end
% end
% for t=1:8
%     hn(:,:,t)=(h(:,:,t)-min(min(h(:,:,t),1),2))./(max(max(h(:,:,t),1),2)...
%     -min(min(h(:,:,t),1),2));
%     u(:,:,t)=Fd.*h(:,:,t);
%     o(:,:,t)=ifft2(u(:,:,t));
% end
% for t=1:8
%     for m=1:M
%         for n=1:N
%             o(m,n,t)=((-1)^(m+n))*o(m,n,t);
%         end
%     end
%     figure,imshow(o(:,:,t),[])
% end
% L=17;
% Ws=2*L+1;
% am=0;
% output=zeros(size(f));
% for i=1+L:Ws:M-L
%     for j=1+L:Ws:N-L
%         for k=1:8
%             a=std2(o(i-L:i+L,j-L:j+L,k));
%             if a>am;output(i-L:i+L,j-L:j+L)=o(i-L:i+L,j-L:j+L,k);end
%             am=max(am,a);
%         end
%         am=0;
%     end
% end
% figure,imshow(output,[]),title('Gaussian Final Output')
%% Thresholding idea
level=multithresh(abs(g2g),2);
fs=imquantize(real(g2g),level);
figure,imshow(fs,[]),title('Quantized with 2 Thresholds')