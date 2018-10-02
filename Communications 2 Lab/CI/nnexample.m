clc
clear
close all
x=-5:0.01:5;
y=-5:0.01:5;
% [X,Y]=meshgrid(x,y);
% z=sin(X)+cos(Y);
% surf(X,Y,z)
% title('The actual answer')
x=x(:);
y=y(:);
z=sin(x)+cos(y);
n=length(x);
a=sort(randperm(n,100));
x1=x(a);
y1=y(a);
z1=z(a);
input=[x1,y1];
nftool