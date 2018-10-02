clc
clear
close all
% Part 1
l=2;
N=1000; 
w=[1;1];
w0=0;
a=10;
e=1;
sed=0;
X=generate_hyper(w,w0,a,e,N,sed);
% Part 2 
[pc,variances]=pcacov(cov(X'));
disp(['The direction of the first principal component is: [',num2str(pc(1,:)),...
    '] and our w vector is : [',num2str(w'),']']);
