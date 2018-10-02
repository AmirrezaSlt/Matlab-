clc
clear
close all
T0=0.01;
F0=1/T0;
t=0:T0:8;
c=[1 2 3 7 3 2 1 -1 -2 -3 -7 -3 -2 -1 1 2];
h1=[1 1]/sqrt(2);
h2=[-1 1]/sqrt(2);
c0k=conv(c,h1);
d0k=conv(c,h2);
c0k=dyaddown(c0k,2);
d0k=dyaddown(d0k,2);
f0=zeros(length(t));
d0=zeros(length(t));
for i=1:8 
    f0((i-1)*F0+1:i*F0)=c0k(i);
    d0((i-1)*F0+1:(i-0.5)*F0)=d0k(i);
    d0((i-0.5)*F0+1:i*F0)=-d0k(i);
end
fr=f0+d0;
figure,plot(t,f0),title('f0')
figure,plot(t,d0),title('d0')
figure,plot(t,fr),title('Reconstructed Signal')