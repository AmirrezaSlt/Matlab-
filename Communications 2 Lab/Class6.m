clc
clear 
close all
%% Part 1
% t=-10:0.01:10;
u1=randn(1,10000);
u2=randn(1,10000);
% u1=normpdf(t,0,sqrt(0.5));
% u2=normpdf(t,0,sqrt(0.5));
ur=sqrt(u1.^2+u2.^2);
[h,c]=hist(ur,100);
hn=h/10000;
dx=diff(c);
dx1=dx(1);
h1=hn/dx1;
plot(c,h1)
sigma=1;
p=(c.*exp(-(c.^2)/(2*sigma)))/sigma;
hold on
plot(c,p)
%% Part 2 
u1=randn(1,10000)*sqrt(0.5);
u2=randn(1,10000)*sqrt(0.5);
temp=zeros(1,30);
for i=1:30
snr=10^(i/10);
Csh=quadgk(@(x) log(1+x*snr).*exp(-x),0,inf);
temp(i)=Csh;
cg(i)=log(1+snr);
end
snrdb=1:30;
figure
plot(snrdb,cg)
hold on
plot(snrdb,temp)
hold on 
h=(u1.^2+u2.^2);
sumtemp3=0;
for j=1:30
    for k=1:10000
    temp3=log(1+h(k)*10^(j/10));
    sumtemp3=sumtemp3+temp3;
    end
    avg(j)=0.0001*sumtemp3;
    sumtemp3=0;
end
plot(snrdb,avg)
%% Part 3 
mysnrdb=20;
mysnr=10^(mysnrdb/10);
Coff=quadgk(@(x) log(1+x*mysnr).*exp(-x),0,x);
hth=0:0.01:2;
for i=1:length(hth)
Pout(i)=quadgk(@(x) exp(-x),0,hth(i));
end
cth=log(1+mysnr*Pout);
figure
plot(Pout,cth)
%% Part 4 
for i=1:length(hth)
fmax(i)=exp(-hth(i)).*log(1+Pout(i)*mysnr);
end
plot(Pout,fmax)
%% Part 5 
seq=floor(rand (1,10000)*16);
M=16;
y=qammod(seq,M);
clear('j')
hr=u1+j*u2;
yt=y.*hr;
snrsample=1:40;
symbol=4;
for i=1:40
ychg=awgn(y,i,'measured');
ychr=awgn(yt,i,'measured');
yrr=ychr./hr;
yfr=qamdemod(yrr,M);
yfg=qamdemod(ychg,M);
Gaussian_error(i)=symerr(yfg,seq);
Ryleigh_error(i)=symerr(yfr,seq);
P_ryleigh_error(i)=Ryleigh_error(i)/(length(seq));
P_Gaussian_error(i)=Gaussian_error(i)/(length(seq));
end
semilogy(snrsample,P_Gaussian_error);
hold on 
semilogy(snrsample,P_ryleigh_error);
hold on 
%% Part 6
for j=1:40
    ebn0=(10.^(j/10))/4;
    for i=1:length(ur)
        q(i)=4*qfunc(sqrt((log2(M)/(M-1))*(ur(i).^2).*ebn0));
    end
    qavg(j)=sum(q)/10000;
end
semilogy(snrsample,qavg);
 

