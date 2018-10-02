clc
clear 
close all
%% Part 1
f1=4;
f2=8;
f3=12;
fs=400;
t1=0:1/fs:2-1/fs;
t2=2:1/fs:4-1/fs;
t3=4:1/fs:6-1/fs;
t=[t1 t2 t3];
x1=cos(2*pi*f1*t1);
x2=cos(2*pi*f2*t2);
x3=cos(2*pi*f3*t3);
x=[x1 x2 x3];
a1=1.9765;
a2=0.9922;
b1=0.9961;
b2=1.9765;
b3=0.9961;
n_app=10000;
delta=[0 0 1 zeros(1,n_app)];
h_app=zeros(1,n_app+3);
for n=3:n_app+3
    h_app(n)=a1*h_app(n-1)-a2*h_app(n-2)+b1*delta(n)-b2*delta(n-1)+b3*delta(n-2);
end
num=[b1 -b2 b3];
den=[1 -a1 a2];
% plot(y_out)  
% figure 
% plot(t,x)
% freqz(num,den)
% figure 
% freqz(h_app)
y=filter(num,den,x);
% plot(y)
% freqz(y)
a1=1.9238;
a2=0.9391;
b1=0.9695;
b2=1.9238;
b3=0.9695;
num2=[b1 -b2 b3];
den2=[1 -a1 a2];
% freqz(num2,den2)
% hold on 
% freqz(num,den)
y2=filter(num2,den2,x);
% figure 
% plot(y2)
% freqz(y2)
%% Part 2 
% Peak filter 
b1=0.030469;
b2=0;
b3=-0.030469;
a1=1;
a2=-1.923772;
a3=0.939063;
num3=[b1 b2 b3];
den3=[a1 a2 a3];
y3=filter(num3,den3,x);
% figure
% plot(y3)
% freqz(y3)
b1=0.003912;
b2=0;
b3=-0.003912;
a1=1;
a2=-1.976468;
a3=0.992177;
num4=[b1 b2 b3];
den4=[a1 a2 a3];
y4=filter(num4,den4,x);
figure
plot(y4)
freqz(y4)
%% Part 3 
clc
clear
close all
f=0.15/2;
fs2=1;
t11=0:1/fs2:200-1/fs2;
t22=200:1/fs2:400-1/fs2;
t33=400:1/fs2:600-1/fs2;
tt=[t11 t22 t33];
x11=2*sin(2*pi*f*t11);
x22=4*sin(2*pi*f*t22);
x33=0.5*sin(2*pi*f*t33);
xx=[x11 x22 x33];
% plot(tt,xx)
% Compressor 
Lc=0.9;
c0=0.5;
for n=1:length(xx)
    c(n)=Lc.*c0+(1-Lc).*abs(xx(n));
    c0=c(n);
end
% figure 
plot(c)
p=0.2;
for i=1:length(c)
if c(i)>c0
    ff=(c(i)/c0).^p;
else
    ff=1;
end 
fc(i)=ff;
end 
length=7;
moving_avg=(1/length)*ones(1,7);
y_sc=filter(moving_avg,1,fc);
% plot(y_s)
prc=xx.*y_sc;
plot(prc,'r')
hold on 
plot(xx,'b')
legend('compressed','original')
%%  Expander 
clc
clear
close all
f=0.15/2;
fs2=1;
t11=0:1/fs2:200-1/fs2;
t22=200:1/fs2:400-1/fs2;
t33=400:1/fs2:600-1/fs2;
tt=[t11 t22 t33];
x11=2*sin(2*pi*f*t11);
x22=4*sin(2*pi*f*t22);
x33=0.5*sin(2*pi*f*t33);
xx=[x11 x22 x33];
Lc=0.9;
c0=0.5;
for n=1:length(xx)
    c(n)=Lc.*c0+(1-Lc).*abs(xx(n));
    c0=c(n);
end
Lc=0.9;
c0=0.5;
% figure 
plot(c)
p=2;
for i=1:length(c)
if c(i)<c0
    ff=(c0/c(i)).^(p-1);
else
    ff=1;
end 
fe(i)=ff;
end 
length=7;
moving_avg=(1/length)*ones(1,7);
y_se=filter(moving_avg,1,fe);
% plot(y_s)
pre=xx.*y_se;
plot(pre,'r')
hold on 
plot(xx,'b')



  
