    clc
clear 
close all
% Part 1
t = 0:0.01:2;
y = 5*sin(2*pi*t);
plot(t,y)   
title('plot of the 5sin(2*pi*t)')
xlabel('t')
ylabel('amplitude')
figure
stem(t,y)
title('stem of the 5sin(2*pi*t)')
xlabel('t')
ylabel('amplitude')
% %Part 2 
y_noisy = y + rand(size(t));
subplot(2,2,1)
plot(t,y)
subplot(2,2,3)
plot(t,y_noisy)
subplot(2,2,2)
stem(t,y)
subplot(2,2,4)
stem(t,y_noisy)
%part 3
moving_avg = ones(1,20)*0.05;
result = conv(y_noisy,moving_avg);
t2 = 0:0.01:(length(result)-1)*0.01;
plot(t2,result)
hold on 
plot(t,y,'r')
legend('convolved with moving average','the original result')
%part 4
filtered_out = filter(0.05*ones(1,20),1,y_noisy);
figure
plot(t2,result)
hold on 
plot(t,filtered_out,'g')
legend('convolved with moving average','using the filter command')
% part 5 
% Part 6
x=cos(2*pi*t)+cos(8*pi*t)+cos(12*pi*t);
plot(t,x)
f=5;
T=1/f;
ts=0:T:2;
xs=cos(2*pi*ts)+cos(8*pi*ts)+cos(12*pi*ts);
hold on 
plot(ts,xs,'ro')
grid on
[T1,Ts]=ndgrid(t,ts);
xr=sinc((T1-Ts)/T)*xs';
figure
plot(t,xr)
hold on
plot(t,x,'r')
hold on 
plot(ts,xs,'o')
legend('Reconstructed signal','Original Signal','Samples')
%Part 7
tt = 0:0.005:10;
x1 = 2*tt.*exp(-tt);
tt1=0:10;
x11=2*tt1.*exp(-tt1);
[a1,f1]=freqz(x1);
[a2,f2]=freqz(x11);
figure
plot(f1,abs(a1),'b');
hold on
plot(f2,abs(a2),'r');
axis([0 0.2 0 400])
% Part 8
t=0:1/(2*pi):60;
f1=pi/16;
f2=5*pi/16;
f3=9*pi/16;
f4=13*pi/16;
x=cos(2*pi*f1*t)+cos(2*pi*f2*t)+cos(2*pi*f3*t)+cos(2*pi*f4*t);
xfft=fftshift(fft(x,512));
w=linspace(-pi,pi,512);
h=xlsread('filters.xls',1);
f=xlsread('filters.xls',2);
y=zeros(4,length(x));
for i=1:4
   y(i,:)=filter(h(i,:),1,x); 
end
y11=downsample(y',4);
y1=y11';
pu=[2,0,1,0.5];
for i=1:4
y2(i,:)=pu(i)*y1(i,:);
end
for i=1:4
   y3(i,:)=upsample(y2(i,:),4); 
end
for i=1:4
   y4(i,:)=filter(h(i,:),1,y3(i,:)); 
end
y3=resample(y2,4,1);
y5=sum(y4);
yfft=fftshift(fft(y5,512));
w=linspace(-pi,pi,512);
figure
plot(w,abs(xfft))
hold on
plot(w,4*abs(yfft),'r')
legend('The original signal','filtered signal')
grid on
