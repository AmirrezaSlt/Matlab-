clc
clear
close all
f=imread('teapot.jpg');
f=rgb2gray(f);
figure,imshow(f,[]),title('Original Image')
[M,N]=size(f);
h=zeros(256,1);
for m=1:M
    for n=1:N
        r=f(m,n);
        h(r+1)=h(r+1)+1;
    end
end
figure,plot(h),title('Image Histogram')
p=h./(M*N);  
f=255*im2double(f);
gamma=1.5;
f=255^(1-gamma)*f.^gamma;
L=6;          
v=256/L;
gu=fix(f/v);
figure,imshow(gu,[]),title(['Uniform Quantization in ',num2str(L),' Levels']);
t=0:v:256;     
tt=0; 
r=0;
for iteration = 1:10
    for k = 1:L
        num=(t(k):t(k+1)-1)*p(t(k)+1:t(k+1));
        den=sum(p(t(k)+1:t(k+1)));
        r(k)=num/den;
    end
    r(isnan(r))=0; 
    for k=2:L
        t(k)=(r(k)+r(k-1))/2;
        tt(iteration,k-1)=t(k);
    end
end
tt=[zeros(size(tt,1),1),tt,256*ones(size(tt,1),1)];
tt=[(0:v:256);tt];
x=1:size(tt,1);
glm=zeros(M,N);
for i = 1:L
glm=glm+((f>=t(i))&(f<t(i+1)))*r(i);
end
glm=uint8(glm);
figure,imshow(glm,[]),title(['Lloyd max Quantization with ',num2str(L),' Levels']);
figure,plot(x,tt),title(['Lloyd max Quantization Convergence in ',num2str(L),'  Levels']);

