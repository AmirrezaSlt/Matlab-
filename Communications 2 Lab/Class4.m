clc
clear
close all
% Part 1
M=16;
x=(0:M-1);
y1=qammod(x,M);
scatterplot(y1)
hold on
for j=1:16
    text(real(y1(j)),imag(y1(j)),dec2bin(j,4))
end
y2=qammod(x,M,0,'gray');
scatterplot(y2)
hold on 
for i=1:16
    text(real(y2(i)),imag(y2(i)),dec2bin(i,4))
end
% % Part 2   
seq=floor(rand (1,1000)*16);
% % for k=1:250
% %     temp='str2num(seq(4*k)) str2num(seq(4*k+1)) str2num(seq(4*k+2)) str2num(seq(4*k+3))';
% %      u(k)=bin2dec(temp);
% % end
y3=qammod(seq,M);
ch1=awgn(y3,0,'measured');
ch2=awgn(y3,30,'measured');
scatterplot(ch1)
scatterplot(ch2)
% part 3
p1=pskmod(x,M);
scatterplot(p1)
hold on
for j=1:16
    text(real(p1(j)),imag(p1(j)),dec2bin(j,4))
end
p2=pskmod(x,M,0,'gray');
scatterplot(p2)
hold on 
for i=1:16
    text(real(p2(i)),imag(p2(i)),dec2bin(i,4))
end
p3 = pskmod(seq,M);
ch1=awgn(p3,0,'measured');
ch2=awgn(p3,30,'measured');
scatterplot(ch1)
scatterplot(ch2)
% Part 4
seq2=floor(rand (1,10000)*16);
seq3=floor(rand (1,10000)*256);
y4 = qammod(seq2,M);
y5 = qammod(seq3,256);
ch4=awgn(y4,20,'measured');
ch5=awgn(y5,20,'measured');
scatterplot(ch4)
scatterplot(ch5)



