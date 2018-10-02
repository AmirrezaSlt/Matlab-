clc
clear
close all
syms f
g=0.54*sinc(f)+0.23*(sinc(f-1)+sinc(f+1));
g=abs(g);
gn=g;
ezplot(gn)