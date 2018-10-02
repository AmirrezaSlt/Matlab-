clc
clear
close all
% Part a1
N=100;
m1=[10;10];
m2=[-10;10];
m3=[10;-10];
m4=[-10;-10];
k=0.2*eye(2);
x1=mvnrnd(m1,k,N);
x2=mvnrnd(m2,k,N);
x3=mvnrnd(m3,k,N);  
x4=mvnrnd(m4,k,N);
y1=1*ones(N,1);
y2=2*ones(N,1);
y3=3*ones(N,1);
y4=4*ones(N,1);
x=[x1;x2;x3;x4];
y=[y1;y2;y3;y4];
% Part a2
[Sw,Sb,Sm]=scatter_mat(x',y');
disp('The values of Sw,Sb and Sm are :')
Sw
Sb
Sm
% Part a3
J3=J3_comp(Sw,Sm);
disp('The value of J3 criterion is :')
J3
% Part b
m1=[1;1];
m2=[-1;1];
m3=[1;-1];
m4=[-1;-1];
x1=mvnrnd(m1,k,N);
x2=mvnrnd(m2,k,N);
x3=mvnrnd(m3,k,N);
x4=mvnrnd(m4,k,N);
y1=1*ones(N,1);
y2=2*ones(N,1);
y3=3*ones(N,1);
y4=4*ones(N,1);
x=[x1;x2;x3;x4];
y=[y1;y2;y3;y4];
[Sw,Sb,Sm]=scatter_mat(x',y');
J3=J3_comp(Sw,Sm);
disp('The values of Sw,Sb and Sm for the new means are :')
Sw
Sb
Sm
disp('The value of J3 criterion for the new means is :')
J3
% Part c
N=100;
m1=[10;10];
m2=[-10;10];
m3=[10;-10];
m4=[-10;-10];
k=3*eye(2);
x1=mvnrnd(m1,k,N);
x2=mvnrnd(m2,k,N);
x3=mvnrnd(m3,k,N);
x4=mvnrnd(m4,k,N);
y1=1*ones(N,1);
y2=2*ones(N,1);
y3=3*ones(N,1);
y4=4*ones(N,1);
x=[x1;x2;x3;x4];
y=[y1;y2;y3;y4];
[Sw,Sb,Sm]=scatter_mat(x',y');
J3=J3_comp(Sw,Sm);
disp('The values of Sw,Sb and Sm for the new covariance matrix are :')
Sw
Sb
Sm
disp('The value of J3 criterion for the new covariance matrix is :')
J3