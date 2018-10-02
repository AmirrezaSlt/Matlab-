clc
clear
close all
rng(1);
sigma=[1 0;0 1];
m1=[1,0]';
m2=[-1,0]';
x1=mvnrnd(m1,sigma,200)';
x2=mvnrnd(m2,sigma,200)';
hold on
plot(x1(1,:),x1(2,:),'rx')
hold on
plot(x2(1,:),x2(2,:),'bx')
X=[x1 x2];
X(3,1:200)=-1;
X(3,201:400)=+1;
W=randn(1,2);
b=randn(1);
p=.5;
%    t=-8:.1:8;
%    line=(W(1)/W(2))*t;
%    plot(t,line,'r','LineWidth',2)
for i=1:15
k=0;
k1=0;  
for j=1:length(X)
      if(W*X(1:2,j)<0)
            if (X(3,j)==+1)
            k=k+1;
            b=X(1:2,j);
            misclass1(k,:)=X(1:2,j);
      end
      end
      if(W*X(1:2,j)>0)
          if (X(3,j)==-1)
          k1=k1+1;
          misclass2(k1,:)=X(1:2,j);
          end
      end   
end
    Y=[-1*misclass1(1:k,:);misclass2(1:k1,:)];
    Y1=[misclass1(1:k,:)];
    Y2=[misclass2(1:k1,:)];
    d=sum(Y);
     W=W-p*sum(Y);
end
hold on
t=-4:.1:4;
line=(W(1)/W(2))*t;
plot(t,line,'r')
legend('class2','class1','border')
title('LMS algorithm')
pause(.05)
hold on
plot(Y1(:,1),Y1(:,2),'bx')
hold on
plot(Y2(:,1),Y2(:,2),'rx')



