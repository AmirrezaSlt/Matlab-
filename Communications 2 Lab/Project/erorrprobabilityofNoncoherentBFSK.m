clc
clear 
close all
gb=10;
for L=1:10
    for i=1:30000
        gb=gb+1;
        gc=gb/L;
        p=1/(2+gc);
        for K=0:L-1
            P1(K+1)=p^L*nchoosek(L-1+K,K)*(1-p)^K;
        end
        p1(i)=sum(P1);   
    end
    gama=10:30009;
    plot(10*log10(gama),p1);
    hold on
    title('NonCoherent BFSK Error Probabilty')
end