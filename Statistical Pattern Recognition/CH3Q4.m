clc
clear
close all
% Part 1 
lr=0.01;
lr_inc=1.05;
lr_dec=0.7;
max_per_inc=1.04;
parameters=[lr,0,lr_inc,lr_dec,max_per_inc];
code=3;
iteration=300;
fln=4;
load('CH2Q2dataset1')
load('CH2Q2dataset2')
w0=rand(2,fln);
w1=w0;
input=X1';
w2=rand(1,2);
net=NN_training(X1,Y1,fln,code,iteration,parameters);
Y_predicted=net(X2);
Y_predicted=hardlims(Y_predicted);
% for i=1:iteration
%     for j=1:400
%         net=input(j,:)*w1;
%         y1=tanh(tnet);
%         net2=net*w2';
%         y_est=tanh(tnet);
%         diff_err=2*(Y1(j)-y_est);
%         diff_err=diff_err.*(1-tanh(diff_err).^2);
%         w1=w1-lr*diff_err*[input(j,1) input(j,1);input(j,2) input(j,2)];
%     end
% end
% Y_predicted=X1'*w1;
% Y_predicted=sum(Y_predicted,2);
% Y_predicted=hardlims(Y_predicted);
% Part 2 
pe=NN_evaluation(net,X1,Y1);
% w1=net.IW{1}; %the input-to-hidden layer weights
% w2=net.LW{2}; %the hidden-to-output layer weights
% b1=net.b{1}; %the input-to-hidden layer bias
% b2=net.b{2}; %the hidden-to-output layer bias
% figure,plotconfusion(Y1,Y_predicted)
a=find(Y_predicted==1);
b=find(Y_predicted==-1);
figure
% plot(X1(1,1:200),X1(2,1:200),'r.')
plot(X2(1,a),X2(2,a),'r.')
hold on 
% plot(X1(1,200:400),X1(2,200:400),'b.')
plot(X2(1,b),X2(2,b),'b.')
hold on 
x=-15:15;
plot(x,zeros(size(x)),'k-')
hold on 
plot(zeros(size(x)),x,'k-')
% for i=1:length(Y_predicted)
%     if Y_predicted>0
%         plot(X1(1,i),X1(2,i),'r.'),hold on
%     end
%     if Y_predicted<0
%         figure,plot(X1(1,i),X1(2,i),'b.')
%         hold on
%     end
% end