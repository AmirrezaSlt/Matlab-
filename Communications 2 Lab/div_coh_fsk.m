clc
clear
close all
T=1;
delt=0.01; 
ti=0:delt:T-delt; 
fc=5; 
delf=1/T; 
gammac=10;
len=1000;
uo=2*randi(2,1,len)-3;
o=zeros(size(uo));
for L=1:10
    for j=1:length(uo)
        u(L*(j-1)+1:L*j)=uo(j);
    end
    alpha=raylrnd(length(u));
    n=randn(size(u));
    r=alpha.*u+n;
    s1 = A*cos(2*pi*fc*ti);     
    s2 = A*cos(2*pi*(fc+delf)*ti);    
    if u(i) == 0
        ri = s1 +n;    
    else
        ri = s2 +n;
    end
    for j=1:length(uo)
        sum(r(L*(j-1)+1:L*j))=o(j);
    end
    e=sum(o==uo);
    pe(L)=e/len;
end
figure,plot(L,pe)
    
 