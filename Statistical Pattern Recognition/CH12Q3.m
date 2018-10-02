clc
clear
close all
x1=[2;5];
x2=[8;4];
x3=[7;3];
x4=[2;2];
x5=[1;4];
x6=[7;2];
x7=[3;3];
x8=[2;3];
X=[x1,x2,x3,x4,x5,x6,x7,x8];
q=5;
% Part a
order=[1 5 8 4 7 3 6 2]; 
theta=sqrt(2)+0.001;
[bel,m]=BSAS(X,theta,q,order);
plot_data(X,bel,[])
title('Part a')
% Part b
order=[5 8 1 4 7 2 3 6]; 
theta=sqrt(2)+0.001;
[bel,~]=BSAS(X,theta,q,order);
plot_data(X,bel,[])
title('Part b')
% Part c
order=[1 4 5 7 8 2 3 6]; 
theta=2.5;
[bel,~]=BSAS(X,theta,q,order);
plot_data(X,bel,[])
title('Part c')
% Part d
order=[1 8 4 7 5 2 3 6]; 
theta=2.5;
[bel,~]=BSAS(X,theta,q,order);
plot_data(X,bel,[])
title('Part d')
% Part e
order=[1 4 5 7 8 2 3 6]; 
theta=3;
[bel,~]=BSAS(X,theta,q,order);
plot_data(X,bel,[])
title('Part e')
% Part f
order=[1 8 4 7 5 2 3 6]; 
theta=3;
[bel,~]=BSAS(X,theta,q,order);
plot_data(X,bel,[])
title('Part f')