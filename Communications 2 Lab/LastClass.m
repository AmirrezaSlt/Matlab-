clc
clear
close all
x=floor(rand (1,10000)*16);
M=16;
y=qammod(x,M);
y_u=upsample(y,20);
h=0.05*ones(1,20);
y_r=filter(h,1,y_u);
t=0.001:0.001:(length(y_r))*0.001;  
L=1;
for f=0.0001:0.0001:0.01
c1=sin(2*pi*100*t);
c2=cos(2*pi*100*t);
c1p=sin(2*pi*(100+f)*t);
c2p=cos(2*pi*(100+f)*t);
y_c1=real(y_r).*c1;
y_c2=imag(y_r).*c2;
y0=y_c1+y_c2;
% for k=1:20
    k=20;
    snr=10^(k/10);
    snr4=4*snr;
    snrs=10*log10(snr4);
    ch=awgn(y0,snrs,'measured');
    y1=ch;
y_r1=2*y1.*c1p;
y_r2=2*y1.*c2p;     
    for i=1:length(y_r1)/20
        p1(i)=sum(y_r1(20*i-19:20*i));
        p2(i)=sum(y_r2(20*i-19:20*i));
    end
p=p1+j*p2;
r=qamdemod(p,M);
[number(L),ratio(L)]=biterr(x,r);
L=L+1;
end
% end
semilogy(0.0001:0.0001:0.01,ratio)
