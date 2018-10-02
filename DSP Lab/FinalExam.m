clc
clear
close all
%% Part 1 
fs=12000;
f1=100;
t=0:1/(5*fs):0.2;
x1=sin(2*pi*f1*t);
amp=abs(fftshift(fft(x1)));
freq=linspace(-pi,pi,length(amp));
% figure,plot(freq,abs(amp));
load handel.mat
filename_1 = 'test_sound_1.wav';
audiowrite(filename_1,x1,fs);
fs=12000;
f2=1800;
t=0:1/(5*fs):0.2;  
t1=0:1/fs:0.2;     
x2=sin(2*pi*f1*t); 
x2_s=sin(2*pi*f1*t1);
amp=abs(fftshift(fft(x2)));
% figure,plot(amp);
freq=linspace(-pi,pi,length(amp));
% figure,plot(freq,abs(amp));
load('Q1LPF.mat')
filename_2='test_sound_2.wav';
audiowrite(filename_2,x2,fs);
y=zeros(1,length(x2_s));
t1_1=zeros(length(t1),length(t));
T=1/fs;
for n=1:length(t1)
    t1_1(n,:)=(t-t1(n))/T;
end
h=sinc(t1_1);
y=x2_s*h; 
% figure,plot(t,x2)
% figure,stem(t1,x2_s)
% figure,plot(t,y)
fs=12000;
f3=4500;
x3=sin(2*pi*f3*t);
amp=abs(fftshift(fft(x3)));
freq=linspace(-pi,pi,length(amp));
% figure,plot(freq,abs(amp));
load handel.mat
filename_3='test_sound_3.wav';
audiowrite(filename_3,x3,fs);
sum_signal=x1+x2+x3;
amp=abs(fftshift(fft(sum_signal)));
freq=linspace(-pi,pi,length(amp));
%figure,plot(freq,abs(amp));
filename_4 = 'test_sound_4.wav';
audiowrite(filename_4,x1,fs);
x1_s=sin(2*pi*f1*t1); 
x2_s=sin(2*pi*f2*t1); 
x3_s=sin(2*pi*f3*t1); 
sum_signal_sampled = x1_s+x2_s+x3_s;
y=zeros(1,length(sum_signal_sampled));
t1_1=zeros(length(t1),length(t));
T=1/fs;
for n=1:length(t1) 
    t1_1(n,:)=(t-t1(n))/T;
end
h=sinc(t1_1);
y=x2_s*h;  
% figure,plot(t,x2)
% figure,stem(t1,x2_s)
% figure,plot(t,y)
y1=downsample(y,2); 
%% Part 3 
L=800;
k=50;
t0=0:L;
x=square(2*pi*1/k*t0);
audiowrite('square sound.wav',x,1000);
% sound(x,10000)
% figure,plot(abs(fftshift(fft(x))))
load('examLPF.mat')
y=filter(Num,1,x);
% figure,plot(abs(fftshift(fft(y))))
audiowrite('Lowpass filtered square sound.wav',y,1000)
% sound(y,10000)
load('examHPF.mat')
y2=filter(Num2,1,x);
% figure,plot(abs(fftshift(fft(y2))))
audiowrite('Highpass filtered square sound.wav',y2,1000)
% sound(y2,10000)
