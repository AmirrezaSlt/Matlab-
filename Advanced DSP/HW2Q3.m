clc
clear
close all
t=0:.001:1;
f1=cos(2*pi*(5.*t+.5*25.*t.^2));
f2=cos(2*pi*(10.*t+.5*25.*t.^2));
f=f1+f2;
 figure
 plot(t,f1,'r','LineWidth',2)
 title('chirp1')
 figure
 plot(t,f2,'r','LineWidth',2)
 title('chirp2')
 figure
 plot(t,f,'r','LineWidth',2)
 title('chirp2')

t1=0:1/140:1;
f1=cos(2*pi*(5.*t1+.5*25.*t1.^2));
f2=cos(2*pi*(10.*t1+.5*25.*t1.^2));
g=f1+f2;

N_w=30;
N=1*N_w;
% Ts=1/20;
% t=0:Ts:10;
X=g;%=cos(2*pi.*t*10)+cos(2*pi.*t*100);
W=hamming(N_w);
W1=hanning(N_w);
M=length(X);

k1=0;
figure
plot(X)
figure
stem(W1)
title('Hanning')
figure
stem(W)
title('Hamming')


   for m=N_w:M
  
  r=X(m-(N_w-1):m);
       S=X(m-(N_w-1):m).*W';
  S1=X(m-(N_w-1):m).*W1';
 
   for k=0:N-1
x(k+1,m-(N_w-1))=S*exp((-2i*pi*k/N_w)*[m-(N_w-1):m]');
x1(k+1,m-(N_w-1))=S1*exp((-2i*pi*k/N_w)*[m-(N_w-1):m]');
end
end
figure
mesh(abs(x))
title('Hamming')
figure
mesh(abs(x1))
title('Hanning')

