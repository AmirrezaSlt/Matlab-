clc
clear
close all
load('CH2Q2dataset1')
load('CH2Q2dataset2')
C=[1 100 1000];
sigma=[0.5 1 2 4];
tol=0.01;
% [SVMstruct,svIndex,pe_tr,pe_te]=SVM_clas(X1,Y1,X2,Y2,tol,C(1),sigma(1));
SVMModel=fitcsvm(X1',Y1');
sv = SVMModel.SupportVectors;
figure
gscatter(X1(1,:),X1(2,:),Y1)
hold on
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
legend('Class 1','Class 2','Support Vector')
hold off
SVMModel=fitcsvm(X2',Y2');
sv = SVMModel.SupportVectors;
figure
gscatter(X2(1,:),X2(2,:),Y2)
hold on
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
legend('Class 1','Class 2','Support Vector')
hold off

