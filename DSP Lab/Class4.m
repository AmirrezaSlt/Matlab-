clc
clear
close all
%% Part 1 
% the whole program is written inside a single loop for the 3 amounts of R to make it shorter and
% to stop repetition.
f0=500;
fs=10000;
f=linspace(-pi,pi,500);
n1=0:300;
w0=2*pi*f0/fs;
y(1)=0;
y(2)=0;
delta=[0,0,1,zeros(1,300)];
vn=randn(1,301);
s=cos(w0*n1);
x=cos(w0*n1)+vn;
y_out(1)=0;
y_out(2)=0;
x_in=[0 0 x];
v_in=[0 0 vn];
yn_out(1)=0;
yn_out(2)=0;
for r=0.95:0.02:0.99
%    part a
g=(1-r)*sqrt(1-2*r*cos(2*w0)+r^2);
numh=g;
a1=-2*r*cos(w0);
a2=r^2;
denh=[1 a1 a2];
u=freqz(numh,denh,f);
% figure
% plot(f,abs(u).^2)
% figure
% freqz(numh,denh,f)

%   Part b
    for n=3:303
    y(n)=-a1*y(n-1)-a2*y(n-2)+g*delta(n);
    end
    h2=filter(numh,denh,delta);
    h22=h2/g;
%     figure 
%     plot(y/g)
%     figure 
%     plot(h22)
%   part c
    for n=3:303
    y_out(n)=-a1*y_out(n-1)-a2*y_out(n-2)+g*x_in(n);
    end
    for n=3:303
    yn_out(n)=-a1*yn_out(n-1)-a2*yn_out(n-2)+g*v_in(n);
    end
%   figure
%   plot(y_out)
%   hold on 
%   plot(s)
%   legend('filtered signal','original signal')
%  Part d
%   figure
%   plot(v_in)
%   hold on 
%   plot(yn_out)
%   legend('original noise','filtered noise')
% Part f
a=std(v_in);
b=std(yn_out);
c1=(b^2)/(a^2);
c2=sum(y.^2);
c3=(1+r^2)/((1+r)*(1+2*r*cos(w0)+r^2));
end
