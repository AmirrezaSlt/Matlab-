clc
clear
close all
N=100;
m1=[0;0;0;0;0];
m2=[0;2;2;3;3];
k=zeros(5);
ki=[0.5 0.5 1 1 1.5];
for i=1:5
    k(i,i)=ki(i);
end
x1=mvnrnd(m1,k,N);
x2=mvnrnd(m2,k,N);
x=[x1;x2];
y1=1*ones(N,1);
y2=-1*ones(N,1);
y=[y1;y2];
% Part a 
L=1;
id=features_best_combin(x',y',L);
disp(['The J3 criterion for individual features is :',num2str(id)]);
% Part b
L=2;
features_best_combin(x',y',L);
disp(['The J3 criterion for a pair of features is :',num2str(id)]);
% Part c
L=3;
features_best_combin(x',y',L);
disp(['The J3 criterion for triple features is :',num2str(id)]);