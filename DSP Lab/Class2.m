clc
clear
close all
%% Part 1 Done
%% Part 2 A
L=200;
k=50;
f=1/k;
t=0:L;
x=square(2*pi*f*t);
h=0.1*ones(1,10);
y=myconv(x,h);
stem(y)
%% Part 2 B
n=0:14;
h22=0.25*(0.75).^n;
y22=myconv(h22,x);
figure
stem(y22)
%% Part 2 C
syms z f
f=0.25*((1-1/z)^5);
fn=iztrans(f);
hc=[0.25,-1.25,2.5,-2.5,1.25,-0.25];
y33=myconv(hc,x);
figure 
stem(y33)
%% Part 3 A
w1=.05*pi;
w2=0.2*pi;
w3=0.35*pi;
nn=1:200;
s=sin(w2*nn);
v=sin(w1*nn)+sin(w3*nn);
xn=s+v;
figure
stem(nn,s,'b')
hold on 
stem(nn,xn,'r')
legend('The original signal','distorted signal')
%% Part 3 B
wa=0.15*pi;
wb=0.25*pi;
M=100;
n=0:M;
w=0.54-0.46*sin(2*pi*n/M);
k=sinc(wb.*(n-M/2))-sinc(wa.*(n-M/2));
h=w.*k;

yn=filter(h,1,xn);
stem(nn,s,'b')
hold on
stem(nn,yn,'g')
legend('The pure signal','filtered noisy signal')

%% part 3 C
h1=matfile('F1.mat');
h2=h1.Num;