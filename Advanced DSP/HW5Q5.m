clc
clear
close all 
c0k=0:10;
Ts=[1/500,1/100,1/50,1/25];
for i=1:length(Ts)
    t=0:Ts(i):1;
    x=cos(2*pi*10*t)+heaviside(t-0.5);
    [C,L]=wavedec(x,1,'db4');
%     D1=detcoef(c,l,1);
    D1=C(L(1)+1:end);
    C1=C(1:L(1));
    figure (1)
    subplot(4,1,i)
    plot(D1)
    axis([1,length(D1),-1,1])
    suptitle('D1')
    figure (2)
    subplot(4,1,i)
    plot(C1)
    axis([1,length(C1),-1,1])
    suptitle('C1')
end