clc
clear
close all
%  Loading training set and extracting covariance matrix
fid1=readtable('Normal-Data-Training_dat.txt');
y=fid1(:,1);
x=fid1(:,2:3);
x=table2array(x);
y=table2array(y);
N=length(y);
yest=zeros(size(y));
m1=mean(x(1:500,:));
m2=mean(x(501:1000,:));
C1=cov(x(1:500,1),x(1:500,2));
C2=cov(x(501:1000,1),x(501:1000,2));
%  loading test set and performing classification
fid2=readtable('Normal-Data-Testing_dat.txt');
yt=fid2(:,1);
xt=fid2(:,2:3);
xt=table2array(xt);
yt=table2array(yt);
l=2;
for i=1:N
    gv1=(1/((2*pi)^ (l/2)*det(C1)^ 0.5) )*exp(-0.5*(xt(i,:)-m1)*inv(C1)*(xt(i,:)-m1)');
    gv2=(1/((2*pi)^ (l/2)*det(C2)^ 0.5) )*exp(-0.5*(xt(i,:)-m2)*inv(C2)*(xt(i,:)-m2)');
    if gv1>=gv2
        yest(i)=1;
    else
        yest(i)=2;
    end
end
figure
    plot(x(y==1,1),x(y==1,2),'bx')
    hold on
    plot(x(y==2,1),x(y==2,2),'rx')
    title('Class 1 in blue and class 2 in red')
figure
    plot(xt(yest==yt,1),xt(yest==yt,2),'bx')
    hold on
    plot(xt(yest~=yt,1),xt(yest~=yt,2),'rx')
    title('Correctly classified data in blue and misclassified data in red')
pc=sum(yt==yest)/length(yt);
pe=1-pc;