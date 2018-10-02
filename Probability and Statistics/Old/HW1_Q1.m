clc
clear
close all
x=rand(1,1000);
y=rand(1,1000);
plot(x,y,'bx'),title('Point Locations')
% part a
figure,hist(x,50),title('x Distributions');
figure,hist(y,50),title('y Distributions');
figure,histogram2(x,y,50),title('joint x&y Distributions')
% Part b
zb=x+y;
figure,hist(zb,100),title('Distribution of z=x+y')
% Part c
zc=x.*y;
figure,hist(zc,100),title('Distribution of z=x*y')
% Part d
zd=x./y;
figure,hist(zd,100),axis([0 30 0 850]),title('Distribution of z=x/y')
