
%% Question 1 
clc
clear
close all
L=3;
Tx=6;
Ty=12;
p=0;
for m=1:L:300 
    p=p+1;
    q=0;
    for n=1:L:300 
        q=q+1;
        f(p,q)=sin((2*pi/Tx)*m + (2*pi/Ty)*n);
    end
end
figure(1),imshow(f,[])
F=fft2(f);
figure(2),mesh(abs(F))
figure,mesh(abs(fftshift(F)))   
%% Question 2 
clc
clear
close all
M=200;
g=zeros(M);
N=256;
cte=20;
for x=1:M
    for y=1:M
        xhat=3/199*(x-1)-2;
        yhat=(2/199)*(y-1)-1;
        c=xhat+1j*yhat;
        z=0;
        for n=0:N
            z=z^2+c;
            if z > cte
                g(x,y)=n;
                break
            end
        end
    end
end
% figure,imshow(g)
g2=ind2rgb(g,jet);
figure(6),imshow(g2,[])