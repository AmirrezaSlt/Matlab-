clc
clear
close all
syms Sw kr
Lx=10;
Ly=10;
M=10;
N=5;
Ax=5;
k=10;
miu=0.002;
rho=1000;
g=10;
C=0.2;
kr=input('Please enter relative permeability dependent on Sw: ');
Pc=zeros(M,N);
for i=M-1:2
    for j=N-1:2
        Pc(i,j)=input('Please enter Pc: ');
    end
end
for i=M:1
    for j=N:1
        L=Pc(i,j)+(N-j)*rho*g;
    end
end
T=2*1*Ax*k*kr/miu;
Tr=zeros(M,N);
Tl=zeros(M,N);
Td=zeros(M,N);
Tu=zeros(M,N);
for i=M-1:2
    for j=N-1:2
        if L(i,j)>=L(i+1,j)
           Tr(i,j)=kr(i,j);
        else
           Tr(i,j)=kr(i+1,j);
        end
        if L(i,j)>=L(i-1,j)
           Tl(i,j)=kr(i,j);
        else
           Tl(i,j)=kr(i-1,j);
        end
        if L(i,j)>L(i,j+1)
           Td(i,j)=kr(i,j);
        else
           Td(i,j)=kr(i,j+1);
        end
        if L(i,j)>L(i,j-1)
           Tu(i,j)=kr(i,j);
        else
           Tu(i,j)=kr(i+1,j-1);
        end
    end
end        
Tl(1,:)=0;Tr(M,:)=0;Tu(:,1)=0;Td(:,N)=0;
sw=C*ones([M,N]);
new_S=sym(new_S,[M,N]);
answer=zeros(M,N);
for i=2:M-1
    for j=2:N-1
        answer(i,j)=Tu(i,j)*rho*g*Ly/n-Td(i,j)*g*rho-Tr(i,j)*(Pc(i+1,j)-Pc(i,j))+...
        Tl(i,j)*(Pc(i,j)-Pc(i-1,j))-Tu(i,j)*(Pc(i,j+1)-Pc(i,j))+...
        Td(i,j)*(Pc(i,j)-Pc(i,j-1))-Lx*Ly/(M*N*dt)*new_S-S(i,j);
    end
end
jacob=jacobian(answer,new_S);
delta=jacobian\(-answer);


