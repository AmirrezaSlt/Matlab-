clc
clear
close all
load('ex4data1.mat')
yn=zeros(5000,10);
for i=1:5000
    a=y(i,1);
    yn(i,a)=1;
end
yt=yn';
Xt=X';
n=size(Xt,2);
% a=randperm(n,5000);
% Xs=zeros(400,length(a));
% ys=zeros(10,length(a));
% y_in=zeros(500,1);
% Xs=Xt(:,a);
% ys=yt(:,a);
x = Xt;
t = yt;
hiddenLayerSize = 25;
trainFcn = 'trainlm';    
net=fitnet(hiddenLayerSize,trainFcn);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
net.trainparam.epochs=5;
net.trainparam.Q=20;
[net,tr] = train(net,x,t);
y2 = net(x);
% e = gsubtract(t,y2);
y_out=vec2ind(y2);
% e=gsubtract(y_out,y_in);
% e_t=(5000/n)*e;
performance=perform(net,t,y2);
% view(net)
p=0;
y_out1=y_out';
ytest=zeros(10,10);
for i=1:10
    ytest(i,i)=1;
end
for j=1:5000
    min=100;
    for i=1:10
        d=y2(:,j)-ytest(:,i);
        if norm(d)<min
        min=norm(d);
        ind(j)=i;
        end
    end
end


