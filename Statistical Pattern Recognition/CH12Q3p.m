clc
clear
close all
x1=[1;1];
x2=[1;2];
x3=[2;2];
x4=[2;3];
x5=[3;3];
x6=[3;4];
x7=[4;4];
x8=[4;5];
x9=[5;5];
x10=[5;6];
x11=[-4;5];
x12=[-3;5];
x13=[-4;4];
x14=[-3;4];
X=[x1,x2,x3,x4,x5,x6,x7,x8];
q=5;
theta=sqrt(2);
% Part a
order=[1 2 3 4 5 6 7 8 9 10 11 12 13 14]; 
[bel,~]=MBSAS(X,theta,q,order);
plot_data(X,bel,[])
title('Part a MBSAS')
[bel,~]=BSAS(X,theta,q,order);
plot_data(X,bel,[])
title('Part a BSAS')
% Part b 
order=[1 10 2 3 4 11 12 5 6 7 13 8 14 9]; 
[bel,~]=MBSAS(X,theta,q,order);
plot_data(X,bel,[])
title('Part b MBSAS')
[bel,~]=BSAS(X,theta,q,order);
plot_data(X,bel,[])
title('Part b BSAS')
% Part c 
order=[1 10 5 2 3 11 12 4 6 7 13 14 8 9]; 
[bel,m]=MBSAS(X,theta,q,order);
plot_data(X,bel,[])
title('Part c MBSAS')
[bel,~]=BSAS(X,theta,q,order);
plot_data(X,bel,[])
title('Part c BSAS')
