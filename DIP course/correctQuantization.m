clc
clear
close all
f=imread('teapot.jpg');
f=rgb2gray(f);
[M,N]=size(f);
h=zeros(256,1);
for m=1:M
    for n=1:N
        r=f(m,n);
        h(r+1)=h(r+1)+1;
    end
end
p=h./(M*N);  
L=4;          
v=256/L;
gu=fix(f/v);
figure,imshow(gu,[]),title(['Uniform Quantization with ',num2str(L),' Levels']);
t=0:v:256;     
tt=0; 
r=0;
for iteration = 1:20
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
figure,plot(x,tt); title(['Convergence of Lloyd-Max in ' num2str(L) ' Levels quantization']);
