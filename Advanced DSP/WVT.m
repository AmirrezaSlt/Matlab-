clc
clear
close all
f0=2;
f1=8;
t=0:0.01:5;
x=cos(2*pi*f0*t)+cos(2*pi*f1*t);
% xf=fft(x);
L=10;
Nw=2*L+1;
W=hamming(Nw);
M=length(x);
N=100000;
E=exp(1i*4*pi/N);
for m=L+1:M-L
    s=x(m-L:m+L);
    s=W'.*s;
    sinv=fliplr(s);
    S=s.*sinv;
    for k=0:N/4-1
        X(m,k+1)=S*((E.^((m-L:m+L)*k)'));
    end
end
mesh(abs(X))