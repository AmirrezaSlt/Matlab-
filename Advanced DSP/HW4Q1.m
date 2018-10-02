clc
clear
close all
% Part 1 
N=8;
E=exp(-i*2*pi/N);
for i=0:N-1
    for j=0:N-1
        W(i+1,j+1)=E.^(i*j);
    end
end
IW=inv(W);
IIW=1/N*(W');
e1=sum(sum(abs(IW-IIW)));
e2=abs(sse(IW,IIW));
disp(['Sum of absolute error is: ',num2str(e1),' and sum of square error is: ',num2str(e2)]);
% Part 2 
dt=0.001;
t=0:dt:0.4-dt;
f=cos(2*pi*50*t);
L=length(f);
for n=1:L
    a=rand(1);
    if a>0.97 
        y(n)=6;
    else
        y(n)=0;
    end
end
g=f+y;
figure,plot(t,g),title('Noisy Signal')
h1=1/sqrt(2)*[1 -1];
h0=1/sqrt(2)*[1 1];
level=4;
wvtc=zeros(level+1,L/2);
s=g;
for i=1:level
   d=conv(s,h1);
   d=downsample(d,2);
   wvtc(i,1:length(d))=d;
   if i==level
       c=conv(s,h0);
       c=downsample(c,2);
       wvtc(i+1,1:length(c))=c;
   end
   s=d;
end
figure
for i=1:level
    subplot(level+1,1,i)
    plot(wvtc(i,:));  
    title(['d-',num2str(i),',k'])
end
subplot(level+1,1,level+1)
plot(wvtc(level+1,:)); 
title('c-4,k')
suptitle('Coefficients of the noisy signal')
% DFT of the coefficient
s=f;
wvtc=zeros(level+1,floor(L/2)-50);
for i=1:level
   d=conv(s,h1);
   d=downsample(d,2);
   wvtc(i,1:length(d))=d;
   if i==level
       c=conv(s,h0);
       c=downsample(c,2);
       wvtc(i+1,1:length(c))=c;
   end
   s=d;
end
figure
Lc=zeros(1,level);
for i=1:level
    subplot(level+1,1,i)
    plot(wvtc(i,:));   
    title(['d-',num2str(i),',k'])
    Lc(i)=L/(2^i);
end
subplot(level+1,1,level+1)
plot(wvtc(level+1,:)); 
title('c-4,k')
suptitle('Coefficients of the original signal')
FD=fft(wvtc(1,1:Lc(1)));
figure,plot(abs(FD)),title('FFT of d-1,k')
set(gca,'XTick',0:20:200)
set(gca,'XTickLabel',(0:20:200)/200*1000)
FC=fft(wvtc(level+1,1:Lc(level)));
figure,plot(abs(FC)),title('FFT of c-4,k')
set(gca,'XTick',0:2.5:25)
set(gca,'XTickLabel',(0:2.5:25)/25*1000)
plot(wvtc(level+1,1:Lc(level))),title('c-4,k')
x=[1 2 3 4 -4 -3 -2 -1];
X=x*W;
XX=fft(x);
xh=X*(1/N*(W'));
xhh=ifft(XX);
e1=sum(abs(xh-xhh));
e2=abs(sse(xh,xhh));
disp(['Sum of absolute error is: ',num2str(e1),' and sum of square error is: ',num2str(e2)]);