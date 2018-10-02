clc

wa=0.15*pi;
wb=0.25*pi;
M=100;
n=0:M;
w=0.54-0.46*sin(2*pi*n/M);
k=sinc(wb.*(n-M/2))-sinc(wa.*(n-M/2));
h=w.*k;
xfft=fftshift(fft(h,1024));
q=linspace(-pi,pi,1024);
plot(q,abs(xfft))