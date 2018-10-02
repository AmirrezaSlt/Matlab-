clc
clear 
close all
s=[0.01 0;0 0.01];
m1=[0;0];
m2=[1;1];
m3=[0;1];
m4=[1;0];
x1=mvnrnd(m1,s,100);
x2=mvnrnd(m2,s,100);
x3=mvnrnd(m3,s,100);
x4=mvnrnd(m4,s,100);
x=[x1;x2;x3;x4];
y1=ones(200,1);
y2=-ones(200,1);
y=[y1;y2];
xt1=mvnrnd(m1,s,50);
xt2=mvnrnd(m2,s,50);
xt3=mvnrnd(m3,s,50);
xt4=mvnrnd(m4,s,50);
xt=[xt1;xt2;xt3;xt4];
yt1=ones(100,1);
yt2=-ones(100,1);
yt=[yt1;yt2];
x=x';
t=y';
trainFcn='trainlm';  
hiddenLayerSize=2;
net=fitnet(hiddenLayerSize,trainFcn);
net.input.processFcns={'removeconstantrows','mapminmax'};
net.output.processFcns={'removeconstantrows','mapminmax'};
net.divideFcn='dividerand';  
net.divideMode='sample';  
net.divideParam.trainRatio=65/100;
net.divideParam.valRatio=0/100;
net.divideParam.testRatio=0/100;
net.performFcn='mse';  
net.plotFcns={'plotperform','plottrainstate','ploterrhist', ...
    'plotregression', 'plotfit'};
[net,tr]=train(net,x,t);
y=net(x);
e = gsubtract(t,y);
performance=perform(net,t,y);
trainTargets = t.*tr.trainMask{1};
valTargets = t.*tr.valMask{1};
testTargets = t.*tr.testMask{1};
trainPerformance=perform(net,trainTargets,y);
valPerformance=perform(net,valTargets,y);
testPerformance=perform(net,testTargets,y);
view(net)
figure,plotperform(tr)
%figure,plottrainstate(tr)
%figure,ploterrhist(e)
%figure,plotregression(t,y)
%figure,plotfit(net,x,t)
if (false)
    genFunction(net,'myNeuralNetworkFunction');
    y=myNeuralNetworkFunction(x);
end
if (false)
    genFunction(net,'myNeuralNetworkFunction','MatrixOnly','yes');
    y=myNeuralNetworkFunction(x);
end
if (false)
    gensim(net);
end
output=net(xt');
y_est=hardlims(output);
pc=sum(yt'==y_est)/length(yt);
pe=1-pc;
pe=pe*100;
disp(['The training error is : ',num2str(pe),' percent'])
figure
plot(x(1,1:200),x(2,1:200),'r.')
hold on 
plot(x(1,201:400),x(2,201:400),'bx')
title('Training data')
figure
plot(xt(1:100,1),xt(1:100,2),'r.')
hold on 
plot(xt(101:200,1),xt(101:200,2),'bx')
title('Test Data')