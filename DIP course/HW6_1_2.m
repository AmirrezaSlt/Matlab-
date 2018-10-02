%% Loading Image and Acquiring FFT
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
%% Designing Gaussian Filters
sx=0.15;
sy=0.25;
c=[40,40];
for theta=0:pi/4:2*pi-pi/4
    t=theta./(pi/4)+1;
    for m=1:M
        for n=1:N
            x=(m-M/2)*cos(theta)-(n-N/2)*sin(theta);
            y=(m-M/2)*sin(theta)+(n-N/2)*cos(theta);
            x=x-c(1)*cos(theta);
            y=y-c(2)*sin(theta);
            h(m,n,t)=exp(-((sx^2)*x^2)/2)*exp(-((sy^2)*y^2)/2);
        end
    end
end
%% Obtaining Output
for t=1:8
    hn(:,:,t)=(h(:,:,t)-min(min(h(:,:,t),1),2))./(max(max(h(:,:,t),1),2)...
    -min(min(h(:,:,t),1),2));
    u(:,:,t)=Fc.*h(:,:,t);
    o(:,:,t)=ifft2(u(:,:,t));
end
for t=1:8
    for m=1:M
        for n=1:N
            o(m,n,t)=((-1)^(m+n))*o(m,n,t);
        end
    end
    figure,imshow(o(:,:,t),[])
end
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
figure,imshow(output,[]),title('Gaussian Final Output')
