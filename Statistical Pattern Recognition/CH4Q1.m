clc
clear
close all
rng(1)
% Part a
m=[-5 5 5 -5;5 -5 5 -5];
s=2;
N=100;
[X1,Y1]=data_generator(m,s,N);
% Part b
rng(10)
[X2,Y2]=data_generator(m,s,N);
% Part c
rng(0)
s=5;
m=[-5 5 5 -5;5 -5 5 -5];
N=100;
[X3,Y3]=data_generator(m,s,N);
rng(10)
[X4,Y4]=data_generator(m,s,N);
% Part d
figure
plot(X1(1,1:200),X1(2,1:200),'r.')
hold on 
plot(X1(1,200:400),X1(2,200:400),'b.')
title(' Generated data with seed= 0 and s= 2')
figure
plot(X2(1,1:200),X2(2,1:200),'r.')
hold on 
plot(X2(1,200:400),X2(2,200:400),'b.')
title(' Generated data with seed= 10 and s= 2')
figure
plot(X3(1,1:200),X3(2,1:200),'r.')
hold on 
plot(X3(1,200:400),X3(2,200:400),'b.')
title(' Generated data with seed= 0 and s= 5')
figure
plot(X4(1,1:200),X4(2,1:200),'r.')
hold on 
plot(X4(1,200:400),X4(2,200:400),'b.')
title(' Generated data with seed= 10 and s= 5')
% Saving variables for other questions 
save CH2Q2dataset1 X1 Y1
save CH2Q2dataset2 X2 Y2