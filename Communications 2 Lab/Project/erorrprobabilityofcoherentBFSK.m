clc
clear 
close all
gb=10;
L=1;
 for m=1:10
    L=L+1;
    for i=1:10000
        gb=gb+1;
        gamac=gb/L;
        p(i)=(1/((2*gamac)^L))*nchoosek((2*L-1),L);
    end
    gama=10:10009;
    plot(10*log10(gama),p);
    hold on
    title('Coherent BFSK Error Probabilty')
 end
