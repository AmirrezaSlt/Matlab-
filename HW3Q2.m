clc
clear 
close all
h=2/3;
Tb=1;
L=input('Please insert a value for L : ');
n=0:0.005:L*Tb;
m=0:0.005:Tb;
input=[0 0 1 0 1 0 1 1];
m_d=2*((input)-0.5);
g=(1/(2*L*Tb))*(1-cos((2*pi*n)/(L*Tb)));
q1=(n/(2*Tb*L))-((1/(4*pi))*(sin((2*pi*n)/(L*Tb))));
V=(q1(1,length(n)))*ones(1,length(m)*(length(input)-(L*Tb)));
q=[q1 V];
plot(n,g)
title('Raised Cosine Pulse')
figure,plot(q)
title('Raised Cosine Pulse Integrated')
fc=10;
Q=[];
Q2=[];
for i=1:length(m_d)
   Q1=(2*pi*h*m_d(i)*q);
   if i==1
       Q2=Q1;
   else
   Q3=[zeros(1,(i-1)*length(m)) Q1];
   Q2=Q3(1:length(Q1))+Q2;
   end
end
a=((length(m_d))*Tb)/length(Q2);
K=0:a:((length(m_d))*Tb)-a;
figure
plot(K,Q2)
title('Phase Path')
Si=sin(Q2);
Sq=cos(Q2);
figure
plot3(q,Si,Sq)
title('Phase Cylinder')
xlabel('Time')
ylabel('In-phase Component')
zlabel('Quadrature Component')