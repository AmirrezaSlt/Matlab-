clc
clear
close all
g=imread('1.bmp');
f=g(:,:,3);
f=im2double(f);
f=f(23:end,:);
[M,N]=size(f);
% rbh=4;
% A=strel('disk',rbh);
% f=imbothat(im,A);
F=fftshift(fft(f));
figure,mesh(abs(F))
sx=0.12;
sy=0.04;
c=[5,5];
for theta=0:pi/8:pi-pi/8
    t=theta./(pi/8)+1;
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
figure,suptitle('Gabor Filters')
for t=1:8
    hn(:,:,t)=(h(:,:,t)-min(min(h(:,:,t),1),2))./(max(max(h(:,:,t),1),2)...
    -min(min(h(:,:,t),1),2));
    u(:,:,t)=F.*h(:,:,t);
    o(:,:,t)=ifft2(u(:,:,t));
    subplot(4,2,t)
    imshow(h(:,:,t),[])
end
figure,suptitle('Gabor Outputs')
for t=1:8
    for m=1:M
        for n=1:N
            o(m,n,t)=((-1)^(m+n))*o(m,n,t);
        end
    end
    subplot(4,2,t)
    imshow(o(:,:,t),[])
end
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
% output2=imclose(output,A);
figure,imshow(output,[]),title('Final Output')