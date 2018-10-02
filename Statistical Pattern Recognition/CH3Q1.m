clc
clear
close all
syms r t
% Part 1 
N=200;
m1=[-5;0];
s1=eye(2);
m2=[5;0];
s2=eye(2);
P=[1/2,1/2];
m=[m1,m2];
S=zeros(2,2,2);
S(:,:,1)=s1;
S(:,:,2)=s2;
% [X1,y1]=generate_gauss_classes(m1,s1,1,N);
% [X2,y2]=generate_gauss_classes(m,s2,1,N);
X11=randn(N,1)-5;
X12=randn(N,1);
X1=[X11,X12];
X21=randn(N,1)+5;
X22=randn(N,1);
X2=[X21,X22];
y1=ones(200,1);
y2=ones(200,1)*(-1);
figure,plot(X1(:,1),X1(:,2),'rx')
hold on 
plot(X2(:,1),X2(:,2),'bx'),title('Generated Data')
X1=[X1,ones(N,1)];
X2=[X2,ones(N,1)];
X=[X1;X2];
y=[y1;y2];
% Part 2 
wi=rand([3,1]);
wperce=perce(X',y',wi);
yperce=wperce'*X';
wlms=LMSalg(X',y',wi);
ylms=wlms'*X';
% figure,plot(X1(:,1),X1(:,2),'rx')
% hold on 
% plot(X2(:,1),X2(:,2),'bx'),title('Generated Data')
% hold on 
% plot(X,yperce)
% hold on 
% fplot(wperce(2)/wperce(1)*r+wperce(3),'g-')
% Part 3 
eperce=SSErr(yperce,y');
elms=SSErr(ylms,y');