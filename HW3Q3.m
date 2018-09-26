clc
clear
close all
h=input('Please insert a value for h : ');
T=1;
f=-pi:0.01:pi;
for k=1:4
M=[2 4 8 16];
phi=(sin(M(k)*pi*h)/(M(k)*sin(pi*h)));
s1=[];
for i=1:M
    s2=(sin(pi*(f*T-(h/2)*(2*i-1-M(k)))))./(pi*(f*T-(h/2)*(2*i-1-M(k))));
    s2=[s1;s2];
end
s4=(1/M(k))*sum(s2.^2,1);
s5=[];
for i=1:M(k)
    for j=1:M(k)
        a=pi*h*(i+j-1-M(k));
        s6=(cos(2*pi*f*T-a)-phi*cos(a))./(1+phi^2-2*phi*cos(2*pi*f*T));
        s6=[s5;s6];
    end
end
s8=(2/(M(k)^2))*sum(s6.*s2.*s2,1);
sT=T*(s4+s8);
hold on;
plot(abs(f*T),sT)
title('Spectral Density')
end