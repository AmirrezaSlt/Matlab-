clc
clear 
close all
rng(1);
rate_sample=240;
y = linspace(-1,1,rate_sample);
a=find(y<=.5&y>-.5);
a1=find(y<-.5);
a2=find(y>.5);

y(a)=1;
y(a1)=0;
y(a2)=0;
t=0:2/rate_sample:2-1/rate_sample;
s=2*cos(40*pi.*t);
y1=s.*y;
plot(t,y1,'r','LineWidth',1.5)

Y1=[y1 y1 y1]*1;
Y2=[y y y];
t=0:6/length(Y1):6-6/length(Y1);


q1=Y1;%+.15*randn(1,length(Y1));
figure
plot(t,Y1,'r','LineWidth',1.5)
figure
plot(t,q1,'r','LineWidth',1.5)

N_w=50;
N=5*N_w;
X=q1;
W2=ones(N_w,1);
W1=hanning(N_w);
W=hamming(N_w);
M=length(X);

k1=0;
% figure
% plot(X)
% figure
% stem(W1)
% title('Hanning window')
% figure
% stem(W)
% title('Hamming window')

   for m=N_w:M
  
 % r=X(m-(N_w-1):m);
       S=X(m-(N_w-1):m).*W';
  S1=X(m-(N_w-1):m).*W1';
 
   for k=0:N-1
x(k+1,m-(N_w-1))=S*exp((2i*pi*k/N_w)*[m-(N_w-1):m])';
x1(k+1,m-(N_w-1))=S1*exp((2i*pi*k/N_w)*[m-(N_w-1):m])';
end
   end

 
% max1=max(max(abs(x)))
%   min1=min(min(abs(x)))
%   ff=(max1+min1)/2
 %%
  
 [row,col] = find(abs(x)<5);
 for i=1:length(row)
    x(row(i),col(i))=0; 
 end
    p=abs(x);
  

    %%
figure
mesh(p)
title('effect of Hamming window in short time fourier transform')
xlabel('time')
ylabel('frequency in radian')
zlabel('amp')
% %%
% figure
% mesh(1:671,0:2*pi/250:2*pi-(2*pi/250),abs(x1))
% title('effect of Hanning window in short time fourier transform')
% xlabel('time')
% ylabel('frequency in radian')
% zlabel('amp')


%% fbs
v=exp((1i*2*pi/250)*(0:249));
for n=1:671
    xi(n)=(v.^n)*x(:,n);
end
figure
plot(abs(xi)/250)
%% overlap add
for n1=1:671-N_w
    E=exp((1i*2*pi*n1/250)*(0:249));
    sq=0;
    for r=n1:n1+(N_w-1)
       sq=sq+E*x(:,r);
    end
    b(n1)=(1/(250*sum(W)))*sq;
end
figure,plot(abs(b))