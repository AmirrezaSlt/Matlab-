clc
clear
close all
rng default
n=randn(10,1);
x=sqrt(2)*n+1;
mx=mean(x);
sx=std(x);
figure,hist(x)
title(['x has a mean of : ',num2str(mx),' and variance : ',num2str(sx)])
y=1/2*(x.^2+log(2*pi));
my=mean(y);
sy=std(y);
figure,hist(y)
title(['y has a mean: ',num2str(my),' and variance : ',num2str(sy)])