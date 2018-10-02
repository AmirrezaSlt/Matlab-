clc
clear 
close all
gb=10;
for L=1:10
    for i=1:30000
        gb=gb+1;
        gc=gb/L;
        p=1/(2+gc);
        p1(i)=(4*p*(1-p))^L;
        for K=0:L-1
            P2(K+1)=p^L*nchoosek(L-1+K,K)*(1-p)^K;
        end
        p2(i)=sum(P2);

    end
     gama=10:30009;
     plot(10*log10(gama),p1,'b.');
     hold on
     plot(10*log10(gama),p2,'r-');  
     hold on
     title('Chernov Bounds')
end
