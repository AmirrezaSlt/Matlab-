clc
clear
close all
% Part a
t=0:0.01:1;
n=32;
f0=25;
fd=10;
x=zeros(size(t));
for i=1:length(t)
    theta=rand*2*pi;
    beta=rand;
    f=f0+fd*cos(beta);
    x(i)=sum(cos(2*pi*f*t(i)+theta));
end
figure,plot(x,'bo'),title('Generated data')
% Part b
figure,hist(x),title('Estimated pdf')
% Part c
m=mean(x);
disp(['Due to ergodicity, the mean of the process is estimated : ',num2str(m)]);