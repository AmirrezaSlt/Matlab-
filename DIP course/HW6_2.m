%% Loading and Preprocessing Data
clc
clear
close all
load restoration.mat
[M,N]=size(g);
G=fft2(g);
G1=fftshift(G);
figure,imshow(g),title('Original Image')
%% Wiener Filter with Constant K
a=20;
b=2;
T=1;
uu=(pi*a)/M;
vv=(pi*b)/N;
H=zeros(M,N);
for u=1:M
    for v=1:N
        H(u,v)=(T/(uu*u+vv*v))*exp((1j)*(uu*u+vv*v))*sin((uu*u+vv*v));
    end
end
k=0.06;
H_hat=conj(H)./((abs(H).^2)+k);
F_hat=G.*H_hat;
f_hat=real(ifft2(F_hat));
f_hat(isnan(f_hat))=0;
figure,imshow(f_hat,[]),title(['Wiener Filter "k" Method with a=',num2str(a),'  b=',num2str(b)])
%%  Noise Variance Estimation
gg=g*255;
window=gg(1:40,350:400);
sigma_N=var(window(:)); % Estimated Noise Power
L=4; % number of variance segmentation
mm=min(M,N);
R=linspace(0,floor(mm/2),L+1);
R=fix(R);
A=struct('cdata',[]);
for k=1:size(R,2)-1
    c=1;
    for u=1:M
        for v=1:N
            r=sqrt(((u-M/2)^2)+((v-N/2)^2));
            if r>R(k) && r<=R(k+1)
                A(k).cdata(c)=abs(G1(u,v));
                c=c+1;
            end
        end
    end
end
H_hat=zeros(M,N);
sigma1=var(A(size(R,2)-1).cdata(:));
for k=1:size(R,2)-1
    sigma=var(A(k).cdata(:));
    parfor u=1:M
        for v=1:N
            r=sqrt(((u-M/2)^2)+((v-N/2)^2));
            if r>R(k) && r<=R(k+1)
                 H_hat(u,v)=conj(H(u,v))/((abs(H(u,v))^2)+(sigma_N/sigma));
            elseif r>R(size(R,2))
                 H_hat(u,v)=conj(H(u,v))/((abs(H(u,v))^2)+(sigma_N/sigma1));
            end
        end
    end
end
F_hat=G.*H_hat;
f_hat=abs(ifft2(F_hat));
figure,imshow(f_hat,[]),title('Wiener Filter-Estimated Power Spectrum N and F')
fig=gcf;
%% Constrained Least Square (CLS)
lap=[0 -1 0;1 -4 -1;0 -1 0];
lap=padarray(lap,[M-3 N-3],'post');
p=fft2(lap);
gamma=0.02;
H_hat=(conj(H))./((abs(H).^2)+(gamma*(abs(p).^2)));
F_hat=G.*H_hat;
f_hat=real(ifft2(F_hat));
figure,imshow(f_hat,[]),title(['Constrained Least Square(CLS)- gamma =' num2str(gamma)])
%% Direct Inverse Filter 
F_hat=G./(H);
f_hat=real(ifft2(F_hat));
f_hat(isnan(f_hat))=0;
figure,imshow(f_hat,[]),title('Direct Inverse Filter')
