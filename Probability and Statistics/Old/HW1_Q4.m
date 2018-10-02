clc
clear
close all
% Part a
x=randi([0,1],[10000,2]);
x=2*x-1;
x1=x(:,1);
x2=x(:,2);
figure,scatter(x1,x2,'rx'),axis([-2 2 -2 2]),title('Transmitted Signal')
% Part b
n=randn(10000,2);
figure,hist(n,100),title('Gaussian Noise')
% Part c
y=x+n;
% Part d
y1=y(:,1);
y2=y(:,2);
figure,scatter(y2,y1),title('Scatterplot of y')
hold on 
scatter(x1,x2,'rx')
legend('Received Signal','Transmitted Signal')
% Part e
xhat=[sign(y1),sign(y2)];
% Part f
e=xhat-x;
c=0;
for i=1:10000
    if e(i,:)~=[0,0]
        c=c+1;
    end
end
disp(['Total number of errors: ',num2str(c)])
pe=c/10000;
disp(['The probability of error is: ',num2str(pe)])
