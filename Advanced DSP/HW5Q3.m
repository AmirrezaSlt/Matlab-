clc
clear
close all
iteration=10;
[h,g,~,~]=wfilters('db1');
phi=conv(1,h);
for k=1:iteration
    phi=dyadup(phi,2);
    phi=conv(phi,h);
end
phi=sqrt(2)^(iteration+1)*phi; %Normalizer 
figure,plot(phi)
phi2=dyadup(phi,2);
phi2=conv(phi2,h);
psi=phi2-upsample(phi,2);
plot(psi)