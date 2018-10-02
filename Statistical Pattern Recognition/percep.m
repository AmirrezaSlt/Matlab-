clc
clear
close all
rng(1)
sigma=[1 0;0 1];
m1=[+1,0]';
m2=[-1,0]';
x1=mvnrnd(m1,sigma,200)';
x2=mvnrnd(m2,sigma,200)';
X=[x1 x2];
X(3,1:200)=-1;
X(3,201:400)=+1;
W=randn(1,2);
b=randn(1);
figure
p=.5;
t=-6:.1:6;
hold on
plot(x1(1,:),x1(2,:),'rx')
hold on
plot(x2(1,:),x2(2,:),'bx')
hold on
line=(W(1)/W(2))*t;
plot(t,line,'k')
legend('class2','class1','Border')
title('Perceptron')
i=0;
while (i<=10)
i=i+1;
    for j=1:length(X)
      if(W*X(1:2,j)<=0 && X(3,j)==1)
       W=W+(p*X(1:2,j))';      
      end
        if(W*X(1:2,j)>=0 && X(3,j)==-1)
             W=W-(p*X(1:2,j))';  
        end
    end
end 
hold on
t=-.2:.1:.2;
line=(W(1)/W(2))*t;
% plot(t,line,'b')





