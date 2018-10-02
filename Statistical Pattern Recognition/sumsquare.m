clc
clear
close all
rng(1)
sigma=[1 0;0 1];
m1=[+1,0]';
m2=[-1,0]';
x1=mvnrnd(m1,sigma,200)';
x2=mvnrnd(m2,sigma,200)';
plot(x1(1,:),x1(2,:),'r>')
hold on
plot(x2(1,:),x2(2,:),'b^')
legend('class2','class1')
X=[x1 x2]';
y1(1:200)=-1;
y2(1:200)=+1;
Y=[y1 y2 ;y1 y2]';
W=randn(1,2);
b=randn(1);
t=-6:.1:6;
line=(W(1)/W(2))*t;
plot(t,line,'b')
X1=X'*X;
s=sum(X.*Y)';
W=inv(X1)*s;
figure
t=-.2:.1:.2;
line=(W(1)/W(2))*t;
plot(x1(1,:),x1(2,:),'rx')
hold on
plot(x2(1,:),x2(2,:),'bx')
hold on
plot(t,line,'k')
legend('class2','class1','border')
title('Sum of Square Error')



