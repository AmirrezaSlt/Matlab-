clc
clear
close all
%Part 1 
x=floor(rand (1,1000)*16);
n=8;
y=qammod(x,16);
u=upsample(y,n);
%Part 2 
[num,den]=rcosine(1,n);
o=filter(num,den,u);
%Part 3 
w=50;
T=0:1/400:7999/400;
carrier=exp(2*1j*pi*100*T);
o2=real(o.*carrier);
periodogram(o2,[],[],400)
%Part 4
y2=rectpulse(y,8);
o3=real(y2.*carrier);
figure 
periodogram(o3,[],[],400)

