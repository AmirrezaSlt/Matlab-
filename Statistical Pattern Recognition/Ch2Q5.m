clc
clear
close all
%% Part a
N=1000;
m1=[1;1];m2=[10;5];m3=[11;1];
m=[m1,m2,m3];
s1=[5 3;3 4];
s3=s1;s2=s3;
S=zeros(2,2,3);
p=[1/3,1/3,1/3];
for i=1:3
    str=strcat('s',num2str(i));
    S(:,:,i)=eval(str);
end
% x1=mvnrnd(m1,s1,N);
% x2=mvnrnd(m2,s2,N);
% x3=mvnrnd(m3,s3,N);
[X4,y]=generate_gauss_classes(m,S,p,N);
plot_data(X4,y,m),title('Generated Data')
%% Part b
zb=bayes_classifier(m,S,p,X4);
ze=euclidean_classifier(m,X4);
zm=mahalanobis_classifier(m,S,X4);
plot_data(X4,zb,m),title('Bayesian Classification')
plot_data(X4,ze,m),title('Euclidean Classification')
plot_data(X4,zm,m),title('Mahalanobis Classification')
%% Part c
eb=compute_error(y,zb);
disp(['Bayesian Classification Error is : ',num2str(eb)])
ee=compute_error(y,ze);
disp(['Euclidean Classification Error is : ',num2str(ee)])
em=compute_error(y,zm);
disp(['Mahalanobis Classification Error is : ',num2str(em)])