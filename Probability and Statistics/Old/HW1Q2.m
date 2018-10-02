clc
clear
close all
lambda=5;
r1=poissrnd(lambda,[200 1]);
r2=poissrnd(2*lambda,[200 1]);
% Part a
figure,hist(r1),title('Xi Distribution')
figure,hist(r2),title('Yi Distribution')
% Part b 
z=r1+r2;
figure,hist(z),title('Z Distribution')