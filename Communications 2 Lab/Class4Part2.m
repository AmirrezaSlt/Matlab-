clc
clear
close all
%  Part 1
M=16;
x=floor(rand (1,10000)*16);
y1=qammod(x,M);
snrr=5:2:27;
for i=1:12
    snr=(10*log10((10.^(0.1*(2*i+3)))*4));
    ch=awgn(y1,snr,'measured');
    u=qamdemod(ch,M);
    [n(i),r(i)]=symerr(x,u);
end 
semilogy(snrr,r/4,'b')
hold on
% Part 2
snr2=(10*log10((10.^(0.1*(2*snrr+3)))*4));
input=sqrt(3.*log2(M).*snr2/(M-1));
qfunc(input)
% Part 3
y2=qammod(x,M,0,'gray');
snrr=5:2:27;
for i=1:12
    snr=(10*log10((10.^(0.1*(2*i+3)))*4));
    ch=awgn(y2,snr,'measured');
    u=qamdemod(ch,M,0,'gray');
    [n(i),r(i)]=symerr(x,u);
end 
semilogy(snrr,r,'r')
hold on
input=sqrt(3.*log2(M).*snrr/(M-1));
qfunc(input)
% Part 4
x1=floor(rand (1,10000)*64);
y3=qammod(x1,64);
for i=1:12
      snr=(10*log10((10.^(0.1*(2*i+3)))*4));
    ch=awgn(y3,snr,'measured');
    u=qamdemod(ch,64);
    [n(i),r(i)]=symerr(x1,u);
end 
semilogy(snrr,r,'g')
legend('binary 16 QAM','grey coded','binary 64 QAM')

