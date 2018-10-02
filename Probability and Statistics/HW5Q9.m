clc
clear
close all
N=1000;
X=randn(N,1);Y=randn(N,1);
f1=X.^2+Y.^2;
f2=X./Y;
f3=atan(X./Y);
f4=sqrt(X.^2+Y.^2);
subplot(4,3,1),hist(f1)
title('Statistical pdf for x^2+y^2')
% m=max(f1);
% yticks(0:m/5:m);
% yticklabels(string(0:0.2:1));
subplot(4,3,4),hist(f2,1000)
title('Statistical pdf for x/y')
% m=max(f2);
% yticks(0:m/5:m);
% yticklabels(string(0:0.2:1));
subplot(4,3,7),hist(f3)
title('Statistical pdf for arctan(x/y)')
% m=max(f3);
% yticks(0:m/5:m);
% yticklabels(string(0:0.2:1));
subplot(4,3,10),hist(f4)
title('Statistical pdf for arctan(x/y)')
% m=max(f3);
% yticks(0:m/5:m);
% yticklabels(string(0:0.2:1));
c=0;
for data=[f1,f2,f3,f4]
    c=c+1;
    fs={'x^2+y^2','x/y','arctan(x/y)','\surd x^2+y^2'};
    n=length(data); % number of samples
    h=std(data)*(4/3/n)^(1/5); % Silverman's rule of thumb
    phi=@(x)(exp(-.5*x.^2)/sqrt(2*pi)); % normal pdf
    ksden=@(x)mean(phi((x-data)/h)/h); % kernel density 
    subplot(4,3,3*c-1),fplot(ksden)
    title(['Kdensity estimation of pdf for ',fs(c)])
end
g1=@(z) z.*exp(-z.^2/2).*heaviside(z);
g2=@(z) 1/(pi*((z.^2)+1));
g3=@(z) 1/pi*(heaviside(z+pi/2)-heaviside(z-pi/2));
g4=@(z) z*exp(-z^2/2)*heaviside(z);
subplot(4,3,3),fplot(g1)
title('Analytical pdf derivation for x^2+y^2')
subplot(4,3,6),fplot(g2)
title('Analytical pdf derivation for x/y')
subplot(4,3,9),fplot(g3)
title('Analytical pdf derivation for arctan(x/y)')
subplot(4,3,12),fplot(g4)
title('Analytical pdf derivation for \surd x^2+y^2')
