clc
clear
close all
miu=input('Please insert the mean matrix');
sigma=input('Please insert the covariance matrix');
d=length(miu);
data=mvnrnd(miu,sigma);
[v,lambda]=eig(data);
L=sqrt(lambda)*v;
w_data=L\(data-miu);
