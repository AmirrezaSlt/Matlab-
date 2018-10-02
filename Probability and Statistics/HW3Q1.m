clc
clear
close all
%% for X
N=5000;
sigma=sqrt(5);
m=3;
var=5;
X=sqrt(var)*randn(N,1)+3;
% data=[X;Y]; % normal mixture with two humps
data=X;
n=length(data); % number of samples
h=std(data)*(4/3/n)^(1/5); % Silverman's rule of thumb
phi=@(x)(exp(-.5*x.^2)/sqrt(2*pi)); % normal pdf
ksden=@(x)mean(phi((x-data)/h)/h); % kernel density
M=mean(data);
V=std(data)^2;
figure,fplot(ksden,[-5 10],'r') % plot kernel density with rule of thumb 
hold on 
fplot(@(x)(1/(sqrt(2*pi)*sigma)*exp(-(x-m)^2/(2*sigma^2))),[-5,10],'b') % plot the true density
legend('Estimated pdf','Actual pdf')
title({['Estimated mean is: ',num2str(M),' compared to actual mean: ',...
    num2str(m)],[' and the estimated variance is: ',num2str(V),...
    ' and the actual variance is: ',num2str(var)]});
% kde(data); % plot kde with solve-the-equation bandwidth
figure,hist(data,10,'r'),title('Histogram of the generated data')
%% For y
N=5000;
Y=rand(N,1)*7-2;
m=(-2+5)/2;
var=0;
p=1/(5-(-2));
% data=[X;Y]; % normal mixture with two humps
data=Y;
n=length(data); % number of samples
h=std(data)*(4/3/n)^(1/5); % Silverman's rule of thumb
phi=@(x)(exp(-.5*x.^2)/sqrt(2*pi)); % normal pdf
ksden=@(x)mean(phi((x-data)/h)/h); % kernel density 
M=mean(data);
V=std(data)^2;
figure,fplot(ksden,[-2 5],'k') % plot kernel density with rule of thumb 
hold on 
fplot(@(x)p,[-2,5],'b') % plot the true density
legend('Estimated pdf','Actual pdf')
title({['Estimated mean is: ',num2str(M),' compared to actual mean: ',...
    num2str(m)],[' and the estimated variance is: ',num2str(V),...
    ' and the actual variance is: ',num2str(var)]});
% kde(data); % plot kde with solve-the-equation bandwidth
figure,hist(data,10,'r'),title('Histogram of the generated data')