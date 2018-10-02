clc
clear 
close all
x=-5:0.01:5;
y=-5:0.01:5;
[X,Y]=meshgrid(x,y);
f=sin(X).*sigmoid(Y)+1./(1+X.*Y);
surf(X,Y,f)
title('The actual answer')
x=x(:);
y=y(:);
f=f(:);
n=length(x);
a=randperm(n,100);
x1=x(a);
y1=y(a);
f1=f(a);
input=[x1,y1];
nftool