clc
clear
close all
l=2;
N=1000; 
w=[1;-5;2];
w0=0;
a=10;
e=1;
sed=0;
X=generate_hyper(w,w0,a,e,N,sed);
[pc,variances]=pcacov(cov(X'));
disp('for e=1:')
disp(['The direction of the first principal component is: [',num2str(pc(1,:)),...
    '] and our w vector is : [',num2str(w'),']']);
l=2;
N=1000; 
w=[1;-5;2];
w0=0;
a=10;
e=5;
sed=0;
X=generate_hyper(w,w0,a,e,N,sed);
[pc,variances]=pcacov(cov(X'));
disp('for e=5:')
disp(['The direction of the first principal component is: [',num2str(pc(1,:)),...
    '] and our w vector is : [',num2str(w'),']']);