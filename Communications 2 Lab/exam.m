clc
clear
close all
sent=('IMPOSSIBLE IS NOT IMPOSSIBLE');
ds=double(sent);
dss=size(sent,2);
[n,x]=hist(ds,unique(ds));
n2=n/dss;
x1=['E','A','S','I','T','N','R','U','L','O','D','C','M','P','V','Q','G','F','B','H','J','X','Z','Y','W','K',' '];
xn1=double(x1);
fchar=[850 395 388 366 356 355 305 295 278 255 200 148 145 144 75 61 51 46 42 35 29 17 10 8 2 1 860];
prob=fchar/sum(fchar);
[dict,avglen]=huffmandict(xn1,prob);
huffenco=huffmanenco(ds,dict);
L=encode(huffenco,7,4,'hamming/binary');
for k=1:0.25*length(L)
    L_i(k)=bin2dec(num2str(L(4*(k-1)+1:4*k)));
end
M=16;
y=qammod(L_i,M);
y_u=upsample(y,25);
u_s=0.2*ones(1,5);
y_r=filter(u_s,1,y_u);
f=25*5;
t=1/f:1/f:(length(y_r))*1/f; 
fc=100;
c1=sin(2*pi*100*t);
c2=cos(2*pi*100*t);
c1p=sin(2*pi*(100+fc)*t);
c2p=cos(2*pi*(100+fc)*t);
y_c1=real(y_r).*c1;
y_c2=imag(y_r).*c2;
y0=y_c1+y_c2;
ebn0=10^(10/10);
bitrate=5;
snr=bitrate*ebn0;
snrdb=10*log10(snr);
y1=awgn(y0,snrdb,'measured');
y_r1=2*y1.*c1p;
y_r2=2*y1.*c2p;
for i=1:length(y_r1)/20
        p1(i)=sum(y_r1(20*i-19:20*i));
        p2(i)=sum(y_r2(20*i-19:20*i));
end
p=p1+j*p2;
y_dem=qamdemod(y,M);
y_b=de2bi(y_dem);
y_b1=fliplr(y_b);
y_b2=y_b1';
y_b3=y_b2(:)';
y_hd=decode(y_b3,7,4,'hamming/binary');
y_dec=huffmandeco(y_hd,dict);
output=char(y_dec)

