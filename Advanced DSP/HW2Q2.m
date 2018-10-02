clc
clear
close all
w=-.8:.001:.8;
t=-.8:.001:.8;
sigma=.006;
omega0=20;
% k=0;
for k=1:length(t)
 
    for j=1:length(t)
   a= exp(-.5*sigma*((w(j)-omega0)^2)+(2i*t(k)*(w(j)-omega0)));
    b=exp(-.5*sigma*((w(j)+omega0)^2)+(2i*t(k)*(w(j)+omega0)));
   F(k,j)=.5*(a+b);
    end
end
mesh(abs(F))

