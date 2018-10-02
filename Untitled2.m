clc
clear
close all
w=[-1 1];
for x=-2:0.02:2
n1=[dist(x,-1);dist(x,1)];
a1=radbas(n1);
a2=w*a1;
plot(x,a2,'rx')
hold on
end