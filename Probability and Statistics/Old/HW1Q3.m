clc
clear
close all
alpha=1;
u1=rand(1000);
figure,hist(u1,30),title('First Uniform Random Variable')
u2=rand(1000);
figure,hist(u2,30),title('Second Uniform Random Variable')
x=log(u1./u2);
figure,hist(x,100),title('Generated Laplacian Random Variable with \alpha=1')