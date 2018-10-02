clc
clear
close all
N=1000;
m1=[1;1];m2=[8;6];m3=[13;1];
m=[m1,m2,m3];
I=[1 0;0 1];
s1=6*I;s2=6*I;s3=6*I;
S=zeros(2,2,3);
p=[1/3,1/3,1/3];
for i=1:3
    str=strcat('s',num2str(i));
    S(:,:,i)=eval(str);
end
% x1=mvnrnd(m1,s1,N);
% x2=mvnrnd(m2,s2,N);
% x3=mvnrnd(m3,s3,N);
[X3,y]=generate_gauss_classes(m,S,p,N);
plot_data(X3,y,m),title('Generated Data')
[Z,v]=generate_gauss_classes(m,S,p,N);
for k=[1,11]
    z=k_nn_classifier(Z,v,k,X3);
    plot_data(X3,z,m),title(['K Nearest Neighborhood Classification for k= ',num2str(k)])
end