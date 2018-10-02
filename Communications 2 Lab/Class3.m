clc
clear
close all
%Part 1&2
m=3;
n=2^m-1;
k=2^m-m-1;
[h,g]=hammgen(m);
mm=[1 0 0 1];
x=rem(mm*g,2);
y=rem(x*h',2);
% %Part 3
xe=[1 1 1 1 0 0 1];
ye=rem(xe*h',2);
ybin=ye(1)*4+ye(2)*2+ye(3)*1;
for i=1:7
    x(i)=x(i)+1;
    a=rem(x,2);
    s=rem(a*h',2);
    sbin(i)=s(1)*4+s(2)*2+s(3)*1;
    x(i)=x(i)-1;
end
xc=xe;
xc(1)=xc(1)-1;
xc=rem(xc,2);
yc=rem(xc*h',2);
me=[x(4) x(5) x(6) x(7)];
%Part 4
% seq=floor(rand (1,10000)*2);
% enc=encode(seq,15,4,'cyclic/fmt',cyclpoly(15,4));
% [ch,err]=bsc(enc,0.1);
% outerr=decode(ch,15,4,'cyclic/fmt',cyclpoly(15,4));
% BER=sum(xor(outerr,seq))/10000
% % Part 5
seq2=floor(rand (1,1000)*2);
trellis=poly2trellis(7,[133 171]);
coded=convenc(seq2,trellis);
[ch2,err2]=bsc(coded,0.1);
decoded=vitdec(ch2,trellis,35,'cont','hard');
[n,r]=biterr(decoded(36:end),seq2(1:end-35))


