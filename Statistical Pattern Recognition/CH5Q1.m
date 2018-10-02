clc
clear
close all
% Part a 
disp('for N1=100 and N2=100:')
N1=100;
m1=0;
x1=randn(1,N1)+m1;
N2=100;
m2=2;
x2=randn(1,N2)+m2;
mh1=mean(x1);
varh1=std(x1).^2;
mh2=mean(x2);
varh2=std(x2).^2;
t=abs(mh1-mh2)/sqrt(varh1/N1+varh2/N2);
nu=N1+N2-2;
% SL=tpdf(m1-m2,2);
SL=ttest2(x1,x2);
disp(['Significance level for m2=2 is : ',num2str(SL)]);
% Part b
m2=0.2;
x2=randn(1,N2)+m2;
mh1=mean(x1);
varh1=std(x1).^2;
mh2=mean(x2);
varh2=std(x2).^2;
% SL=tpdf(m1-m2,2);
SL=ttest2(x1,x2);
disp(['Significance level for m2=0.2 is : ',num2str(SL)]);
% Part c
disp('for N1=150 and N2=200:')
N1=150;
m1=0;
x1=randn(1,N1)+m1;
N2=200;
m2=2;
x2=randn(1,N2)+m2;
mh1=mean(x1);
varh1=std(x1).^2;
mh2=mean(x2);
varh2=std(x2).^2;
t=abs(mh1-mh2)/sqrt(varh1/N1+varh2/N2);
nu=N1+N2-2;
% SL=tpdf(m1-m2,2);
SL=ttest2(x1,x2);
disp(['Significance level for m2=2 is : ',num2str(SL)]);
m2=0.2;
x2=randn(1,N2)+m2;
mh1=mean(x1);
varh1=std(x1).^2;
mh2=mean(x2);
varh2=std(x2).^2;
% SL=tpdf(m1-m2,2);
SL=ttest2(x1,x2);
disp(['Significance level for m2=0.2 is : ',num2str(SL)]);