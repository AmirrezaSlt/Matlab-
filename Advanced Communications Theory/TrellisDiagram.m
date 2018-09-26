clc
clear 
close all
h=2/3;
Tb=1;
L=1;
n=0:0.005:L*Tb;
m=0:0.005:Tb;
input=[0 0 1 0 1 0 1 1];
modulate_data=2*((input)-0.5);
g=(1/(2*L*Tb))*(1-cos((2*pi*n)/(L*Tb)));
q1=(n/(2*Tb*L))-((1/(4*pi))*(sin((2*pi*n)/(L*Tb))));
V=(q1(1,length(n)))*ones(1,length(m)*(length(input)-(L*Tb)));
q=[q1 V];
Q=[];
Q2=[];
for i=1:length(modulate_data)
   Q1=(2*pi*h*modulate_data(i)*q);
   if i==1
   Q2=((2*pi)/(3*max(abs(Q1))))*Q1;
   elseif (i==2) && (modulate_data(i)==1)&& (modulate_data(i-1)==1)
   Q3=[zeros(1,(i-1)*length(m)) (-(4*pi)/(3*max(abs(Q1))))*Q1];
   Q2=Q3(1:length(Q1))+Q2;
   elseif (i==2) && (modulate_data(i)==-1)&& (modulate_data(i-1)==-1)
   Q3=[zeros(1,(i-1)*length(m)) (-(4*pi)/(3*max(abs(Q1))))*Q1];
   Q2=Q3(1:length(Q1))+Q2;
   elseif (Q2(1,(i-1)*length(m))==0) && (modulate_data(i)==1) && (modulate_data(i-1)==1)
   Q3=[zeros(1,(i-1)*length(m)) (-(4*pi)/(3*max(abs(Q1))))*Q1];
   Q2=Q3(1:length(Q1))+Q2;
   elseif (Q2(1,(i-1)*length(m))==0) && (modulate_data(i)==-1) && (modulate_data(i-1)==-1)
   Q3=[zeros(1,(i-1)*length(m)) (-(4*pi)/(3*max(abs(Q1))))*Q1];
   Q2=Q3(1:length(Q1))+Q2;
   elseif (Q2(1,(i-1)*length(m))==((2*pi)/3)) && (modulate_data(i)==1) 
   Q3=[zeros(1,(i-1)*length(m)) (-(4*pi)/(3*max(abs(Q1))))*Q1];
   Q2=Q3(1:length(Q1))+Q2;
   elseif (Q2(1,(i-1)*length(m))==(-(2*pi)/3)) && (modulate_data(i)==-1) 
   Q3=[zeros(1,(i-1)*length(m)) (-(4*pi)/(3*max(abs(Q1))))*Q1];
   Q2=Q3(1:length(Q1))+Q2;
   else
   Q3=[zeros(1,(i-1)*length(m)) Q1];
   Q2=Q3(1:length(Q1))+Q2;
   end
end
a=((length(modulate_data))*Tb)/length(Q2);
K=0:a:((length(modulate_data))*Tb)-a;
figure;
plot(K,Q2)
title('Trellis Diagram')