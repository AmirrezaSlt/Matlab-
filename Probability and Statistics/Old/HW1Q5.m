clc
clear
close all
% Part a
syms var1 var2 rho 
V=[var1,rho*sqrt(var1*var2);rho*sqrt(var1*var2),var1]; % Transformation Matrix
clear
% Part b
s1=randn(1,1000);
s2=randn(1,1000);
s=[s1;s2];
m1=1;
m2=-1;
var1=1;
var2=2;
rho=-0.5;
V=[var1,rho*sqrt(var1*var2);rho*sqrt(var1*var2),var1];
O=V*[s1-m1;s2-m2];
figure,histogram2(O(1,:),O(2,:),50),title('Empirical PDF of the Samples')
% Part c
figure,scatter(O(1,:),O(2,:))...
,title(['Scatter Plot of a Jointly Gaussian Distribution with \rho= ',num2str(rho)])


    